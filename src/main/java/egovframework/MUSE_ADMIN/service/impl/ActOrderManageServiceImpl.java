package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActOrderManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActOrderManageService")
public class ActOrderManageServiceImpl extends EgovAbstractServiceImpl implements ActOrderManageService {

	@Resource(name = "ActOrderManageDAO")
	private ActOrderManageDAO actOrderManageDAO;

	@Override
	public Map<String, Object> selectActOrderDetail(ActOrderManageVO vo) throws Exception {
		return actOrderManageDAO.selectActOrderDetail(vo);
	}

	@Override
	public Map<String, Object> selectActOrderSubDetail(ActOrderManageVO vo) throws Exception {
		return actOrderManageDAO.selectActOrderSubDetail(vo);
	}

	@Override
	public Map<String, Object> selectActOrderCancel(ActOrderManageVO vo) throws Exception {
		return actOrderManageDAO.selectActOrderCancel(vo);
	}

	@Override
	public List<?> selectActOrderList(ActManageDefaultVO searchVO) throws Exception {
		return actOrderManageDAO.selectActOrderList(searchVO);
	}

	@Override
	public List<?> selectActOrderSubList(ActOrderManageVO vo) throws Exception {
		return actOrderManageDAO.selectActOrderSubList(vo);
	}

	@Override
	public int selectActOrderListTotCnt(ActManageDefaultVO searchVO) {
		return actOrderManageDAO.selectActOrderListTotCnt(searchVO);
	}

	@Override
	public String selectActOrderMaxIdx(ActOrderManageVO vo) {
		return actOrderManageDAO.selectActOrderMaxIdx(vo);
	}

	@Override
	public void insertActOrder(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.insertActOrder(vo);
	}

	@Override
	public void updateActOrder(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.updateActOrder(vo);
	}

	@Override
	public void updateActOrderBasic(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.updateActOrderBasic(vo);
	}

	@Override
	public void updateActOrderCancel(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.updateActOrderCancel(vo);
	}

	@Override
	public void deleteActOrder(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.deleteActOrder(vo);
	}

	@Override
	public List<?> selectActOrderCartList(ActOrderManageVO vo) throws Exception {
		return actOrderManageDAO.selectActOrderCartList(vo);
	}

	@Override
	public void deleteActOrderCart(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.deleteActOrderCart(vo);
	}

	@Override
	public void transActOrderStatus(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.transActOrderStatus(vo);
	}

	@Override
	public void transActOrderGigan(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.transActOrderGigan(vo);
	}

	@Override
	public void transActOrderPrice2(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.transActOrderPrice2(vo);
	}

	@Override
	public void transActOrderSinDate(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.transActOrderSinDate(vo);
	}

	@Override
	public void transActOrderClosing(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.transActOrderClosing(vo);
	}

	@Override
	public void deleteActOrderCartExpired(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.deleteActOrderCartExpired(vo);
	}

	@Override
	public void transActOrderJongLect(ActOrderManageVO vo) throws Exception {
		actOrderManageDAO.transActOrderJongLect(vo);
	}

}
