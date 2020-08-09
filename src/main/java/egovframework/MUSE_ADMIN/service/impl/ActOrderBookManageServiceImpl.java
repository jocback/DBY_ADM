package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActOrderBookManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOrderBookManageService")
public class ActOrderBookManageServiceImpl extends EgovAbstractServiceImpl implements ActOrderBookManageService {

	@Resource(name = "ActOrderBookManageDAO")
	private ActOrderBookManageDAO actOrderBookManageDAO;

	@Override
	public Map<String, Object> selectActOrderBookDetail(ActOrderManageVO vo) throws Exception {
		return actOrderBookManageDAO.selectActOrderBookDetail(vo);
	}

	@Override
	public Map<String, Object> selectActOrderBookCancel(ActOrderManageVO vo) throws Exception {
		return actOrderBookManageDAO.selectActOrderBookCancel(vo);
	}

	@Override
	public List<?> selectActOrderBookList(ActManageDefaultVO searchVO) throws Exception {
		return actOrderBookManageDAO.selectActOrderBookList(searchVO);
	}

	@Override
	public List<?> selectActOrderBookSubList(ActOrderManageVO vo) throws Exception {
		return actOrderBookManageDAO.selectActOrderBookSubList(vo);
	}

	@Override
	public void updateActOrderBookBasic(ActOrderManageVO vo) throws Exception {
		actOrderBookManageDAO.updateActOrderBookBasic(vo);
	}

	@Override
	public void transActOrderBook(ActOrderManageVO vo) throws Exception {
		actOrderBookManageDAO.transActOrderBook(vo);
	}

	@Override
	public void updateActOrderBookCancel(ActOrderManageVO vo) throws Exception {
		actOrderBookManageDAO.updateActOrderBookCancel(vo);
	}

	@Override
	public void deleteActOrderBook(ActOrderManageVO vo) throws Exception {
		actOrderBookManageDAO.deleteActOrderBook(vo);
	}

}
