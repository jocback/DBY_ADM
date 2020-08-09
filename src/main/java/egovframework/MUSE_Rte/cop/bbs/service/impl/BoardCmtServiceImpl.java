package egovframework.MUSE_Rte.cop.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.MUSE_Rte.cop.bbs.service.BoardCmtVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardCmtService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 * 댓글관리를 위한 서비스 구현 클래스
 */
@Service("EgovBBSCommentService")
public class BoardCmtServiceImpl extends EgovAbstractServiceImpl implements BoardCmtService {

    @Resource(name = "BoardCmtDAO")
    private BoardCmtDAO bbsCommentDAO;
    
    @Resource(name = "egovAnswerNoGnrService")
    private EgovIdGnrService egovAnswerNoGnrService;

    /**
     * 댓글에 대한 목록을 조회 한다.
     */
    public Map<String, Object> selectCommentList(BoardCmtVO commentVO) throws Exception {
	List<?> result = bbsCommentDAO.selectCommentList(commentVO);
	int cnt = bbsCommentDAO.selectCommentListCnt(commentVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }
    
    /**
     * 댓글을 등록한다.
     */
    public void insertComment(BoardCmtVO comment) throws Exception {
    comment.setCommentNo(egovAnswerNoGnrService.getNextLongId() + "");//2011.10.18
	bbsCommentDAO.insertComment(comment);
    }
    
    /**
     * 댓글을 삭제한다.
     */
    public void deleteComment(BoardCmtVO commentVO) throws Exception {
	bbsCommentDAO.deleteComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 조회한다.
     */
    public BoardCmtVO selectComment(BoardCmtVO commentVO) throws Exception {
	return bbsCommentDAO.selectComment(commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 수정한다.
     */
    public void updateComment(BoardCmtVO comment) throws Exception {
	bbsCommentDAO.updateComment(comment);
    }
    
    /**
     * 댓글 패스워드를 가져온다.
     */
    public String getCommentPassword(BoardCmtVO comment) throws Exception {
	return bbsCommentDAO.getCommentPassword(comment);
    }
}
