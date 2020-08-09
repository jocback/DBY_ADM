package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActEmpManageService;
import egovframework.MUSE_ADMIN.service.ActTeamsManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActEmpManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActEmpManageController extends ActCommonController {

	/** actEmpManageService */
	@Resource(name = "ActEmpManageService")
	private ActEmpManageService actEmpManageService;

	/** actTeamsManageService */
	@Resource(name = "ActTeamsManageService")
	private ActTeamsManageService actTeamsManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "144";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actEmp/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actEmp/actEmpList.do")
	public String selectActEmpList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		/** EgovPropertyService */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> userList = actEmpManageService.selectActEmpList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actEmpManageService.selectActEmpListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		List<?> emplyrSttusCode_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("emplyrSttusCode_result", emplyrSttusCode_result);//사용자상태코드목록
		model.addAttribute("menuCode", MENU_AUTH_NO);

		return "/boffice/actEmp/empList";
	}

	@RequestMapping("/boffice/actEmp/actEmpView.do")
	public String selectActEmpDetail(ActEmpManageVO actEmpManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		List<?> grvo = actEmpManageService.selectActGroupList(actEmpManageVO);
		model.addAttribute("resultGroup", grvo);

		Map<String, Object> vo = actEmpManageService.selectActEmpDetail(actEmpManageVO);
		model.addAttribute("resultInfo", vo);

		String orgCd = "";
		if (vo != null) {
			if(vo.get("orgCd") != null){
				orgCd = vo.get("orgCd").toString();
			}
		}
		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();

		codevo.setCodeId("COM045"); //직급
		List<?> codeResult45 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult45", codeResult45);

		String foreId = "";
		//3차의 부모 코드를 획득한 후에
		ActManageDefaultVO orgSearchVO = new ActManageDefaultVO();
		if (orgCd != null && orgCd.length() != 0) {
			foreId = cmmUseService.selectFieldDataOne("ORG_TEAMS", "A_FORE", "A_ID", orgCd);
			orgSearchVO.setSearchCnd("d3");
			orgSearchVO.setSearchKeyword(foreId);
			List<?> teamsD3List = actTeamsManageService.selectActTeamsList(orgSearchVO);
			model.addAttribute("teamsD3List", teamsD3List);
		}
		//2차의 부모 코드를 획득한다.
		if (orgCd != null && orgCd.length() != 0) {
			foreId = cmmUseService.selectFieldDataOne("ORG_TEAMS", "A_FORE", "A_ID", foreId);
			orgSearchVO.setSearchKeyword(foreId);
		}
		orgSearchVO.setSearchCnd("d2");
		List<?> teamsD2List = actTeamsManageService.selectActTeamsList(orgSearchVO);
		model.addAttribute("teamsD2List", teamsD2List);
		model.addAttribute("foreId", foreId);
		model.addAttribute("menuCode", MENU_AUTH_NO);

		return "/boffice/actEmp/empView";
	}

	@RequestMapping("/boffice/actEmp/modifyActEmp.do")
	@ResponseBody
	public String updateActEmp(@ModelAttribute("actEmpManageVO") ActEmpManageVO actEmpManageVO, ModelMap model)
			throws Exception {

     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		actEmpManageVO.setModemp(lastUpdusrId); // 최종수정자ID
		actEmpManageService.updateActEmp(actEmpManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actEmp/deleteActEmp.do")
	@ResponseBody
	public String deleteActEmp(@ModelAttribute("actEmpManageVO") ActEmpManageVO actEmpManageVO, ModelMap model)
			throws Exception {

     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		actEmpManageService.deleteActEmp(actEmpManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actEmp/insertActEmp.do")
	@ResponseBody
	public String insertActEmp(@ModelAttribute("actEmpManageVO") ActEmpManageVO actEmpManageVO, BindingResult bindingResult, Model model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actEmpManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actEmpManageVO.setRegemp(lastUpdusrId); // 최종수정자ID
			actEmpManageService.insertActEmp(actEmpManageVO);
		}
		return retstr;
	}

    /**
     * 회원 목록 조회.
     */
    @RequestMapping(value="/boffice/actEmp/searchInfoEmpList.do")
	@ResponseBody
	public ModelAndView searchInfoEmp(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		ModelAndView mv = new ModelAndView();
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return mv;
		}
        List<?> infoEmpList = actEmpManageService.searchInfoEmp(searchVO);
        mv.setViewName("jsonView");
        mv.addObject("infoEmpList", infoEmpList);
        return mv;
    }

	@RequestMapping(value = "/boffice/actEmp/empOtpQr.do")
	public String selectActEmpOtpQr(ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("155")){
			return MENU_AUTH_REDIRECT;
		}
		model.addAttribute("menuCode", "155");
		return "/boffice/actEmp/empOtpQr";
	}

}
