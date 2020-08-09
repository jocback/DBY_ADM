package egovframework.MUSE_Rte.cop.bbs.service;

import java.util.Map;


/**
 * 게시물 관리를 위한 서비스 인터페이스  클래스
 */
public interface BoardManageService {

    /**
     * 게시물 한 건을 삭제 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void deleteBoardArticle(BoardManageVO Board) throws Exception;

    /**
     * 게시판에 게시물 또는 답변 게시물을 등록 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void insertBoardArticle(BoardManageVO Board) throws Exception;

    /**
     * 게시물 대하여 상세 내용을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public BoardManageVO selectBoardArticle(BoardManageVO boardVO) throws Exception;
    public BoardManageVO selectBoardExtField(BoardManageVO boardVO) throws Exception;
    Map<String, Object> selectBoardTwoArticle(BoardManageVO vo) throws Exception;

    /**
     * 조건에 맞는 게시물 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectBoardArticles(BoardManageVO boardVO) throws Exception;
    public Integer selectBoardArticleCheckCnt(BoardManageVO boardVO) throws Exception;


    /**
     * 게시물 한 건의 내용을 수정 한다.
     * 
     * @param Board
     * @throws Exception
     */
    public void updateBoardArticle(BoardManageVO Board) throws Exception;

    public void updateBoardSeqSwitch(BoardManageVO Board) throws Exception;

    /**
     * 방명록에 대한 목록을 조회 한다.
     * 
     * @param boardVO
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectGuestList(BoardManageVO boardVO) throws Exception;

    /**
     * 방명록 내용을 삭제 한다.
     * 
     * @param boardVO
     * @throws Exception
     */
    public void deleteGuestList(BoardManageVO boardVO) throws Exception;

    /**
     * 방명록에 대한 패스워드를 조회 한다.
     * 
     * @param Board
     * @return
     * @throws Exception
     */
    public String getPasswordInf(BoardManageVO Board) throws Exception;

}
