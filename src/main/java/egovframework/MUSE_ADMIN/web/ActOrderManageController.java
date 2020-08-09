package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.MUSE_ADMIN.service.ActOrderManageService;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
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
public class ActOrderManageController extends ActCommonController {

	/** actOrderManageService */
	@Resource(name = "ActOrderManageService")
	private ActOrderManageService actOrderManageService;

	/** actCollegeManageService */
	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	@Resource(name = "ActMembManageService")
	private ActMembManageService actMembManageService;

	@Resource(name = "ActStatManageService")
	private ActStatManageService actStatManageService;

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

	final String MENU_AUTH_NO = "105";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actLecture/EgovUserManage
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actOrder/actOrderList.do")
	public String selectActOrderListView(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		orderVO.setPageUnit(propertiesService.getInt("pageUnit"));
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());
		
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchSdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			//orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		orderVO.setSearchOp1("동영상");
		orderVO.setActListMode("PAGE");
		List<?> orderList = actOrderManageService.selectActOrderList(orderVO);
		ActOrderManageVO subVo = new ActOrderManageVO();
		String sinDate = "";
		String sinDate2 = "";
		int giganDay = 0;
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			subVo.setSno(String.valueOf(orderMap.get("sno")));
			subVo.setPsno(String.valueOf(orderMap.get("psno")));
			//수강 종료일자 추가(수강시작일 + 기간)
			orderMap.put("sinDate2",orderMap.get("sinDate"));
			if(isNumeric(String.valueOf(orderMap.get("giganDay"))) && !isNull((String) orderMap.get("sinDate"))){
				sinDate = String.valueOf(orderMap.get("sinDate"));
				sinDate2 = sinDate.substring(0,sinDate.length());
				giganDay = Integer.valueOf(String.valueOf(orderMap.get("giganDay")));
				if(sinDate2.length()==10){
					orderMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
				}
			}
			//수강 종료일자 추가
			List<?> orderSubList = actOrderManageService.selectActOrderSubList(subVo);
			//수강 종료일자 추가(수강시작일 + 기간)
			for(int j=0;j<orderSubList.size();j++){
				Map<String,String> subMap = (Map<String,String>) orderSubList.get(j);
				subMap.put("sinDate2",subMap.get("sinDate"));
				if(isNumeric(String.valueOf(subMap.get("giganDay"))) && !isNull(subMap.get("sinDate"))){
					sinDate2 = (String.valueOf(subMap.get("sinDate"))).substring(0,10);
					giganDay = Integer.valueOf(String.valueOf(subMap.get("giganDay")));
					if(sinDate2.length()==10){
						subMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
					}
				}
			}
			//수강 종료일자 추가
			orderMap.put("subList", orderSubList);
			orderMap.put("subListCnt", orderSubList.size());
		}
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		List<?> orderCnt = actOrderManageService.selectActOrderList(orderVO);
		Map<String,String> cntMap = (Map<String,String>) orderCnt.get(0);
		int totCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderList";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actOrder/actOrderExcel.do")
	public String selectActOrderExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setSearchOp1("동영상");
		orderVO.setActListMode("EXCEL");
		List<?> orderList = actOrderManageService.selectActOrderList(orderVO);
		ActOrderManageVO subVo = new ActOrderManageVO();
		String sinDate = "";
		String sinDate2 = "";
		int giganDay = 0;
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			subVo.setSno(String.valueOf(orderMap.get("sno")));
			subVo.setPsno(String.valueOf(orderMap.get("psno")));
			//수강 종료일자 추가(수강시작일 + 기간)
			orderMap.put("sinDate2",orderMap.get("sinDate"));
			if(isNumeric(String.valueOf(orderMap.get("giganDay"))) && !isNull((String) orderMap.get("sinDate"))){
				sinDate = String.valueOf(orderMap.get("sinDate"));
				sinDate2 = sinDate.substring(0,sinDate.length());
				giganDay = Integer.valueOf(String.valueOf(orderMap.get("giganDay")));
				if(sinDate2.length()==10){
					orderMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
				}
			}
			//수강 종료일자 추가
			List<?> orderSubList = actOrderManageService.selectActOrderSubList(subVo);
			//수강 종료일자 추가(수강시작일 + 기간)
			for(int j=0;j<orderSubList.size();j++){
				Map<String,String> subMap = (Map<String,String>) orderSubList.get(j);
				subMap.put("sinDate2",subMap.get("sinDate"));
				if(isNumeric(String.valueOf(subMap.get("giganDay"))) && !isNull(subMap.get("sinDate"))){
					sinDate2 = (String.valueOf(subMap.get("sinDate"))).substring(0,10);
					giganDay = Integer.valueOf(String.valueOf(subMap.get("giganDay")));
					if(sinDate2.length()==10){
						subMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
					}
				}
			}
			//수강 종료일자 추가
			orderMap.put("subList", orderSubList);
			orderMap.put("subListCnt", orderSubList.size());
		}
		model.addAttribute("orderList",orderList);

		String fileName = "동영상주문리스트_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actOrder/orderExcel";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/boffice/actOrder/actOrderView.do")
	public String selectActMovingDetail(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actOrderManageService.selectActOrderDetail(orderVO);
		model.addAttribute("resultInfo", vo);

		Map<String, Object> cancelVo = actOrderManageService.selectActOrderCancel(orderVO);
		model.addAttribute("cancelInfo", cancelVo);

		List<?> resultList = actOrderManageService.selectActOrderSubList(orderVO);
		//수강 종료일자 추가(수강시작일 + 기간)
		String sinDate2 = "";
		int giganDay = 0;
		ActCollegeManageVO collegeVO = new ActCollegeManageVO();
		for(int i=0;i<resultList.size();i++){
			Map<String,Object> subMap = (Map<String,Object>) resultList.get(i);
			subMap.put("sinDate2",subMap.get("sinDate"));
			if(isNumeric(String.valueOf(subMap.get("giganDay"))) && !isNull((String) subMap.get("sinDate"))){
				sinDate2 = (String.valueOf(subMap.get("sinDate"))).substring(0,10);
				giganDay = Integer.valueOf(String.valueOf(subMap.get("giganDay")));
				if(sinDate2.length()==10){
					subMap.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
				}
			}
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
		}
		//수강 종료일자 추가
		model.addAttribute("resultList", resultList);

		//관리자 로그 기록
		List<?> logList = actStatManageService.selectActCommonLog(orderVO);
		model.addAttribute("logList", logList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderView";
	}

	@RequestMapping("/boffice/actOrder/actOrderUpdate.do")
	@ResponseBody
	public String updateActOrder(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		Map<String, Object> vo = actOrderManageService.selectActOrderSubDetail(orderVO);
		orderVO.setReturnStt(orderVO.getPsno());
		orderVO.setSapStatus((String) vo.get("status2")+" -> "+orderVO.getStatus2());
		actOrderManageService.updateActOrder(orderVO);
		//관리자 로그 기록
		commonLogInsert(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderBasicUpdate.do")
	@ResponseBody
	public String updateActOrderBasic(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderManageService.updateActOrderBasic(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderCancelInfo.do")
	@ResponseBody
	public String updateActOrderCancel(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderManageService.updateActOrderCancel(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderDelete.do")
	@ResponseBody
	public String deleteActMoving(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String[] psnoArr = orderVO.getPsno().split(",");
		for(int i=0;i<psnoArr.length;i++){
			orderVO.setPsno(psnoArr[i]);
			Map<String, Object> vo = actOrderManageService.selectActOrderDetail(orderVO);
			orderVO.setReturnStt(orderVO.getPsno());
			orderVO.setSapStatus("("+(String) vo.get("jumun")+")("+(String) vo.get("status")+") 주문건 삭제");
			actOrderManageService.deleteActOrder(orderVO);
			commonLogInsert(orderVO);
		}
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderCartView.do")
	public String selectActOrderCartDetail(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		orderVO.setmId(unscript(orderVO.getmId()));
		List<?> resultList = actOrderManageService.selectActOrderCartList(orderVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderCartPop";
	}

	@RequestMapping("/boffice/actOrder/actOrderCartDel.do")
	@ResponseBody
	public String deleteActOrderCart(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderManageService.deleteActOrderCart(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/transActOrderClosing.do")
	@ResponseBody
	public String transActOrderClosing(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		//actOrderManageService.transActOrderClosing(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/transActOrderGigan.do")
	@ResponseBody
	public String transActOrderGigan(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderManageService.transActOrderGigan(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/transActOrderPrice2.do")
	@ResponseBody
	public String transActOrderPrice2(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderManageService.transActOrderPrice2(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/transActOrderSinDate.do")
	@ResponseBody
	public String transActOrderSinDate(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		orderVO.setGiganDay(String.valueOf(getDaysCnt(orderVO.getSearchSdt(), orderVO.getSearchEdt())));
		orderVO.setSinDate(orderVO.getSearchSdt());
		actOrderManageService.transActOrderSinDate(orderVO);
		return "success";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/boffice/actOrder/transOrderStatus.do")
	@ResponseBody
	public String transOrderStatus(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String[] psnoArr = orderVO.getPsno().split(",");
		for(int i=0;i<psnoArr.length;i++){
			orderVO.setPsno(psnoArr[i]);
			List<?> subList = actOrderManageService.selectActOrderSubList(orderVO);
			for(int j=0;j<subList.size();j++){
				Map<String,Object> vo = (Map<String,Object>) subList.get(j);
				String orgStatus2 = String.valueOf(vo.get("status2"));
				String orgSian = String.valueOf(vo.get("sian"));
				String orgGiganDay = String.valueOf(vo.get("giganDay"));
				orderVO.setSno(String.valueOf(vo.get("sno")));
				if(isNull(orgGiganDay)){ orgGiganDay = "0"; }
				orderVO.setSian(orgSian);
				if(("입금요".equals(orgStatus2) || "수강중".equals(orgStatus2)) && "일시정지".equals(orderVO.getStatus2())){
					orgSian = getDateTransStrSp(getCurrDate(),"-");
					orderVO.setSian(orgSian);
				}
				orderVO.setGiganDay(orgGiganDay);
				if("일시정지".equals(orgStatus2) && "수강중".equals(orderVO.getStatus2())){
					orderVO.setGiganDay(String.valueOf(Integer.valueOf(orgGiganDay)+getDaysCnt(orgSian, getDateTransStrSp(getCurrDate(),"-"))));
				}
				
				orderVO.setReturnStt(orderVO.getPsno());
				orderVO.setSapStatus((String) vo.get("status2")+" -> "+orderVO.getStatus2());
				actOrderManageService.transActOrderStatus(orderVO);
				//관리자 로그 기록
				commonLogInsert(orderVO);
			}
		}
		return "success";
	}

	@RequestMapping("/boffice/actOrder/transActOrderJongLect.do")
	@ResponseBody
	public String transActOrderJongLect(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderManageService.transActOrderJongLect(orderVO);
		return "success";
	}

}
