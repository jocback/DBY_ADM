package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;
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
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActCollegeManageController extends ActCommonController {

	/** actCollegeManageService */
	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

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

	final String MENU_AUTH_NO = "147";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actLecture/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actLecture/actCollegeType.do")
	public String selectActCollegeType(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("108")){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setActListMode("type");
		List<?> userList = actCollegeManageService.selectActCollegeList(searchVO);
		model.addAttribute("resultList", userList);
		return "/com/cmm/common/frmCollegeType";
	}

	@RequestMapping(value = "/boffice/actLecture/actCollegeList.do")
	public String selectActCollegeList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		/** EgovPropertyService */
		//searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		if(searchVO.getPageUnit() == 10){
			searchVO.setPageUnit(30);
		}
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> userList = actCollegeManageService.selectActCollegeList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actCollegeManageService.selectActCollegeListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		ActLecCodeManageVO categoryVO = new ActLecCodeManageVO();
		categoryVO.setCodeGb("CL");
        List<?> LecCodeManageList =actLecCodeManageService.selectLecCodeManageList(categoryVO);
        model.addAttribute("lecCodeList", LecCodeManageList);
        model.addAttribute("menuCode", MENU_AUTH_NO);

		return "/boffice/actLecture/collegeList";
	}

	@RequestMapping("/boffice/actLecture/actCollegeView.do")
	public String selectActCollegeDetail(ActCollegeManageVO actCollegeManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actCollegeManageService.selectActCollegeDetail(actCollegeManageVO);
		model.addAttribute("resultInfo", vo);

		List<?> collegePrice = actCollegeManageService.selectActCollegePrice(actCollegeManageVO);
		model.addAttribute("collegePrice", collegePrice);
		List<?> collegeLect = actCollegeManageService.selectActCollegeLect(actCollegeManageVO);
		model.addAttribute("collegeLect", collegeLect);
		List<?> collegeOpt = actCollegeManageService.selectActCollegeOpt(actCollegeManageVO);
		model.addAttribute("collegeOpt", collegeOpt);

		ActLecCodeManageVO categoryVO = new ActLecCodeManageVO();
		categoryVO.setCodeGb("LE");
        List<?> LecCodeManageList =actLecCodeManageService.selectLecCodeManageList(categoryVO);
        model.addAttribute("lecCodeList", LecCodeManageList);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actLecture/collegeView";
	}

	@RequestMapping("/boffice/actLecture/insertActCollege.do")
	@ResponseBody
	public String insertActCollege(@ModelAttribute("actCollegeManageVO") ActCollegeManageVO actCollegeManageVO, BindingResult bindingResult, Model model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actCollegeManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actCollegeManageVO.setRegid(lastUpdusrId); // 최종수정자ID

			actCollegeManageVO.setCoIdx(actCollegeManageService.selectActCollegeMaxIdx(actCollegeManageVO));
			
			//금액 저장 s-------------------------------------------------------------------------------------------------------------
			if(!isNull(actCollegeManageVO.getCpDay())){
				String[] cpDayArr = (actCollegeManageVO.getCpDay()).split(",");
				String[] cpPrice1Arr = (actCollegeManageVO.getCpPrice1()).split(",",cpDayArr.length);
				String[] cpPrice2Arr = (actCollegeManageVO.getCpPrice2()).split(",",cpDayArr.length);
				String[] cpPrice3Arr = (actCollegeManageVO.getCpPrice3()).split(",",cpDayArr.length);
				for(int i = 0;i<cpDayArr.length;i++){
					actCollegeManageVO.setCpDay(cpDayArr[i]);
					actCollegeManageVO.setCpPrice1(cpPrice1Arr[i]);
					actCollegeManageVO.setCpPrice2(cpPrice2Arr[i]);
					actCollegeManageVO.setCpPrice3(cpPrice3Arr[i]);
					actCollegeManageService.insertActCollegePrice(actCollegeManageVO);
				}
			}
			//금액 저장 e-------------------------------------------------------------------------------------------------------------
			//강좌 저장 s-------------------------------------------------------------------------------------------------------------
			if(!isNull(actCollegeManageVO.getMvIdx())){
				String[] mvIdxArr = (actCollegeManageVO.getMvIdx()).split(",");
				String[] ccSeqArr = (actCollegeManageVO.getCcSeq()).split(",",mvIdxArr.length);
				String[] clCodeArr = (actCollegeManageVO.getClCode()).split(",",mvIdxArr.length);
				String[] ccOptArr = (actCollegeManageVO.getCcOpt()).split(",",mvIdxArr.length);
				for(int i = 0;i<mvIdxArr.length;i++){
					actCollegeManageVO.setMvIdx(mvIdxArr[i]);
					actCollegeManageVO.setCcSeq(ccSeqArr[i]);
					actCollegeManageVO.setClCode(clCodeArr[i]);
					actCollegeManageVO.setCcOpt(ccOptArr[i]);
					actCollegeManageService.insertActCollegeLect(actCollegeManageVO);
				}
			}
			//강좌 저장 e-------------------------------------------------------------------------------------------------------------
			//택일설정 저장 s-------------------------------------------------------------------------------------------------------------
			if(!isNull(actCollegeManageVO.getCtCode())){
				String[] ctCodeArr = (actCollegeManageVO.getCtCode()).split(",");
				String[] ctOptArr = (actCollegeManageVO.getCtOpt()).split(",",ctCodeArr.length);
				for(int i = 0;i<ctCodeArr.length;i++){
					actCollegeManageVO.setCtCode(ctCodeArr[i]);
					actCollegeManageVO.setCtOpt(ctOptArr[i]);
					actCollegeManageService.insertActCollegeOpt(actCollegeManageVO);
				}
			}
			//택일설정 저장 e-------------------------------------------------------------------------------------------------------------
			actCollegeManageService.insertActCollege(actCollegeManageVO);
		}
		return retstr;
	}

	@RequestMapping("/boffice/actLecture/modifyActCollege.do")
	@ResponseBody
	public String updateActCollege(@ModelAttribute("actCollegeManageVO") ActCollegeManageVO actCollegeManageVO, ModelMap model)
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
		actCollegeManageVO.setRegid(lastUpdusrId); // 최종수정자ID
		actCollegeManageVO.setModid(lastUpdusrId); // 최종수정자ID

		//금액 저장 s-------------------------------------------------------------------------------------------------------------
		actCollegeManageService.deleteActCollegePrice(actCollegeManageVO);
		if(!isNull(actCollegeManageVO.getCpDay())){
			String[] cpDayArr = (actCollegeManageVO.getCpDay()).split(",");
			String[] cpPrice1Arr = (actCollegeManageVO.getCpPrice1()).split(",",cpDayArr.length);
			String[] cpPrice2Arr = (actCollegeManageVO.getCpPrice2()).split(",",cpDayArr.length);
			String[] cpPrice3Arr = (actCollegeManageVO.getCpPrice3()).split(",",cpDayArr.length);
			for(int i = 0;i<cpDayArr.length;i++){
				actCollegeManageVO.setCpDay(cpDayArr[i]);
				actCollegeManageVO.setCpPrice1(cpPrice1Arr[i]);
				actCollegeManageVO.setCpPrice2(cpPrice2Arr[i]);
				actCollegeManageVO.setCpPrice3(cpPrice3Arr[i]);
				actCollegeManageService.insertActCollegePrice(actCollegeManageVO);
			}
		}
		//금액 저장 e-------------------------------------------------------------------------------------------------------------
		//강좌 저장 s-------------------------------------------------------------------------------------------------------------
		actCollegeManageService.deleteActCollegeLect(actCollegeManageVO);
		if(!isNull(actCollegeManageVO.getMvIdx())){
			String[] mvIdxArr = (actCollegeManageVO.getMvIdx()).split(",");
			String[] ccSeqArr = (actCollegeManageVO.getCcSeq()).split(",",mvIdxArr.length);
			String[] clCodeArr = (actCollegeManageVO.getClCode()).split(",",mvIdxArr.length);
			String[] ccOptArr = (actCollegeManageVO.getCcOpt()).split(",",mvIdxArr.length);
			for(int i = 0;i<mvIdxArr.length;i++){
				actCollegeManageVO.setMvIdx(mvIdxArr[i]);
				actCollegeManageVO.setCcSeq(ccSeqArr[i]);
				actCollegeManageVO.setClCode(clCodeArr[i]);
				actCollegeManageVO.setCcOpt(ccOptArr[i]);
				actCollegeManageService.insertActCollegeLect(actCollegeManageVO);
			}
		}
		//강좌 저장 e-------------------------------------------------------------------------------------------------------------
		//택일설정 저장 s-------------------------------------------------------------------------------------------------------------
		actCollegeManageService.deleteActCollegeOpt(actCollegeManageVO);
		if(!isNull(actCollegeManageVO.getCtCode())){
			String[] ctCodeArr = (actCollegeManageVO.getCtCode()).split(",");
			String[] ctOptArr = (actCollegeManageVO.getCtOpt()).split(",",ctCodeArr.length);
			for(int i = 0;i<ctCodeArr.length;i++){
				actCollegeManageVO.setCtCode(ctCodeArr[i]);
				actCollegeManageVO.setCtOpt(ctOptArr[i]);
				actCollegeManageService.insertActCollegeOpt(actCollegeManageVO);
			}
		}
		//택일설정 저장 e-------------------------------------------------------------------------------------------------------------
		actCollegeManageService.updateActCollege(actCollegeManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actLecture/deleteActCollege.do")
	@ResponseBody
	public String deleteActCollege(@ModelAttribute("actCollegeManageVO") ActCollegeManageVO actCollegeManageVO, ModelMap model)
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
		actCollegeManageVO.setModid(lastUpdusrId); // 최종수정자ID
		actCollegeManageService.deleteActCollege(actCollegeManageVO);
		return "success";
	}

    /**
     * 게시물 순서 체인지.
     */
    @RequestMapping("/boffice/actLecture/seqSwitchUpdate.do")
    @ResponseBody
    public String updateCollegeSeqSwitch(@ModelAttribute("actCollegeManageVO") ActCollegeManageVO actCollegeManageVO) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "fail";
		}
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
		    actCollegeManageService.updateSeqSwitch(actCollegeManageVO);
		}
	
		return "success";
    }	
}
