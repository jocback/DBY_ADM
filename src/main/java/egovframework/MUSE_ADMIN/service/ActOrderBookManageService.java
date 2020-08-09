package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActOrderBookManageService {

	Map<String, Object> selectActOrderBookDetail(ActOrderManageVO vo) throws Exception;

	Map<String, Object> selectActOrderBookCancel(ActOrderManageVO vo) throws Exception;

	List<?> selectActOrderBookList(ActManageDefaultVO searchVO) throws Exception;

	List<?> selectActOrderBookSubList(ActOrderManageVO vo) throws Exception;

	void updateActOrderBookBasic(ActOrderManageVO vo) throws Exception;

	void transActOrderBook(ActOrderManageVO vo) throws Exception;

	void updateActOrderBookCancel(ActOrderManageVO vo) throws Exception;

	void deleteActOrderBook(ActOrderManageVO vo) throws Exception;

}
