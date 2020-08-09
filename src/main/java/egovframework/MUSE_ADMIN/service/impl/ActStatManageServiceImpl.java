package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActStatManageService")
public class ActStatManageServiceImpl extends EgovAbstractServiceImpl implements ActStatManageService {

	@Resource(name = "ActStatManageDAO")
	private ActStatManageDAO actStatManageDAO;

	@Override
	public List<?> selectActStatMoving(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatMoving(orderVO);
	}
	@Override
	public Map<String,String> selectActStatSum(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatSum(orderVO);
	}
	@Override
	public int selectActStatTotalCnt(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatTotalCnt(orderVO);
	}


	@Override
	public List<?> selectActStatBook(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatBook(orderVO);
	}
	@Override
	public Map<String,String> selectActStatBookSum(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatBookSum(orderVO);
	}
	@Override
	public int selectActStatBookTotalCnt(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatBookTotalCnt(orderVO);
	}

	@Override
	public List<?> selectActStatProf(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatProf(orderVO);
	}

	@Override
	public List<?> selectActStatQna(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatQna(orderVO);
	}

	@Override
	public List<?> selectActStatPds(BoardManageVO bbsVO) throws Exception {
		return actStatManageDAO.selectActStatPds(bbsVO);
	}

	@Override
	public List<?> selectActStatBbsDw(BoardManageVO bbsVO) throws Exception {
		return actStatManageDAO.selectActStatBbsDw(bbsVO);
	}

	@Override
	public Map<String,String> selectActStatPdsSum(BoardManageVO bbsVO) throws Exception {
		return actStatManageDAO.selectActStatPdsSum(bbsVO);
	}

	@Override
	public List<?> selectActStatMain(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatMain(orderVO);
	}

	@Override
	public List<?> selectActStatMain1(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActStatMain1(orderVO);
	}

	@Override
	public void insertCommonLog(ActManageDefaultVO orderVO) throws Exception {
		actStatManageDAO.insertCommonLog(orderVO);
	}

	@Override
	public List<?> selectActCommonLog(ActOrderManageVO orderVO) throws Exception {
		return actStatManageDAO.selectActCommonLog(orderVO);
	}
}
