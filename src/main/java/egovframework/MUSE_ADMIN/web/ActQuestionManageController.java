package egovframework.MUSE_ADMIN.web;

import org.springframework.stereotype.Controller;

@Controller
public class ActQuestionManageController extends ActCommonController {

//	/** actQuestionManageService */
//	@Resource(name = "ActQuestionManageService")
//	private ActQuestionManageService actQuestionManageService;
//
//    @Resource(name = "EgovFileMngService")
//    private EgovFileMngService fileMngService;
//
//    @Resource(name = "EgovFileMngUtil")
//    private EgovFileMngUtil fileUtil;
//
//	/** EgovPropertyService */
//	@Resource(name = "propertiesService")
//	protected EgovPropertyService propertiesService;
//
//	final String MENU_AUTH_NO = "131";
//
//	/**
//	 * 사용자목록을 조회한다. (pageing)
//	 * @param searchVO 검색조건정보
//	 * @param model 화면모델
//	 * @return cmm/boffice/actQuestion/EgovUserManage
//	 * @throws Exception
//	 */
//	@RequestMapping(value = "/boffice/actQuestion/actQuestionList.do")
//	public String selectActQuestionListView(@ModelAttribute("freeVO") ActQuestionManageVO freeVO, ModelMap model) throws Exception {
//		// 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){
//			return MENU_AUTH_REDIRECT;
//		}
//		selectActQuestionList(freeVO,model);
//		return "/boffice/actQuestion/questionList";
//	}		
//
//	public void selectActQuestionList(@ModelAttribute("freeVO") ActQuestionManageVO freeVO, ModelMap model) throws Exception {
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
//		List<?> resultList = actQuestionManageService.selectActQuestionList(freeVO);
//		model.addAttribute("resultList", resultList);
//
//		freeVO.setActListMode("COUNT");
//		Map<String,Object> resultMap = (Map<String,Object>) actQuestionManageService.selectActQuestionListCnt(freeVO);
//		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
//		model.addAttribute("paginationInfo", paginationInfo);
//
//        model.addAttribute("menuCode", MENU_AUTH_NO);
//
//	}
//
//	@RequestMapping("/boffice/actQuestion/ajaxQuestionList.do")
//	@ResponseBody
//	public ModelAndView ajaxQuestionList(@ModelAttribute("freeVO") ActQuestionManageVO freeVO, Model model) throws Exception {
//		freeVO.setActListMode("EXCEL");
//		List<?> resultList = actQuestionManageService.selectActQuestionList(freeVO);
//        ModelAndView mv = new ModelAndView();
//        mv.setViewName("jsonView");
//        mv.addObject("resultList", resultList);
//        return mv;
//	}
//
//	@RequestMapping("/boffice/actQuestion/actQuestionView.do")
//	public String selectActQuestionDetail(@ModelAttribute("freeVO") ActQuestionManageVO freeVO, ModelMap model) throws Exception {
//
//		// 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){
//			return MENU_AUTH_REDIRECT;
//		}
//
//		Map<String, Object> vo = actQuestionManageService.selectActQuestionDetail(freeVO);
//		model.addAttribute("resultInfo", vo);
//
//		model.addAttribute("menuCode", MENU_AUTH_NO);
//		return "/boffice/actQuestion/questionView";
//	}
//
//	@SuppressWarnings("unchecked")
//	@RequestMapping("/boffice/actQuestion/insertActQuestion.do")
//	@ResponseBody
//	public String insertActQuestion(final MultipartHttpServletRequest multiRequest, @ModelAttribute("freeVO") ActQuestionManageVO freeVO, Model model) throws Exception {
//    	//관리자로그 기록
//    	webLogInsert(MENU_AUTH_NO,1);
//        // 미인증 사용자에 대한 보안처리
//		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
//		String retstr = "success";
//		// 로그인VO에서  사용자 정보 가져오기
//		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		String lastUpdusrId = loginVO.getId();
//		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
//		freeVO.setQmIdx(actQuestionManageService.selectActQuestionMaxIdx(freeVO));
//		
//			//전체 파일의 확장자 체크
//			if(!checkImgUpLoadFile(multiRequest,2)) return "noneEx";
////파일 저장 s-------------------------------------------------------------------------------------------------------------
//			//시험지(이미지)파일 저장
//			List<FileVO> result = null;
//			String atchFileId = "";
//			final Map<String, MultipartFile> files = multiRequest.getFileMap();
//			files.remove("dwfile");
//			files.remove("asfile");
//			if(!files.isEmpty()){
//				result = fileUtil.parseFileInf(files, "QMS", 0, "", "QMS/EXAM");
//				atchFileId = fileMngService.insertFileInfs(result);
//			    freeVO.setQmExfile(atchFileId);
//			}
//			//다운(hwp)파일 저장
//			final Map<String, MultipartFile> filesDw = multiRequest.getFileMap();
//			filesDw.remove("asfile");
//			Object[] fileseKey = filesDw.keySet().toArray();
//			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
//					filesDw.remove("examfile_"+Integer.toString(keyNo));
//			}
//			if(filesDw.keySet().size()>0 && !filesDw.isEmpty()){
//				result = fileUtil.parseFileInf(filesDw, "QMS", 0, "", "QMS/DOWN");
//				atchFileId = fileMngService.insertFileInfs(result);
//			    freeVO.setQmDwfile(atchFileId);
//			}
//			//답안(excel)파일 저장
//			final Map<String, MultipartFile> filesAs = multiRequest.getFileMap();
//			filesAs.remove("dwfile");
//			Object[] fileseKey2 = filesAs.keySet().toArray();
//			for(int keyNo=0;keyNo<fileseKey2.length;keyNo++){
//					filesAs.remove("examfile_"+Integer.toString(keyNo));
//			}
//			if(filesAs.keySet().size()>0 && !filesAs.isEmpty()){
//				result = fileUtil.parseFileInf(filesAs, "QMS", 0, "", "QMS/ANSW");
//				atchFileId = fileMngService.insertFileInfs(result);
//			    freeVO.setQmAsfile(atchFileId);
//
//			    //--- 엑셀 파싱 시작 ----
//			    Iterator<Entry<String, MultipartFile>> itr = filesAs.entrySet().iterator();
//				MultipartFile file;
//				List<ListOrderedMap> CalInfoList = null;
//				while (itr.hasNext()) {
//					Entry<String, MultipartFile> entry = itr.next();
//					file = entry.getValue();
//					if (!"".equals(file.getOriginalFilename())) {
//						if (!file.getOriginalFilename().toUpperCase().endsWith(".XLSX")) {
//							return "noneXlsx";
//						}
//						CalInfoList = actQuestionManageService.eduAppExcellSet(freeVO, file.getInputStream());
//						//sub 저장 s-------------------------------------------------------------------------------------------------------------
//						if(CalInfoList != null && CalInfoList.size()>0){
//							for(int i = 0;i<CalInfoList.size();i++){
//								Map<String,String> calMap = (Map<String,String>) CalInfoList.get(i);
//								freeVO.setQsNum(calMap.get("qsNum"));
//								freeVO.setQsAns(calMap.get("qsAns"));
//								actQuestionManageService.insertActQuestionSub(freeVO);
//							}
//							freeVO.setQmCnt(String.valueOf(CalInfoList.size()));
//						}
//						//sub 저장 e-------------------------------------------------------------------------------------------------------------
//					}
//				}
//			    //--- 엑셀 파싱 종료 ----
//			
//			}
////파일 저장 e-------------------------------------------------------------------------------------------------------------
//
//		actQuestionManageService.insertActQuestion(freeVO);
//		return retstr;
//	}
//
//	@SuppressWarnings("unchecked")
//	@RequestMapping("/boffice/actQuestion/modifyActQuestion.do")
//	@ResponseBody
//	public String updateActQuestion(final MultipartHttpServletRequest multiRequest, @ModelAttribute("freeVO") ActQuestionManageVO freeVO, ModelMap model) throws Exception {
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
//		String exFileId = freeVO.getQmExfile();
//		String dwFileId = freeVO.getQmDwfile();
//		String asFileId = freeVO.getQmAsfile();
//	
//		//전체 파일의 확장자 체크
//		if(!checkImgUpLoadFile(multiRequest,2)) return "noneEx";
//	
//			final Map<String, MultipartFile> files = multiRequest.getFileMap();
//			files.remove("dwfile");
//			files.remove("asfile");
//		    if (!files.isEmpty()) {
//				if ("".equals(exFileId)) {
//				    List<FileVO> result = fileUtil.parseFileInf(files, "QMS", 0, exFileId, "QMS/EXAM");
//				    exFileId = fileMngService.insertFileInfs(result);
//				    freeVO.setQmExfile(exFileId);
//				} else {
//				    FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(exFileId);
//				    int cnt = fileMngService.getMaxFileSN(fvo);
//				    List<FileVO> _result = fileUtil.parseFileInf(files, "QMS", cnt, exFileId, "QMS/EXAM");
//				    fileMngService.updateFileInfs(_result);
//				}
//		    }
//			//다운(hwp)파일 저장
//			final Map<String, MultipartFile> filesDw = multiRequest.getFileMap();
//			filesDw.remove("asfile");
//			Object[] fileseKey = filesDw.keySet().toArray();
//			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
//					filesDw.remove("examfile_"+Integer.toString(keyNo));
//			}
//			MultipartFile fileCheckItem = multiRequest.getFile("dwfile");
//			if(filesDw.keySet().size()>0 && !filesDw.isEmpty() && !fileCheckItem.isEmpty()){
//				if ("".equals(dwFileId)) {
//				    List<FileVO> result = fileUtil.parseFileInf(filesDw, "QMS", 0, "", "QMS/DOWN");
//				    dwFileId = fileMngService.insertFileInfs(result);
//				    freeVO.setQmDwfile(dwFileId);
//				} else {
//				    FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(dwFileId);
//				    List<FileVO> result = fileUtil.parseFileInf(filesDw, "QMS", 0, dwFileId, "QMS/DOWN");
//				    fileMngService.updateFileInfs(result);
//				}
//		    }
//			//답안(excel)파일 저장
//			final Map<String, MultipartFile> filesAs = multiRequest.getFileMap();
//			filesAs.remove("dwfile");
//			Object[] fileseKey2 = filesAs.keySet().toArray();
//			for(int keyNo=0;keyNo<fileseKey2.length;keyNo++){
//					filesAs.remove("examfile_"+Integer.toString(keyNo));
//			}
//			MultipartFile fileCheckItem2 = multiRequest.getFile("asfile");
//			if(filesAs.keySet().size()>0 && !filesAs.isEmpty() && !fileCheckItem2.isEmpty()){
//				if ("".equals(asFileId)) {
//				    List<FileVO> result = fileUtil.parseFileInf(filesAs, "QMS", 0, "", "QMS/ANSW");
//				    asFileId = fileMngService.insertFileInfs(result);
//				    freeVO.setQmAsfile(asFileId);
//				} else {
//				    FileVO fvo = new FileVO();
//				    fvo.setAtchFileId(asFileId);
//				    List<FileVO> result = fileUtil.parseFileInf(filesAs, "QMS", 0, asFileId, "QMS/ANSW");
//				    fileMngService.updateFileInfs(result);
//				}
//				
//			    //--- 엑셀 파싱 시작 ----
//				Iterator<Entry<String, MultipartFile>> itr = filesAs.entrySet().iterator();
//				MultipartFile file;
//				List<ListOrderedMap> CalInfoList = null;
//				while (itr.hasNext()) {
//					Entry<String, MultipartFile> entry = itr.next();
//					file = entry.getValue();
//					if (!"".equals(file.getOriginalFilename())) {
//						if (!file.getOriginalFilename().toUpperCase().endsWith(".XLSX")) {
//							return "noneXlsx";
//						}
//						CalInfoList = actQuestionManageService.eduAppExcellSet(freeVO, file.getInputStream());
//						//sub 저장 s-------------------------------------------------------------------------------------------------------------
//						if(CalInfoList != null && CalInfoList.size()>0){
//							actQuestionManageService.deleteActQuestionSub(freeVO);
//							for(int i = 0;i<CalInfoList.size();i++){
//								Map<String,String> calMap = (Map<String,String>) CalInfoList.get(i);
//								freeVO.setQsNum(calMap.get("qsNum"));
//								freeVO.setQsAns(calMap.get("qsAns"));
//								actQuestionManageService.insertActQuestionSub(freeVO);
//							}
//							freeVO.setQmCnt(String.valueOf(CalInfoList.size()));
//						}
//						//sub 저장 e-------------------------------------------------------------------------------------------------------------
//					}
//				}
//			    //--- 엑셀 파싱 종료 ----
//			
//		    }
//
//		actQuestionManageService.updateActQuestion(freeVO);
//		return "success";
//	}
//
//	@RequestMapping("/boffice/actQuestion/deleteActQuestion.do")
//	@ResponseBody
//	public String deleteActQuestion(@ModelAttribute("freeVO") ActQuestionManageVO freeVO, ModelMap model) throws Exception {
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
//		actQuestionManageService.deleteActQuestion(freeVO);
//		return "success";
//	}
//
}
