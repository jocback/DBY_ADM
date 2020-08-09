package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOrderEstiManageDAO")
public class ActOrderEstiManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderEstiDetail(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderEstiManage.selectActOrderEstiDetail", vo);
	}
	/*목록*/
	public List<?> selectActOrderEstiList(ActOrderManageVO orderVO) throws Exception {
		return selectList("ActOrderEstiManage.selectActOrderEstiList", orderVO);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderEstiListCnt(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderEstiManage.selectActOrderEstiList", vo);
	}
	public String selectActOrderEstiMaxIdx(ActOrderManageVO vo) {
		return (String) selectOne("ActOrderEstiManage.selectActOrderEstiMaxIdx", vo);
	}
	/*등록*/
	public void insertActOrderEsti(ActOrderManageVO vo) throws Exception {
		insert("ActOrderEstiManage.insertActOrderEsti", vo);
	}
	/*삭제*/
	public void deleteActOrderEsti(ActOrderManageVO vo) throws Exception {
		delete("ActOrderEstiManage.deleteActOrderEsti", vo);
	}

}
