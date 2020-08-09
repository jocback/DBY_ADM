package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActOrderEstiManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOrderEstiManageService")
public class ActOrderEstiManageServiceImpl extends EgovAbstractServiceImpl implements ActOrderEstiManageService {

	@Resource(name = "ActOrderEstiManageDAO")
	private ActOrderEstiManageDAO actOrderEstiManageDAO;

	@Override
	public Map<String, Object> selectActOrderEstiDetail(ActOrderManageVO vo) throws Exception {
		return actOrderEstiManageDAO.selectActOrderEstiDetail(vo);
	}

	@Override
	public List<?> selectActOrderEstiList(ActOrderManageVO orderVO) throws Exception {
		return actOrderEstiManageDAO.selectActOrderEstiList(orderVO);
	}

	@Override
	public Map<String, Object> selectActOrderEstiListCnt(ActOrderManageVO vo) throws Exception {
		return actOrderEstiManageDAO.selectActOrderEstiListCnt(vo);
	}

	@Override
	public String selectActOrderEstiMaxIdx(ActOrderManageVO vo) {
		return actOrderEstiManageDAO.selectActOrderEstiMaxIdx(vo);
	}

	@Override
	public void insertActOrderEsti(ActOrderManageVO vo) throws Exception {
		actOrderEstiManageDAO.insertActOrderEsti(vo);
	}

	@Override
	public void deleteActOrderEsti(ActOrderManageVO vo) throws Exception {
		actOrderEstiManageDAO.deleteActOrderEsti(vo);
	}

}
