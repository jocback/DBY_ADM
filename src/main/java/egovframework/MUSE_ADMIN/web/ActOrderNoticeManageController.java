package egovframework.MUSE_ADMIN.web;

import java.util.Map;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActOrderNoticeManageService;
import egovframework.MUSE_ADMIN.service.ActOrderNoticeManageVO;
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActOrderNoticeManageController extends ActCommonController {

	/** actOrderNoticeManageService */
	@Resource(name = "ActOrderNoticeManageService")
	private ActOrderNoticeManageService actOrderNoticeManageService;

	final String MENU_AUTH_NO = "145";

	@RequestMapping("/boffice/actOrderNotice/actOrderNoticeView.do")
	public String selectActOrderNoticeDetail(@ModelAttribute("freeVO") ActOrderNoticeManageVO freeVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setFqGb("11");
		Map<String, Object> vo = actOrderNoticeManageService.selectActOrderNoticeDetail(freeVO);
		model.addAttribute("resultInfo", vo);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/contents/orderNotice";
	}

	@RequestMapping("/boffice/actOrderNotice/modifyActOrderNotice.do")
	@ResponseBody
	public String updateActOrderNotice(@ModelAttribute("freeVO") ActOrderNoticeManageVO freeVO, ModelMap model) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
		freeVO.setModid(lastUpdusrId); // 최종수정자ID

		actOrderNoticeManageService.updateActOrderNotice(freeVO);
		return "success";
	}

}
