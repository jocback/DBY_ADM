package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActBookManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActBookManageVO;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActBookManageController extends ActCommonController {

	/** actBookManageService */
	@Resource(name = "ActBookManageService")
	private ActBookManageService actBookManageService;

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

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "103";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actLecture/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actLecture/actBookType.do")
	public String selectActBookListType(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("108")){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setActListMode("type");
		List<?> userList = actBookManageService.selectActBookList(searchVO);
		model.addAttribute("resultList", userList);
		return "/com/cmm/common/frmBookType";
	}
	@RequestMapping(value = "/boffice/actLecture/actBookList.do")
	public String selectActBookListView(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActBookList(searchVO,model);
        model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actLecture/bookList";
	}
	@RequestMapping(value = "/boffice/actLecture/actBookListPop.do")
	public String selectActBookListPopView(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActBookList(searchVO,model);
        model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actLecture/bookListPop";
	}

	public void selectActBookList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService */
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

		List<?> userList = actBookManageService.selectActBookList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actBookManageService.selectActBookListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

	}

	@RequestMapping("/boffice/actLecture/actBookView.do")
	public String selectActBookDetail(ActBookManageVO actBookManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actBookManageService.selectActBookDetail(actBookManageVO);
		model.addAttribute("resultInfo", vo);

		List<?> categoryList = actBookManageService.selectActBookCategory(actBookManageVO);
		model.addAttribute("categoryList", categoryList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actLecture/bookView";
	}

	@RequestMapping("/boffice/actLecture/modifyActBook.do")
	@ResponseBody
	public String updateActBook(final MultipartHttpServletRequest multiRequest, @ModelAttribute("actBookManageVO") ActBookManageVO actBookManageVO, ModelMap model)
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
		actBookManageVO.setRegid(lastUpdusrId); // 최종수정자ID
		actBookManageVO.setModid(lastUpdusrId); // 최종수정자ID

		//파일 저장 s-------------------------------------------------------------------------------------------------------------
		if(!checkImgUpLoadFile(multiRequest,1)) return "ERR_PIC";
		List<FileVO> result1 = null;
		//파일 삭제하기 위한 FileVO생성
		FileVO filevom = new FileVO();
		if("Y".equals(actBookManageVO.getFileDel1())){
			filevom.setAtchFileId(actBookManageVO.getBmPic());
			filevom.setFileSn("0");
			deleteUpLoadFile(filevom);
			actBookManageVO.setBmPic("");
		}
		final Map<String, MultipartFile> files1 = multiRequest.getFileMap();
		MultipartFile fileCheck = multiRequest.getFile("file_1");
		String atchFileId1 = "";
		if (!fileCheck.isEmpty()) {
			result1 = fileUtil.parseFileInf(files1, "BOOK", 0, "", "BOOK");
			atchFileId1 = fileMngService.insertFileInfs(result1);
			actBookManageVO.setBmPic(atchFileId1);
		}
		//파일 저장 e-------------------------------------------------------------------------------------------------------------

		//카테고리 저장 s-------------------------------------------------------------------------------------------------------------
		actBookManageService.deleteActBookCategory(actBookManageVO);
		if(!isNull(actBookManageVO.getLeCode())){
			String[] leCodeArr = (actBookManageVO.getLeCode()).split(",");
			String[] clCodeArr = (actBookManageVO.getClCode()).split(",",leCodeArr.length);
			for(int i = 0;i<leCodeArr.length;i++){
				actBookManageVO.setLeCode(leCodeArr[i]);
				actBookManageVO.setClCode(clCodeArr[i]);
				actBookManageService.insertActBookCategory(actBookManageVO);
			}
		}
		//카테고리 저장 e-------------------------------------------------------------------------------------------------------------
		actBookManageService.updateActBook(actBookManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actLecture/deleteActBook.do")
	@ResponseBody
	public String deleteActBook(@ModelAttribute("actBookManageVO") ActBookManageVO actBookManageVO, ModelMap model)
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
		actBookManageVO.setModid(lastUpdusrId); // 최종수정자ID
		actBookManageService.deleteActBook(actBookManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actLecture/insertActBook.do")
	@ResponseBody
	public String insertActBook(final MultipartHttpServletRequest multiRequest, @ModelAttribute("actBookManageVO") ActBookManageVO actBookManageVO, BindingResult bindingResult, Model model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actBookManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actBookManageVO.setRegid(lastUpdusrId); // 최종수정자ID

			//파일 저장 s-------------------------------------------------------------------------------------------------------------
			if(!checkImgUpLoadFile(multiRequest,1)) return "ERR_PIC";
			List<FileVO> result = null;
			String atchFileId = "";
	
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if(!files.isEmpty()){
				result = fileUtil.parseFileInf(files, "BOOK", 0, "", "BOOK");
				atchFileId = fileMngService.insertFileInfs(result);
				actBookManageVO.setBmPic(atchFileId);
			}
			//파일 저장 e-------------------------------------------------------------------------------------------------------------

			actBookManageVO.setBmIdx(actBookManageService.selectActBookMaxIdx(actBookManageVO));
			
			String[] leCodeArr = (actBookManageVO.getLeCode()).split(",");
			String[] clCodeArr = (actBookManageVO.getClCode()).split(",");
			for(int i = 0;i<leCodeArr.length;i++){
				actBookManageVO.setLeCode(leCodeArr[i]);
				actBookManageVO.setClCode(clCodeArr[i]);
				actBookManageService.insertActBookCategory(actBookManageVO);
			}
			actBookManageService.insertActBook(actBookManageVO);
		}
		return retstr;
	}

}
