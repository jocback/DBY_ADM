package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActMovingManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActMovingManageVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
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
import org.springmodules.validation.commons.DefaultBeanValidator;

@Controller
public class ActMovingManageController extends ActCommonController {

	/** actMovingManageService */
	@Resource(name = "ActMovingManageService")
	private ActMovingManageService actMovingManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	@Resource(name = "ActMembManageService")
	private ActMembManageService actMembManageService;

	@Resource(name = "ActOrderManageService")
	private ActOrderManageService actOrderManageService;

	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

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

	final String MENU_AUTH_NO = "102";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actLecture/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actLecture/actMovingList.do")
	public String selectActMovingListView(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setPageUnit(20);
		selectActMovingList(searchVO,model);
		return "/boffice/actLecture/movingList";
	}		
	@RequestMapping(value = "/boffice/actLecture/actMovingListPop.do")
	public String selectActMovingListPop(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActMovingList(searchVO,model);
		return "/boffice/actLecture/movingListPop";
	}		
	@RequestMapping(value = "/boffice/actLecture/actMovingListPop2.do")
	public String selectActMovingListPop2(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		searchVO.setPageUnit(5);
		selectActMovingList(searchVO,model);
		ActCollegeManageVO collegeVO = new ActCollegeManageVO();
		ActOrderManageVO orderVO = new ActOrderManageVO();
		orderVO.setPsno(searchVO.getSapStatus());
		orderVO.setSno(searchVO.getSearchMyAct());
		Map<String, Object> subMap = actOrderManageService.selectActOrderSubDetail(orderVO);
		collegeVO.setCoIdx((String) subMap.get("idx"));
		// lecture_order2 테이블 sno 170278 번까지는 pro 교수명이 입력되어 있음.
		if((Integer) subMap.get("sno") > 200000){
			collegeVO.setMvIdx((String) subMap.get("pro"));
		}
		if(isNull(collegeVO.getMvIdx())){ collegeVO.setMvIdx((String) subMap.get("jongNew")); }
		//if(!isNull(collegeVO.getCoIdx()) && !isNull(collegeVO.getMvIdx()) && (!"0".equals(collegeVO.getCoIdx()) || isNull(collegeVO.getCoIdx()))){
		//if(!isNull(collegeVO.getMvIdx()) && (!"0".equals(collegeVO.getCoIdx()) || isNull(collegeVO.getCoIdx()))){
		if(!isNull(collegeVO.getMvIdx())){
			collegeVO.setCoIdx("");
			List<?> lectList = actCollegeManageService.selectActCollegeLectList(collegeVO);
			subMap.put("lectList",lectList);
		}
		model.addAttribute("mvIdxs",collegeVO.getMvIdx());
		model.addAttribute("orderMap",subMap);
		return "/boffice/actLecture/movingListPop2";
	}		

	public void selectActMovingList(@ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService */
		//searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		//searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> userList = actMovingManageService.selectActMovingList(searchVO);
		model.addAttribute("resultList", userList);

		int totCnt = actMovingManageService.selectActMovingListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("menuCode", MENU_AUTH_NO);

	}

