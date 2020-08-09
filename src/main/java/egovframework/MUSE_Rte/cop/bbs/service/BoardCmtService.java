package egovframework.MUSE_Rte.cop.bbs.service;

import java.util.Map;


/**
 * 댓글관리를 위한 서비스 인터페이스 클래스
 */
public interface BoardCmtService {
    
    /**
     * 댓글에 대한 목록을 조회 한다.
     * 
     * @param commentVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectCommentList(BoardCmtVO commentVO) throws Exception;
    
    /**
     * 댓글을 등록한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void insertComment(BoardCmtVO comment) throws Exception;
    
    /**
     * 댓글을 삭제한다.
     * 
     * @param commentVO
     * @throws Exception
     */
    public void deleteComment(BoardCmtVO commentVO) throws Exception;
    
    /**
     * 댓글에 대한 내용을 조회한다.
     *      
     * @param commentVO
     * @return
     * @throws Exception
     */
    public BoardCmtVO selectComment(BoardCmtVO commentVO) throws Exception;
    
    /**
     * 댓글에 대한 내용을 수정한다.
     * 
     * @param comment
     * @throws Exception
     */
    public void updateComment(BoardCmtVO comment) throws Exception;
   
    /**
     * 댓글 패스워드를 가져온다.
     * 
     * @param comment
     * @return
     * @throws Exception
     */
    public String getCommentPassword(BoardCmtVO comment) throws Exception;
}
