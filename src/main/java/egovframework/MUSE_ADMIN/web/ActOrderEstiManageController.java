package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActBookManageService;
import egovframework.MUSE_ADMIN.service.ActBookManageVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;
import egovframework.MUSE_ADMIN.service.ActOrderEstiManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.service.ActMovingManageService;
import egovframework.MUSE_ADMIN.service.ActMovingManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActOrderEstiManageController extends ActCommonController {

	/** actOrderEstiManageService */
	@Resource(name = "ActOrderEstiManageService")
	private ActOrderEstiManageService actOrderEstiManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

	@Resource(name = "ActBookManageService")
	private ActBookManageService actBookManageService;

	@Resource(name = "ActMovingManageService")
	private ActMovingManageService actMovingManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	final String MENU_AUTH_NO = "108";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actOrderEsti/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actOrder/actOrderEstiList.do")
	public String selectActOrderEstiListView(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActOrderEstiList(orderVO,model);
		return "/boffice/actOrder/orderEstiList";
	}		

	public void selectActOrderEstiList(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {

		/** EgovPropertyService */
		orderVO.setPageUnit(propertiesService.getInt("pageUnit"));
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());

		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		orderVO.setActListMode("PAGE");
		List<?> resultList = actOrderEstiManageService.selectActOrderEstiList(orderVO);
		model.addAttribute("resultList", resultList);

		orderVO.setActListMode("COUNT");
		Map<String,Object> resultMap = (Map<String,Object>) actOrderEstiManageService.selectActOrderEstiListCnt(orderVO);
		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("menuCode", MENU_AUTH_NO);

	}

	@RequestMapping("/boffice/actOrder/actOrderEstiWrite.do")
	public String selectActOrderEstiDetail(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		ActLecCodeManageVO categoryVO = new ActLecCodeManageVO();
		categoryVO.setCodeGb("CL");
        List<?> clCodeManageList =actLecCodeManageService.selectLecCodeManageList(categoryVO);
        model.addAttribute("clCodeList", clCodeManageList);

		categoryVO.setCodeGb("LE");
        List<?> LeCodeManageList =actLecCodeManageService.selectLecCodeManageList(categoryVO);
        model.addAttribute("leCodeList", LeCodeManageList);

        model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderEstiView";
	}

	@RequestMapping("/boffice/actOrder/actAddEstiLecture.do")
	public String selectActMovingDetail(@ModelAttribute("movingVO") ActMovingManageVO movingVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actMovingManageService.selectActMovingDetail(movingVO);
		model.addAttribute("resultInfo", vo);

		List<?> lectureBookList = actMovingManageService.selectActLectureBook(movingVO);
		model.addAttribute("lectureBookList", lectureBookList);

		return "/boffice/actOrder/addEstiLecture";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/boffice/actOrder/actAddEstiCollege.do")
	public String selectActCollegeDetail(@ModelAttribute("collegeVO") ActCollegeManageVO collegeVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actCollegeManageService.selectActCollegeDetail(collegeVO);
		model.addAttribute("resultInfo", vo);
		List<?> collegePrice = actCollegeManageService.selectActCollegePrice(collegeVO);
		model.addAttribute("collegePrice", collegePrice);
		List<?> collegeLect = actCollegeManageService.selectActCollegeLect(collegeVO);
		ActMovingManageVO movingVO = new ActMovingManageVO();
		for(int i=0;i<collegeLect.size();i++){
			Map<String,Object> lectMap = (Map<String,Object>) collegeLect.get(i);
			movingVO.setMvIdx(String.valueOf(lectMap.get("mvIdx")));
			List<?> lectureBookList = actMovingManageService.selectActLectureBook(movingVO);
			lectMap.put("bookList",lectureBookList);
		}
		model.addAttribute("collegeLect", collegeLect);
		List<?> collegeOpt = actCollegeManageService.selectActCollegeOpt(collegeVO);
		model.addAttribute("collegeOpt", collegeOpt);

		return "/boffice/actOrder/addEstiCollege";
	}

	@RequestMapping("/boffice/actOrder/actAddEstiBook.do")
	public String selectActBookDetail(@ModelAttribute("bookVO") ActBookManageVO bookVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actBookManageService.selectActBookDetail(bookVO);
		model.addAttribute("resultInfo", vo);

		return "/boffice/actOrder/addEstiBook";
	}

	@RequestMapping("/boffice/actOrder/actOrderEstiAdd.do")
	@ResponseBody
	public String insertActOrderEsti(@ModelAttribute("orderVO") ActOrderManageVO orderVO, Model model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		String retstr = "success";
		
		String[] mIdArr = (orderVO.getmId()).split(",");
		String[] ocPidxArr = (orderVO.getOcPidx()).split(",");
		String[] ocBooidxArr = (orderVO.getOcBooidx()).split(",",ocPidxArr.length);
		String[] ocGubunArr = (orderVO.getOcGubun()).split(",",ocPidxArr.length);
		String[] ocLecidxArr = (orderVO.getOcLecidx()).split(",",ocPidxArr.length);
		String[] ocLecmodArr = (orderVO.getOcLecmod()).split(",",ocPidxArr.length);
		String[] ocLecdayArr = (orderVO.getOcLecday()).split(",",ocPidxArr.length);
		String[] ocQntArr = (orderVO.getOcQnt()).split(",",ocPidxArr.length);
		String[] ocPriceArr = (orderVO.getOcPrice()).split(",",ocPidxArr.length);
		String[] ocEstiPriceArr = (orderVO.getOcEstiPrice()).split(",",ocPidxArr.length);
		ActOrderManageVO orderVo = new ActOrderManageVO();
		for(int i=0;i<mIdArr.length;i++){
			orderVo.setmId(mIdArr[i]);
			for(int j=0;j<ocPidxArr.length;j++){
				orderVo.setOcPidx(ocPidxArr[j]);
				orderVo.setOcBooidx(ocBooidxArr[j]);
				orderVo.setOcGubun(ocGubunArr[j]);
				orderVo.setOcLecidx(ocLecidxArr[j].replace("||",","));
				orderVo.setOcLecmod(ocLecmodArr[j]);
				orderVo.setOcLecday(ocLecdayArr[j]);
				orderVo.setOcQnt(ocQntArr[j]);
				orderVo.setOcPrice(ocPriceArr[j]);
				orderVo.setOcEstiPrice(ocEstiPriceArr[j]);
				actOrderEstiManageService.insertActOrderEsti(orderVo);
			}
		}
		return retstr;
	}

	@RequestMapping("/boffice/actOrder/deleteActOrderEsti.do")
	@ResponseBody
	public String deleteActOrderEsti(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		
		ActOrderManageVO orderVo = new ActOrderManageVO(); 
		String[] ocIdxArr = (orderVO.getOcIdx()).split(",");
		for(int i=0;i<ocIdxArr.length;i++){
			orderVo.setOcIdx(ocIdxArr[i]);
			actOrderEstiManageService.deleteActOrderEsti(orderVo);
		}
		return "success";
	}

}
