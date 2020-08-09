package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_Rte.uss.olh.faq.service.EgovFaqManageService;
import egovframework.MUSE_Rte.uss.olh.faq.service.FaqManageDefaultVO;
import egovframework.MUSE_Rte.uss.olh.faq.service.FaqManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActFaqManageController extends ActCommonController {

	@Resource(name = "FaqManageService")
	private EgovFaqManageService faqManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	// Validation 관련
	@Autowired
	private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "116";

	/**
	 * FAQ 목록을 조회한다.
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/bbs/faqList.do")
	public String selectFaqList(@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, ModelMap model) throws Exception {

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

		List<?> FaqList = faqManageService.selectFaqList(searchVO);
		model.addAttribute("resultList", FaqList);

		int totCnt = faqManageService.selectFaqListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "boffice/contents/faqList";
	}

	/**
	 * FAQ 목록에 대한 상세정보를 조회한다.
	 * @param faqManageVO
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/bbs/viewFaq.do")
	public String selectFaqListDetail(FaqManageVO faqManageVO, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		FaqManageVO vo = faqManageService.selectFaqListDetail(faqManageVO);

		model.addAttribute("result", vo);

		return "boffice/contents/faqModify";
	}

	/**
	 * FAQ를 등록하기 위한 전 처리
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/bbs/writeFaq.do")
	public String insertFaqCnView(@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, Model model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM054");
		List<?> codeResult54 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult54", codeResult54);

		model.addAttribute("faqManageVO", new FaqManageVO());
		model.addAttribute("user", user);

		return "boffice/contents/faqWrite";

	}

	/**
	 * FAQ를 등록한다.
	 * @param multiRequest
	 * @param searchVO
	 * @param faqManageVO
	 * @param bindingResult
	 * @throws Exception
	 */
	@RequestMapping("/boffice/bbs/insertFaqArticle.do")
	public String insertFaqCn(final MultipartHttpServletRequest multiRequest, // 첨부파일을 위한...
			@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, @ModelAttribute("faqManageVO") FaqManageVO faqManageVO, BindingResult bindingResult) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		beanValidator.validate(faqManageVO, bindingResult);

		if (bindingResult.hasErrors()) {
			return "boffice/contents/faqWrite";
		}

		// 첨부파일 관련 첨부파일ID 생성
		List<FileVO> _result = null;
		String _atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		if (!files.isEmpty()) {
			_result = fileUtil.parseFileInf(files, "FAQ_", 0, "", "FAQ");
			_atchFileId = fileMngService.insertFileInfs(_result); //파일이 생성되고나면 생성된 첨부파일 ID를 리턴한다.
		}

		// 리턴받은 첨부파일ID를 셋팅한다..
		faqManageVO.setAtchFileId(_atchFileId); // 첨부파일 ID

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String frstRegisterId = loginVO.getId();

		faqManageVO.setFrstRegisterId(frstRegisterId); // 최초등록자ID
		faqManageVO.setLastUpdusrId(frstRegisterId); // 최종수정자ID

		faqManageService.insertFaqCn(faqManageVO);

		return "forward:/boffice/bbs/faqList.do";
	}

	/**
	 * FAQ를 수정하기 위한 전 처리
	 * @param faqId
	 * @param searchVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/bbs/modifyFaq.do")
	public String updateFaqCnView(@RequestParam("faqId") String faqId, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO, ModelMap model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		FaqManageVO faqManageVO = new FaqManageVO();

		// Primary Key 값 세팅
		faqManageVO.setFaqId(faqId);

		// 변수명은 CoC 에 따라
		model.addAttribute(selectFaqListDetail(faqManageVO, searchVO, model));

		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM054");
		List<?> codeResult54 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult54", codeResult54);

		// 변수명은 CoC 에 따라 JSTL사용을 위해
		model.addAttribute("faqManageVO", faqManageService.selectFaqListDetail(faqManageVO));
		model.addAttribute("user", user);

		return "boffice/contents/faqModify";
	}

	/**
	 * FAQ를 수정처리한다.
	 * @param atchFileAt
	 * @param multiRequest
	 * @param searchVO
	 * @param faqManageVO
	 * @param bindingResult
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("/boffice/bbs/modifyFaqArticle.do")
	public String updateFaqCn(final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("searchVO") FaqManageDefaultVO searchVO, @ModelAttribute("faqManageVO") FaqManageVO faqManageVO, BindingResult bindingResult, ModelMap model)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		// Validation
		beanValidator.validate(faqManageVO, bindingResult);

		if (bindingResult.hasErrors()) {
			return "boffice/contents/faqModify";
		}

		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String lastUpdusrId = loginVO.getId();

		faqManageVO.setLastUpdusrId(lastUpdusrId); // 최종수정자ID

		faqManageService.updateFaqCn(faqManageVO);

		return "forward:/boffice/bbs/modifyFaq.do";

	}

	/**
	 * FAQ를 삭제처리한다.
	 * @param faqManageVO
	 * @param searchVO
	 * @throws Exception
	 */
	@RequestMapping("/boffice/bbs/deleteFaqArticle.do")
	public String deleteFaqCn(FaqManageVO faqManageVO, @ModelAttribute("searchVO") FaqManageDefaultVO searchVO) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		// 첨부파일 삭제를 위한 ID 생성 start....
		String _atchFileId = faqManageVO.getAtchFileId();

		faqManageService.deleteFaqCn(faqManageVO);

		// 첨부파일을 삭제하기 위한  Vo
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(_atchFileId);

		fileMngService.deleteAllFileInf(fvo);
		// 첨부파일 삭제 End.............

		return "forward:/boffice/bbs/faqList.do";
	}

}
