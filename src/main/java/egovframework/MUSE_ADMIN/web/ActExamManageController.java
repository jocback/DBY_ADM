package egovframework.MUSE_ADMIN.web;

import org.springframework.stereotype.Controller;

@Controller
public class ActExamManageController extends ActCommonController {

//	/** actExamManageService */
//	@Resource(name = "ActExamManageService")
//	private ActExamManageService actExamManageService;
//
//	@Resource(name = "ActQuestionManageService")
//	private ActQuestionManageService actQuestionManageService;
//
//	/** EgovPropertyService */
//	@Resource(name = "propertiesService")
//	protected EgovPropertyService propertiesService;
//
//	final String MENU_AUTH_NO = "132";
//
//	/**
//	 * 사용자목록을 조회한다. (pageing)
//	 * @param searchVO 검색조건정보
//	 * @param model 화면모델
//	 * @return cmm/boffice/actExam/EgovUserManage
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/boffice/actExam/actExamList.do")
//	public String selectActExamListView(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//		// 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){
//			return MENU_AUTH_REDIRECT;
//		}
//		selectActExamList(freeVO,model);
//		return "/boffice/actExam/examList";
//	}		
//
//	@SuppressWarnings("unchecked")
//	public void selectActExamList(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//
//		/** EgovPropertyService */
//		freeVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		freeVO.setPageSize(propertiesService.getInt("pageSize"));
//
//		/** pageing */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(freeVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(freeVO.getPageUnit());
//		paginationInfo.setPageSize(freeVO.getPageSize());
//
//		freeVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		freeVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		freeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//
//		freeVO.setActListMode("PAGE");
//		List<?> resultList = actExamManageService.selectActExamList(freeVO);
//		ActQuestionManageVO qmVo = new ActQuestionManageVO();
//		String qmIdxArr[];
//		for(int i = 0;i<resultList.size();i++){
//			Map<String,String> resultMap = (Map<String,String>) resultList.get(i);
//			resultMap.put("qmIdxsNm","");
//			qmIdxArr = (resultMap.get("qmIdxs")).split(",");
//			for(int qm=0;qm<qmIdxArr.length;qm++){
//				qmVo.setQmIdx(qmIdxArr[qm]);
//				Map<String, Object> qmMap = actQuestionManageService.selectActQuestionDetail(qmVo);
//				resultMap.put("qmIdxsNm",(String) resultMap.get("qmIdxsNm")+(String) qmMap.get("qmSubject")+"<br/>");
//			}
//		}
//		model.addAttribute("resultList", resultList);
//
//		freeVO.setActListMode("COUNT");
//		Map<String,Object> resultMap = (Map<String,Object>) actExamManageService.selectActExamListCnt(freeVO);
//		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
//		model.addAttribute("paginationInfo", paginationInfo);
//
//        model.addAttribute("menuCode", MENU_AUTH_NO);
//
//	}
//
//	@RequestMapping("/boffice/actExam/actExamView.do")
//	public String selectActExamDetail(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//
//		// 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){
//			return MENU_AUTH_REDIRECT;
//		}
//
//		if(!isNull(freeVO.getEbIdx())){
//			Map<String, Object> vo = actExamManageService.selectActExamDetail(freeVO);
//			model.addAttribute("resultInfo", vo);
//		}
//
//		model.addAttribute("currYear", getCurrYear());
//		model.addAttribute("menuCode", MENU_AUTH_NO);
//		return "/boffice/actExam/examView";
//	}
//
//	@RequestMapping("/boffice/actExam/insertActExam.do")
//	@ResponseBody
//	public String insertActExam(@ModelAttribute("freeVO") ActExamManageVO freeVO, Model model) throws Exception {
//    	//관리자로그 기록
//    	webLogInsert(MENU_AUTH_NO,1);
//        // 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
//		String retstr = "success";
//		// 로그인VO에서  사용자 정보 가져오기
//		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		String lastUpdusrId = loginVO.getId();
//		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
//		freeVO.setEbIdx(actExamManageService.selectActExamMaxIdx(freeVO));
//		
//		actExamManageService.insertActExam(freeVO);
//		return retstr;
//	}
//
//	@RequestMapping("/boffice/actExam/modifyActExam.do")
//	@ResponseBody
//	public String updateActExam(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//     	//관리자로그 기록
//    	webLogInsert(MENU_AUTH_NO,1);
//       // 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
//		// 로그인VO에서  사용자 정보 가져오기
//		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		String lastUpdusrId = loginVO.getId();
//		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
//		freeVO.setModid(lastUpdusrId); // 최종수정자ID
//
//		actExamManageService.updateActExam(freeVO);
//		return "success";
//	}
//
//	@RequestMapping("/boffice/actExam/deleteActExam.do")
//	@ResponseBody
//	public String deleteActExam(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//
//     	//관리자로그 기록
//    	webLogInsert(MENU_AUTH_NO,1);
//       // 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
//		
//		// 로그인VO에서  사용자 정보 가져오기
//		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		String lastUpdusrId = loginVO.getId();
//		freeVO.setModid(lastUpdusrId); // 최종수정자ID
//		actExamManageService.deleteActExam(freeVO);
//		return "success";
//	}
//
//	
//	
//
//	//응시 관리 -----------------------------------------------------------------------------------------
//	//응시 관리 -----------------------------------------------------------------------------------------
//
//	
//	
//	
//	@RequestMapping(value = "/boffice/actExam/actExamAppList.do")
//	public String selectActExamAppListView(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//		// 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck("133")){
//			return MENU_AUTH_REDIRECT;
//		}
//		selectActExamAppList(freeVO,model);
//		return "/boffice/actExam/examAppList";
//	}		
//
//	public void selectActExamAppList(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//
//		/** EgovPropertyService */
//		freeVO.setPageUnit(propertiesService.getInt("pageUnit"));
//		freeVO.setPageSize(propertiesService.getInt("pageSize"));
//
//		/** pageing */
//		PaginationInfo paginationInfo = new PaginationInfo();
//		paginationInfo.setCurrentPageNo(freeVO.getPageIndex());
//		paginationInfo.setRecordCountPerPage(freeVO.getPageUnit());
//		paginationInfo.setPageSize(freeVO.getPageSize());
//
//		freeVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
//		freeVO.setLastIndex(paginationInfo.getLastRecordIndex());
//		freeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
//
//		freeVO.setActListMode("PAGE");
//		List<?> resultList = actExamManageService.selectActExamAppList(freeVO);
//		model.addAttribute("resultList", resultList);
//
//		freeVO.setActListMode("COUNT");
//		Map<String,Object> resultMap = (Map<String,Object>) actExamManageService.selectActExamAppListCnt(freeVO);
//		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
//		model.addAttribute("paginationInfo", paginationInfo);
//
//        model.addAttribute("menuCode", "133");
//
//	}
//
//	@RequestMapping("/boffice/actExam/actExamAppView.do")
//	public String selectActExamAppDetail(@ModelAttribute("freeVO") ActExamManageVO freeVO, ModelMap model) throws Exception {
//
//		// 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){
//			return "133";
//		}
//
//		if(!isNull(freeVO.getEbIdx())){
//			Map<String, Object> vo = actExamManageService.selectActExamDetail(freeVO);
//			model.addAttribute("resultInfo", vo);
//		}
//
//		model.addAttribute("currYear", getCurrYear());
//		model.addAttribute("menuCode", MENU_AUTH_NO);
//		return "/boffice/actExam/examAppView";
//	}
//
//	
//

}
