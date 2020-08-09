package egovframework.MUSE_ADMIN.web;

import java.util.List;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActTeamsManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActTeamsManageVO;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActTeamsManageController extends ActCommonController {

	/** actTeamsManageService */
	@Resource(name = "ActTeamsManageService")
	private ActTeamsManageService actTeamsManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

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
	 * @return cmm/boffice/actTeams/EgovUserManage
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value = "/boffice/actTeams/actTeamsList.do")
	public String selectActTeamsList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();

		codevo.setCodeId("COM045"); //직급
		List<?> codeResult45 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult45", codeResult45);

		return "/boffice/actTeams/teamsList";
	}

	@RequestMapping("/boffice/actTeams/ajaxActTeamsList.do")
	@ResponseBody
	public ModelAndView selectAaxActTeamsList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO) throws Exception {

		ModelAndView mv = new ModelAndView();
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return mv;
		}

		List<?> userList = actTeamsManageService.selectActTeamsList(searchVO);
        mv.setViewName("jsonView");
        mv.addObject("ajaxListResult", userList);
        return mv;
	}

	@RequestMapping("/boffice/actTeams/ajaxActTeamEmpList.do")
	@ResponseBody
	public ModelAndView selectAaxActTeamEmpList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO) throws Exception {
		ModelAndView mv = new ModelAndView();
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return mv;
		}

		List<?> userList = actTeamsManageService.selectActTeamEmpList(searchVO);
        mv.setViewName("jsonView");
        mv.addObject("ajaxListResult", userList);
        return mv;
	}

    @RequestMapping(value="/boffice/actTeams/ajaxActTeamsDetail.do")
	public ModelAndView ajaxActTeamsDetail(@ModelAttribute("searchVO") ActTeamsManageVO searchVO, ModelMap model) throws Exception {
		ModelAndView mv = new ModelAndView();
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return mv;
		}

		ActTeamsManageVO vo = actTeamsManageService.selectActTeamsDetail(searchVO);
        mv.setViewName("jsonView");
        mv.addObject("infoArtcDetail", vo);
        return mv;
    }

    @RequestMapping("/boffice/actTeams/modifyActTeams.do")
	@ResponseBody
	public String updateActTeams(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actEmpManageVO") ActTeamsManageVO actTeamsManageVO)
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
		actTeamsManageVO.setModemp(lastUpdusrId); // 최종수정자ID
		actTeamsManageService.updateActTeams(actTeamsManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actTeams/insertActTeams.do")
	@ResponseBody
	public String insertActTeams(@ModelAttribute("actEmpManageVO") ActTeamsManageVO actTeamsManageVO, BindingResult bindingResult) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actTeamsManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actTeamsManageVO.setModemp(lastUpdusrId); // 최종수정자ID
			actTeamsManageService.insertActTeams(actTeamsManageVO);
		}
		return retstr;
	}

	@RequestMapping("/boffice/actTeams/updateActTeamsSeq.do")
	@ResponseBody
	public String tranSeqArtc(@ModelAttribute("actTeamsManageVO") ActTeamsManageVO actTeamsManageVO) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}

		String idx[] = (actTeamsManageVO.getaId()).split(",");
		actTeamsManageVO.setFrmMode("seq");
		for(int i=0;i<idx.length;i++){
			actTeamsManageVO.setaId(idx[i]);
			//정관 1차 분류는 내림차순으로 정렬
			//2,3차는 오름차순으로 정렬
			if("d1".equals(actTeamsManageVO.getaDepth())){
				actTeamsManageVO.setaSeq(Integer.toString(idx.length-i));
			}else{
				actTeamsManageVO.setaSeq(Integer.toString(i+1));
			}
			actTeamsManageService.updateActTeams(actTeamsManageVO);
		}
		return "success";
	}

	@RequestMapping("/boffice/actTeams/deleteActTeams.do")
	@ResponseBody
	public String deleteActTeams(@ModelAttribute("actTeamsManageVO") ActTeamsManageVO actTeamsManageVO, BindingResult bindingResult)
			throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String retstr = "success";

		beanValidator.validate(actTeamsManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			int totCnt = actTeamsManageService.selectActTeamsCnt(actTeamsManageVO);
			if(totCnt>0){
				retstr = "sub";
			}else{
				actTeamsManageService.deleteActTeams(actTeamsManageVO);
			}
		}
		return retstr;

	}

}
