package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActOrderExtManageService {

	Map<String, Object> selectActOrderExtDetail(ActOrderManageVO vo) throws Exception;

	Map<String, Object> selectActOrderExtCancel(ActOrderManageVO vo) throws Exception;

	List<?> selectActOrderExtList(ActManageDefaultVO searchVO) throws Exception;

	List<?> selectActOrderExtDtList(ActOrderManageVO vo) throws Exception;

	void updateActOrderExt(ActOrderManageVO vo) throws Exception;

	void updateActOrderExtCancel(ActOrderManageVO vo) throws Exception;

	void deleteActOrderExt(ActOrderManageVO vo) throws Exception;

	Map<String, Object> selectActMovingExtStatSum(ActOrderManageVO vo) throws Exception;

}
