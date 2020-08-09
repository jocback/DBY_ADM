package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;
import java.io.File;
import java.util.ArrayList;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.EmailSender;
import egovframework.com.cmm.service.FileVO;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.util.GenExcelView;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.web.servlet.View;

@Controller
public class ActMembManageController extends ActCommonController {

	/** actMembManageService */
	@Resource(name = "ActMembManageService")
	private ActMembManageService actMembManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "EmailSender")
	private EmailSender emailSender;

	@Autowired
	ServletContext context;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "109";
	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actMemb/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actMemb/selectMembListEmail.do")
	public String selectMembListEmail(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setSearchCnd3("Y");
		searchVO.setPageView("EXCEL");
		List<?> colValue = actMembManageService.selectActMembList(searchVO);
		model.addAttribute("resultList",colValue);
		String fileName = "회원이메일리스트_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("text/txt;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".txt");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actMemb/membListEmail";
	}

	@RequestMapping(value = "/boffice/actMemb/actMembList.do")
	public String selectMembListView(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		Map<String, Object> totCnt = actMembManageService.selectActMemTotCnt(searchVO);
		model.addAttribute("totCnt", totCnt);
		Map<String, Object> loginTotCnt = actMembManageService.selectActMemLoginTotCnt(searchVO);
		model.addAttribute("loginTotCnt", loginTotCnt);
		Map<String, Object> condTotCnt = actMembManageService.selectActMemCondTotCnt(searchVO);
		model.addAttribute("condTotCnt", condTotCnt);
		searchVO.setPageUnit(20);
		selectMembList(searchVO, model);
        model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actMemb/membList";
	}
	@RequestMapping(value = "/boffice/actMemb/actMembListPop.do")
	public String selectMembListPop(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setPageUnit(10);
		selectMembList(searchVO, model);
		return "/boffice/actMemb/membListPop";
	}
	@RequestMapping(value = "/boffice/actMemb/actProfList.do")
	public String selectProfListView(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("112")){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setSearchActgubun("21");
		searchVO.setPageUnit(20);
		selectMembList(searchVO, model);
        model.addAttribute("menuCode", "112");
		return "/boffice/actMemb/professorList";
	}
	public void selectMembList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService */
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		/*if(searchVO.getSearchOp1() == null || searchVO.getSearchOp1().length()<1){
			searchVO.setSearchOp1("11");
		}*/

		List<?> userList = actMembManageService.selectActMembList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actMembManageService.selectActMembListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

	}
	
	@RequestMapping("/boffice/actMemb/downloadActMembExcel.do")
	public View downloadActMembExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		List<String> colName = new ArrayList<String>();
		colName.add("번호");
		colName.add("구분");
		colName.add("이름");
		colName.add("아이디");
		colName.add("이메일");
		colName.add("연락처");
		colName.add("가입경로");
		colName.add("가입일");
		String[] colNmArr = new String[colName.size()];
		colNmArr[0] = "RN";
		colNmArr[1] = "ISNULL(M_GUBUN,'') M_GUBUN";
		colNmArr[2] = "ISNULL(M_NAME,'') M_NAME";
		colNmArr[3] = "ISNULL(M_ID,'') M_ID";
		colNmArr[4] = "ISNULL(M_EMAIL,'') M_EMAIL";
		colNmArr[5] = "ISNULL(M_HP,'') M_HP";
		colNmArr[6] = "ISNULL(M_WAY,'') M_WAY";
		colNmArr[7] = "ISNULL(REGDT_C,'') REGDT_C";
		searchVO.setReturnItem(colNmArr);
		searchVO.setPageView("EXCEL");
		List<?> colValue = actMembManageService.selectActMembList(searchVO);
		model.put("excelName", "회원목록");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}

	@RequestMapping("/boffice/actMemb/downloadActProfExcel.do")
	public View downloadActProfExcel(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return null;
		}
		List<String> colName = new ArrayList<String>();
		colName.add("번호");
		colName.add("순서");
		colName.add("이름");
		colName.add("아이디");
		colName.add("성별");
		colName.add("이메일");
		colName.add("연락처");
		colName.add("전공과목");
		colName.add("노출");
		colName.add("강의수");
		String[] colNmArr = new String[colName.size()];
		colNmArr[0] = "RN";
		colNmArr[1] = "ISNULL(P_SEQ,'') P_SEQ";
		colNmArr[2] = "ISNULL(M_NAME,'') M_NAME";
		colNmArr[3] = "ISNULL(M_ID,'') M_ID";
		colNmArr[4] = "ISNULL(M_SEX,'') M_SEX";
		colNmArr[5] = "ISNULL(M_EMAIL,'') M_EMAIL";
		colNmArr[6] = "ISNULL(M_HP,'') M_HP";
		colNmArr[7] = "ISNULL(P_MAJOR,'') P_MAJOR";
		colNmArr[8] = "ISNULL(P_SHOW,'') P_SHOW";
		colNmArr[9] = "ISNULL(LEC_CNT,'') LEC_CNT";
		searchVO.setReturnItem(colNmArr);
		searchVO.setPageView("EXCEL");
		searchVO.setSearchActgubun("21");
		List<?> colValue = actMembManageService.selectActMembList(searchVO);
		model.put("excelName", "교수목록");
		model.put("colName", colName);
		model.put("colValue", colValue);

		return new GenExcelView();
	}

	@RequestMapping("/boffice/actMemb/actMembView.do")
	public String selectActMembDetailView(@ModelAttribute("searchVO") ActMembManageVO actMembManageVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		Map<String, Object> vo = actMembManageService.selectActMembDetail(actMembManageVO);
		model.addAttribute("resultInfo", vo);
		actMembManageVO.setmId((String) vo.get("mId"));
		List<?> equipList = actMembManageService.selectActEquipList(actMembManageVO);
		model.addAttribute("equipList", equipList);
        model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actMemb/membView";
	}
	
	@RequestMapping("/boffice/actMemb/actProfView.do")
	public String selectActProfDetailView(@ModelAttribute("searchVO") ActMembManageVO actMembManageVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("112")){
			return MENU_AUTH_REDIRECT;
		}
		Map<String, Object> vo = actMembManageService.selectActMembDetail(actMembManageVO);
		model.addAttribute("resultInfo", vo);
		ActLecCodeManageVO lecCodeVO = new ActLecCodeManageVO();
		lecCodeVO.setCodeGb("CL");
        List<?> SbtCodeManageList =actLecCodeManageService.selectLecCodeManageList(lecCodeVO);
        model.addAttribute("clCodeList", SbtCodeManageList);
        model.addAttribute("menuCode", "112");
		return "/boffice/actMemb/professorView";
	}

	@RequestMapping("/boffice/actMemb/modifyActMemb.do")
	@ResponseBody
	public String updateActMemb(final MultipartHttpServletRequest multiRequest, @ModelAttribute("actMembManageVO") ActMembManageVO actMembManageVO)
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
		actMembManageVO.setModid(lastUpdusrId); // 최종수정자ID

		//파일 저장 s-------------------------------------------------------------------------------------------------------------
		String atchFileId = actMembManageVO.getFileid();
		String thumFileId = actMembManageVO.getThumId();
		actMembManageVO.setmPic(thumFileId);
		actMembManageVO.setpBanner(atchFileId);
		int fileIdCnt = 0;
	
		if(!checkImgUpLoadFile(multiRequest,1)) return "ERR_PIC";
		if("21".equals(actMembManageVO.getmGubun()) && !isNull(actMembManageVO.getpIdx())){
//파일 저장 s-------------------------------------------------------------------------------------------------------------
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			files.remove("fileThum");
		    if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
				    List<FileVO> result = fileUtil.parseFileInf(files, "GINFO_", 0, "", "GINFO");
				    atchFileId = fileMngService.insertFileInfs(result);
				    actMembManageVO.setFileid(atchFileId);
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    //int cnt = fileMngService.getMaxFileSN(fvo);
					Object[] fileseKey = files.keySet().toArray();
					fileIdCnt = fileseKey.length;
					String delFile[] = {""};
					String fileSnum[] = {"0"};
					if(!isNull(actMembManageVO.getFileDel())){
						delFile = (actMembManageVO.getFileDel()).split(",",fileseKey.length);
						fileSnum = (actMembManageVO.getFileSnum()).split(",",fileseKey.length);
					}
					//파일 삭제하기 위한 FileVO생성
					FileVO filevo = new FileVO();
					//
					if(!isNull(atchFileId) && actMembManageVO.getFileSnum() != null){
						int cnt = 0;
						for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
							if(fileSnum.length > keyNo){
								if("Y".equals(delFile[keyNo])){
									filevo.setAtchFileId(atchFileId);
									filevo.setFileSn(fileSnum[keyNo]);
									deleteUpLoadFile(filevo);
								}
							}
							if(!files.get(fileseKey[keyNo]).isEmpty()){
								if(fileSnum.length > keyNo){
									if(!"Y".equals(delFile[keyNo])){
										filevo.setAtchFileId(atchFileId);
										filevo.setFileSn(fileSnum[keyNo]);
										deleteUpLoadFile(filevo);
									}
								}
								if(fileSnum.length >= fileseKey.length){
									cnt = Integer.parseInt(fileSnum[keyNo]);
								}else{
									cnt = fileMngService.getMaxFileSN(fvo);
								}
								final Map<String, MultipartFile> filesJJ = multiRequest.getFileMap();
								filesJJ.remove("fileThum");
								Object[] fileseKeyJJ = filesJJ.keySet().toArray();
								for(int jj=0;jj<fileseKeyJJ.length;jj++){
									if(!(filesJJ.get(fileseKeyJJ[jj]).getName()).equals(files.get(fileseKey[keyNo]).getName())){
										filesJJ.remove(filesJJ.get(fileseKeyJJ[jj]).getName());
									}
								}
							    List<FileVO> _result = fileUtil.parseFileInf(filesJJ, "GINFO_", cnt, atchFileId, "GINFO");
							    fileMngService.updateFileInfs(_result);
							}
						} //for
					}else{ //atchFileId 가 있을 경우 업데이트
					    List<FileVO> _result = fileUtil.parseFileInf(files, "GINFO_", 0, "", "GINFO");
						atchFileId = fileMngService.insertFileInfs(_result);
						actMembManageVO.setFileid(atchFileId);
					}
				}
		    }
			final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			Object[] fileseKey = filesThum.keySet().toArray();
			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
				filesThum.remove("file_"+Integer.toString(keyNo));
			}
			//파일 삭제하기 위한 FileVO생성
			FileVO filevo = new FileVO();
			filevo.setAtchFileId(thumFileId);
			filevo.setFileSn("0");
			//파일 삭제하기 위한 FileVO생성
			if("Y".equals(actMembManageVO.getThumDel())){
				deleteUpLoadFile(filevo);
				actMembManageVO.setThumId("");
			}
			MultipartFile fileCheckItem = multiRequest.getFile("fileThum");
			if(filesThum.keySet().size()>0 && !filesThum.isEmpty() && !fileCheckItem.isEmpty()){
				if(actMembManageVO.getThumDel()!=null){
					deleteUpLoadFile(filevo);
				}
			    List<FileVO> result = fileUtil.parseFileInf(filesThum, "GINFO_", 0, "", "GINFO/THUM");
			    thumFileId = fileMngService.insertFileInfs(result);
			    actMembManageVO.setThumId(thumFileId);
		    }

			if(!isNull(actMembManageVO.getFileSnum())){
				String[] fileCn = (actMembManageVO.getFileCn()).split(",",fileIdCnt);
				String[] fileSn = (actMembManageVO.getFileSnum()).split(",",fileIdCnt);
				FileVO fvoCn = new FileVO();
				fvoCn.setAtchFileId(actMembManageVO.getpBanner());
				for(int i=0;i<fileCn.length;i++){
					if(i<fileSn.length){
						fvoCn.setFileSn(fileSn[i]);
					}else{
						fvoCn.setFileSn(String.valueOf(Integer.valueOf(fileSn[fileSn.length-1])+(fileCn.length-i)));
					}
					fvoCn.setFileCn(fileCn[i]);
					fileMngService.updateFileCn(fvoCn);
				}
			}
			//파일 저장 e-------------------------------------------------------------------------------------------------------------
		}
		actMembManageService.updateActMemb(actMembManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actMemb/deleteActMemb.do")
	@ResponseBody
	public String deleteActMemb(@ModelAttribute("actMembManageVO") ActMembManageVO actMembManageVO)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
	    if(isNull(actMembManageVO.getSearchChk())){
	    	actMembManageVO.setSearchChk(String.valueOf(actMembManageVO.getmIdx()));
	    }
	    String[] mIdxArr = (actMembManageVO.getSearchChk()).split(",");
	    actMembManageVO.setdSta("관리자삭제");
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		actMembManageVO.setModid(lastUpdusrId); // 최종수정자ID
	    for(int i=0;i<mIdxArr.length;i++){
	    	actMembManageVO.setmIdx((mIdxArr[i]));
	    	actMembManageService.deleteActMemb(actMembManageVO);
	    }
		return "success";
	}

	@RequestMapping("/boffice/actMemb/updateProfSeq.do")
	@ResponseBody
	public String updateProfSeq(@ModelAttribute("actMembManageVO") ActMembManageVO actMembManageVO)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
	    String[] mIdxArr = (actMembManageVO.getmIdx()).split(",");
	    String[] mpSeqArr = (actMembManageVO.getpSeq()).split(",",mIdxArr.length);
	    actMembManageVO.setdSta("관리자삭제");
	    for(int i=0;i<mIdxArr.length;i++){
	    	actMembManageVO.setmIdx((mIdxArr[i]));
	    	actMembManageVO.setpSeq((mpSeqArr[i]));
	    	actMembManageService.updateProfSeq(actMembManageVO);
	    }
		return "success";
	}

	@RequestMapping("/boffice/actMemb/insertActMemb.do")
	@ResponseBody
	public String insertActMemb(@ModelAttribute("actMembManageVO") ActMembManageVO actMembManageVO, BindingResult bindingResult, Model model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		
		String retstr = "success";

		beanValidator.validate(actMembManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actMembManageVO.setModid(lastUpdusrId); // 최종수정자ID
			actMembManageService.insertActMemb(actMembManageVO);
		}
		return retstr;
	}

	@RequestMapping("/boffice/actMemb/deleteActEquip.do")
	@ResponseBody
	public String deleteActEquip(@ModelAttribute("searchVO") ActManageDefaultVO searchVO)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
    	actMembManageService.deleteActEquip(searchVO);
		return "success";
	}

	@RequestMapping("/boffice/actMemb/delMemoActMembInfo.do")
	@ResponseBody
	public String delMemoActMembInfo(@ModelAttribute("membVO") ActMembManageVO membVO)
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
		membVO.setModid(lastUpdusrId); // 최종수정자ID
    	actMembManageService.delMemoActMembInfo(membVO);
		return "success";
	}

	@RequestMapping("/boffice/actMemb/cancelDelActMemb.do")
	@ResponseBody
	public String cancelDelActMemb(@ModelAttribute("membVO") ActMembManageVO membVO)
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
		membVO.setModid(lastUpdusrId); // 최종수정자ID
    	actMembManageService.cancelDelActMemb(membVO);
		return "success";
	}

	@RequestMapping("/boffice/actMemb/withdrawActMembInfo.do")
	@ResponseBody
	public String withdrawActMembInfo(@ModelAttribute("membVO") ActMembManageVO membVO)
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
		membVO.setModid(lastUpdusrId); // 최종수정자ID
    	actMembManageService.withdrawActMembInfo(membVO);
		return "success";
	}

	@RequestMapping(value = "/boffice/actMemb/actMembDelList.do")
	public String selectMembDelList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("151")){
			return MENU_AUTH_REDIRECT;
		}
		/** EgovPropertyService */
		searchVO.setPageUnit(20);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		/*if(searchVO.getSearchOp1() == null || searchVO.getSearchOp1().length()<1){
			searchVO.setSearchOp1("11");
		}*/

		List<?> userList = actMembManageService.selectActMembDelList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actMembManageService.selectActMembDelListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("menuCode", "151");
		return "/boffice/actMemb/membDelList";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/boffice/actMemb/actMembSendMail.do")
	@ResponseBody
	public String actMembSendMail(@ModelAttribute("membVO") ActMembManageVO membVO)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String mailResult = "";
		String addMail = "";
		ActManageDefaultVO searchVO = new ActManageDefaultVO();
		searchVO.setSearchCnd3("Y");
		searchVO.setReturnStt(membVO.getmIdx());
		searchVO.setPageView("EXCEL");
		List<?> resultList = actMembManageService.selectActMembList(searchVO);
		for(int i=0;i<resultList.size();i++){
			Map<String, Object> vo = (Map<String,Object>) resultList.get(i);
			if(!isNull((String) vo.get("mEmail"))){
				addMail = addMail + (String) vo.get("mEmail");
				if(i < resultList.size()-1){
					addMail = addMail + ",";
				}
			}
		}
		//이메일 전송
		try {
			String mailSubject = membVO.getFileid();
			String mailHtml = "";
			String mailFolder = context.getRealPath("/html/mail//");
			String mailTpl = mailFolder+"/memMail.html";
			File file = new File(mailTpl);
			mailHtml = FileUtil.readAsString(file);
			mailHtml = mailHtml.replace("[MAIL_SUBJECT]", mailSubject);
			mailHtml = mailHtml.replace("[MAIL_CON]", membVO.getFileCn());
			if(!isNull(addMail)){
				emailSender.send(addMail, mailSubject, mailHtml);
			}
          // 메일 전송 성공
			mailResult = "메일전송성공";
		} catch(Exception ne) {
			ne.printStackTrace();
			mailResult = "메일전송실패";
		} finally {
			System.out.println("Email_sending===>>>"+mailResult);
		}
		//이메일 전송
		return "success";
	}

}
