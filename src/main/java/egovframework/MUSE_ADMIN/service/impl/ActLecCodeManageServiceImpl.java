package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActLecCodeManageService")
public class ActLecCodeManageServiceImpl extends EgovAbstractServiceImpl implements ActLecCodeManageService {

    @Resource(name="ActLecCodeManageDAO")
    private ActLecCodeManageDAO actLecCodeManageDAO;

	@Override
	public List<?> selectLecCodeManageList(ActLecCodeManageVO lecCodeManageVO) throws Exception {
        return actLecCodeManageDAO.selectLecCodeManageList(lecCodeManageVO);
	}

	@Override
	public ActLecCodeManageVO selectLecCodeManageDetail(ActLecCodeManageVO lecCodeManageVO) throws Exception {
    	ActLecCodeManageVO ret = actLecCodeManageDAO.selectLecCodeManageDetail(lecCodeManageVO);
    	return ret;
	}

	@Override
	public void insertLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception {
    	actLecCodeManageDAO.insertLecCodeManage(lecCodeManageVO);
	}

	@Override
	public void updateLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		actLecCodeManageDAO.updateLecCodeManage(lecCodeManageVO);
	}

	@Override
	public void deleteLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		actLecCodeManageDAO.deleteLecCodeManage(lecCodeManageVO);
	}

	@Override
	public void updateActLecCodeSeq(ActLecCodeManageVO lecCodeManageVO) throws Exception {
		actLecCodeManageDAO.updateActLecCodeSeq(lecCodeManageVO);
	}

}
