package egovframework.MUSE_ADMIN.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.util.StringUtil;
import egovframework.MUSE_ADMIN.service.ActEmpManageService;
import egovframework.MUSE_ADMIN.service.ActEmpManageVO;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_Rte.cop.bbs.service.CkeditorVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterManageService;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageService;
import egovframework.MUSE_Rte.utl.fcc.service.EgovFileUploadUtil;
import egovframework.MUSE_Rte.utl.fcc.service.EgovFormBasedFileUtil;
import egovframework.MUSE_Rte.utl.fcc.service.EgovFormBasedFileVo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;


@Controller
public class ActBbsManageController extends ActCommonController {
	
    @Resource(name = "BoardManageService")
    private BoardManageService bbsMngService;

    @Resource(name = "BoardMasterManageService")
    private BoardMasterManageService bbsAttrbService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "ActEmpManageService")
	private ActEmpManageService actEmpManageService;	

	@Resource(name = "ActStatManageService")
	private ActStatManageService actStatManageService;

    @Autowired
    private DefaultBeanValidator beanValidator;

    //protected Logger log = Logger.getLogger(this.getClass());
    
 	final String getMenuCode(String cd) throws Exception{
 		return cmmUseService.selectFieldDataOne("CODE_DT","CODE","CODE_ID+CODE_ETC1","COM041"+cd);
 	}

 	/**
     * 게시물에 대한 목록을 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/bbsList.do")
    public String selectBoardArticles(@ModelAttribute("searchVO") BoardManageVO boardVO, ModelMap model) throws Exception {
    	
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
	
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		vo.setId(user.getId());
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
		
		boardVO.setPageUnit(20);
		boardVO.setPageSize(propertyService.getInt("pageSize"));	
		
		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setPageSize(boardVO.getPageSize());
		
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	    boardVO.setExtYn(master.getExtYn());
	    
		//Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO);//2011.09.07
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
	
		model.addAttribute("currDate", getDateTransStrSp(getCurrDate(),"-"));
		if("Y".equals(master.getNewYn())){
			String newNo = master.getNewNo();
			if(isNull(newNo) || !isNumeric(newNo)){
				newNo = "1";
			}
			model.addAttribute("newDate", getDateTransStrSp(addDateDay(getCurrDate(),0,0,-(Integer.parseInt(newNo))),"-"));
		}
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("menuCode", getMenuCode(boardVO.getBbsId()));
		String retView = "/boffice/contents/bbsList";
		return retView;
		
    }

    /**
     * 게시물에 대한 상세 정보를 조회한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/viewAritcle.do")
    public String selectBoardArticle(ActEmpManageVO actEmpManageVO, @ModelAttribute("searchVO") BoardManageVO boardVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		// 조회수 증가 여부 지정
		boardVO.setPlusCount(true);
		if (!boardVO.getSubPageIndex().equals("")) {
		    boardVO.setPlusCount(false);
		}
		boardVO.setModid(user.getId());
		BoardManageVO vo = bbsMngService.selectBoardArticle(boardVO);
		model.addAttribute("result", vo);
		model.addAttribute("sessionUserId", user.getId());
		actEmpManageVO.setEmpId(user.getId());
		Map<String, Object> orgvo = actEmpManageService.selectActEmpDetail(actEmpManageVO);
		model.addAttribute("resultInfo", orgvo);
		BoardMasterVO master = new BoardMasterVO();
		master.setBbsId(boardVO.getBbsId());
		master.setId(user.getId());
		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
	    //확장필드 이용일 경우 확장 필드 할당
	    if("Y".equals(masterVo.getExtYn()) && !isNull(masterVo.getExtFld())){
			Map<String,String> extMapList = getExtMapList(masterVo.getExtFld());
			model.addAttribute("extMapList", extMapList);
	        BoardManageVO voExt = bbsMngService.selectBoardExtField(boardVO);
			model.addAttribute("resultExt", voExt);
	    }
	    //확장필드 이용일 경우 확장 필드 할당

		Map<String, Object> voTwo = bbsMngService.selectBoardTwoArticle(boardVO);
		model.addAttribute("resultTwo", voTwo);
        model.addAttribute("menuCode", getMenuCode(boardVO.getBbsId()));
		model.addAttribute("brdMstrVO", masterVo);
		
		if("BBS_0018".equals(boardVO.getBbsId())){
			List<?> downList = actStatManageService.selectActStatBbsDw(boardVO);
			model.addAttribute("downList", downList);
		}
		return "/boffice/contents/bbsView";
    }

    /**
     * 게시물 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/writeArticle.do")
    public String addBoardArticle(@ModelAttribute("searchVO") BoardManageVO boardVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		BoardMasterVO bdMstr = new BoardMasterVO();
	
		if (isAuthenticated) {
	
		    BoardMasterVO vo = new BoardMasterVO();
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setId(user.getId());
	
		    bdMstr = bbsAttrbService.selectBBSMasterInf(vo);

		    //확장필드 이용일 경우 확장 필드 할당
		    if("Y".equals(bdMstr.getExtYn()) && !isNull(bdMstr.getExtFld())){
				Map<String,String> extMapList = getExtMapList(bdMstr.getExtFld());
				model.addAttribute("extMapList", extMapList);
		    }
		    //확장필드 이용일 경우 확장 필드 할당

		    model.addAttribute("bdMstr", bdMstr);
		}
	
		bdMstr.setCurrDate(getDateTransStrSp(getCurrDate(),"."));
		model.addAttribute("user", user);
		model.addAttribute("brdMstrVO", bdMstr);
		model.addAttribute("currDate", getDateTransStrSp(getCurrDate(),"-"));
        model.addAttribute("menuCode", getMenuCode(boardVO.getBbsId()));
	
		return "/boffice/contents/bbsModify";
    }

    /**
     * 게시물을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/insertBoardArticle.do")
    public String insertBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardManageVO boardVO,
	    @ModelAttribute("bdMstr") BoardMasterVO bdMstr, @ModelAttribute("board") BoardManageVO board, BindingResult bindingResult, SessionStatus status,
	    ModelMap model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(getMenuCode(boardVO.getBbsId()),1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors() || !checkImgUpLoadFile(multiRequest,3)) {
		    BoardMasterVO master = new BoardMasterVO();
		    BoardMasterVO vo = new BoardMasterVO();
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setId(user.getId());
		    master = bbsAttrbService.selectBBSMasterInf(vo);
		    if(!checkImgUpLoadFile(multiRequest,3)){
		    	board.setAtchFileId("NONEX");
		    }
		    master.setCurrDate(board.getNttRegdt());
		    user.setName(board.getNtcrNm());
		    model.addAttribute("user", user);
		    model.addAttribute("bdMstr", master);
		    model.addAttribute("brdMstrVO", master);
		    model.addAttribute("boardVO", board);
			return "/boffice/contents/bbsModify";
		}
		
		if (isAuthenticated) {

//파일 저장 s-------------------------------------------------------------------------------------------------------------
			
			List<FileVO> result = null;
			String atchFileId = "";
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			files.remove("fileThum");
			if(!files.isEmpty()){
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "BBS");
				atchFileId = fileMngService.insertFileInfs(result);
			    board.setAtchFileId(atchFileId);
			}
			//final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			Object[] fileseKey = filesThum.keySet().toArray();
			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
					filesThum.remove("file_"+Integer.toString(keyNo));
			}
			if(filesThum.keySet().size()>0 && !filesThum.isEmpty()){
				result = fileUtil.parseFileInf(filesThum, "BBS_", 0, "", "BBS/THUM");
				atchFileId = fileMngService.insertFileInfs(result);
			    board.setThumFileId(atchFileId);
			}
//파일 저장 e-------------------------------------------------------------------------------------------------------------
		    
		    
		    
		    board.setRegid(user.getId());
		    board.setBbsId(board.getBbsId());
		    
		    //board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    board.setNttPsw("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    
		    //board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
		    board.setRegip(multiRequest.getRemoteAddr());
		    bbsMngService.insertBoardArticle(board);
		}
	
		//status.setComplete();
		return "forward:/boffice/bbs/bbsList.do";
    }

    /**
     * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardVO
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/writeReplyArticle.do")
    public String addReplyBoardArticle(@ModelAttribute("searchVO") BoardManageVO boardVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
	
		BoardMasterVO master = new BoardMasterVO();
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		vo.setId(user.getId());
	
		master = bbsAttrbService.selectBBSMasterInf(vo);
		
		model.addAttribute("bdMstr", master);
		model.addAttribute("result", boardVO);
	
		model.addAttribute("user", user);
		model.addAttribute("brdMstrVO", master);
		////-----------------------------

		model.addAttribute("currDate", getDateTransStrSp(getCurrDate(),"-"));
		BoardManageVO tvo = bbsMngService.selectBoardArticle(boardVO);
		model.addAttribute("Tresult", tvo);
        model.addAttribute("menuCode", getMenuCode(boardVO.getBbsId()));
	
		return "/boffice/contents/replyWrite";
    }

    /**
     * 게시물에 대한 답변을 등록한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/insertReplyArticle.do")
    public String replyBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardManageVO boardVO,
	    @ModelAttribute("bdMstr") BoardMasterVO bdMstr, @ModelAttribute("board") BoardManageVO board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

    	//관리자로그 기록
    	webLogInsert(getMenuCode(boardVO.getBbsId()),1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors() || !checkImgUpLoadFile(multiRequest,3)) {
		    BoardMasterVO master = new BoardMasterVO();
		    BoardMasterVO vo = new BoardMasterVO();
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setId(user.getId());
		    master = bbsAttrbService.selectBBSMasterInf(vo);
		    if(!checkImgUpLoadFile(multiRequest,3)){
		    	board.setAtchFileId("NONEX");
		    }
		    model.addAttribute("user", user);
		    model.addAttribute("bdMstr", master);
		    model.addAttribute("result", boardVO);
		    model.addAttribute("boardVO", board);
		    model.addAttribute("brdMstrVO", master);
		    return "/boffice/contents/replyWrite";
		}
	
		if (isAuthenticated) {

//파일 저장 s-------------------------------------------------------------------------------------------------------------
			List<FileVO> result = null;
			String atchFileId = "";
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			files.remove("fileThum");
			if(!files.isEmpty()){
				result = fileUtil.parseFileInf(files, "BBS_", 0, "", "BBS");
				atchFileId = fileMngService.insertFileInfs(result);
			    board.setAtchFileId(atchFileId);
			}
			//final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			Object[] fileseKey = filesThum.keySet().toArray();
			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
					filesThum.remove("file_"+Integer.toString(keyNo));
			}
			if(filesThum.keySet().size()>0 && !filesThum.isEmpty()){
				result = fileUtil.parseFileInf(filesThum, "BBS_", 0, "", "BBS/THUM");
				atchFileId = fileMngService.insertFileInfs(result);
			    board.setThumFileId(atchFileId);
			}
//파일 저장 e-------------------------------------------------------------------------------------------------------------
	
		    board.setAtchFileId(atchFileId);

			BoardManageVO tvo = bbsMngService.selectBoardArticle(boardVO);
			board.setNttPsw(tvo.getNttPsw());
		    board.setReplyAt("Y");
		    board.setRegid(user.getId());
		    board.setBbsId(board.getBbsId());
		    board.setReplyNo(Long.toString(boardVO.getNttId()));
		    board.setSortOrdr(boardVO.getSortOrdr());
		    board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(unscript(board.getNtcrNm())); //게시물 통계 집계를 위해 등록자 Name 저장
		    //board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    board.setRegip(multiRequest.getRemoteAddr());
		    
		    bbsMngService.insertBoardArticle(board);
		}
		
		return "forward:/boffice/bbs/bbsList.do";
    }
    @RequestMapping("/boffice/bbs/modifyReplyArticle.do")
    public String replyBoardArticleupdate(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardManageVO boardVO,
	    @ModelAttribute("bdMstr") BoardMasterVO bdMstr, @ModelAttribute("board") BoardManageVO board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {

    	//관리자로그 기록
    	webLogInsert(getMenuCode(boardVO.getBbsId()),1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}

		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		String atchFileId = boardVO.getAtchFileId();
		String thumFileId = boardVO.getThumFileId();
	
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors() || !checkImgUpLoadFile(multiRequest,3)) {
		    BoardMasterVO master = new BoardMasterVO();
		    BoardMasterVO vo = new BoardMasterVO();
		    vo.setBbsId(boardVO.getBbsId());
		    vo.setId(user.getId());
		    master = bbsAttrbService.selectBBSMasterInf(vo);
		    if(!checkImgUpLoadFile(multiRequest,3)){
		    	board.setAtchFileId("NONEX");
		    }
		    model.addAttribute("user", user);
		    model.addAttribute("bdMstr", master);
		    model.addAttribute("result", boardVO);
		    model.addAttribute("boardVO", board);
		    model.addAttribute("brdMstrVO", master);
		    return "/boffice/contents/replyWrite";
		}
	
		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			files.remove("fileThum");
		    if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
				    List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "BBS");
				    atchFileId = fileMngService.insertFileInfs(result);
				    board.setAtchFileId(atchFileId);
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "BBS");
				    fileMngService.updateFileInfs(_result);
				}
		    }
			final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			//MultipartFile file = multiRequest.getFile("fileThum");
			Object[] fileseKey = filesThum.keySet().toArray();
			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
					filesThum.remove("file_"+Integer.toString(keyNo));
			}
			//files.put("fileThum", file);
			MultipartFile fileCheckItem = multiRequest.getFile("fileThum");
			if(filesThum.keySet().size()>0 && !filesThum.isEmpty() && !fileCheckItem.isEmpty()){
				if ("".equals(thumFileId)) {
				    List<FileVO> result = fileUtil.parseFileInf(filesThum, "BBS_", 0, "", "BBS/THUM");
				    thumFileId = fileMngService.insertFileInfs(result);
				    System.out.println("thumFileId==========>>"+thumFileId);
				    board.setThumFileId(thumFileId);
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(thumFileId);
				   // int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> result = fileUtil.parseFileInf(filesThum, "BBS_", 0, thumFileId, "BBS/THUM");
				    fileMngService.updateFileInfs(result);
				}
		    }
	
		    board.setReplyAt("Y");
		    board.setModid(user.getId());
		    board.setBbsId(board.getBbsId());
		    board.setReplyNo(Long.toString(boardVO.getNttId()));
		    board.setNttId(Long.parseLong(board.getReplyLc()));
		    board.setSortOrdr(boardVO.getSortOrdr());
		    //board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    //board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    board.setRegip(multiRequest.getRemoteAddr());
		    bbsMngService.updateBoardArticle(board);
		}
		
		return "forward:/boffice/bbs/bbsList.do";
    }

    /**
     * 게시물 수정을 위한 수정페이지로 이동한다.
     * 
     * @param boardVO
     * @param vo
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/forUpdateArticle.do")
    public String selectBoardArticleForUpdt(@ModelAttribute("searchVO") BoardManageVO boardVO, @ModelAttribute("board") BoardManageVO vo, ModelMap model)
	    throws Exception {
	
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getNttId "+boardVO.getNttId());
		//log.debug(this.getClass().getName()+"selectBoardArticleForUpdt getBbsId "+boardVO.getBbsId());
	
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		boardVO.setRegid(user.getId());
		
		BoardMasterVO master = new BoardMasterVO();
		BoardMasterVO bmvo = new BoardMasterVO();
		BoardManageVO bdvo = new BoardManageVO();
		
		vo.setBbsId(boardVO.getBbsId());
		
		master.setBbsId(boardVO.getBbsId());
		master.setId(user.getId());
	
		if (isAuthenticated) {
		    bmvo = bbsAttrbService.selectBBSMasterInf(master);
		    //확장필드 이용일 경우 확장 필드 할당
		    if("Y".equals(bmvo.getExtYn()) && !isNull(bmvo.getExtFld())){
				Map<String,String> extMapList = getExtMapList(bmvo.getExtFld());
				model.addAttribute("extMapList", extMapList);
		        BoardManageVO voExt = bbsMngService.selectBoardExtField(boardVO);
				model.addAttribute("resultExt", voExt);
		    }
		    if("BBS_0004".equals(bmvo.getBbsId()) || "BBS_0005".equals(bmvo.getBbsId())){
		        BoardManageVO voExt = bbsMngService.selectBoardExtField(boardVO);
				model.addAttribute("resultExt", voExt);		    	
		    }
		    //확장필드 이용일 경우 확장 필드 할당
		    bdvo = bbsMngService.selectBoardArticle(boardVO);
		}
	
		model.addAttribute("result", bdvo);
		model.addAttribute("bdMstr", bmvo);
	
		model.addAttribute("user", user);
		model.addAttribute("brdMstrVO", bmvo);
		
        model.addAttribute("menuCode", getMenuCode(boardVO.getBbsId()));
		return "/boffice/contents/bbsModify";
    }

    /**
     * 게시물에 대한 내용을 수정한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/updateBoardArticle.do")
    public String updateBoardArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardManageVO boardVO,
	    @ModelAttribute("bdMstr") BoardMasterVO bdMstr, @ModelAttribute("board") BoardManageVO board, BindingResult bindingResult, ModelMap model,
	    SessionStatus status) throws Exception {
	
    	//관리자로그 기록
    	webLogInsert(getMenuCode(boardVO.getBbsId()),1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		String atchFileId = boardVO.getAtchFileId();
		String thumFileId = boardVO.getThumFileId();
	
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors() || !checkImgUpLoadFile(multiRequest,3)) {
		    boardVO.setRegid(user.getId());
		    BoardMasterVO master = new BoardMasterVO();
		    BoardMasterVO bmvo = new BoardMasterVO();
		    BoardManageVO bdvo = new BoardManageVO();
		    if(!checkImgUpLoadFile(multiRequest,3)){
		    	board.setAtchFileId("NONEX");
		    }
		    master.setBbsId(boardVO.getBbsId());
		    master.setId(user.getId());
		    bmvo = bbsAttrbService.selectBBSMasterInf(master);
		    bdvo = bbsMngService.selectBoardArticle(boardVO);
		    model.addAttribute("user", user);
		    model.addAttribute("result", bdvo);
		    model.addAttribute("boardVO", board);
		    model.addAttribute("bdMstr", bmvo);
			return "/boffice/contents/bbsModify";
		}
		
		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			files.remove("fileThum");
		    if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
				    List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "BBS");
				    atchFileId = fileMngService.insertFileInfs(result);
				    board.setAtchFileId(atchFileId);
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "BBS");
				    fileMngService.updateFileInfs(_result);
				}
		    }
			final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
			//MultipartFile file = multiRequest.getFile("fileThum");
			Object[] fileseKey = filesThum.keySet().toArray();
			for(int keyNo=0;keyNo<fileseKey.length;keyNo++){
					filesThum.remove("file_"+Integer.toString(keyNo));
			}
			//files.put("fileThum", file);
			MultipartFile fileCheckItem = multiRequest.getFile("fileThum");
			if(filesThum.keySet().size()>0 && !filesThum.isEmpty() && !fileCheckItem.isEmpty()){
				if ("".equals(thumFileId)) {
				    List<FileVO> result = fileUtil.parseFileInf(filesThum, "BBS_", 0, "", "BBS/THUM");
				    thumFileId = fileMngService.insertFileInfs(result);
				    System.out.println("thumFileId==========>>"+thumFileId);
				    board.setThumFileId(thumFileId);
				} else {
				    FileVO fvo = new FileVO();
				    fvo.setAtchFileId(thumFileId);
				   // int cnt = fileMngService.getMaxFileSN(fvo);
				    List<FileVO> result = fileUtil.parseFileInf(filesThum, "BBS_", 0, thumFileId, "BBS/THUM");
				    fileMngService.updateFileInfs(result);
				}
		    }
	
		    board.setModid(user.getId());
		    
		    board.setNtcrId(user.getId()); //게시물 통계 집계를 위해 등록자 ID 저장
		    board.setNtcrNm(user.getName()); //게시물 통계 집계를 위해 등록자 Name 저장
		    board.setNttPsw("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		    
		    //board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
		    
		    board.setRegip(multiRequest.getRemoteAddr());
		    bbsMngService.updateBoardArticle(board);
		}
		
		return "forward:/boffice/bbs/viewAritcle.do";
    }

    /**
     * 게시물에 대한 내용을 삭제한다.
     * 
     * @param boardVO
     * @param board
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/deleteBoardArticle.do")
    @ResponseBody
    public String deleteBoardArticle(@ModelAttribute("searchVO") BoardManageVO boardVO, @ModelAttribute("board") BoardManageVO board,
	    @ModelAttribute("bdMstr") BoardMasterVO bdMstr, ModelMap model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(getMenuCode(boardVO.getBbsId()),1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(boardVO.getBbsId()))){
			return "fail";
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
		    board.setModid(user.getId());
		    
		    if(isNull(board.getSearchChk())){
		    	board.setSearchChk(String.valueOf(board.getNttId()));
		    }
		    String[] nttIdArr = (board.getSearchChk()).split(",");
		    for(int i=0;i<nttIdArr.length;i++){
		    	board.setNttId(Integer.valueOf(nttIdArr[i]));
			    bbsMngService.deleteBoardArticle(board);
			    if("BBS_0036".equals(boardVO.getBbsId()) & !isNull(board.getReplyLc()) & !"".equals(board.getReplyLc())){
			    	board.setNttId(Long.parseLong(board.getReplyLc()));
			    	bbsMngService.deleteBoardArticle(board);
			    }
		    }
		}
	
		return "success";
    }	
	    
    /**
     * 게시물 순서 체인지.
     */
    @RequestMapping("/boffice/bbs/seqSwitchUpdate.do")
    @ResponseBody
    public String updateBoardSeqSwitch(@ModelAttribute("board") BoardManageVO board, ModelMap model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(getMenuCode(board.getBbsId()),1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(getMenuCode(board.getBbsId()))){
			return "fail";
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
		    board.setModid(user.getId());
		    bbsMngService.updateBoardSeqSwitch(board);
		}
	
		return "success";
    }	
	    
    //-------------------------------------------
	// 추가 
    //-------------------------------------------
    /**
	 * 에디터 파일 업로드
	 * @param 
	 * @return ModelAndView
	 * @exception Exception
	 */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("/boffice/bbs/fileUploadCKEditor.do")
    public ModelAndView fileUploadCKEditor(HttpServletRequest request, HttpServletResponse response, 
    		@ModelAttribute("ckeditorVO") CkeditorVO ckeditorVO, BindingResult rslt, ModelMap model) throws Exception {
    	
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	ModelAndView newModel = new ModelAndView("view/common/editorUploadResult");
		if(!isAuthenticated){
			return newModel;
		}
    	Map resultMap = new HashMap();
    	
    	if(rslt.hasErrors()){
            FieldError fe = rslt.getFieldError();
            
            resultMap.put("result", "fail");
            resultMap.put("msg", fe.getDefaultMessage());
            newModel.addObject("upResult", resultMap);
            
            return newModel;
        }
    	
    	String CKEditor = StringUtil.convNullObj(ckeditorVO.getCKEditor());
    	String CKEditorFuncNum = StringUtil.convNullObj(ckeditorVO.getCKEditorFuncNum());
    	String langCode = StringUtil.convNullObj(ckeditorVO.getLangCode());
    	
    	System.out.println("CKEditor :::::: "+ckeditorVO.getCKEditor());
    	System.out.println("CKEditorFuncNum :::::: "+ckeditorVO.getCKEditorFuncNum());
    	System.out.println("langCode :::::: "+ckeditorVO.getLangCode());
    	
    	if("".equals(CKEditor) || "".equals(CKEditorFuncNum) || "".equals(langCode)){
    		resultMap.put("result", "fail");
        	resultMap.put("msg", "필수값이 전달되지 않아 업로드에 실패하였습니다.");
        	newModel.addObject("upResult", resultMap);
        	
        	return newModel;
    	}
    	
    	/** 
    	 * 파일 업로드 
    	 **/

        /** 첨부파일 위치 지정 */
        String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");
        uploadDir = uploadDir+"/CKEDITOR";

        /** 첨부 최대 파일 크기 지정 */
        long maxFileSize = 1024 * 1024 * 100;   //업로드 최대 사이즈 설정 (100M)
    	// 파일 업로드 경로 추출
    	//String uploadPath = uploadDir;
    	
    	// 파일 업로드 사이즈 추출
    	//String uploadSize = propertiesService.getString("file_upload_max_size");
    	Long fileMaxSize = (maxFileSize)*1024*1024;
    	
    	// 허용 확장자 추출
    	String[] pExts = new String[] {".jpg",".gif",".jpeg",".png"};
    	
    	// 디렉토리 생성
    	/*File saveFolder = new File(uploadPath);
    	if (!saveFolder.exists() || saveFolder.isFile()) {
    		saveFolder.mkdirs();
    	}*/
    	
    	List<EgovFormBasedFileVo> list = EgovFileUploadUtil.uploadFiles(request, uploadDir, maxFileSize);
    	// 파일 저장
    	MultipartFile mFile = ckeditorVO.getUpload();
    	boolean permittedExt = false;
    	
    	if (list.size() > 0) {
		    EgovFormBasedFileVo vo = list.get(0);	// 첫번째 이미지
		    String url = request.getContextPath()
		    + "/cmm/cke/imageSrc.do?"
		    + "path=" + vo.getServerSubPath()
		    + "&physical=" + vo.getPhysicalName()
		    + "&contentType=" + vo.getContentType();
		    newModel.addObject("url", url);
		    System.out.println("url=====>>>>"+url);

		    String orgFileNm = mFile.getOriginalFilename();
    		//String fileNm = orgFileNm.substring(0, orgFileNm.lastIndexOf("."));
    		String fileExt = orgFileNm.substring(orgFileNm.lastIndexOf("."));
    		fileExt = fileExt.toLowerCase();
    		//String unqFileNm = fileNm + new Date().getTime() + "."+fileExt;
    		Long fileSize = mFile.getSize();
    		
    		// 허용 확장자 체크
    		for (int i = 0; i < pExts.length; i++) {
                if (fileExt.equalsIgnoreCase(pExts[i])) {
                	
                    permittedExt = true;
                    break; 
                }
            }	            
            if(!permittedExt){
            	resultMap.put("result", "invalid");
            	resultMap.put("msg", ".jpg, .gif, .jpeg, .png 이미지만 등록 가능합니다.");
            	newModel.addObject("upResult", resultMap);
            	
            	return newModel;
            }
            
            
            // 파일 사이즈 체크
            if(fileSize > fileMaxSize){
            	resultMap.put("result", "invalid");
            	resultMap.put("msg", maxFileSize+"MB 이하의 이미지만 등록 가능합니다.");
            	newModel.addObject("upResult", resultMap);
            	
            	return newModel;
            }
            
            // 파일 저장
            //String fileFullNm = uploadPath +"/"+ unqFileNm;
    		//mFile.transferTo(new File(fileFullNm));
    		
    		/** set model */
        	resultMap.put("unqFileNm", url);
        	resultMap.put("CKEditorFuncNum", CKEditorFuncNum);
        	resultMap.put("result", "success");
        	newModel.addObject("upResult", resultMap);
    	}else{
    		/** set model */
        	resultMap.put("result", "invalid");
        	resultMap.put("msg", "업로드한 파일이 존재하지 않습니다.");
        	newModel.addObject("upResult", resultMap);
    	}
    	
    	return newModel;
   }

    /** 첨부파일 위치 지정 */
    private final String uploadDir = EgovProperties.getProperty("Globals.fileStorePath");

    @RequestMapping(value="/cmm/cke/imageSrc.do",method=RequestMethod.GET)
	    public void download(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subPath = request.getParameter("path");
		String physical = request.getParameter("physical");
		String mimeType = request.getParameter("contentType");
	
		EgovFormBasedFileUtil.viewFile(response, uploadDir+"/CKEDITOR", subPath, physical, mimeType);
    }

    @RequestMapping(value="/cmm/dext/imageSrc.do",method=RequestMethod.GET)
	    public void dextImgLoad(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String subPath = request.getParameter("path");
		String physical = request.getParameter("physical");
		String mimeType = request.getParameter("contentType");
	
		EgovFormBasedFileUtil.viewFile(response, uploadDir+"/DEXT", subPath, physical, mimeType);
    }
}
