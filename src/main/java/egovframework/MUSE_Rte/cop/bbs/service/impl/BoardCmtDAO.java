package egovframework.MUSE_Rte.cop.bbs.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardCmtVO;

import org.springframework.stereotype.Repository;

/**
 * 댓글관리를 위한 데이터 접근 클래스
 */
@Repository("BoardCmtDAO")
public class BoardCmtDAO extends EgovComAbstractDAO {

    /**
     * 댓글에 대한 목록을 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public List<?> selectCommentList(BoardCmtVO commentVO) throws Exception {
	return selectList("BBSComment.selectCommentList", commentVO);
    }
    
    /**
     * 댓글에 대한 목록 건수를 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public int selectCommentListCnt(BoardCmtVO commentVO) throws Exception {
	return (Integer)selectOne("BBSComment.selectCommentListCnt", commentVO);
    }
    
    /**
     * 댓글을 등록한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void insertComment(BoardCmtVO comment) throws Exception {	
	insert("BBSComment.insertComment", comment);
    }
    
    /**
     * 댓글을 삭제한다.
     * 
     * @param commentVO
     * @throws Exception
     */
    public void deleteComment(BoardCmtVO commentVO) throws Exception {
	update("BBSComment.deleteComment", commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 조회한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public BoardCmtVO selectComment(BoardCmtVO commentVO) throws Exception {
	return (BoardCmtVO)selectOne("BBSComment.selectComment", commentVO);
    }
    
    /**
     * 댓글에 대한 내용을 수정한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void updateComment(BoardCmtVO comment) throws Exception {	
	insert("BBSComment.updateComment", comment);
    }
    
    /**
     * 댓글에 대한 패스워드를 조회 한다.
     * 
     * @param comment
     * @return
     * @throws Exception
     */
    public String getCommentPassword(BoardCmtVO comment) throws Exception {
	return (String)selectOne("BBSComment.getCommentPassword", comment);
    }
}
