package egovframework.MUSE_ADMIN.service;

import java.util.List;

public interface ActStatsManageService {

	List<?> selectActStatsKORList(ActManageDefaultVO searchVO) throws Exception;
	/**
*  글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectActStatsDateList(ActManageDefaultVO searchVO) throws Exception;

	/**
*  글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
	int selectActStatsDateListTotCnt(ActManageDefaultVO searchVO);

	List<?> selectActStatsDeviceList(ActManageDefaultVO searchVO) throws Exception;

	List<?> selectActStatsMenuList(ActManageDefaultVO searchVO) throws Exception;

	List<?> selectActStatsHistoryList(ActManageDefaultVO searchVO) throws Exception;

	int selectActStatsHistoryListTotCnt(ActManageDefaultVO searchVO);


}
