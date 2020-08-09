package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActOrderEstiManageService {

	Map<String, Object> selectActOrderEstiDetail(ActOrderManageVO vo) throws Exception;

	List<?> selectActOrderEstiList(ActOrderManageVO orderVO) throws Exception;

	Map<String, Object> selectActOrderEstiListCnt(ActOrderManageVO vo) throws Exception;

	String selectActOrderEstiMaxIdx(ActOrderManageVO vo);

	void insertActOrderEsti(ActOrderManageVO vo) throws Exception;

	void deleteActOrderEsti(ActOrderManageVO vo) throws Exception;

}
