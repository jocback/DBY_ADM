package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_ADMIN.service.ActBannerManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActBannerManageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActBannerManageService")
public class ActBannerManageServiceImpl extends EgovAbstractServiceImpl implements ActBannerManageService {

	@Resource(name = "ActBannerManageDAO")
	private ActBannerManageDAO actBannerManageDAO;

	@Override
	public Map<String, Object> selectActBannerDetail(ActBannerManageVO vo) throws Exception {
		return actBannerManageDAO.selectActBannerDetail(vo);
	}

	@Override
	public List<?> selectActBannerList(ActManageDefaultVO searchVO) throws Exception {
		return actBannerManageDAO.selectActBannerList(searchVO);
	}

	@Override
	public int selectActBannerListTotCnt(ActManageDefaultVO searchVO) {
		return actBannerManageDAO.selectActBannerListTotCnt(searchVO);
	}

	@Override
	public List<?> selectActBannerMonthly(ActBannerManageVO vo) throws Exception {
		return actBannerManageDAO.selectActBannerMonthly(vo);
	}

	@Override
	public String selectActBannerInfoOne(String actField, String empId) {
		ActBannerManageVO vo = new ActBannerManageVO();
		return actBannerManageDAO.selectActBannerInfoOne(vo);
	}

	@Override
	public void insertActBanner(ActBannerManageVO vo) throws Exception {
		actBannerManageDAO.insertActBanner(vo);
	}

	@Override
	public void updateActBanner(ActBannerManageVO vo) throws Exception {
		actBannerManageDAO.updateActBanner(vo);
	}

	@Override
	public void deleteActBanner(ActBannerManageVO vo) throws Exception {
		actBannerManageDAO.deleteActBanner(vo);
	}

	@Override
	public void updateActBannerSeq(ActBannerManageVO vo) throws Exception {
		actBannerManageDAO.updateActBannerSeq(vo);
	}

}