	@RequestMapping("/boffice/actLecture/actMovingView.do")
	public String selectActMovingDetail(ActMovingManageVO actMovingManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actMovingManageService.selectActMovingDetail(actMovingManageVO);
		model.addAttribute("resultInfo", vo);

		List<?> lectureBookList = actMovingManageService.selectActLectureBook(actMovingManageVO);
		model.addAttribute("lectureBookList", lectureBookList);

		ActManageDefaultVO smVo = new ActManageDefaultVO();
		smVo.setPageView("EXCEL");
		smVo.setSearchActgubun("21");
		List<?> profList = actMembManageService.selectActMembList(smVo);
		model.addAttribute("profList", profList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actLecture/movingView";
	}

	@RequestMapping("/boffice/actLecture/insertActMoving.do")
	@ResponseBody
	public String insertActMoving(@ModelAttribute("actMovingManageVO") ActMovingManageVO actMovingManageVO, BindingResult bindingResult, Model model) throws Exception {

    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		
		String retstr = "success";

		beanValidator.validate(actMovingManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			retstr = "fail";
		} else {
			// 로그인VO에서  사용자 정보 가져오기
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			String lastUpdusrId = loginVO.getId();
			actMovingManageVO.setRegid(lastUpdusrId); // 최종수정자ID

			actMovingManageVO.setMvIdx(actMovingManageService.selectActMovingMaxIdx(actMovingManageVO));
			
			//교재 저장 s-------------------------------------------------------------------------------------------------------------
			if(!isNull(actMovingManageVO.getBmIdx())){
				String[] bmIdxArr = (actMovingManageVO.getBmIdx()).split(",");
				for(int i = 0;i<bmIdxArr.length;i++){
					actMovingManageVO.setBmIdx(bmIdxArr[i]);
					actMovingManageService.insertActLectureBook(actMovingManageVO);
				}
			}
			//교재 저장 e-------------------------------------------------------------------------------------------------------------
			actMovingManageService.insertActMoving(actMovingManageVO);
		}
		return retstr;
	}

	@RequestMapping("/boffice/actLecture/modifyActMoving.do")
	@ResponseBody
	public String updateActMoving(@ModelAttribute("actMovingManageVO") ActMovingManageVO actMovingManageVO, ModelMap model)
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
		actMovingManageVO.setRegid(lastUpdusrId); // 최종수정자ID
		actMovingManageVO.setModid(lastUpdusrId); // 최종수정자ID

		//카테고리 저장 e-------------------------------------------------------------------------------------------------------------
		//교재 저장 s-------------------------------------------------------------------------------------------------------------
		actMovingManageService.deleteActLectureBook(actMovingManageVO);
		if(!isNull(actMovingManageVO.getBmIdx())){
			String[] bmIdxArr = (actMovingManageVO.getBmIdx()).split(",");
			for(int i = 0;i<bmIdxArr.length;i++){
				actMovingManageVO.setBmIdx(bmIdxArr[i]);
				actMovingManageService.insertActLectureBook(actMovingManageVO);
			}
		}
		//카테고리 저장 e-------------------------------------------------------------------------------------------------------------
		actMovingManageService.updateActMoving(actMovingManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actLecture/deleteActMoving.do")
	@ResponseBody
	public String deleteActMoving(@ModelAttribute("actMovingManageVO") ActMovingManageVO actMovingManageVO, ModelMap model)
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
		actMovingManageVO.setModid(lastUpdusrId); // 최종수정자ID
		actMovingManageService.deleteActMoving(actMovingManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actLecture/actMovingClip.do")
	public String selectActMovingClip(ActMovingManageVO actMovingManageVO, @ModelAttribute("searchVO") ActManageDefaultVO searchVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actMovingManageService.selectActMovingDetail(actMovingManageVO);
		model.addAttribute("resultInfo", vo);

		actMovingManageVO.setCpSmp("Y");
		List<?> resultSmpList = actMovingManageService.selectActLectureClip(actMovingManageVO);
		model.addAttribute("resultSmpList", resultSmpList);
		actMovingManageVO.setCpSmp("");
		List<?> resultList = actMovingManageService.selectActLectureClip(actMovingManageVO);
		model.addAttribute("resultList", resultList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actLecture/movingClip";
	}

	@RequestMapping("/boffice/actLecture/actMovingClipReg.do")
	@ResponseBody
	public String updateActMovingClip(@ModelAttribute("actMovingManageVO") ActMovingManageVO actMovingManageVO, ModelMap model)
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
		actMovingManageVO.setRegid(lastUpdusrId); // 최종수정자ID
		actMovingManageVO.setModid(lastUpdusrId); // 최종수정자ID
		
		actMovingManageService.insertActLectureClip(actMovingManageVO);
		return "success";
	}

	@RequestMapping("/boffice/actLecture/actMovingClipDel.do")
	@ResponseBody
	public String deleteActMovingClip(@ModelAttribute("actMovingManageVO") ActMovingManageVO actMovingManageVO, ModelMap model)
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
		actMovingManageVO.setModid(lastUpdusrId); // 최종수정자ID
		
		actMovingManageService.deleteActLectureClip(actMovingManageVO);
		return "success";
	}

}
