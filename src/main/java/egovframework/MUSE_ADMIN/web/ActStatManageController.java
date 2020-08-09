package egovframework.MUSE_ADMIN.web;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActMovingManageService;
import egovframework.MUSE_ADMIN.service.ActMovingManageVO;
import egovframework.MUSE_ADMIN.service.ActOrderExtManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.web.ActCommonController;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ActStatManageController extends ActCommonController {

	/** actStatManageService */
	@Resource(name = "ActStatManageService")
	private ActStatManageService actStatManageService;

	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

	@Resource(name = "ActMovingManageService")
	private ActMovingManageService actMovingManageService;

	@Resource(name = "ActOrderManageService")
	private ActOrderManageService actOrderManageService;

	@Resource(name = "ActOrderExtManageService")
	private ActOrderExtManageService actOrderExtManageService;

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

	final String MENU_AUTH_NO = "113";

	@RequestMapping(value = "/boffice/actStat/statMovingList.do")
	public String selectActStatMoving(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchActSday()) && isNull(orderVO.getSearchActEday()) ){
			orderVO.setSearchActEday(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchActSday(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("PAGE");
		selectActStatMovingList(orderVO,model);

		int totCnt = actStatManageService.selectActStatTotalCnt(orderVO);

		orderVO.setActListMode("SUM");
		Map<String,String> sumMap = (Map<String,String>) actStatManageService.selectActStatSum(orderVO);
		sumMap.put("totCnt",String.valueOf(totCnt));
		model.addAttribute("sumInfo",sumMap);

		ActManageDefaultVO smVo = new ActManageDefaultVO();
		smVo.setPageView("EXCEL");
		smVo.setSearchActgubun("21");
		List<?> profList = actMembManageService.selectActMembList(smVo);
		model.addAttribute("profList", profList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actStat/statMoving";
	}
	
	@RequestMapping(value = "/boffice/actMemb/actMembLectList.do")
	public String selectMembLectList(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("110")){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(orderVO.getSearchOp2())){
			orderVO.setSearchOp2("수강중");
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("PAGE");
		selectActStatMovingList(orderVO, model);
        model.addAttribute("menuCode", "110");
		return "/boffice/actStat/membLectList";
	}

	@RequestMapping(value = "/boffice/actMemb/actMembLectExcel.do")
	public String selectMembLectExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("110")){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(orderVO.getSearchOp2())){
			orderVO.setSearchOp2("수강중");
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("EXCEL");
		selectActStatMovingList(orderVO, model);
		String fileName = "수강회원리스트_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actStat/membLectExcel";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actMemb/actMembLectView.do")
	public String selectMembLectView(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("110")){
			return MENU_AUTH_REDIRECT;
		}
		String sinDate2 = "";
		int giganDay = 0;
		Map<String,Object> orderInfo = (Map<String,Object>) actOrderManageService.selectActOrderSubDetail(orderVO);
		String payDate = (String) orderInfo.get("payday");
		if(!isNull(payDate)){
			payDate = payDate.substring(0,10);
		}
		//종료일자 체크s
		//강의시작일 설정을 안했을 경우 강의 결제일+7일로 강의시작일 강제설정
		if(isNull(String.valueOf(orderInfo.get("sinDate")))){
			orderInfo.put("sinDate2",getDateTransStrSp(addDateDay(payDate,0,0,7),"-"));
		}
		orderInfo.put("sinDate2",orderInfo.get("sinDate"));
		if(isNumeric(String.valueOf(orderInfo.get("giganDay"))) && !isNull((String) orderInfo.get("sinDate"))){
			sinDate2 = (String.valueOf(orderInfo.get("sinDate"))).substring(0,10);
			giganDay = Integer.valueOf(String.valueOf(orderInfo.get("giganDay")));
			//giganDay = giganDay+Integer.valueOf(String.valueOf(orderInfo.get("giganExt")));
			if(sinDate2.length()==10){
				orderInfo.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
			}
		}
		//종료일자 체크e
		
		ActMovingManageVO movingVO = new ActMovingManageVO();
		BoardManageVO bbsVO = new BoardManageVO();
		bbsVO.setBbsId("BBS_0007");
		bbsVO.setNtcrId(String.valueOf(orderInfo.get("uid")));
		double playEvrg = 0.00;
		double playRate = 0.00;
		String endDate1 = "1900-01-01";
		String endDate2 = "1900-01-01";
		String endDate3 = "1900-01-01";
		int clipCnt = 0;
		movingVO.setOrderSno(String.valueOf(orderInfo.get("lsno")));

		//단과반일 경우만 연장신청 목록 및 종합반신청강의 목록 처리 S-----------------------------------------------
		if(!"0".equals(String.valueOf(orderInfo.get("lectureSno")))){
			movingVO.setCpSmp("");
			movingVO.setMvIdx(String.valueOf(orderInfo.get("lectureSno")));
			movingVO.setMobileYn(String.valueOf(orderInfo.get("mobileYn")));
			movingVO.setID(String.valueOf(orderInfo.get("uid")));
			List<?> clipList = actMovingManageService.selectActLectureClip(movingVO);
			clipCnt = 0;
			for(int jj=0;jj<clipList.size();jj++){
				Map<String,Object> clipMap = (Map<String,Object>) clipList.get(jj);
				playRate = playRate + Double.parseDouble(String.valueOf(clipMap.get("playRate")));
				//최종 수강 일자 반환
				if(clipMap.get("endDate")!=null){
					if(getDaysCnt(endDate1,String.valueOf(clipMap.get("endDate")))>-1){
						endDate1 = String.valueOf(clipMap.get("endDate"));
					}
				}
				if(!"0".equals(String.valueOf(clipMap.get("cpTime")))){
					clipCnt = clipCnt+1;
				}
			}
			if(clipCnt>0){
				playRate = playRate/clipCnt;
			}
			String playRateStr = String.format("%.2f" , playRate);
			orderInfo.put("playRate",playRateStr);
			//최종 수강 일자 반환
			if(getDaysCnt(endDate2,endDate1)>-1){
				endDate2 = endDate1;
			}
			orderInfo.put("endDate2",endDate2);
			//자료실 다운로드 횟수 s
			bbsVO.setNttCat(movingVO.getMvIdx());
			Map<String, String> DownSum = (Map<String,String>) actStatManageService.selectActStatPdsSum(bbsVO);
			orderInfo.put("downSum",DownSum.get("sumCnt"));
			//자료실 다운로드 횟수 e
		}
		//단과반일 경우만 연장신청 목록 및 종합반신청강의 목록 처리 E-----------------------------------------------

		//종합반일 경우만 연장신청 목록 및 종합반신청강의 목록 처리 S-----------------------------------------------
		if("0".equals(String.valueOf(orderInfo.get("lectureSno")))){
			ActCollegeManageVO collegeVO = new ActCollegeManageVO();
			//연장신청 건 처리 S
			List<?> orderExtList = actOrderExtManageService.selectActOrderExtDtList(orderVO);
			//연장신청시 연장신청한 일수만큼 연장된 기간의 종료일 누적할당
			String sinDate3 = (String.valueOf(orderInfo.get("sinDate2"))).substring(0,10);
			for(int i=0;i<orderExtList.size();i++){
				Map<String,Object> orderExtMap = (Map<String,Object>) orderExtList.get(i);
				giganDay = Integer.valueOf(String.valueOf(orderExtMap.get("giganDay")));
				orderExtMap.put("sinDate3",getDateTransStrSp(addDateDay(sinDate3,0,0,giganDay-1),"-"));
				//연장된 종료일자에 추가 연장일자 설정
				sinDate3 = (String.valueOf(orderExtMap.get("sinDate3"))).substring(0,10);
			}
			model.addAttribute("orderExtList",orderExtList);
			//연장신청 건 처리 S
			//종합반 강의 리스트 처리 S
				collegeVO.setMvIdx((String) orderInfo.get("pro"));
				System.out.println("subMap.get(pro)===>>>"+orderInfo.get("pro"));
				if(isNull(collegeVO.getMvIdx())){ collegeVO.setMvIdx(String.valueOf(orderInfo.get("jongNew"))); }
				//if(!isNull(collegeVO.getCoIdx()) && !isNull(collegeVO.getMvIdx()) && (!"0".equals(collegeVO.getCoIdx()) || isNull(collegeVO.getCoIdx()))){
				if(!isNull(collegeVO.getMvIdx())){
					List<?> lectList = actCollegeManageService.selectActCollegeLectList(collegeVO);
					//강좌 학습 진행율 
					for(int j=0;j<lectList.size();j++){
						playRate = 0.00;
						Map<String,Object> lectMap = (Map<String,Object>) lectList.get(j);
						//자료실 다운로드 횟수 s
						bbsVO.setNttCat(String.valueOf(lectMap.get("mvIdx")));
						Map<String, String> DownSum = (Map<String,String>) actStatManageService.selectActStatPdsSum(bbsVO);
						lectMap.put("downSum",DownSum.get("sumCnt"));
						//자료실 다운로드 횟수 e
						movingVO.setCpSmp("");
						movingVO.setMvIdx(String.valueOf(lectMap.get("mvIdx")));
						movingVO.setMobileYn(String.valueOf(orderInfo.get("mobileYn")));
						movingVO.setID(String.valueOf(orderInfo.get("uid")));
						List<?> clipList = actMovingManageService.selectActLectureClip(movingVO);
						clipCnt = 0;
						for(int jj=0;jj<clipList.size();jj++){
							Map<String,Object> clipMap = (Map<String,Object>) clipList.get(jj);
							playRate = playRate + Double.parseDouble(String.valueOf(clipMap.get("playRate")));
							//최종 수강 일자 반환
							if(clipMap.get("endDate")!=null){
								if(getDaysCnt(endDate1,String.valueOf(clipMap.get("endDate")))>-1){
									endDate1 = String.valueOf(clipMap.get("endDate"));
								}
							}
							if(!"0".equals(String.valueOf(clipMap.get("cpTime")))){
								clipCnt = clipCnt+1;
							}
						}
						if(clipCnt>0){
							playRate = playRate/clipCnt;
						}
						String playRateStr = String.format("%.2f" , playRate);
						lectMap.put("playRate",playRateStr);
						playEvrg = playEvrg + playRate;
						//최종 수강 일자 반환
						if(getDaysCnt(endDate2,endDate1)>-1){
							endDate2 = endDate1;
						}
						lectMap.put("endDate2",endDate2);
					}
					playEvrg = playEvrg/lectList.size();
					String playEvrgStr = String.format("%.2f" , playEvrg);
					orderInfo.put("playEvrg",playEvrgStr);
					//최종 수강 일자 반환
					if(getDaysCnt(endDate3,endDate2)>-1){
						endDate3 = endDate2;
					}
					orderInfo.put("endDate3",endDate3);
					orderInfo.put("lectList",lectList);
				}
			//종합반 강의 리스트 처리 E
		}
		//종합반일 경우만 연장신청 목록 및 종합반신청강의 목록 처리 E-----------------------------------------------

		
		model.addAttribute("orderInfo",orderInfo);
		model.addAttribute("menuCode", "110");
		return "/boffice/actStat/membLectView";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actMemb/actMembLectStatPop.do")
	public String selectMembLectStat(@ModelAttribute("movingVO") ActMovingManageVO movingVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("110")){
			return MENU_AUTH_REDIRECT;
		}
		Map<String, Object> lectMap = actMovingManageService.selectActMovingDetail(movingVO);
		
		String endDate1 = "1900-01-01";
		movingVO.setCpSmp("");
		List<?> clipList = actMovingManageService.selectActLectureClip(movingVO);
		for(int jj=0;jj<clipList.size();jj++){
			Map<String,Object> clipMap = (Map<String,Object>) clipList.get(jj);
			//최종 수강 일자 반환
			if(clipMap.get("endDate")!=null){
				if(getDaysCnt(endDate1,String.valueOf(clipMap.get("endDate")))>-1){
					endDate1 = String.valueOf(clipMap.get("endDate"));
				}
			}
		}
		model.addAttribute("lectInfo", lectMap);
		model.addAttribute("clipList",clipList);
		
        model.addAttribute("menuCode", "110");
		return "/boffice/actStat/membLectStatPop";
	}

	@RequestMapping(value = "/boffice/actMemb/actMembPdsStatPop.do")
	public String selectMembPdsStat(@ModelAttribute("bbsVO") BoardManageVO bbsVO, ModelMap model, HttpServletRequest request) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("110")){
			return MENU_AUTH_REDIRECT;
		}
		Enumeration<?> params = request.getParameterNames();
		while (params.hasMoreElements()){
			String name = (String)params.nextElement();
			System.out.println(name + " : " +request.getParameter(name));
			System.out.println("tagsxx : " +chkTagScript(request.getParameter(name)));
			if(chkTagScript(request.getParameter(name))){
				return "ERR_TAG";
			}
		}
		List<?> bbsList = actStatManageService.selectActStatPds(bbsVO);
		model.addAttribute("bbsList",bbsList);
		
		
        model.addAttribute("menuCode", "110");
		return "/boffice/actStat/membPdsStatPop";
	}

	@SuppressWarnings("unchecked")
	public void selectActStatMovingList(ActOrderManageVO orderVO, ModelMap model) throws Exception{
		orderVO.setPageUnit(20);
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());
		
		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> orderList = actStatManageService.selectActStatMoving(orderVO);
		//수강 종료일자 추가(수강시작일 + 기간) s
		String sinDate2 = "";
		int giganDay = 0;
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			orderMap.put("bsinDate2",orderMap.get("bsinDate"));
			if(isNumeric(String.valueOf(orderMap.get("bgiganDay"))) && !isNull((String) orderMap.get("bsinDate"))){
				sinDate2 = (String.valueOf(orderMap.get("bsinDate"))).substring(0,10);
				giganDay = Integer.valueOf(String.valueOf(orderMap.get("bgiganDay")));
				if(sinDate2.length()==10){
					orderMap.put("bsinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
				}
			}
		}
		//수강 종료일자 추가 e
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		List<?> orderCnt = actStatManageService.selectActStatMoving(orderVO);
		Map<String,String> cntMap = (Map<String,String>) orderCnt.get(0);
		int resultCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actStat/statMovingExcel.do")
	public String selectMovingExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("113")){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchActSday()) && isNull(orderVO.getSearchActEday()) ){
			orderVO.setSearchActEday(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchActSday(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("EXCEL");
		List<?> orderList = actStatManageService.selectActStatMoving(orderVO);
		//수강 종료일자 추가(수강시작일 + 기간) s
		String sinDate2 = "";
		int giganDay = 0;
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			orderMap.put("bsinDate2",orderMap.get("bsinDate"));
			if(isNumeric(String.valueOf(orderMap.get("bgiganDay"))) && !isNull((String) orderMap.get("bsinDate"))){
				sinDate2 = (String.valueOf(orderMap.get("bsinDate"))).substring(0,10);
				giganDay = Integer.valueOf(String.valueOf(orderMap.get("bgiganDay")));
				if(sinDate2.length()==10){
					orderMap.put("bsinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
				}
			}
		}
		orderVO.setActListMode("SUM");
		Map<String,String> sumMap = (Map<String,String>) actStatManageService.selectActStatSum(orderVO);
		model.addAttribute("sumInfo",sumMap);
		model.addAttribute("orderList",orderList);
		String fileName = "동영상매출통계_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actStat/statMovingExcel";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actStat/statBookList.do")
	public String selectActStatBook(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("114")){
			return MENU_AUTH_REDIRECT;
		}
		orderVO.setPageUnit(20);
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());
		
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchActSday()) && isNull(orderVO.getSearchActEday()) ){
			orderVO.setSearchActEday(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchActSday(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		orderVO.setActListMode("PAGE");
		List<?> orderList = actStatManageService.selectActStatBook(orderVO);
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		List<?> orderCnt = actStatManageService.selectActStatBook(orderVO);
		Map<String,String> cntMap = (Map<String,String>) orderCnt.get(0);
		int resultCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		int totCnt = actStatManageService.selectActStatBookTotalCnt(orderVO);

		orderVO.setActListMode("SUM");
		Map<String,String> sumMap = (Map<String,String>) actStatManageService.selectActStatBookSum(orderVO);
		sumMap.put("totCnt",String.valueOf(totCnt));
		model.addAttribute("sumInfo",sumMap);

		model.addAttribute("menuCode", "114");
		return "/boffice/actStat/statBook";
	}

	@RequestMapping(value = "/boffice/actStat/statBookExcel.do")
	public String selectBookExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("114")){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchActSday()) && isNull(orderVO.getSearchActEday()) ){
			orderVO.setSearchActEday(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchActSday(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("EXCEL");
		List<?> orderList = actStatManageService.selectActStatBook(orderVO);
		orderVO.setActListMode("SUM");
		Map<String,String> sumMap = (Map<String,String>) actStatManageService.selectActStatBookSum(orderVO);
		model.addAttribute("sumInfo",sumMap);
		model.addAttribute("orderList",orderList);
		String fileName = "서적매출통계_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actStat/statBookExcel";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actStat/statProfList.do")
	public String selectActStatProf(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("115")){
			return MENU_AUTH_REDIRECT;
		}
		orderVO.setPageUnit(10);
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());
		
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		orderVO.setActListMode("PAGE");
		List<?> orderList = actStatManageService.selectActStatProf(orderVO);
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		List<?> orderCnt = actStatManageService.selectActStatProf(orderVO);
		Map<String,String> cntMap = (Map<String,String>) orderCnt.get(0);
		int resultCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		ActManageDefaultVO smVo = new ActManageDefaultVO();
		smVo.setPageView("EXCEL");
		smVo.setSearchActgubun("21");
		List<?> profList = actMembManageService.selectActMembList(smVo);
		model.addAttribute("profList", profList);

		model.addAttribute("menuCode", "115");
		return "/boffice/actStat/statProf";
	}

	@RequestMapping(value = "/boffice/actStat/statProfExcel.do")
	public String selectProfExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("115")){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("EXCEL");
		List<?> orderList = actStatManageService.selectActStatProf(orderVO);
		model.addAttribute("orderList",orderList);

		String fileName = "교수별정산_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actStat/statProfExcel";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actStat/statQnaList.do")
	public String selectActStatQna(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("116")){
			return MENU_AUTH_REDIRECT;
		}
		orderVO.setPageUnit(20);
		orderVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(orderVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(orderVO.getPageUnit());
		paginationInfo.setPageSize(orderVO.getPageSize());
		
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(isNull(orderVO.getSearchOp1())){ orderVO.setSearchOp1("1"); }

		orderVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		orderVO.setLastIndex(paginationInfo.getLastRecordIndex());
		orderVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		orderVO.setActListMode("PAGE");
		List<?> orderList = actStatManageService.selectActStatQna(orderVO);
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		List<?> orderCnt = actStatManageService.selectActStatQna(orderVO);
		Map<String,String> cntMap = (Map<String,String>) orderCnt.get(0);
		int resultCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		ActManageDefaultVO smVo = new ActManageDefaultVO();
		smVo.setPageView("EXCEL");
		smVo.setSearchActgubun("21");
		List<?> profList = actMembManageService.selectActMembList(smVo);
		model.addAttribute("profList", profList);

		model.addAttribute("menuCode", "116");
		return "/boffice/actStat/statQna";
	}

	@RequestMapping(value = "/boffice/actStat/statQnaExcel.do")
	public String selectQnaExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck("116")){
			return MENU_AUTH_REDIRECT;
		}
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(isNull(orderVO.getSearchOp1())){ orderVO.setSearchOp1("1"); }

		orderVO.setActListMode("EXCEL");
		List<?> orderList = actStatManageService.selectActStatQna(orderVO);
		model.addAttribute("orderList",orderList);

		String fileName = "학습게시판답변현황(교수별)_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actStat/statQnaExcel";
	}

}
