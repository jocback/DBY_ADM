package egovframework.MUSE_ADMIN.service.impl;

import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActOrderNoticeManageService;
import egovframework.MUSE_ADMIN.service.ActOrderNoticeManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOrderNoticeManageService")
public class ActOrderNoticeManageServiceImpl extends EgovAbstractServiceImpl implements ActOrderNoticeManageService {

	@Resource(name = "ActOrderNoticeManageDAO")
	private ActOrderNoticeManageDAO actOrderNoticeManageDAO;

	@Override
	public Map<String, Object> selectActOrderNoticeDetail(ActOrderNoticeManageVO vo) throws Exception {
		return actOrderNoticeManageDAO.selectActOrderNoticeDetail(vo);
	}

	@Override
	public void updateActOrderNotice(ActOrderNoticeManageVO vo) throws Exception {
		actOrderNoticeManageDAO.updateActOrderNotice(vo);
	}

}
