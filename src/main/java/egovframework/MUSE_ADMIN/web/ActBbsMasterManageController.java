package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import javax.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * 게시판 속성관리를 위한 컨트롤러  클래스
 */

@Controller
public class ActBbsMasterManageController extends ActCommonController {
	
    @Resource(name = "BoardMasterManageService")
    private BoardMasterManageService bbsAttrbService;

    @Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    @Autowired
    private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "143";

    /**
     * 게시판 마스터 목록을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/actBbsMasterList.do")
    public String selectBBSMasterInfs(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		boardMasterVO.setPageUnit(20);
		boardMasterVO.setPageSize(propertyService.getInt("pageSize"));
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardMasterVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardMasterVO.getPageUnit());
		paginationInfo.setPageSize(boardMasterVO.getPageSize());
		boardMasterVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardMasterVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardMasterVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		Map<String, Object> map = bbsAttrbService.selectBBSMasterInfs(boardMasterVO);
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("resultCnt", map.get("resultCnt"));	
		model.addAttribute("paginationInfo", paginationInfo);
	
		return "boffice/contents/bbsMasterList";
    }

    /**
     * 게시판 마스터 상세내용을 조회한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/actBbsMasterView.do")
    public String selectBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(searchVO);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		model.addAttribute("result", vo);
		return "boffice/contents/bbsMasterView";
    }

    /**
     * 신규 게시판 마스터 등록을 위한 등록페이지로 이동한다.
     * 
     * @param boardMasterVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/addBBSMaster.do")
    public String addBBSMaster(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		BoardMasterVO boardMaster = new BoardMasterVO();
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM004");
		List<?> codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("typeList", codeResult);
		vo.setCodeId("COM009");
		codeResult = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		model.addAttribute("attrbList", codeResult);
		model.addAttribute("boardMaster", boardMaster);
		return "boffice/contents/bbsMasterView";
    }

    /**
     * 신규 게시판 마스터 정보를 등록한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/insertBBSMasterInf.do")
    public String insertBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMasterVO boardMaster,
	    BindingResult bindingResult, SessionStatus status, ModelMap model) throws Exception {
	
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		beanValidator.validate(boardMaster, bindingResult);
		if (bindingResult.hasErrors()) {
		    ComDefaultCodeVO vo = new ComDefaultCodeVO();
		    vo.setCodeId("COM004");
		    List<?> codeResult = cmmUseService.selectCmmCodeDetail(vo);
		    model.addAttribute("typeList", codeResult);
		    vo.setCodeId("COM009");
		    codeResult = cmmUseService.selectCmmCodeDetail(vo);
		    model.addAttribute("attrbList", codeResult);
		    return "boffice/contents/bbsMasterReg";
		}
		
		if (isAuthenticated) {
		    boardMaster.setRegid(user.getId());
		    boardMaster.setUseYn("Y");
		    boardMaster.setTrgetId("SYSTEMDEFAULT_REGIST");
		    bbsAttrbService.insertBBSMastetInf(boardMaster);
		}
	
		return "forward:/boffice/bbs/actBbsMasterList.do";
    }

    /**
     * 게시판 마스터 정보를 수정한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/UpdateBBSMasterInf.do")
    public String updateBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMasterVO boardMaster,
	    BindingResult bindingResult, ModelMap model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		beanValidator.validate(boardMaster, bindingResult);
		if (bindingResult.hasErrors()) {
		    BoardMasterVO vo = bbsAttrbService.selectBBSMasterInf(boardMasterVO);
		    model.addAttribute("result", vo);
		    return "boffice/contents/bbsMasterView";
		}
		if (isAuthenticated) {
		    boardMaster.setModid(user.getId());
		    bbsAttrbService.updateBBSMasterInf(boardMaster);
		}
	    model.addAttribute("searchVO", boardMasterVO);
		return "forward:/boffice/bbs/actBbsMasterView.do";
    }

    /**
     * 게시판 마스터 정보를 삭제한다.
     * 
     * @param boardMasterVO
     * @param boardMaster
     * @param status
     * @return
     * @throws Exception
     */
    @RequestMapping("/boffice/bbs/DeleteBBSMasterInf.do")
    public String deleteBBSMasterInf(@ModelAttribute("searchVO") BoardMasterVO boardMasterVO, @ModelAttribute("boardMaster") BoardMasterVO boardMaster,
	    SessionStatus status) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
		    boardMaster.setModid(user.getId());
		    bbsAttrbService.deleteBBSMasterInf(boardMaster);
		}
		return "forward:/boffice/bbs/actBbsMasterList.do";
    }

}
