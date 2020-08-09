package egovframework.MUSE_ADMIN.web;

import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_Rte.uss.ion.pwm.service.EgovPopupManageService;
import egovframework.MUSE_Rte.uss.ion.pwm.service.PopupManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * 개요
 * - 팝업창에 대한 Controller를 정의한다.
 *
 */

@Controller
public class ActPopupManageController extends ActCommonController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ActPopupManageController.class);

	@Autowired
	private DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovPopupManageService */
	@Resource(name = "egovPopupManageService")
	private EgovPopupManageService egovPopupManageService;

	final String MENU_AUTH_NO = "129";

	/**
	 * 팝업창관리 목록을 조회한다.
	 * @param popupManageVO
	 * @param model
	 * @return "com/boffice/actPopup/listPopupManage"
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/listPopup.do")
	public String egovPopupManageList(@RequestParam Map<?, ?> commandMap, PopupManageVO popupManageVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		/** EgovPropertyService.sample */
		popupManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
		popupManageVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(popupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(popupManageVO.getPageUnit());
		paginationInfo.setPageSize(popupManageVO.getPageSize());

		popupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		popupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		popupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> reusltList = egovPopupManageService.selectPopupList(popupManageVO);
		model.addAttribute("resultList", reusltList);

		model.addAttribute("searchKeyword", commandMap.get("searchKeyword") == null ? "" : (String) commandMap.get("searchKeyword"));
		model.addAttribute("searchCondition", commandMap.get("searchCondition") == null ? "" : (String) commandMap.get("searchCondition"));

		int totCnt = egovPopupManageService.selectPopupListCount(popupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "boffice/contents/popupList";
	}

	/**
	 * 통합링크관리 목록을 상세조회 조회한다.
	 * @param popupManageVO
	 * @param commandMap
	 * @param model
	 * @return
	 *         "/boffice/actPopup/detailPopupManage"
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/detailPopup.do")
	public String egovPopupManageDetail(PopupManageVO popupManageVO, @RequestParam Map<?, ?> commandMap, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		String sLocationUrl = "boffice/contents/popupView";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		if (sCmd.equals("del")) {
			egovPopupManageService.deletePopup(popupManageVO);
			sLocationUrl = "forward:/boffice/actPopup/listPopup.do";
		} else {
			//상세정보 불러오기
			PopupManageVO popupManageVOs = egovPopupManageService.selectPopup(popupManageVO);
			model.addAttribute("popupManageVO", popupManageVOs);
		}

		return sLocationUrl;
	}

	/**
	 * 통합링크관리를 수정한다.
	 * @param searchVO
	 * @param popupManageVO
	 * @param bindingResult
	 * @param model
	 * @return
	 *         "/boffice/actPopup/updtPopupManage"
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/updtPopup.do")
	public String egovPopupManageUpdt(@RequestParam Map<?, ?> commandMap, PopupManageVO popupManageVO, BindingResult bindingResult, ModelMap model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "com/uat/uia/EgovLoginUsr";
		}

		// 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "boffice/contents/popupView";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");

		//팝업창시작일자(시)
		model.addAttribute("ntceBgndeHH", getTimeHH());
		//팝업창시작일자(분)
		model.addAttribute("ntceBgndeMM", getTimeMM());
		//팝업창종료일자(시)
		model.addAttribute("ntceEnddeHH", getTimeHH());
		//팝업창정료일자(분)
		model.addAttribute("ntceEnddeMM", getTimeMM());

		if (sCmd.equals("save")) {
			sLocationUrl = "forward:/boffice/actPopup/listPopup.do";
			//서버  validate 체크
			beanValidator.validate(popupManageVO, bindingResult);
			if (bindingResult.hasErrors()) {
				return sLocationUrl;
			}
			//아이디 설정
			popupManageVO.setFrstRegisterId(loginVO.getId());
			popupManageVO.setLastUpdusrId(loginVO.getId());

			popupManageVO.setPopupCn(unscript(popupManageVO.getPopupCn()));	// XSS 방지

			//저장
			egovPopupManageService.updatePopup(popupManageVO);
		} else {

			PopupManageVO popupManageVOs = egovPopupManageService.selectPopup(popupManageVO);

			String sNtceBgnde = popupManageVOs.getNtceBgnde();
			String sNtceEndde = popupManageVOs.getNtceEndde();

			popupManageVOs.setNtceBgndeHH(sNtceBgnde.substring(8, 10));
			popupManageVOs.setNtceBgndeMM(sNtceBgnde.substring(10, 12));

			popupManageVOs.setNtceEnddeHH(sNtceEndde.substring(8, 10));
			popupManageVOs.setNtceEnddeMM(sNtceEndde.substring(10, 12));

			model.addAttribute("popupManageVO", popupManageVOs);
		}

		return sLocationUrl;
	}

	/**
	 * 통합링크관리를 등록한다.
	 * @param searchVO
	 * @param popupManageVO
	 * @param bindingResult
	 * @param model
	 * @return
	 *         "/boffice/actPopup/registPopupManage"
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/registPopup.do")
	public String egovPopupManageRegist(@RequestParam Map<?, ?> commandMap, @ModelAttribute("popupManageVO") PopupManageVO popupManageVO, BindingResult bindingResult,
			ModelMap model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "com/uat/uia/EgovLoginUsr";
		}

		// 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String sLocationUrl = "boffice/contents/popupView";

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");
		LOGGER.info("cmd => {}", sCmd);

		if (sCmd.equals("save")) {
			//서버  validate 체크
			beanValidator.validate(popupManageVO, bindingResult);
			if (bindingResult.hasErrors()) {
				return sLocationUrl;
			}
			//아이디 설정
			popupManageVO.setFrstRegisterId(loginVO.getId());
			popupManageVO.setLastUpdusrId(loginVO.getId());

			popupManageVO.setPopupCn(unscript(popupManageVO.getPopupCn()));	// XSS 방지
		    
			//저장
			egovPopupManageService.insertPopup(popupManageVO);

			sLocationUrl = "forward:/boffice/actPopup/listPopup.do";
		}

		//팝업창시작일자(시)
		model.addAttribute("ntceBgndeHH", getTimeHH());
		//팝업창시작일자(분)
		model.addAttribute("ntceBgndeMM", getTimeMM());
		//팝업창종료일자(시)
		model.addAttribute("ntceEnddeHH", getTimeHH());
		//팝업창정료일자(분)
		model.addAttribute("ntceEnddeMM", getTimeMM());

		return sLocationUrl;
	}

	/**
	 * 팝업창정보를 조회한다.
	 * @param commandMap
	 * @param popupManageVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/ajaxPopupManageInfo.do")
	public void egovPopupManageInfoAjax(@RequestParam Map<?, ?> commandMap, HttpServletResponse response, PopupManageVO popupManageVO) throws Exception {

		response.setHeader("Content-Type", "text/html;charset=utf-8");
		PrintWriter out = new PrintWriter(new OutputStreamWriter(response.getOutputStream(), "UTF-8"));

		LOGGER.debug("commandMap : {}", commandMap);
		LOGGER.debug("popupManageVO : {}", popupManageVO);

		PopupManageVO popupManageVOs = egovPopupManageService.selectPopup(popupManageVO);

		String sPrint = "";
		sPrint = popupManageVOs.getFileUrl();
		sPrint = sPrint + "||" + popupManageVOs.getPopupWSize();
		sPrint = sPrint + "||" + popupManageVOs.getPopupHSize();
		sPrint = sPrint + "||" + popupManageVOs.getPopupHlc();
		sPrint = sPrint + "||" + popupManageVOs.getPopupWlc();
		sPrint = sPrint + "||" + popupManageVOs.getStopVewAt();
		out.print(sPrint);
		out.flush();
	}

	/**
	 * 팝업창을 오픈 한다.
	 * @param commandMap
	 * @param popupManageVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/openPopupManage.do")
	public String egovPopupManagePopupOpen(PopupManageVO popupManageVO, @RequestParam("fileUrl") String fileUrl, @RequestParam("stopVewAt") String stopVewAt, @RequestParam("popupId") String popupId,
			ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		//상세정보 불러오기
		popupManageVO.setPopupId(popupId);
		PopupManageVO popupManageVOs = egovPopupManageService.selectPopup(popupManageVO);
		model.addAttribute("popupManageVO", popupManageVOs);

		model.addAttribute("stopVewAt", stopVewAt);
		model.addAttribute("popupId", popupId);
		return fileUrl;
	}

	/**
	 * 팝업창관리 메인 테스트 목록을 조회한다.
	 * @param popupManageVO
	 * @param model
	 * @return "com/boffice/actPopup/listMainPopup"
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actPopup/listMainPopup.do")
	public String egovPopupManageMainList(PopupManageVO popupManageVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		List<?> reusltList = egovPopupManageService.selectPopupMainList(popupManageVO);
		model.addAttribute("resultList", reusltList);

		return "boffice/contents/popupMainList";
	}

	/**
	 * 시간을 LIST를 반환한다.
	 * @return  List
	 * @throws
	 */
	@SuppressWarnings("unused")
	private List<ComDefaultCodeVO> getTimeHH() {
		ArrayList<ComDefaultCodeVO> listHH = new ArrayList<ComDefaultCodeVO>();
		HashMap<?, ?> hmHHMM;
		for (int i = 0; i <= 24; i++) {
			String sHH = "";
			String strI = String.valueOf(i);
			if (i < 10) {
				sHH = "0" + strI;
			} else {
				sHH = strI;
			}

			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCode(sHH);
			codeVO.setCodeNm(sHH);

			listHH.add(codeVO);
		}

		return listHH;
	}

	/**
	 * 분을 LIST를 반환한다.
	 * @return  List
	 * @throws
	 */
	@SuppressWarnings("unused")
	private List<ComDefaultCodeVO> getTimeMM() {
		ArrayList<ComDefaultCodeVO> listMM = new ArrayList<ComDefaultCodeVO>();
		HashMap<?, ?> hmHHMM;
		for (int i = 0; i <= 60; i++) {

			String sMM = "";
			String strI = String.valueOf(i);
			if (i < 10) {
				sMM = "0" + strI;
			} else {
				sMM = strI;
			}

			ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
			codeVO.setCode(sMM);
			codeVO.setCodeNm(sMM);

			listMM.add(codeVO);
		}
		return listMM;
	}

	/**
	 * 0을 붙여 반환
	 * @return  String
	 * @throws
	 */
	public String dateTypeIntForString(int iInput) {
		String sOutput = "";
		if (Integer.toString(iInput).length() == 1) {
			sOutput = "0" + Integer.toString(iInput);
		} else {
			sOutput = Integer.toString(iInput);
		}

		return sOutput;
	}
}