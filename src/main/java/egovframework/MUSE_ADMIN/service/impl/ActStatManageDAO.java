package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActStatManageDAO")
public class ActStatManageDAO extends EgovComAbstractDAO {

	public List<?> selectActStatMoving(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActStatMoving", orderVO);
	}
	@SuppressWarnings("unchecked")
	public Map<String,String> selectActStatSum(ActOrderManageVO orderVO) throws Exception {
		return (Map<String,String>) selectOne("ActStatManage.selectActStatSum", orderVO);
	}
	public int selectActStatTotalCnt(ActOrderManageVO orderVO) throws Exception {
		return (Integer) selectOne("ActStatManage.selectActStatTotalCnt", orderVO);
	}


	public List<?> selectActStatBook(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActStatBook", orderVO);
	}
	@SuppressWarnings("unchecked")
	public Map<String,String> selectActStatBookSum(ActOrderManageVO orderVO) throws Exception {
		return (Map<String,String>) selectOne("ActStatManage.selectActStatBook", orderVO);
	}
	public int selectActStatBookTotalCnt(ActOrderManageVO orderVO) throws Exception {
		return (Integer) selectOne("ActStatManage.selectActStatBookTotalCnt", orderVO);
	}

	public List<?> selectActStatProf(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActStatProf", orderVO);
	}

	public List<?> selectActStatQna(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActStatQna", orderVO);
	}

	public List<?> selectActStatPds(BoardManageVO bbsVO) throws Exception {
		return selectList("ActStatManage.selectActStatPds", bbsVO);
	}

	public List<?> selectActStatBbsDw(BoardManageVO bbsVO) throws Exception {
		return selectList("ActStatManage.selectActStatBbsDw", bbsVO);
	}

	@SuppressWarnings("unchecked")
	public Map<String,String> selectActStatPdsSum(BoardManageVO bbsVO) throws Exception {
		bbsVO.setActListMode("SUM");
		return (Map<String,String>) selectOne("ActStatManage.selectActStatPds", bbsVO);
	}

	public List<?> selectActStatMain(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActStatMain", orderVO);
	}
	public List<?> selectActStatMain1(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActStatMain1", orderVO);
	}

	/*관리자 로그 등록*/
	public void insertCommonLog(ActManageDefaultVO vo) throws Exception {
		insert("ActStatManage.insertCommonLog", vo);
	}

	public List<?> selectActCommonLog(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActStatManage.selectActCommonLog", orderVO);
	}

}
