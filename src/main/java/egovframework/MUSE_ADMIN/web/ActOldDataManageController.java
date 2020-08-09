package egovframework.MUSE_ADMIN.web;

import java.util.Iterator;
import java.util.List;

import egovframework.MUSE_ADMIN.web.ActCommonController;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActOldDataManageService;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageService;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ActOldDataManageController extends ActCommonController{

	/** actArtcManageService */
	@Resource(name = "ActOldDataManageService")
	private ActOldDataManageService actOldDataManageService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "ActMembManageService")
	private ActMembManageService actMembManageService;
    
	@Resource(name = "BoardManageService")
    private BoardManageService bbsMngService;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("/boffice/activity/oldBbsLoad.do")
	@ResponseBody
	public String insertOldDataBbs(@ModelAttribute("searchVO") BoardManageVO boardVO) throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("143")){ //게시판 마스터 권한으로 체크
			return "illegal";
		}else{
			//boardVO.setReplyAt("N");
			List<?> otherResult = actOldDataManageService.selectActOldDataList(boardVO);
		    BoardManageVO vo;
		    FileVO fileVo = new FileVO();
		    Iterator<?> iter = otherResult.iterator();
		    while (iter.hasNext()) {
		    	vo = (BoardManageVO)iter.next();
				boardVO.setPreNoteid(vo.getPreNoteid());
				boardVO.setReplyAt(vo.getReplyAt());
				int knoCnt = bbsMngService.selectBoardArticleCheckCnt(boardVO);
			    if(knoCnt<1){
					System.out.println("NTT_SJ ======>>> "+vo.getNttSj());
					//첨부파일 처리 s
					//fileVo.setPreBno(vo.getPreNoteid());
					//List<FileVO> otherFileResult = actOldDataManageService.selectActOldDataFileList(fileVo);
					String atchFileId = "";
					//atchFileId = fileMngService.insertFileInfs(otherFileResult);
					//vo.setAtchFileId(atchFileId);
					if(!isNull(vo.getAtchFileId())){
						String thumId = String.format("%012d", Integer.parseInt(vo.getPreNoteid()));
						fileVo.setAtchFileId("PRE"+boardVO.getBbsId().substring(4)+"_"+thumId);
						/*if("BBS_0007".equals(boardVO.getBbsId())){
							fileVo.setAtchFileId("PREBOOK_"+thumId);
						}
						if("BBS_0005".equals(boardVO.getBbsId())){
							fileVo.setAtchFileId("PRERCRT_"+thumId);
						}*/
						fileVo.setFileSn("0");
						fileVo.setFileStreCours("/usr/dby/upload/BBS");
						fileVo.setStreFileNm(vo.getAtchFileId());
						fileVo.setOrignlFileNm(vo.getFileName());
						fileVo.setFileExtsn(vo.getFileExt());
						fileVo.setFileMg(null);
						fileVo.setFileCn(null);
						atchFileId = fileMngService.insertFileInf(fileVo);
						vo.setAtchFileId(atchFileId);
						/*if("BBS_0002".equals(boardVO.getBbsId()) || "BBS_0007".equals(boardVO.getBbsId()) || "BBS_0009".equals(boardVO.getBbsId())
								|| "BBS_0016".equals(boardVO.getBbsId()) || "BBS_0017".equals(boardVO.getBbsId()) || "BBS_0019".equals(boardVO.getBbsId())	){
							vo.setThumFileId(atchFileId);
						}*/
					}
					//첨부파일 처리 e
					bbsMngService.insertBoardArticle(vo);
			    }
		    }
		    actOldDataManageService.updateActOldDataCn(boardVO);
		}
		return retStr;
	}

	@RequestMapping("/boffice/activity/oldBookLoad.do")
	@ResponseBody
	public String insertOldBook() throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("109")){ //회원관리 권한으로 체크
			return "illegal";
		}else{
			actOldDataManageService.insertActBookOld();
		}
		return retStr;
	}

	@RequestMapping("/boffice/activity/oldLectureLoad.do")
	@ResponseBody
	public String insertActLectureOld() throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("109")){ //회원관리 권한으로 체크
			return "illegal";
		}else{
			actOldDataManageService.insertActLectureOld();
		}
		return retStr;
	}

	@RequestMapping("/boffice/activity/oldMemberLoad.do")
	@ResponseBody
	public String insertOldMember() throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("109")){ //회원관리 권한으로 체크
			return "illegal";
		}else{
			actOldDataManageService.insertActMembOld();
		}
		return retStr;
	}

	@RequestMapping("/boffice/activity/oldProfLoad.do")
	@ResponseBody
	public String insertOldProf() throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("109")){ //회원관리 권한으로 체크
			return "illegal";
		}else{
			ActMembManageVO membVO = new ActMembManageVO(); 
			List<?> profResult = actOldDataManageService.selectActOldProfList(membVO);
		    ActMembManageVO vo;
		    Iterator<?> iter = profResult.iterator();
		    while (iter.hasNext()) {
		    	vo = (ActMembManageVO)iter.next();
				actOldDataManageService.insertActProfOld(vo);
		    }
		}
		return retStr;
	}

	@RequestMapping("/boffice/activity/oldDownCntLoad.do")
	@ResponseBody
	public String insertActDownCntOld() throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("109")){ //회원관리 권한으로 체크
			return "illegal";
		}else{
			actOldDataManageService.insertActDownCntOld();
		}
		return retStr;
	}

	@RequestMapping("/boffice/activity/oldMemberPassTran.do")
	@ResponseBody
	public String updateOldMemberPassTran() throws Exception {
		String retStr = "success";
		if(!isMenuAuthCheck("109")){ //회원관리 권한으로 체크
			return "illegal";
		}else{
			List<?> Result = actOldDataManageService.selectOldMemberPass();
		    ActMembManageVO vo;
		    Iterator<?> iter = Result.iterator();
		    while (iter.hasNext()) {
		    	vo = (ActMembManageVO)iter.next();
				actOldDataManageService.oldMemberPassTran(vo);
		    }
		}
		return retStr;
	}

}
