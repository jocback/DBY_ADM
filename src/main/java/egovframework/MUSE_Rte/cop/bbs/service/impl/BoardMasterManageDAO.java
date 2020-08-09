package egovframework.MUSE_Rte.cop.bbs.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterVO;

import org.springframework.stereotype.Repository;

/**
 * 게시판 속성정보 관리를 위한 데이터 접근 클래스
 */
@Repository("BoardMasterManageDAO")
public class BoardMasterManageDAO extends EgovComAbstractDAO {

    /**
     * 등록된 게시판 속성정보를 삭제한다.
     * 
     * @param BoardMaster
     */
    public void deleteBBSMasterInf(BoardMasterVO boardMaster) throws Exception {
		update("BBSMaster.deleteBBSMasterInf", boardMaster);
    }

    /**
     * 신규 게시판 속성정보를 등록한다.
     * 
     * @param BoardMaster
     */
    public void insertBBSMasterInf(BoardMasterVO boardMaster) throws Exception {
		insert("BBSMaster.insertBBSMasterInf", boardMaster);
    }

    /**
     * 게시판 속성정보 한 건을 상세조회 한다.
     * 
     * @param BoardMasterVO
     */
	public BoardMasterVO selectBBSMasterInf(BoardMasterVO vo) throws Exception {
		return (BoardMasterVO) selectOne("BBSMaster.selectBBSMasterInf", vo);
    }

    /**
     * 게시판 속성정보 목록을 조회한다.
     * 
     * @param BoardMasterVO
     */
    public List<?> selectBBSMasterInfs(BoardMasterVO vo) throws Exception {
	return selectList("BBSMaster.selectBBSMasterInfs", vo);
    }

    /**
     * 게시판 속성정보 목록 숫자를 조회한다
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectBBSMasterInfsCnt(BoardMasterVO vo) throws Exception {
	return (Integer)selectOne("BBSMaster.selectBBSMasterInfsCnt", vo);
    }

    /**
     * 게시판 속성정보를 수정한다.
     * 
     * @param BoardMaster
     */
    public void updateBBSMasterInf(BoardMasterVO boardMaster) throws Exception {
	update("BBSMaster.updateBBSMasterInf", boardMaster);
    }

    /**
     * 유효한 게시판 목록을 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<?> selectAllBBSMasteInf() throws Exception {
	return (List<?>) selectList("BBSMaster.selectAllBBSMaster", "");
    }

    /**
     * 사용중인 게시판 속성정보 목록을 조회한다.
     * 
     * @param BoardMasterVO
     */
    public List<?> selectBdMstrListByTrget(BoardMasterVO vo) throws Exception {
	return selectList("BBSMaster.selectBdMstrListByTrget", vo);
    }

    /**
     * 사용중인 게시판 속성정보 목록 숫자를 조회한다
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectBdMstrListCntByTrget(BoardMasterVO vo) throws Exception {
	return (Integer)selectOne("BBSMaster.selectBdMstrListCntByTrget", vo);
    }

}
