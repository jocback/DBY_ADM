package egovframework.MUSE_ADMIN.web;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.MUSE_ADMIN.service.ActOrderBookManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
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
public class ActOrderBookManageController extends ActCommonController {

	/** actOrderBookManageService */
	@Resource(name = "ActOrderBookManageService")
	private ActOrderBookManageService actOrderBookManageService;

	@Resource(name = "ActStatManageService")
	private ActStatManageService actStatManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	final String MENU_AUTH_NO = "106";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actLecture/EgovUserManage
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actOrder/actOrderBookList.do")
	public String selectActOrderBookList(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {
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

		orderVO.setActListMode("PAGE");
		List<?> orderList = actOrderBookManageService.selectActOrderBookList(orderVO);
		ActOrderManageVO subVO = new ActOrderManageVO();
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			subVO.setSno(String.valueOf(orderMap.get("sno")));
			List<?> subList = actOrderBookManageService.selectActOrderBookSubList(subVO);
			orderMap.put("subList",subList);
		}
		model.addAttribute("orderList",orderList);

		orderVO.setActListMode("COUNT");
		List<?> orderCnt = actOrderBookManageService.selectActOrderBookList(orderVO);
		Map<String,String> cntMap = (Map<String,String>) orderCnt.get(0);
		int resultCnt = Integer.valueOf(String.valueOf(cntMap.get("cnt")));
		paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		int totCnt = actStatManageService.selectActStatBookTotalCnt(orderVO);
		model.addAttribute("totCnt", totCnt);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderBookList";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boffice/actOrder/actOrderBookExcel.do")
	public String selectActOrderBookExcel(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		
		if(isNull(orderVO.getSearchCnd()) && isNull(orderVO.getSearchSdt()) && isNull(orderVO.getSearchSdt()) ){
			orderVO.setSearchEdt(getDateTransStrSp(getCurrDate(),"-"));
			orderVO.setSearchSdt(getDateTransStrSp(addDateDay(getCurrDate(),0,-1,0),"-"));
		}
		if(!isNull(orderVO.getSearchOp2())){ orderVO.setSearchArr1(orderVO.getSearchOp2().split(",")); }
		if(!isNull(orderVO.getSearchOp3())){ orderVO.setSearchArr2(orderVO.getSearchOp3().split(",")); }

		orderVO.setActListMode("EXCEL");
		List<?> orderList = actOrderBookManageService.selectActOrderBookList(orderVO);
		ActOrderManageVO subVO = new ActOrderManageVO();
		for(int i=0;i<orderList.size();i++){
			Map<String,Object> orderMap = (Map<String,Object>) orderList.get(i);
			subVO.setSno(String.valueOf(orderMap.get("sno")));
			List<?> subList = actOrderBookManageService.selectActOrderBookSubList(subVO);
			orderMap.put("subList",subList);
		}
		model.addAttribute("orderList",orderList);

		String fileName = "서적주문리스트_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actOrder/orderBookExcel";
	}

	@RequestMapping("/boffice/actOrder/actOrderBookView.do")
	public String selectActOrderBookDetail(@ModelAttribute("orderVO") ActOrderManageVO orderVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actOrderBookManageService.selectActOrderBookDetail(orderVO);
		model.addAttribute("resultInfo", vo);

		Map<String, Object> cancelVo = actOrderBookManageService.selectActOrderBookCancel(orderVO);
		model.addAttribute("cancelInfo", cancelVo);

		List<?> resultList = actOrderBookManageService.selectActOrderBookSubList(orderVO);
		model.addAttribute("resultList", resultList);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actOrder/orderBookView";
	}

	@RequestMapping("/boffice/actOrder/actOrderBookBasicUpdate.do")
	@ResponseBody
	public String updateActOrderBookBasic(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderBookManageService.updateActOrderBookBasic(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderBookCancelInfo.do")
	@ResponseBody
	public String updateActOrderBookCancel(@ModelAttribute("orderVO") ActOrderManageVO orderVO) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		actOrderBookManageService.updateActOrderBookCancel(orderVO);
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderBookDelete.do")
	@ResponseBody
	public String deleteActOrderBook(@ModelAttribute("orderVO") ActOrderManageVO orderVO)
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
			Map<String, Object> vo = actOrderBookManageService.selectActOrderBookDetail(orderVO);
			orderVO.setReturnStt(orderVO.getSno());
			orderVO.setSapStatus("("+(String) vo.get("status")+") 주문건 삭제");
			actOrderBookManageService.deleteActOrderBook(orderVO);
			commonLogInsert(orderVO);
		}
		return "success";
	}

	@RequestMapping("/boffice/actOrder/actOrderBookTrans.do")
	@ResponseBody
	public String transActOrderBook(@ModelAttribute("orderVO") ActOrderManageVO orderVO)
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
			Map<String, Object> vo = actOrderBookManageService.selectActOrderBookDetail(orderVO);
			orderVO.setReturnStt(orderVO.getSno());
			//orderVO.setSapStatus("("+(String) vo.get("jumun")+")("+(String) vo.get("status")+") 주문상태 변경:"+(String) vo.get("status"));
			orderVO.setSapStatus((String) vo.get("status")+" -> "+orderVO.getStatus());
			actOrderBookManageService.transActOrderBook(orderVO);
			commonLogInsert(orderVO);
		}
		return "success";
	}

}
