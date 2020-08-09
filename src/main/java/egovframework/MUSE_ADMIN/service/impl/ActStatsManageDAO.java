package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;

import org.springframework.stereotype.Repository;

@Repository("ActStatsManageDAO")
public class ActStatsManageDAO extends EgovComAbstractDAO {

	public List<?> selectActStatsKORList(ActManageDefaultVO searchVO) throws Exception{
		return selectList("ActStatsManage.selectActStatsKORListTotList", searchVO);
	}
	/**
*  글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectActStatsDateList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActStatsManage.selectActStatsDateList", searchVO);
	}

	/**
*  글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
	public int selectActStatsDateListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActStatsManage.selectActStatsDateListTotCnt", searchVO);
	}

	public List<?> selectActStatsDeviceList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActStatsManage.selectActStatsDeviceList", searchVO);
	}

	public List<?> selectActStatsMenuList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActStatsManage.selectActStatsMenuList", searchVO);
	}

	public List<?> selectActStatsHistoryList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActStatsManage.selectActStatsHistoryList", searchVO);
	}

	public int selectActStatsHistoryListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActStatsManage.selectActStatsHistoryListTotCnt", searchVO);
	}

}
