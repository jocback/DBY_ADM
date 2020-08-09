package egovframework.MUSE_ADMIN.service.impl;

import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActOrderNoticeManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOrderNoticeManageDAO")
public class ActOrderNoticeManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderNoticeDetail(ActOrderNoticeManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderNoticeManage.selectActOrderNoticeDetail", vo);
	}
	/*수정*/
	public void updateActOrderNotice(ActOrderNoticeManageVO vo) throws Exception {
		update("ActOrderNoticeManage.updateActOrderNotice", vo);
	}

}
