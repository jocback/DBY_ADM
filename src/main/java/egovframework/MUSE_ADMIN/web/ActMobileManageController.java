package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActMobileManageService;
import egovframework.MUSE_ADMIN.service.ActMobileManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActMobileManageController extends ActCommonController {

	/** actMobileManageService */
	@Resource(name = "ActMobileManageService")
	private ActMobileManageService actMobileManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	final String MENU_AUTH_NO = "135";


	
	@RequestMapping(value = "/boffice/actMobile/actConfList.do")
	public String selectActMobileConfList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setTableNm("Default_Settings");
		selectActMobileList(freeVO,model);
        model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actMobile/conf";
	}		

	@RequestMapping(value = "/boffice/actMobile/actConnectList.do")
	public String selectActMobileConnectList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("136")){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setTableNm("Begin_App");
		selectActMobileList(freeVO,model);
        model.addAttribute("menuCode", "136");
		return "/boffice/actMobile/connect";
	}		

	@RequestMapping(value = "/boffice/actMobile/actDownList.do")
	public String selectActMobileDownList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("137")){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setTableNm("download_Content");
		selectActMobileList(freeVO,model);
        model.addAttribute("menuCode", "137");
		return "/boffice/actMobile/downList";
	}		

	@RequestMapping(value = "/boffice/actMobile/actDownDelList.do")
	public String selectActMobileDownDelList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("138")){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setTableNm("delete_Content");
		selectActMobileList(freeVO,model);
        model.addAttribute("menuCode", "138");
		return "/boffice/actMobile/downDel";
	}		

	@RequestMapping(value = "/boffice/actMobile/actDeviceList.do")
	public String selectActMobileDeviceList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("139")){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setTableNm("register_device_id");
		selectActMobileList(freeVO,model);
        model.addAttribute("menuCode", "139");
		return "/boffice/actMobile/device";
	}		

	@RequestMapping(value = "/boffice/actMobile/actDeviceDelList.do")
	public String selectActMobileDeviceDelList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("140")){
			return MENU_AUTH_REDIRECT;
		}
		freeVO.setTableNm("unregister_device_id");
		selectActMobileList(freeVO,model);
        model.addAttribute("menuCode", "140");
		return "/boffice/actMobile/deviceDel";
	}		

	public void selectActMobileList(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {

		/** EgovPropertyService */
		freeVO.setPageUnit(15);
		freeVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(freeVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(freeVO.getPageUnit());
		paginationInfo.setPageSize(freeVO.getPageSize());

		freeVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		freeVO.setLastIndex(paginationInfo.getLastRecordIndex());
		freeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		freeVO.setActListMode("PAGE");
		List<?> resultList = actMobileManageService.selectActMobileList(freeVO);
		model.addAttribute("resultList", resultList);

		freeVO.setActListMode("COUNT");
		Map<String,Object> resultMap = (Map<String,Object>) actMobileManageService.selectActMobileListCnt(freeVO);
		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
		model.addAttribute("paginationInfo", paginationInfo);
		Map<String,Object> resultTotMap = (Map<String,Object>) actMobileManageService.selectActMobileTotCnt(freeVO);
		model.addAttribute("totCnt", resultTotMap);
	}

	@RequestMapping("/boffice/actMobile/insertActMobileConf.do")
	@ResponseBody
	public String insertActMobile(@ModelAttribute("freeVO") ActMobileManageVO freeVO, Model model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		String retstr = "success";
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
		actMobileManageService.insertActMobileConf(freeVO);
		return retstr;
	}

	@RequestMapping("/boffice/actMobile/deleteActMobileConf.do")
	@ResponseBody
	public String deleteActMobile(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {

     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setModid(lastUpdusrId); // 최종수정자ID
		actMobileManageService.deleteMobileConf(freeVO);
		return "success";
	}

	@RequestMapping("/boffice/actMobile/deleteActMobileDevice.do")
	@ResponseBody
	public String deleteActMobileDevice(@ModelAttribute("freeVO") ActMobileManageVO freeVO, ModelMap model) throws Exception {

     	//관리자로그 기록
    	webLogInsert("139",1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("139")){ return "illegal"; }
		
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setModid(lastUpdusrId); // 최종수정자ID
		actMobileManageService.deleteMobileDevice(freeVO);
		return "success";
	}

}
