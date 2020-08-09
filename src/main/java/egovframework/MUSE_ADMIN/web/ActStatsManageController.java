package egovframework.MUSE_ADMIN.web;

import java.util.ArrayList;
import java.util.List;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.GenExcelView;
import egovframework.MUSE_ADMIN.service.ActStatsManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

@Controller
public class ActStatsManageController extends ActCommonController {

	@Resource(name = "ActStatsManageService")
	private ActStatsManageService actStatsManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Resource(name = "BoardMasterManageService")
	private BoardMasterManageService egovBBSAttributeManageService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	final String MENU_AUTH_NO = "130";

	/**
	 *  목록을 조회한다.
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actStats/actStatsDateList.do")
	public String selectActStatsDateList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		/** EgovPropertyService.SiteList */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> GroupList = actStatsManageService.selectActStatsDateList(searchVO);
		model.addAttribute("resultList", GroupList);

		int totCnt = actStatsManageService.selectActStatsDateListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", searchVO);

		return "boffice/actStats/stats_date";
	}

	@RequestMapping(value = "/boffice/actStats/actStatsDateExcel.do")
	public View selectActStatsDateExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}
		List<String> colName = new ArrayList<String>();
		colName.add("No");
		colName.add("일자");
		colName.add("요일");
		colName.add("방문수");
		searchVO.setPageView("EXCEL");
		List<?> colValue = actStatsManageService.selectActStatsDateList(searchVO);
		model.put("excelName", "날짜별유입수");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}

	@RequestMapping(value = "/boffice/actStats/actStatsDeviceList.do")
	public String selectActStatsDeviceList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}

		List<?> GroupList = actStatsManageService.selectActStatsDeviceList(searchVO);
		model.addAttribute("resultList", GroupList);

		return "boffice/actStats/stats_device";
	}

	@RequestMapping(value = "/boffice/actStats/actStatsDeviceExcel.do")
	public View selectActStatsDeviceExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}
		List<String> colName = new ArrayList<String>();
		colName.add("장치");
		colName.add("방문수");
		List<?> colValue = actStatsManageService.selectActStatsDeviceList(searchVO);
		model.put("excelName", "장치별유입수");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}
	@RequestMapping(value = "/boffice/actStats/actStatsHistoryList.do")
	public String selectActStatsHistoryList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		/** EgovPropertyService.SiteList */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchWorkpart("WEBLOG_FRONT");

		List<?> GroupList = actStatsManageService.selectActStatsHistoryList(searchVO);
		model.addAttribute("resultList", GroupList);

		int totCnt = actStatsManageService.selectActStatsHistoryListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", searchVO);
		
		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM041");
		List<?> codeResult41 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult41", codeResult41);

		List<?> bbsIdList = egovBBSAttributeManageService.selectAllBBSMasteInf();
		model.addAttribute("resultBbsIdList", bbsIdList);

		return "boffice/actStats/stats_history";
	}

	@RequestMapping(value = "/boffice/actStats/actStatsHistoryExcel.do")
	public View selectActStatsHistoryExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}
		//REG_DATE, RQESTER_IP, RQESTER_ID, RQESTER_ID_NM, URL, BBS_ID_NM
		List<String> colName = new ArrayList<String>();
		colName.add("No");
		colName.add("접속날짜/시간");
		colName.add("IP주소");
		colName.add("아이디");
		colName.add("이름");
		colName.add("URL");
		colName.add("게시판");
		searchVO.setPageView("EXCEL");
		searchVO.setSearchWorkpart("WEBLOG_FRONT");
		List<?> colValue = actStatsManageService.selectActStatsHistoryList(searchVO);
		model.put("excelName", "접속자로그");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}

	@RequestMapping(value = "/boffice/actStats/actStatsAdminLogList.do")
	public String selectActStatsAdminLogList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		/** EgovPropertyService.SiteList */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchWorkpart("WEBLOG_ADMIN");

		List<?> GroupList = actStatsManageService.selectActStatsHistoryList(searchVO);
		model.addAttribute("resultList", GroupList);

		int totCnt = actStatsManageService.selectActStatsHistoryListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO", searchVO);
		
		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM041");
		List<?> codeResult41 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult41", codeResult41);

		List<?> bbsIdList = egovBBSAttributeManageService.selectAllBBSMasteInf();
		model.addAttribute("resultBbsIdList", bbsIdList);

		return "boffice/actStats/stats_history";
	}

	@RequestMapping(value = "/boffice/actStats/actStatsAdminLogExcel.do")
	public View selectActStatsAdminLogExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}
		List<String> colName = new ArrayList<String>();
		colName.add("No");
		colName.add("접속날짜/시간");
		colName.add("IP주소");
		colName.add("아이디");
		colName.add("이름");
		colName.add("URL");
		colName.add("게시판");
		searchVO.setPageView("EXCEL");
		searchVO.setSearchWorkpart("WEBLOG_ADMIN");
		List<?> colValue = actStatsManageService.selectActStatsHistoryList(searchVO);
		model.put("excelName", "관리자접속로그");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}

	@RequestMapping(value = "/boffice/actStats/actStatsMenuList.do")
	public String selectActStatsMenuList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}

		List<?> GroupList = actStatsManageService.selectActStatsMenuList(searchVO);
		model.addAttribute("resultList", GroupList);

		return "boffice/actStats/stats_menu";
	}

	@RequestMapping(value = "/boffice/actStats/actStatsMenuExcel.do")
	public View selectActStatsMenuExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		if(isNull(searchVO.getSearchSdt())){
			searchVO.setSearchSdt(getCurrMonthMath(-1));
		}
		if(isNull(searchVO.getSearchEdt())){
			searchVO.setSearchEdt(getCurrDate());
		}
		List<String> colName = new ArrayList<String>();
		colName.add("메뉴");
		colName.add("접속");
		colName.add("접속(중복제외)");
		List<?> colValue = actStatsManageService.selectActStatsMenuList(searchVO);
		model.put("excelName", "메뉴별유입수");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}

}
