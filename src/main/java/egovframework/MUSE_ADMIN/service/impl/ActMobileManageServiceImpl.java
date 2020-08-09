package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActMobileManageService;
import egovframework.MUSE_ADMIN.service.ActMobileManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActMobileManageService")
public class ActMobileManageServiceImpl extends EgovAbstractServiceImpl implements ActMobileManageService {

	@Resource(name = "ActMobileManageDAO")
	private ActMobileManageDAO actMobileManageDAO;

	@Override
	public List<?> selectActMobileList(ActMobileManageVO freeVO) throws Exception {
		return actMobileManageDAO.selectActMobileList(freeVO);
	}

	@Override
	public Map<String,Object> selectActMobileListCnt(ActMobileManageVO freeVO) throws Exception {
		return actMobileManageDAO.selectActMobileListCnt(freeVO);
	}

	@Override
	public Map<String,Object> selectActMobileTotCnt(ActMobileManageVO freeVO) throws Exception {
		return actMobileManageDAO.selectActMobileTotCnt(freeVO);
	}

	@Override
	public void insertActMobileConf(ActMobileManageVO vo) throws Exception {
		actMobileManageDAO.insertActMobileConf(vo);
	}

	@Override
	public void deleteMobileConf(ActMobileManageVO vo) throws Exception {
		actMobileManageDAO.deleteMobileConf(vo);
	}

	@Override
	public void deleteMobileDevice(ActMobileManageVO vo) throws Exception {
		actMobileManageDAO.deleteMobileDevice(vo);
	}

}
