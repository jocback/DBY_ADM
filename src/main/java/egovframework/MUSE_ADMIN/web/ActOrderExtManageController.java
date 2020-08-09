package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.MUSE_ADMIN.service.ActOrderExtManageService;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActOrderExtManageController extends ActCommonController {

	/** actOrderExtManageService */
	@Resource(name = "ActOrderExtManageService")
	private ActOrderExtManageService actOrderExtManageService;

	/** actCollegeManageService */
	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	@Resource(name = "ActMembManageService")
	private ActMembManageService actMembManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	final String MENU_AUTH_NO = "152";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actLecture/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actOrder/actOrderExtList.do")
	public String selectActOrderListView(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActOrderList(orderVO,model);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderExtList";
	}

	@RequestMapping(value = "/boffice/actStat/statMovingExtList.do")
	public String selectActOrderListStat(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("153")){
			return MENU_AUTH_REDIRECT;
		}
		selectActOrderList(orderVO,model);
		orderVO.setActListMode("TOTAL");
		Map<String, Object> totMap = actOrderExtManageService.selectActMovingExtStatSum(orderVO);
		model.addAttribute("totInfo",totMap);
		model.addAttribute("menuCode", "153");
		return "/boffice/actStat/statMovingExt";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actStat/statMovingExtExcel.do")
	public String selectMovingExtExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("153")){
			return MENU_AUTH_REDIRECT;
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("EXCEL");
		List<?> orderList = actOrderExtManageService.selectActOrderExtList(orderVO);
		String sinDate2 = "";
		int gigan = 0;
		int giganExt = 0;
		int giganSum = 0;
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			//수강 종료일자 추가(수강시작일 + 기간)
			orderMap.put("sinDate2",orderMap.get("sinDate"));
			if(isNumeric(String.valueOf(orderMap.get("gigan"))) && !isNull((String) orderMap.get("sinDate"))){
				sinDate2 = (String.valueOf(orderMap.get("sinDate"))).substring(0,10);
				gigan = Integer.valueOf(String.valueOf(orderMap.get("gigan")));
				giganExt = Integer.valueOf(String.valueOf(orderMap.get("giganDay")));
				if(sinDate2.length()==10){
					orderMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,(gigan-1)+giganSum),"-"));
					//연장후 종료일
					orderMap.put("sinDate3",getDateTransStrSp(addDateDay(sinDate2,0,0,(gigan-1)+giganExt+giganSum),"-"));
				}
			}
		}
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		Map<String, Object> cntMap = actOrderExtManageService.selectActMovingExtStatSum(orderVO);
		model.addAttribute("sumInfo",cntMap);
		String fileName = "동영상연장신청매출통계_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actStat/statMovingExtExcel";
	}

	@SuppressWarnings("unchecked")
	public void selectActOrderList(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {

		orderVO.setPageUnit(20);
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());
		
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		orderVO.setActListMode("PAGE");
		List<?> orderList = actOrderExtManageService.selectActOrderExtList(orderVO);
		String sinDate2 = "";
		int gigan = 0;
		int giganExt = 0;
		int giganSum = 0;
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			//수강 종료일자 추가(수강시작일 + 기간)
			orderMap.put("sinDate2",orderMap.get("sinDate"));
			if(isNumeric(String.valueOf(orderMap.get("gigan"))) && !isNull((String) orderMap.get("sinDate"))){
				sinDate2 = (String.valueOf(orderMap.get("sinDate"))).substring(0,10);
				gigan = Integer.valueOf(String.valueOf(orderMap.get("gigan")));
				giganExt = Integer.valueOf(String.valueOf(orderMap.get("giganDay")));
				giganSum = Integer.valueOf(String.valueOf(orderMap.get("giganSum")));
				if(sinDate2.length()==10){
					orderMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,(gigan-1)+giganSum),"-"));
					//연장후 종료일
					orderMap.put("sinDate3",getDateTransStrSp(addDateDay(sinDate2,0,0,(gigan-1)+giganExt+giganSum),"-"));
				}
			}
		}
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		Map<String, Object> cntMap = actOrderExtManageService.selectActMovingExtStatSum(orderVO);
		model.addAttribute("sumInfo",cntMap);
		int totCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("menuCode", MENU_AUTH_NO);
	}

	@RequestMapping("/boffice/actOrder/actOrderExtView.do")
	public String selectActMovingDetail(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actOrderExtManageService.selectActOrderExtDetail(orderVO);
		model.addAttribute("resultInfo", vo);

		Map<String, Object> cancelVo = actOrderExtManageService.selectActOrderExtCancel(orderVO);
		model.addAttribute("cancelInfo", cancelVo);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderExtView";
	}

	@RequestMapping("/boffice/actOrder/actOrderExtUpdate.do")
	@ResponseBody
	public String updateActOrder(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		Map<String, Object> vo = actOrderExtManageService.selectActOrderExtDetail(orderVO);
		orderVO.setReturnStt(orderVO.getSno());
		orderVO.setSapStatus((String) vo.get("status")+" -> "+orderVO.getStatus());
		actOrderExtManageService.updateActOrderExt(orderVO);
		//관리자 로그 기록
		commonLogInsert(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderExtCancelInfo.do")
	@ResponseBody
	public String updateActOrderCancel(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderExtManageService.updateActOrderExtCancel(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderExtDelete.do")
	@ResponseBody
	public String deleteActMoving(@ModelAttribute("orderVO") ActOrderManageVO orderVO)
			throws Exception {

     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String[] snoArr = orderVO.getSno().split(",");
		for(int i=0;i<snoArr.length;i++){
			orderVO.setSno(snoArr[i]);
			Map<String, Object> vo = actOrderExtManageService.selectActOrderExtDetail(orderVO);
			orderVO.setReturnStt(orderVO.getSno());
			orderVO.setSapStatus("("+(String) vo.get("jumun")+")("+(String) vo.get("status")+") 주문건 삭제");
			actOrderExtManageService.deleteActOrderExt(orderVO);
			commonLogInsert(orderVO);
		}
		return "success";
	}

}
