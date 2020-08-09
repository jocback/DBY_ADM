package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActFreeLectManageService;
import egovframework.MUSE_ADMIN.service.ActFreeLectManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActFreeLectManageService")
public class ActFreeLectManageServiceImpl extends EgovAbstractServiceImpl implements ActFreeLectManageService {

	@Resource(name = "ActFreeLectManageDAO")
	private ActFreeLectManageDAO actFreeLectManageDAO;

	@Override
	public Map<String, Object> selectActFreeLectDetail(ActFreeLectManageVO vo) throws Exception {
		return actFreeLectManageDAO.selectActFreeLectDetail(vo);
	}

	@Override
	public List<?> selectActFreeLectList(ActFreeLectManageVO freeVO) throws Exception {
		return actFreeLectManageDAO.selectActFreeLectList(freeVO);
	}

	@Override
	public Map<String, Object> selectActFreeLectListCnt(ActFreeLectManageVO vo) throws Exception {
		return actFreeLectManageDAO.selectActFreeLectListCnt(vo);
	}

	@Override
	public String selectActFreeLectMaxIdx(ActFreeLectManageVO vo) {
		return actFreeLectManageDAO.selectActFreeLectMaxIdx(vo);
	}

	@Override
	public void insertActFreeLect(ActFreeLectManageVO vo) throws Exception {
		actFreeLectManageDAO.insertActFreeLect(vo);
	}

	@Override
	public void updateActFreeLect(ActFreeLectManageVO vo) throws Exception {
		actFreeLectManageDAO.updateActFreeLect(vo);
	}

	@Override
	public void deleteActFreeLect(ActFreeLectManageVO vo) throws Exception {
		actFreeLectManageDAO.deleteActFreeLect(vo);
	}

	@Override
	public void deleteActFreeLectSub(ActFreeLectManageVO vo) throws Exception {
		actFreeLectManageDAO.deleteActFreeLectSub(vo);
	}

	@Override
	public void insertActFreeLectSub(ActFreeLectManageVO vo) throws Exception {
		actFreeLectManageDAO.insertActFreeLectSub(vo);
	}
	@Override
	public List<?> selectActFreeLectSub(ActFreeLectManageVO vo) throws Exception {
		return actFreeLectManageDAO.selectActFreeLectSub(vo);
	}

}
