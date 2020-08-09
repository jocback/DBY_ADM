package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOrderBookManageDAO")
public class ActOrderBookManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderBookDetail(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderBookManage.selectActOrderBookDetail", vo);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderBookCancel(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderBookManage.selectActOrderBookCancel", vo);
	}
	/*목록*/
	public List<?> selectActOrderBookList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActOrderBookManage.selectActOrderBookList", searchVO);
	}
	public List<?> selectActOrderBookSubList(ActOrderManageVO vo) throws Exception {
		return selectList("ActOrderBookManage.selectActOrderBookSubList", vo);
	}
	public void updateActOrderBookBasic(ActOrderManageVO vo) throws Exception {
		update("ActOrderBookManage.updateActOrderBookBasic", vo);
	}
	public void transActOrderBook(ActOrderManageVO vo) throws Exception {
		update("ActOrderBookManage.transActOrderBook", vo);
	}
	public void updateActOrderBookCancel(ActOrderManageVO vo) throws Exception {
		update("ActOrderBookManage.updateActOrderBookCancel", vo);
	}
	/*삭제*/
	public void deleteActOrderBook(ActOrderManageVO vo) throws Exception {
		delete("ActOrderBookManage.deleteActOrderBook", vo);
	}

}
