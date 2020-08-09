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
import egovframework.MUSE_ADMIN.service.ActBannerManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActBannerManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActBannerManageController extends ActCommonController {

	/** actBannerManageService */
	@Resource(name = "ActBannerManageService")
	private ActBannerManageService actBannerManageService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	final String MENU_AUTH_NO = "141";
	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actBanner/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actBanner/actBannerList.do")
	public String selectActBannerList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM056");
		List<?> codeResult56 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult56", codeResult56);

		List<?> userList = actBannerManageService.selectActBannerList(searchVO);
		model.addAttribute("resultList", userList);
        model.addAttribute("menuCode", MENU_AUTH_NO);

		return "/boffice/actBanner/bannerList";
	}

	@RequestMapping("/boffice/actBanner/actBannerView.do")
	public String selectActBannerDetail(@ModelAttribute("searchVO") ActBannerManageVO actBannerManageVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		//코드정보로부터 조회
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM056");
		List<?> codeResult56 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult56", codeResult56);

		Map<String, Object> vo = actBannerManageService.selectActBannerDetail(actBannerManageVO);
		model.addAttribute("resultInfo", vo);
        model.addAttribute("menuCode", MENU_AUTH_NO);

		return "/boffice/actBanner/bannerView";
	}

	@RequestMapping("/boffice/actBanner/modifyActBanner.do")
	@ResponseBody
	public String updateActBanner(final MultipartHttpServletRequest multiRequest, @ModelAttribute("actBannerManageVO") ActBannerManageVO actBannerManageVO, BindingResult bindingResult)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
	
		String retstr = "success";

		beanValidator.validate(actBannerManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			//전체 파일의 확장자 체크
			if(!checkImgUpLoadFile(multiRequest,1)) retstr = "noneEx";
			//파일 저장 s
			List<FileVO> result1 = null;
			List<FileVO> result2 = null;
			List<FileVO> result3 = null;
			//파일 삭제하기 위한 FileVO생성
			FileVO filevom = new FileVO();
			if("Y".equals(actBannerManageVO.getFileDel1())){
				filevom.setAtchFileId(actBannerManageVO.getFileId1());
				filevom.setFileSn("0");
				deleteUpLoadFile(filevom);
				actBannerManageVO.setFileId1("");
			}
			if("Y".equals(actBannerManageVO.getFileDel2())){
				filevom.setAtchFileId(actBannerManageVO.getFileId2());
				filevom.setFileSn("0");
				deleteUpLoadFile(filevom);
				actBannerManageVO.setFileId2("");
			}
			if("Y".equals(actBannerManageVO.getFileDel3())){
				filevom.setAtchFileId(actBannerManageVO.getFileId3());
				filevom.setFileSn("0");
				deleteUpLoadFile(filevom);
				actBannerManageVO.setFileId3("");
			}
			final Map<String, MultipartFile> files1 = multiRequest.getFileMap();
			files1.remove("file_2");
			files1.remove("file_3");
			MultipartFile fileCheck = multiRequest.getFile("file_1");
			String atchFileId1 = "";
			String atchFileId2 = "";
			String atchFileId3 = "";
			if (retstr.equals("success") && !fileCheck.isEmpty()) {
				result1 = fileUtil.parseFileInf(files1, "BANR", 0, "", "BANR");
				atchFileId1 = fileMngService.insertFileInfs(result1);
				actBannerManageVO.setFileId1(atchFileId1);
			}
			final Map<String, MultipartFile> files2 = multiRequest.getFileMap();
			files2.remove("file_1");
			files2.remove("file_3");
			fileCheck = multiRequest.getFile("file_2");
			if (retstr.equals("success") && !fileCheck.isEmpty()) {
				result2 = fileUtil.parseFileInf(files2, "BANR", 0, "", "BANR");
				atchFileId2 = fileMngService.insertFileInfs(result2);
				actBannerManageVO.setFileId2(atchFileId2);
			}
			final Map<String, MultipartFile> files3 = multiRequest.getFileMap();
			files3.remove("file_1");
			files3.remove("file_2");
			fileCheck = multiRequest.getFile("file_3");
			if (retstr.equals("success") && !fileCheck.isEmpty()) {
				result3 = fileUtil.parseFileInf(files3, "BANR", 0, "", "BANR");
				atchFileId3 = fileMngService.insertFileInfs(result3);
				actBannerManageVO.setFileId3(atchFileId3);
			}
			//파일 저장 e

			if(retstr.equals("success")){
				// 로그인VO에서  사용자 정보 가져오기
				LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
				String lastUpdusrId = loginVO.getId();
				actBannerManageVO.setModemp(lastUpdusrId); // 최종수정자ID
				actBannerManageService.updateActBanner(actBannerManageVO);
			}
		}
		return retstr;

	}

	@RequestMapping("/boffice/actBanner/deleteActBanner.do")
	@ResponseBody
	public String deleteActBanner(@ModelAttribute("actBannerManageVO") ActBannerManageVO actBannerManageVO, BindingResult bindingResult)
			throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
	
		String retstr = "success";

		beanValidator.validate(actBannerManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			actBannerManageService.deleteActBanner(actBannerManageVO);
		}
		return retstr;

	}

	@RequestMapping("/boffice/actBanner/insertActBanner.do")
	@ResponseBody
	public String insertActBanner(final MultipartHttpServletRequest multiRequest, @ModelAttribute("actBannerManageVO") ActBannerManageVO actBannerManageVO, BindingResult bindingResult) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actBannerManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			//전체 파일의 확장자 체크
			if(!checkImgUpLoadFile(multiRequest,1)) retstr = "noneEx";
			System.out.println("checkImgUpLoadFile(multiRequest,1)===="+checkImgUpLoadFile(multiRequest,1));
		    //파일 저장 s
			List<FileVO> result1 = null;
			List<FileVO> result2 = null;
			List<FileVO> result3 = null;
		    
			String atchFileId1 = "";
			String atchFileId2 = "";
			String atchFileId3 = "";
		    final Map<String, MultipartFile> files1 = multiRequest.getFileMap();
			MultipartFile fileCheck = multiRequest.getFile("file_1");
			files1.remove("file_2");
			files1.remove("file_3");
			if (retstr.equals("success") && !fileCheck.isEmpty()) {
				result1 = fileUtil.parseFileInf(files1, "BANR", 0, "", "BANR");
				atchFileId1 = fileMngService.insertFileInfs(result1);
				actBannerManageVO.setFileId1(atchFileId1);
		    }
		    final Map<String, MultipartFile> files2 = multiRequest.getFileMap();
			fileCheck = multiRequest.getFile("file_2");
			files2.remove("file_1");
			files2.remove("file_3");
			if (retstr.equals("success") && !fileCheck.isEmpty()) {
				result2 = fileUtil.parseFileInf(files2, "BANR", 0, "", "BANR");
				atchFileId2 = fileMngService.insertFileInfs(result2);
				actBannerManageVO.setFileId2(atchFileId2);
		    }
		    final Map<String, MultipartFile> files3 = multiRequest.getFileMap();
			fileCheck = multiRequest.getFile("file_3");
			files3.remove("file_1");
			files3.remove("file_2");
			if (retstr.equals("success") && !fileCheck.isEmpty()) {
				result3 = fileUtil.parseFileInf(files3, "BANR", 0, "", "BANR");
				atchFileId3 = fileMngService.insertFileInfs(result3);
				actBannerManageVO.setFileId3(atchFileId3);
		    }
		    //파일 저장 e

			if(retstr.equals("success")){
				// 로그인VO에서  사용자 정보 가져오기
				LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
				String lastUpdusrId = loginVO.getId();
				actBannerManageVO.setModemp(lastUpdusrId); // 최종수정자ID
				actBannerManageService.insertActBanner(actBannerManageVO);
			}
		}
		return retstr;
	}

	@RequestMapping("/boffice/actBanner/updateActBannerSeq.do")
	@ResponseBody
	public String tranSeqBanner(@ModelAttribute("actBannerManageVO") ActBannerManageVO actBannerManageVO) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String idx[] = (actBannerManageVO.getIdx()).split(",");
		String seqno[] = (actBannerManageVO.gettSeq()).split(",");
		for(int i=0;i<idx.length;i++){
			actBannerManageVO.setIdx(idx[i]);
			actBannerManageVO.settSeq(seqno[i]);
			actBannerManageService.updateActBannerSeq(actBannerManageVO);
		}
		return "success";
	}

}
