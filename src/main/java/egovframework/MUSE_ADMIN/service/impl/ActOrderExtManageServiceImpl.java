package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActOrderExtManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOrderExtManageService")
public class ActOrderExtManageServiceImpl extends EgovAbstractServiceImpl implements ActOrderExtManageService {

	@Resource(name = "ActOrderExtManageDAO")
	private ActOrderExtManageDAO actOrderExtManageDAO;

	@Override
	public Map<String, Object> selectActOrderExtDetail(ActOrderManageVO vo) throws Exception {
		return actOrderExtManageDAO.selectActOrderExtDetail(vo);
	}

	@Override
	public Map<String, Object> selectActOrderExtCancel(ActOrderManageVO vo) throws Exception {
		return actOrderExtManageDAO.selectActOrderExtCancel(vo);
	}

	@Override
	public List<?> selectActOrderExtList(ActManageDefaultVO searchVO) throws Exception {
		return actOrderExtManageDAO.selectActOrderExtList(searchVO);
	}

	@Override
	public List<?> selectActOrderExtDtList(ActOrderManageVO vo) throws Exception {
		return actOrderExtManageDAO.selectActOrderExtDtList(vo);
	}

	@Override
	public void updateActOrderExt(ActOrderManageVO vo) throws Exception {
		actOrderExtManageDAO.updateActOrderExt(vo);
	}

	@Override
	public void updateActOrderExtCancel(ActOrderManageVO vo) throws Exception {
		actOrderExtManageDAO.updateActOrderExtCancel(vo);
	}

	@Override
	public void deleteActOrderExt(ActOrderManageVO vo) throws Exception {
		actOrderExtManageDAO.deleteActOrderExt(vo);
	}
	@Override
	public Map<String, Object> selectActMovingExtStatSum(ActOrderManageVO vo) throws Exception {
		return actOrderExtManageDAO.selectActMovingExtStatSum(vo);
	}

}
