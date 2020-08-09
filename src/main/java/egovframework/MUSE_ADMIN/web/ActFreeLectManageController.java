package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActCollegeManageService;
import egovframework.MUSE_ADMIN.service.ActCollegeManageVO;
import egovframework.MUSE_ADMIN.service.ActFreeLectManageService;
import egovframework.MUSE_ADMIN.service.ActFreeLectManageVO;
import egovframework.MUSE_ADMIN.service.ActMovingManageService;
import egovframework.MUSE_ADMIN.service.ActMovingManageVO;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
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
public class ActFreeLectManageController extends ActCommonController {

	/** actFreeLectManageService */
	@Resource(name = "ActFreeLectManageService")
	private ActFreeLectManageService actFreeLectManageService;

	@Resource(name = "ActCollegeManageService")
	private ActCollegeManageService actCollegeManageService;

	@Resource(name = "ActStatManageService")
	private ActStatManageService actStatManageService;

	@Resource(name = "ActMovingManageService")
	private ActMovingManageService actMovingManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	final String MENU_AUTH_NO = "107";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actFreeLect/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actFreeLect/actFreeLectList.do")
	public String selectActFreeLectListView(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActFreeLectList(freeVO,model);
		return "/boffice/actFreeLect/freeLectList";
	}		

