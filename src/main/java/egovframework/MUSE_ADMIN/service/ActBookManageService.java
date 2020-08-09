package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActBookManageService {

	Map<String, Object> selectActBookDetail(ActBookManageVO vo) throws Exception;

	List<?> selectActBookList(ActManageDefaultVO searchVO) throws Exception;

	int selectActBookListTotCnt(ActManageDefaultVO searchVO);

	String selectActBookMaxIdx(ActBookManageVO vo);

	void insertActBook(ActBookManageVO vo) throws Exception;

	void updateActBook(ActBookManageVO vo) throws Exception;

	void deleteActBook(ActBookManageVO vo) throws Exception;

	void insertActBookCategory(ActBookManageVO vo) throws Exception;

	void deleteActBookCategory(ActBookManageVO vo) throws Exception;

	List<?> selectActBookCategory(ActBookManageVO vo) throws Exception;

}
