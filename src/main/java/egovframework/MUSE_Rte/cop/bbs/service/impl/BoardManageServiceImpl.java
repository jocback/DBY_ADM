package egovframework.MUSE_Rte.cop.bbs.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageService;
import egovframework.MUSE_Rte.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 * 게시물 관리를 위한 서비스 구현 클래스
 */
@Service("BoardManageService")
public class BoardManageServiceImpl extends EgovAbstractServiceImpl implements BoardManageService {

    @Resource(name = "BoardManageDAO")
    private BoardManageDAO bbsMngDAO;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name = "egovNttIdGnrService")
    private EgovIdGnrService nttIdgenService;

    /**
     * 게시물 한 건을 삭제 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#deleteBoardArticle(egovframework.MUSE_Rte.cop.bbs.brd.service.Board)
     */
    public void deleteBoardArticle(BoardManageVO board) throws Exception {
		FileVO fvo = new FileVO();
		fvo.setAtchFileId(board.getAtchFileId());
		board.setNttSj("이 글은 작성자에 의해서 삭제되었습니다.");
		bbsMngDAO.deleteBoardArticle(board);
		if (!"".equals(fvo.getAtchFileId()) || fvo.getAtchFileId() != null) {
		    fileService.deleteAllFileInf(fvo);
		}
		if ("Y".equals(board.getExtYn())) {
		    bbsMngDAO.deleteBoardExtField(board);
		}
    }

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#insertBoardArticle(egovframework.MUSE_Rte.cop.bbs.brd.service.Board)
     */
    public void insertBoardArticle(BoardManageVO board) throws Exception {
	// SORT_ORDR는 부모글의 소트 오더와 같게, NTT_NO는 순서대로 부여

    	if ("Y".equals(board.getReplyAt())) {
		    // 답글인 경우 1. Parnts를 세팅, 2.Parnts의 sortOrdr을 현재글의 sortOrdr로 가져오도록, 3.nttNo는 현재 게시판의 순서대로
		    // replyLc는 부모글의 ReplyLc + 1
	
		    board.setNttId(nttIdgenService.getNextIntegerId());	// 답글에 대한 nttId 생성
		    bbsMngDAO.replyBoardArticle(board);
	
		} else {
		    // 답글이 아닌경우 Parnts = 0, replyLc는 = 0, sortOrdr = nttNo(Query에서 처리)
			if(board.getNttPsw().length()>0){
				String enpassword = EgovFileScrty.encryptPassword2(board.getNttPsw());
		    	board.setNttPsw(enpassword);
			}
		    board.setReplyNo("0");
		    board.setReplyLc("0");
		    board.setReplyAt("N");
		    board.setNttId(nttIdgenService.getNextIntegerId());//2011.09.22
	
		    bbsMngDAO.insertBoardArticle(board);
		}
		if ("Y".equals(board.getExtYn())) {
		    bbsMngDAO.insertBoardExtField(board);
		}
    }

	/**
     * 게시물 대하여 상세 내용을 조회 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#selectBoardArticle(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardVO)
     */
    public BoardManageVO selectBoardArticle(BoardManageVO boardVO) throws Exception {
		if (boardVO.isPlusCount()) {
		    int iniqireCo = bbsMngDAO.selectMaxInqireCo(boardVO);
		    boardVO.setRdcnt(iniqireCo);
		    bbsMngDAO.updateInqireCo(boardVO);
		}
	
		return bbsMngDAO.selectBoardArticle(boardVO);
    }
    public BoardManageVO selectBoardExtField(BoardManageVO boardVO) throws Exception {
		return bbsMngDAO.selectBoardExtField(boardVO);
    }
    @Override
	public Map<String, Object> selectBoardTwoArticle(BoardManageVO vo) throws Exception {
		return bbsMngDAO.selectBoardTwoArticle(vo);
	}

	/**
     * 조건에 맞는 게시물 목록을 조회 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#selectBoardArticles(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardVO)
     */
	public Map<String, Object> selectBoardArticles(BoardManageVO boardVO) throws Exception {
		List<?> list = bbsMngDAO.selectBoardArticleList(boardVO);
		List<?> result = new ArrayList<BoardManageVO>();
	
	    result = list;
		int cnt = bbsMngDAO.selectBoardArticleListCnt(boardVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    public Integer selectBoardArticleCheckCnt(BoardManageVO boardVO) throws Exception {
		return bbsMngDAO.selectBoardArticleCheckCnt(boardVO);
    }

    /**
     * 게시물 한 건의 내용을 수정 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#updateBoardArticle(egovframework.MUSE_Rte.cop.bbs.brd.service.Board)
     */
    public void updateBoardArticle(BoardManageVO board) throws Exception {
		if(board.getNttPsw().length()>0){
			String enpassword = EgovFileScrty.encryptPassword2(board.getNttPsw());
	    	board.setNttPsw(enpassword);
		}
    	bbsMngDAO.updateBoardArticle(board);
		if ("Y".equals(board.getExtYn())) {
		    bbsMngDAO.updateBoardExtField(board);
		}
    }

    public void updateBoardSeqSwitch(BoardManageVO board) throws Exception {
    	bbsMngDAO.updateBoardSeqSwitch(board);
    }

    /**
     * 방명록 내용을 삭제 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#deleteGuestList(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardVO)
     */
    public void deleteGuestList(BoardManageVO boardVO) throws Exception {
		bbsMngDAO.deleteGuestList(boardVO);
    }

    /**
     * 방명록에 대한 목록을 조회 한다.
     *
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSManageService#selectGuestList(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardVO)
     */
    public Map<String, Object> selectGuestList(BoardManageVO boardVO) throws Exception {
		List<?> result = bbsMngDAO.selectGuestList(boardVO);
		int cnt = bbsMngDAO.selectGuestListCnt(boardVO);
	
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     *
     * @param board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(BoardManageVO board) throws Exception {
		return bbsMngDAO.getPasswordInf(board);
    }
}
