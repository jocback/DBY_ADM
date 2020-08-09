package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActOrgManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrgManageVO;
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
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActOrgManageController extends ActCommonController {

	/** actOrgManageService */
	@Resource(name = "ActOrgManageService")
	private ActOrgManageService actOrgManageService;

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

	final String MENU_AUTH_NO = "110";
	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actOrg/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actOrg/actOrgList.do")
	public String selectActOrgList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

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

		List<?> userList = actOrgManageService.selectActOrgList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actOrgManageService.selectActOrgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		List<?> emplyrSttusCode_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("emplyrSttusCode_result", emplyrSttusCode_result);//사용자상태코드목록

		return "/boffice/actOrg/orgList";
	}

	@RequestMapping("/boffice/actOrg/actOrgView.do")
	public String selectActOrgDetail(ActOrgManageVO actOrgManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actOrgManageService.selectActOrgDetail(actOrgManageVO);
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

		codevo.setCodeId("COM051"); //조직1차 : 11(재활용사업실), 12(빈용기사업실)
		List<?> codeResult51 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult51", codeResult51);

		if (orgCd != null && orgCd.length() != 0) {
			codevo.setCodeId("COM052"); //조직2차 예: 1101
			codevo.setCodeLike(orgCd.substring(0,2)); //구성원의 조직1차에 해당되는 코드만 호출
			List<?> codeResult52 = cmmUseService.selectCmmCodeDetail(codevo);
			model.addAttribute("codeResult52", codeResult52);

			codevo.setCodeId("COM053"); //조직3차 예: 110101
			codevo.setCodeLike(orgCd.substring(0,4)); //구성원의 조직2차에 해당되는 코드만 호출
			List<?> codeResult53 = cmmUseService.selectCmmCodeDetail(codevo);
			model.addAttribute("codeResult53", codeResult53);
		}

		return "/boffice/actOrg/orgView";
	}

	@RequestMapping("/boffice/actOrg/modifyActOrg.do")
	@ResponseBody
	public String updateActOrg(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actOrgManageVO") ActOrgManageVO actOrgManageVO, ModelMap model)
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
		actOrgManageVO.setModemp(lastUpdusrId); // 최종수정자ID
		actOrgManageService.updateActOrg(actOrgManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrg/modifyActOrgSeq.do")
	@ResponseBody
	public String updateActOrgSeq(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actOrgManageVO") ActOrgManageVO actOrgManageVO, ModelMap model)
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
		actOrgManageVO.setModemp(lastUpdusrId); // 최종수정자ID
		String idx[] = (actOrgManageVO.getEmpNo()).split(",");
		for(int i=0;i<idx.length;i++){
			actOrgManageVO.setEmpNo(idx[i]);
			actOrgManageVO.setPosNo(Integer.toString(i+1));
			actOrgManageService.updateActOrgSeq(actOrgManageVO);
		}
		return "success";
	}

	@RequestMapping("/boffice/actOrg/deleteActOrg.do")
	@ResponseBody
	public String deleteActOrg(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actOrgManageVO") ActOrgManageVO actOrgManageVO, ModelMap model)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		actOrgManageService.deleteActOrg(actOrgManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrg/insertActOrg.do")
	@ResponseBody
	public String insertActOrg(@ModelAttribute("actOrgManageVO") ActOrgManageVO actOrgManageVO, BindingResult bindingResult, Model model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actOrgManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actOrgManageVO.setModemp(lastUpdusrId); // 최종수정자ID
			actOrgManageService.insertActOrg(actOrgManageVO);
		}
		return retstr;
	}

}
