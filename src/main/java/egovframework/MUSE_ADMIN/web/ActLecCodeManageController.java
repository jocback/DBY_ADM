package egovframework.MUSE_ADMIN.web;

import java.util.List;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;
import egovframework.MUSE_ADMIN.web.ActCommonController;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActLecCodeManageController extends ActCommonController {

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	final String MENU_AUTH_NO = "101";

	@RequestMapping("/boffice/actLecture/actLecCategory.do")
	public String selectActLecCodeSet(@ModelAttribute("searchVO") ActLecCodeManageVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setCodeGb("LE");
        List<?> LecCodeManageList =actLecCodeManageService.selectLecCodeManageList(searchVO);
        model.addAttribute("resultList", LecCodeManageList);
		searchVO.setCodeGb("CL");
        List<?> SbtCodeManageList =actLecCodeManageService.selectLecCodeManageList(searchVO);
        model.addAttribute("resultList2", SbtCodeManageList);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "boffice/actLecture/lecCode";
	}

    @RequestMapping(value="/boffice/actLecture/actLecCodeSave.do")
    @ResponseBody
	public String selectLecCodeManageViewSave (@ModelAttribute("lecCodeManageVO") ActLecCodeManageVO lecCodeManageVO) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
    	String returnStr = "success";
        // 로그인 객체 선언
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

    	if (lecCodeManageVO.getActListMode().equals("Modify")) {
    		lecCodeManageVO.setModId(loginVO.getId());
	    	actLecCodeManageService.updateLecCodeManage(lecCodeManageVO);
    	}else if(lecCodeManageVO.getActListMode().equals("Add")){
        	lecCodeManageVO.setRegId(loginVO.getId());
        	actLecCodeManageService.insertLecCodeManage(lecCodeManageVO);
    	}else if(lecCodeManageVO.getActListMode().equals("Del")){
    		lecCodeManageVO.setDelId(loginVO.getId());
    		lecCodeManageVO.setSearchCnd("1");
    		lecCodeManageVO.setSearchKeyword(lecCodeManageVO.getCodeId());
            int totCnt = 0;
            if(totCnt>0){
            	returnStr = "sub";
            }else{
            	actLecCodeManageService.deleteLecCodeManage(lecCodeManageVO);
            }
    	}
    	return returnStr;
	}
    
	@RequestMapping("/boffice/actLecture/updateActLecCodeSeq.do")
	@ResponseBody
	public String tranSeqLecCode(@ModelAttribute("lecCodeManageVO") ActLecCodeManageVO lecCodeManageVO) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String idx[] = (lecCodeManageVO.getCodeId()).split(",");
		String seqno[] = (lecCodeManageVO.getCodeSq()).split(",");
		for(int i=0;i<idx.length;i++){
			lecCodeManageVO.setCodeId(idx[i]);
			lecCodeManageVO.setCodeSq(seqno[i]);
			actLecCodeManageService.updateActLecCodeSeq(lecCodeManageVO);
		}
		return "success";
	}

}