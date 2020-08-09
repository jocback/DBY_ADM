package egovframework.MUSE_Rte.cop.bbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardMasterManageService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

/**
 * 게시판 속성관리를 위한 서비스 구현 클래스
 */
@Service("BoardMasterManageService")
public class BoardMasterManageServiceImpl extends EgovAbstractServiceImpl implements BoardMasterManageService {

    @Resource(name = "BoardMasterManageDAO")
    private BoardMasterManageDAO attrbMngDAO;

    @Resource(name = "egovBBSMstrIdGnrService")
    private EgovIdGnrService idgenService;
    
		
    /**
     * 등록된 게시판 속성정보를 삭제한다.
     * 
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSAttributeManageService#deleteBBSMasterInf(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardMaster)
     */
    public void deleteBBSMasterInf(BoardMasterVO boardMaster) throws Exception {
    	attrbMngDAO.deleteBBSMasterInf(boardMaster);
    }

    /**
     * 신규 게시판 속성정보를 생성한다.
     * 
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSAttributeManageService#insertBBSMastetInf(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardMaster)
     */
    public String insertBBSMastetInf(BoardMasterVO boardMaster) throws Exception {
	String bbsId = idgenService.getNextStringId();
		boardMaster.setBbsId(bbsId);
		attrbMngDAO.insertBBSMasterInf(boardMaster);
		return bbsId;
    }

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSAttributeManageService#selectAllBBSMasteInf(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardMasterVO)
     */
    public List<?> selectAllBBSMasteInf() throws Exception {
		return attrbMngDAO.selectAllBBSMasteInf();
    }

    /**
     * 게시판 속성정보 한 건을 상세조회한다.
     * 
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInf(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardMasterVO)
     */
    public BoardMasterVO selectBBSMasterInf(BoardMasterVO searchVO) throws Exception {
	
	BoardMasterVO result = attrbMngDAO.selectBBSMasterInf(searchVO);
		return result;
    }

    /**
     * 게시판 속성 정보의 목록을 조회 한다.
     * 
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSAttributeManageService#selectBBSMasterInfs(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardMasterVO)
     */
    public Map<String, Object> selectBBSMasterInfs(BoardMasterVO searchVO) throws Exception {
		List<?> result = attrbMngDAO.selectBBSMasterInfs(searchVO);
		int cnt = attrbMngDAO.selectBBSMasterInfsCnt(searchVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    /**
     * 게시판 속성정보를 수정한다.
     * 
     * @see egovframework.MUSE_Rte.cop.bbs.brd.service.EgovBBSAttributeManageService#updateBBSMasterInf(egovframework.MUSE_Rte.cop.bbs.brd.service.BoardMaster)
     */
    public void updateBBSMasterInf(BoardMasterVO boardMaster) throws Exception {
    	attrbMngDAO.updateBBSMasterInf(boardMaster);
    }
	


    /**
     * 사용중인 게시판 속성 정보의 목록을 조회 한다.
     */
    public Map<String, Object> selectBdMstrListByTrget(BoardMasterVO vo) throws Exception {
		List<?> result = attrbMngDAO.selectBdMstrListByTrget(vo);
		int cnt = attrbMngDAO.selectBdMstrListCntByTrget(vo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

}
