package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.MUSE_ADMIN.service.ActStatsManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("ActStatsManageService")
public class ActStatsManageServiceImpl extends EgovAbstractServiceImpl implements ActStatsManageService {

	@Resource(name = "ActStatsManageDAO")
	private ActStatsManageDAO actStatsManageDAO;

	@Override
	public List<?> selectActStatsKORList(ActManageDefaultVO searchVO) throws Exception {
		return actStatsManageDAO.selectActStatsKORList(searchVO);
	}
	
	/**
*  글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectActStatsDateList(ActManageDefaultVO searchVO) throws Exception {
		return actStatsManageDAO.selectActStatsDateList(searchVO);
	}

	/**
*  글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 * @exception
	 */
	@Override
	public int selectActStatsDateListTotCnt(ActManageDefaultVO searchVO) {
		return actStatsManageDAO.selectActStatsDateListTotCnt(searchVO);
	}

	@Override
	public List<?> selectActStatsDeviceList(ActManageDefaultVO searchVO) throws Exception {
		return actStatsManageDAO.selectActStatsDeviceList(searchVO);
	}

	@Override
	public List<?> selectActStatsMenuList(ActManageDefaultVO searchVO) throws Exception {
		return actStatsManageDAO.selectActStatsMenuList(searchVO);
	}

	@Override
	public List<?> selectActStatsHistoryList(ActManageDefaultVO searchVO) throws Exception {
		return actStatsManageDAO.selectActStatsHistoryList(searchVO);
	}

	@Override
	public int selectActStatsHistoryListTotCnt(ActManageDefaultVO searchVO) {
		return actStatsManageDAO.selectActStatsHistoryListTotCnt(searchVO);
	}

}
