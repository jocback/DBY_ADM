package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.web.ActCommonController;
import egovframework.MUSE_Rte.sym.ccm.cca.service.CmmnCode;
import egovframework.MUSE_Rte.sym.ccm.cca.service.CmmnCodeVO;
import egovframework.MUSE_Rte.sym.ccm.cca.service.EgovCcmCmmnCodeManageService;
import egovframework.MUSE_Rte.sym.ccm.cde.service.EgovCcmCmmnDetailCodeManageService;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActCodeManageController extends ActCommonController {

	@Resource(name = "CmmnCodeManageService")
    private EgovCcmCmmnCodeManageService cmmnCodeManageService;

	@Resource(name = "CmmnDetailCodeManageService")
    private EgovCcmCmmnDetailCodeManageService cmmnDetailCodeManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	@Resource(name="EgovCmmUseService")
	private EgovCmmUseService cmmUseService;


	@Autowired
	private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "142";

	@RequestMapping("/boffice/actCode/actCodeSet.do")
	public String selectActCodeSet(@ModelAttribute("searchVO") CmmnCodeVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
    	searchVO.setSearchGubun("view");
        List<?> CmmnCodeList =cmmnCodeManageService.selectCmmnCodeList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "boffice/actCode/actCodeSet";
	}

    /**
	 * 공통코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/boffice/actCode/cmmCodeSave.do")
    @ResponseBody
	public String selectCmmnCodeViewSave (@ModelAttribute("searchVO") CmmnCodeVO searchVO
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, @RequestParam Map<?, ?> commandMap
			, ModelMap model
			) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
    	String returnStr = "success";
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
        beanValidator.validate(cmmnCode, bindingResult);
		//if (bindingResult.hasErrors()){
    		//returnStr = "fail";
		//}else{
		// 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

	    	if (sCmd.equals("Modify")) {
	    		cmmnCode.setLastUpdusrId(loginVO.getId());
		    	cmmnCodeManageService.updateCmmnCode(cmmnCode);
	    	}else if(sCmd.equals("Add")){
	        	cmmnCode.setFrstRegisterId(loginVO.getId());
	        	cmmnCodeManageService.insertCmmnCode(cmmnCode);
	    	}else if(sCmd.equals("Del")){
	    		searchVO.setSearchCondition("1");
	    		searchVO.setSearchKeyword(cmmnCode.getCodeId());
	            int totCnt = cmmnDetailCodeManageService.selectCmmnDetailCodeListTotCnt(searchVO);
	            if(totCnt>0){
	            	returnStr = "sub";
	            }else{
	            	cmmnCodeManageService.deleteCmmnCode(cmmnCode);
	            }
	    	}
		//}
    	return returnStr;
	}
    
    //-------------------------------------------------  상세 코드 -------------------------------------------------
	/**
     * 공통코드 상세 목록 조회.
     */
    @RequestMapping(value="/boffice/actCode/cmdCodeList.do")
	public ModelAndView ccmCdeList (@ModelAttribute("codeVo") ComDefaultCodeVO codeVo, ModelMap model) throws Exception {
            ModelAndView mv = new ModelAndView();
			// 미인증 사용자에 대한 보안처리
			if(!isMenuAuthCheck(MENU_AUTH_NO)){
				return mv;
			}
    		ComDefaultCodeVO vo = codeVo;
    		vo.setCodeId(codeVo.getCodeId());
    		vo.setCodeEtc1(codeVo.getCodeEtc1());
            List<?> codeList = cmmUseService.selectCmmCodeDetail(vo);
            mv.setViewName("jsonView");
            mv.addObject("codeList", codeList);
            return mv;
    }

    /**
	 * 공통상세코드 목록을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @throws Exception
     */
    @RequestMapping(value="/boffice/actCode/cmdCodeView.do")
	public String selectCmmnDetailCodeView (@ModelAttribute("searchVO") CmmnCodeVO searchVO
			, ModelMap model
			) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		String resultCd = "SUCCESS";
    	if(searchVO.getSearchKeyword() == null || searchVO.getSearchKeyword().equals("")){
    		resultCd = "FAIL";
		}
    	searchVO.setSearchGubun("view");
    	List<?> CmmnCodeList = cmmnDetailCodeManageService.selectCmmnDetailCodeList(searchVO);
		model.addAttribute("menuCode", MENU_AUTH_NO);
        model.addAttribute("resultCd", resultCd);
        model.addAttribute("resultList", CmmnCodeList);
        String newCode = cmmUseService.selectFieldDataOne("CODE_DT", "ISNULL(MAX(CODE),'10')+1", "CODE_ID", searchVO.getSearchKeyword());
        model.addAttribute("newCode", newCode);

        return "boffice/actCode/actCodeDcSet";
	}

    @RequestMapping(value="/boffice/actCode/cmdCodeSave.do")
    @ResponseBody
	public String selectCmmnDetailCodeViewSave (@ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
			, BindingResult bindingResult
			, @RequestParam Map<?, ?> commandMap
			, ModelMap model) throws Exception {

    	// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		String returnStr = "success";

		// 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if (sCmd.equals("Modify")) {
            beanValidator.validate(cmmnDetailCode, bindingResult);
    		if (bindingResult.hasErrors()){
        		CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
        		model.addAttribute("cmmnDetailCode", vo);
    		}
    		cmmnDetailCode.setLastUpdusrId(loginVO.getId());
	    	cmmnDetailCodeManageService.updateCmmnDetailCode(cmmnDetailCode);
    	}else if(sCmd.equals("Add")) {
			CmmnDetailCode vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
	    	if(vo != null){
	    		returnStr = "dup"; //이미 등록된 코드가 존재합니다
	    	}
	    	cmmnDetailCode.setFrstRegisterId(loginVO.getId());
	    	cmmnDetailCodeManageService.insertCmmnDetailCode(cmmnDetailCode);
    	}else if(sCmd.equals("Del")) {
        	cmmnDetailCodeManageService.deleteCmmnDetailCode(cmmnDetailCode);
    	}
    	return returnStr;
	}

	@RequestMapping("/boffice/actCode/actMailCodeSet.do")
	public String selectActMailCodeSet (@ModelAttribute("searchVO") CmmnCodeVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setSearchKeyword("COM063");
    	searchVO.setSearchGubun("view");
    	List<?> CmmnCodeList = cmmnDetailCodeManageService.selectCmmnDetailCodeList(searchVO);
        model.addAttribute("resultList", CmmnCodeList);
        String newCode = cmmUseService.selectFieldDataOne("CODE_DT", "ISNULL(MAX(CODE),'100')+1", "CODE_ID", "COM063");
        model.addAttribute("newCode", newCode);

		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM064");
		List<?> codeResult64 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult64", codeResult64);
		model.addAttribute("menuCode", MENU_AUTH_NO);

		return "boffice/actCode/actMailCodeDcSet";
	}
	
}