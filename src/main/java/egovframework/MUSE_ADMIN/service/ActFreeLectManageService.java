package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActFreeLectManageService {

	Map<String, Object> selectActFreeLectDetail(ActFreeLectManageVO vo) throws Exception;

	List<?> selectActFreeLectList(ActFreeLectManageVO freeVO) throws Exception;

	Map<String, Object> selectActFreeLectListCnt(ActFreeLectManageVO vo) throws Exception;

	String selectActFreeLectMaxIdx(ActFreeLectManageVO vo);

	void insertActFreeLect(ActFreeLectManageVO vo) throws Exception;

	void updateActFreeLect(ActFreeLectManageVO vo) throws Exception;

	void deleteActFreeLect(ActFreeLectManageVO vo) throws Exception;

	void deleteActFreeLectSub(ActFreeLectManageVO vo) throws Exception;

	void insertActFreeLectSub(ActFreeLectManageVO vo) throws Exception;
	List<?> selectActFreeLectSub(ActFreeLectManageVO vo) throws Exception;

}
