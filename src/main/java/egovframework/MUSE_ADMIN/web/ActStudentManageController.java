package egovframework.MUSE_ADMIN.web;

import java.io.File;
import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActStudentManageService;
import egovframework.MUSE_ADMIN.service.ActStudentManageVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.EmailSender;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.aspectj.util.FileUtil;

@Controller
public class ActStudentManageController extends ActCommonController {

	/** actStudentManageService */
	@Resource(name = "ActStudentManageService")
	private ActStudentManageService actStudentManageService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "EmailSender")
	private EmailSender emailSender;

	@Autowired
	ServletContext context;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	final String MENU_AUTH_NO = "156";

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param searchVO 검색조건정보
	 * @param model 화면모델
	 * @return cmm/boffice/actStudent/EgovUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/boffice/actMemb/actStudentList.do")
	public String selectActStudentListView(@ModelAttribute("freeVO") ActStudentManageVO freeVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}
		selectActStudentList(freeVO,model);
		return "/boffice/actMemb/studentList";
	}		

	public void selectActStudentList(@ModelAttribute("freeVO") ActStudentManageVO freeVO, ModelMap model) throws Exception {

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
		List<?> resultList = actStudentManageService.selectActStudentList(freeVO);
		model.addAttribute("resultList", resultList);

		freeVO.setActListMode("COUNT");
		Map<String,Object> resultMap = (Map<String,Object>) actStudentManageService.selectActStudentListCnt(freeVO);
		paginationInfo.setTotalRecordCount(Integer.valueOf(String.valueOf(resultMap.get("cnt"))));
		model.addAttribute("paginationInfo", paginationInfo);

        model.addAttribute("menuCode", MENU_AUTH_NO);

	}

	@RequestMapping(value = "/boffice/actMemb/actStudentExcel.do")
	public String selectMembLectExcel(@ModelAttribute("freeVO") ActStudentManageVO freeVO, ModelMap model, HttpServletResponse response) throws Exception {
		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		freeVO.setActListMode("EXCEL");
		selectActStudentList(freeVO, model);
		String fileName = "현강생리스트_";
		fileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		response.setContentType("application/vnd.ms-excel;charset=EUC-KR");
		response.setHeader("Content-Description", "JSP Generated Data");
		fileName = (fileName+getDateTransStrSp(getCurrDate(),"-")+".xls");
		response.setHeader("Content-Disposition", "attachment; fileName=" + fileName);
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		return "/boffice/actMemb/studentExcel";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/boffice/actMemb/actStudentSendMail.do")
	@ResponseBody
	public String actMembSendMail(@ModelAttribute("freeVO") ActStudentManageVO freeVO) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return "illegal";
		}
		String mailResult = "";
		String addMail = "";
		freeVO.setActListMode("EXCEL");
		freeVO.setReturnStt(freeVO.getsIdx());
		List<?> resultList = actStudentManageService.selectActStudentList(freeVO);
		for(int i=0;i<resultList.size();i++){
			Map<String, Object> vo = (Map<String,Object>) resultList.get(i);
			if(!isNull((String) vo.get("sEmail"))){
				addMail = addMail + (String) vo.get("sEmail");
				if(i < resultList.size()-1){
					addMail = addMail + ",";
				}
			}
		}
		//이메일 전송
		try {
			String mailSubject = freeVO.getMailSubject();
			String mailHtml = "";
			String mailFolder = context.getRealPath("/html/mail//");
			String mailTpl = mailFolder+"/memMail.html";
			File file = new File(mailTpl);
			mailHtml = FileUtil.readAsString(file);
			mailHtml = mailHtml.replace("[MAIL_SUBJECT]", mailSubject);
			mailHtml = mailHtml.replace("[MAIL_CON]", freeVO.getMailCn().replaceAll("(\r\n|\r|\n|\n\r)", "<br/>"));
			if(!isNull(addMail)){
				emailSender.send(addMail, mailSubject, mailHtml);
			}
          // 메일 전송 성공
			mailResult = "메일전송성공";
		} catch(Exception ne) {
			ne.printStackTrace();
			mailResult = "메일전송실패";
		} finally {
			System.out.println("Email_sending===>>>"+mailResult);
		}
		//이메일 전송
		return "success";
	}

	@RequestMapping("/boffice/actMemb/actStudentView.do")
	public String selectActStudentDetail(@ModelAttribute("freeVO") ActStudentManageVO freeVO, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){
			return MENU_AUTH_REDIRECT;
		}

		Map<String, Object> vo = actStudentManageService.selectActStudentDetail(freeVO);
		model.addAttribute("resultInfo", vo);

		model.addAttribute("menuCode", MENU_AUTH_NO);
		return "/boffice/actMemb/studentView";
	}

	@RequestMapping("/boffice/actMemb/insertActStudent.do")
	@ResponseBody
	public String insertActStudent(final MultipartHttpServletRequest multiRequest, @ModelAttribute("studentVO") ActStudentManageVO studentVO, Model model) throws Exception {
    	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
        // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		String retstr = "success";

		//파일 저장 s-------------------------------------------------------------------------------------------------------------
		String thumFileId = studentVO.getThumId();
	
		if(!checkImgUpLoadFile(multiRequest,1)) return "ERR_PIC";
		//파일 저장 s-------------------------------------------------------------------------------------------------------------
		final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
		MultipartFile fileCheckItem = multiRequest.getFile("fileThum");
		if(filesThum.keySet().size()>0 && !filesThum.isEmpty() && !fileCheckItem.isEmpty()){
		    List<FileVO> result = fileUtil.parseFileInf(filesThum, "STDNT_", 0, "", "STDNT");
		    thumFileId = fileMngService.insertFileInfs(result);
		    studentVO.setThumId(thumFileId);
	    }
	
		//파일 저장 e-------------------------------------------------------------------------------------------------------------
		
		studentVO.setsIdx(actStudentManageService.selectActStudentMaxIdx(studentVO));
		
		String[] tel = (studentVO.getsTel()).split(",",3);
		if(!isNull(tel[0]) && !isNull(tel[1]) && !isNull(tel[2])){
			studentVO.setsTel(tel[0]+"-"+tel[1]+"-"+tel[2]);
		}else{
			studentVO.setsTel("");
		}
		String[] hand = (studentVO.getsHand()).split(",",3);
		if(!isNull(hand[0]) && !isNull(hand[1]) && !isNull(hand[2])){
			studentVO.setsHand(hand[0]+"-"+hand[1]+"-"+hand[2]);
		}else{
			studentVO.setsHand("");
		}
		actStudentManageService.insertActStudent(studentVO);
		return retstr;
	}

	@RequestMapping("/boffice/actMemb/modifyActStudent.do")
	@ResponseBody
	public String updateActStudent(final MultipartHttpServletRequest multiRequest, @ModelAttribute("studentVO") ActStudentManageVO studentVO, ModelMap model) throws Exception {
     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }

		//파일 저장 s-------------------------------------------------------------------------------------------------------------
		String thumFileId = studentVO.getThumId();
	
		if(!checkImgUpLoadFile(multiRequest,1)) return "ERR_PIC";
		//파일 저장 s-------------------------------------------------------------------------------------------------------------
		final Map<String, MultipartFile> filesThum = multiRequest.getFileMap();
		//파일 삭제하기 위한 FileVO생성
		FileVO filevo = new FileVO();
		filevo.setAtchFileId(thumFileId);
		filevo.setFileSn("0");
		//파일 삭제하기 위한 FileVO생성
		if("Y".equals(studentVO.getThumDel())){
			deleteUpLoadFile(filevo);
			studentVO.setThumId("");
		}
		MultipartFile fileCheckItem = multiRequest.getFile("fileThum");
		if(filesThum.keySet().size()>0 && !filesThum.isEmpty() && !fileCheckItem.isEmpty()){
			if(studentVO.getThumDel()!=null && !isNull(thumFileId)){
				deleteUpLoadFile(filevo);
			}
		    List<FileVO> result = fileUtil.parseFileInf(filesThum, "STDNT_", 0, "", "STDNT");
		    thumFileId = fileMngService.insertFileInfs(result);
		    studentVO.setThumId(thumFileId);
	    }
	
		//파일 저장 e-------------------------------------------------------------------------------------------------------------

		String[] tel = (studentVO.getsTel()).split(",",3);
		if(!isNull(tel[0]) && !isNull(tel[1]) && !isNull(tel[2])){
			studentVO.setsTel(tel[0]+"-"+tel[1]+"-"+tel[2]);
		}else{
			studentVO.setsTel("");
		}
		String[] hand = (studentVO.getsHand()).split(",",3);
		if(!isNull(hand[0]) && !isNull(hand[1]) && !isNull(hand[2])){
			studentVO.setsHand(hand[0]+"-"+hand[1]+"-"+hand[2]);
		}else{
			studentVO.setsHand("");
		}
		actStudentManageService.updateActStudent(studentVO);
		return "success";
	}

	@RequestMapping("/boffice/actMemb/deleteActStudent.do")
	@ResponseBody
	public String deleteActStudent(@ModelAttribute("freeVO") ActStudentManageVO freeVO, ModelMap model) throws Exception {

     	//관리자로그 기록
    	webLogInsert(MENU_AUTH_NO,1);
       // 미인증 사용자에 대한 보안처리
		if(!isMenuAuthCheck(MENU_AUTH_NO)){ return "illegal"; }
		
	    if(isNull(freeVO.getSearchChk())){
	    	freeVO.setSearchChk(String.valueOf(freeVO.getsIdx()));
	    }
	    String[] mIdxArr = (freeVO.getSearchChk()).split(",");
	    for(int i=0;i<mIdxArr.length;i++){
	    	freeVO.setsIdx((mIdxArr[i]));
	    	actStudentManageService.deleteActStudent(freeVO);
	    }
		return "success";
	}

}
