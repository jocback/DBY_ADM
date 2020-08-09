package egovframework.MUSE_Rte.cop.bbs.service;

import java.util.List;
import java.util.Map;


/**
 * 게시판 속성관리를 위한 서비스 인터페이스 클래스
 */
public interface BoardMasterManageService {

    /**
     * 등록된 게시판 속성정보를 삭제한다.
     * 
     * @param BoardMaster
     */
    public void deleteBBSMasterInf(BoardMasterVO boardMaster) throws Exception;

    /**
     * 신규 게시판 속성정보를 생성한다.
     * 
     * @param BoardMaster
     */
    public String insertBBSMastetInf(BoardMasterVO boardMaster) throws Exception;

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @param BoardMasterVO
     */
    public BoardMasterVO selectBBSMasterInf(BoardMasterVO searchVO) throws Exception;

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param BoardMasterVO
     */
    public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception;

    /**
     * 게시판 속성정보를 수정한다.
     * 
     * @param BoardMaster
     */
    public void updateBBSMasterInf(BoardMasterVO boardMaster) throws Exception;

    /**
     * 유효한 게시판 마스터 정보를 호출한다.
     * 
     * @param searchVO
     * @return
     * @throws Exception
     */
    public List<?> selectAllBBSMasteInf() throws Exception;

    /**
     * 사용중인 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @param BoardMasterVO
     */
    public Map<String, Object> selectBdMstrListByTrget(BoardMasterVO vo) throws Exception;

}