	public void selectActFreeLectList(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, ModelMap model) throws Exception {

		/** EgovPropertyService */
		freeVO.setPageUnit(propertiesService.getInt("pageUnit"));
		freeVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(freeVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(freeVO.getPageUnit());
		paginationInfo.setPageSize(freeVO.getPageSize());

		freeVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		freeVO.setLastIndex(paginationInfo.getLastRecordIndex());
		freeVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		freeVO.setActListMode("PAGE");
		List<?> resultList = actFreeLectManageService.selectActFreeLectList(freeVO);
		model.addAttribute("resultList", resultList);

		freeVO.setActListMode("COUNT");
		Map<String,Object> resultMap = (Map<String,Object>) actFreeLectManageService.selectActFreeLectListCnt(freeVO);
		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("menuCode", MENU_AUTH_NO);

	}

	@RequestMapping("/boffice/actFreeLect/actFreeLectView.do")
	public String selectActFreeLectDetail(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actFreeLectManageService.selectActFreeLectDetail(freeVO);
		model.addAttribute("resultInfo", vo);

		freeVO.setFsGb("LEC");
		List<?> lectList = actFreeLectManageService.selectActFreeLectSub(freeVO);
		model.addAttribute("lectList", lectList);
		freeVO.setFsGb("USR");
		List<?> usrList = actFreeLectManageService.selectActFreeLectSub(freeVO);
		model.addAttribute("membList", usrList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actFreeLect/freeLectView";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actFreeLect/actFreeLectStat.do")
	public String selectMembLectView(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		String sinDate2 = "";
		int giganDay = 0;
		Map<String,Object> orderInfo = (Map<String,Object>) actFreeLectManageService.selectActFreeLectDetail(freeVO);
		String payDate = (String.valueOf(orderInfo.get("fmSdt"))).substring(0,10);
		//종료일자 체크s
		orderInfo.put("sinDate",payDate);
		orderInfo.put("sinDate2",orderInfo.get("sinDate"));
		if(isNumeric(String.valueOf(orderInfo.get("fmGigan"))) && !isNull((String) orderInfo.get("sinDate"))){
			sinDate2 = (String.valueOf(orderInfo.get("sinDate"))).substring(0,10);
			giganDay = Integer.valueOf(String.valueOf(orderInfo.get("fmGigan")));
			//giganDay = giganDay+Integer.valueOf(String.valueOf(orderInfo.get("giganExt")));
			if(sinDate2.length()==10){
				orderInfo.put("sinDate2",getDateTransStrSp(addDateDay(sinDate2,0,0,giganDay-1),"-"));
			}
		}
		//종료일자 체크e
		
		ActMovingManageVO movingVO = new ActMovingManageVO();
		BoardManageVO bbsVO = new BoardManageVO();
		bbsVO.setBbsId("BBS_0007");
		bbsVO.setNtcrId(freeVO.getmId());
		double playEvrg = 0.00;
		double playRate = 0.00;
		String startDate1 = "1900-01-01";
		String startDate2 = "1900-01-01";
		String startDate3 = "1900-01-01";
		int clipCnt = 0;
		movingVO.setOrderSno("0");

		ActCollegeManageVO collegeVO = new ActCollegeManageVO();
		collegeVO.setFmIdx(freeVO.getFmIdx());
		movingVO.setFmIdx(freeVO.getFmIdx());
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
			movingVO.setMobileYn(String.valueOf(orderInfo.get("fmEq")));
			movingVO.setID(freeVO.getmId());
			List<?> clipList = actMovingManageService.selectActLectureClip(movingVO);
			clipCnt = 0;
			for(int jj=0;jj<clipList.size();jj++){
				Map<String,Object> clipMap = (Map<String,Object>) clipList.get(jj);
				playRate = playRate + Double.parseDouble(String.valueOf(clipMap.get("playRate")));
				//최종 수강 일자 반환
				if(clipMap.get("startDate")!=null){
					if(getDaysCnt(startDate1,String.valueOf(clipMap.get("startDate")))>-1){
						startDate1 = String.valueOf(clipMap.get("startDate"));
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
			if(getDaysCnt(startDate2,startDate1)>-1){
				startDate2 = startDate1;
			}
			lectMap.put("startDate2",startDate2);
		}
		playEvrg = playEvrg/lectList.size();
		String playEvrgStr = String.format("%.2f" , playEvrg);
		orderInfo.put("playEvrg",playEvrgStr);
		//최종 수강 일자 반환
		if(getDaysCnt(startDate3,startDate2)>-1){
			startDate3 = startDate2;
		}
		orderInfo.put("startDate3",startDate3);
		orderInfo.put("lectList",lectList);
		
		model.addAttribute("orderInfo",orderInfo);
		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actFreeLect/freeLectStat";
	}

	@RequestMapping("/boffice/actFreeLect/insertActFreeLect.do")
	@ResponseBody
	public String insertActFreeLect(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, Model model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		String retstr = "success";
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
		freeVO.setFmIdx(actFreeLectManageService.selectActFreeLectMaxIdx(freeVO));
		
		//sub 저장 s-------------------------------------------------------------------------------------------------------------
		String[] mvIdxArr = (freeVO.getMvIdx()).split(",");
		String[] mvSubjectArr = (freeVO.getMvSubject()).split(",");
		freeVO.setFsGb("LEC");
		for(int i = 0;i<mvIdxArr.length;i++){
			freeVO.setMvIdx(mvIdxArr[i]);
			freeVO.setMvSubject(mvSubjectArr[i]);
			actFreeLectManageService.insertActFreeLectSub(freeVO);
		}
		String[] mIdArr = (freeVO.getmId()).split(",");
		String[] mNameArr = (freeVO.getmName()).split(",");
		freeVO.setFsGb("USR");
		for(int i = 0;i<mIdArr.length;i++){
			freeVO.setmId(mIdArr[i]);
			freeVO.setmName(mNameArr[i]);
			actFreeLectManageService.insertActFreeLectSub(freeVO);
		}
		//sub 저장 e-------------------------------------------------------------------------------------------------------------
		freeVO.setFmSdt(getDateTransStrSp(getCurrDate(),"-"));
		actFreeLectManageService.insertActFreeLect(freeVO);
		return retstr;
	}

	@RequestMapping("/boffice/actFreeLect/modifyActFreeLect.do")
	@ResponseBody
	public String updateActFreeLect(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, ModelMap model) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setRegid(lastUpdusrId); // 최종수정자ID
		freeVO.setModid(lastUpdusrId); // 최종수정자ID

		//sub 저장 s-------------------------------------------------------------------------------------------------------------
		String[] mvIdxArr = (freeVO.getMvIdx()).split(",");
		String[] mvSubjectArr = (freeVO.getMvSubject()).split(",");
		freeVO.setFsGb("LEC");
		freeVO.setMvIdxArr(mvIdxArr);
		actFreeLectManageService.deleteActFreeLectSub(freeVO);
		for(int i = 0;i<mvIdxArr.length;i++){
			freeVO.setMvIdx(mvIdxArr[i]);
			freeVO.setMvSubject(mvSubjectArr[i]);
			actFreeLectManageService.insertActFreeLectSub(freeVO);
		}
		String[] mIdArr = (freeVO.getmId()).split(",");
		String[] mNameArr = (freeVO.getmName()).split(",");
		freeVO.setFsGb("USR");
		freeVO.setmIdArr(mIdArr);
		actFreeLectManageService.deleteActFreeLectSub(freeVO);
		for(int i = 0;i<mIdArr.length;i++){
			freeVO.setmId(mIdArr[i]);
			freeVO.setmName(mNameArr[i]);
			actFreeLectManageService.insertActFreeLectSub(freeVO);
		}
		//sub 저장 e-------------------------------------------------------------------------------------------------------------
		actFreeLectManageService.updateActFreeLect(freeVO);
		return "success";
	}

	@RequestMapping("/boffice/actFreeLect/deleteActFreeLect.do")
	@ResponseBody
	public String deleteActFreeLect(@ModelAttribute("freeVO") ActFreeLectManageVO freeVO, ModelMap model) throws Exception {

     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		freeVO.setModid(lastUpdusrId); // 최종수정자ID
		actFreeLectManageService.deleteActFreeLect(freeVO);
		return "success";
	}

}
