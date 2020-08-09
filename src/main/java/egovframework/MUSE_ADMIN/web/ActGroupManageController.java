package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActGroupManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActGroupManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActGroupManageController extends ActCommonController {

	@Resource(name = "ActGroupManageService")
	private ActGroupManageService actGroupManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	final String MENU_AUTH_NO = "146";

	/**
	 * GROUP 목록을 조회한다.
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actGroup/actGroupList.do")
	public String selectActGroupList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		/** EgovPropertyService.SiteList */
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

		List<?> GroupList = actGroupManageService.selectActGroupList(searchVO);
		model.addAttribute("resultList", GroupList);

		int totCnt = actGroupManageService.selectActGroupListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		model.addAttribute("currIp",getRemoteAddr());

		return "boffice/actGroup/groupList";
	}

	/**
	 * GROUP 목록에 대한 상세정보를 조회한다.
	 * @param actGroupManageVO
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/actGroupView.do")
	public String selectActGroupDetail(ActGroupManageVO actGroupManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM043"); //관리자구분 코드
		List<?> codeResult43 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult43", codeResult43);

		Map<String, Object> vo = actGroupManageService.selectActGroupDetail(actGroupManageVO);
		model.addAttribute("resultInfo", vo);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "boffice/actGroup/groupView";
	}

	/**
	 * GROUP를 등록한다.
	 * @param multiRequest
	 * @param searchVO
	 * @param actGroupManageVO
	 * @param bindingResult
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/insertActGroup.do")
	public String insertActGroup(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actGroupManageVO") ActGroupManageVO actGroupManageVO) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String frstRegisterId = loginVO.getId();

		actGroupManageVO.setModemp(frstRegisterId); // 최종수정자ID

		actGroupManageService.insertActGroup(actGroupManageVO);

		return "forward:/boffice/actGroup/actGroupList.do";
	}

	/**
	 * GROUP를 수정하기 위한 전 처리
	 * @param groupId
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/actGroupModify.do")
	public String actGroupModify(@RequestParam("idx") String idx, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		ActGroupManageVO actGroupManageVO = new ActGroupManageVO();

		// Primary Key 값 세팅
		actGroupManageVO.setGroupId(idx);

		// 변수명은 CoC 에 따라
		model.addAttribute(selectActGroupDetail(actGroupManageVO, searchVO, model));

		// 변수명은 CoC 에 따라 JSTL사용을 위해
		model.addAttribute("actGroupManageVO", actGroupManageService.selectActGroupDetail(actGroupManageVO));
		model.addAttribute("user", user);

		return "boffice/actGroup/groupModify";
	}

	/**
	 * GROUP를 수정처리한다.
	 * @param atchFileAt
	 * @param multiRequest
	 * @param searchVO
	 * @param actGroupManageVO
	 * @param bindingResult
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/modifyActGroup.do")
	@ResponseBody
	public String updateActGroup(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actGroupManageVO") ActGroupManageVO actGroupManageVO, ModelMap model)
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

		actGroupManageVO.setModemp(lastUpdusrId); // 최종수정자ID

		actGroupManageService.updateActGroup(actGroupManageVO);

		//return "forward:/boffice/actGroup/actGroupModify.do";
		return "success";

	}

	/**
	 * GROUP를 삭제처리한다.
	 * @param actGroupManageVO
	 * @param searchVO
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/deleteActGroup.do")
	public String deleteActGroup(ActGroupManageVO actGroupManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		actGroupManageService.deleteActGroup(actGroupManageVO);

		return "forward:/boffice/actGroup/actGroupList.do";
	}

	/**
	 *	중복 체크.
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/ActGroupDupCheck.do")
    @ResponseBody
	public String actGroupDupCheck(@ModelAttribute("actGroupManageVO") ActGroupManageVO actGroupManageVO) throws Exception {
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String retStr = "success";
		String actGrNm = actGroupManageService.selectActGroupInfoOne("A.GROUP_NM",actGroupManageVO.getGroupId(),actGroupManageVO.getGroupNm());
		if(actGrNm!=null){
			if(actGrNm.equals(actGroupManageVO.getGroupNm())){
				retStr =  "dup";
			}
		}
		return retStr;
	}

	/**
	 * GROUP 권한에 대한 메뉴 리스트를 조회
	 * @param actGroupManageVO
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/actGroupAuth.do")
	public String selectActGroupAuthSet(ActGroupManageVO actGroupManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM042"); //1차메뉴
		List<?> codeResult42 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult42", codeResult42);

		codevo.setCodeId("COM041"); //메뉴리스트
		List<?> codeResult41 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult41", codeResult41);

		Map<String, Object> vo = actGroupManageService.selectActGroupDetail(actGroupManageVO);
		model.addAttribute("resultInfo", vo);

		List<?> authvo = actGroupManageService.selectActGroupAuthList(actGroupManageVO);
		model.addAttribute("resultAuth", authvo);
		model.addAttribute("menuCode", MENU_AUTH_NO);

		return "boffice/actGroup/groupAuth";
	}

	/**
	 * GROUP 권한을 수정처리한다.
	 * @param atchFileAt
	 * @param multiRequest
	 * @param searchVO
	 * @param actGroupManageVO
	 * @param bindingResult
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/actGroup/modifyActGroupAuth.do")
	@ResponseBody
	public String updateActGroupAuth(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, @ModelAttribute("actGroupManageVO") ActGroupManageVO actGroupManageVO, ModelMap model)
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

		actGroupManageVO.setModemp(lastUpdusrId); // 최종수정자ID

		if(actGroupManageService.deleteActGroupAuth(actGroupManageVO)){
			String empNo[] = (actGroupManageVO.getMenuCode()).split(",");
			for(int i=0;i<empNo.length;i++){
				actGroupManageVO.setMenuCode(empNo[i]);
				actGroupManageService.insertActGroupAuth(actGroupManageVO);
			}
		}

		//return "forward:/boffice/actGroup/actGroupModify.do";
		return "success";

	}
}
