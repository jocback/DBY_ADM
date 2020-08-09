package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActOrderManageService {

	Map<String, Object> selectActOrderDetail(ActOrderManageVO vo) throws Exception;

	Map<String, Object> selectActOrderSubDetail(ActOrderManageVO vo) throws Exception;

	Map<String, Object> selectActOrderCancel(ActOrderManageVO vo) throws Exception;

	List<?> selectActOrderList(ActManageDefaultVO searchVO) throws Exception;

	List<?> selectActOrderSubList(ActOrderManageVO vo) throws Exception;

	int selectActOrderListTotCnt(ActManageDefaultVO searchVO);

	String selectActOrderMaxIdx(ActOrderManageVO vo);

	void insertActOrder(ActOrderManageVO vo) throws Exception;

	void updateActOrder(ActOrderManageVO vo) throws Exception;

	void updateActOrderBasic(ActOrderManageVO vo) throws Exception;

	void updateActOrderCancel(ActOrderManageVO vo) throws Exception;

	void deleteActOrder(ActOrderManageVO vo) throws Exception;

	List<?> selectActOrderCartList(ActOrderManageVO vo) throws Exception;

	void deleteActOrderCart(ActOrderManageVO vo) throws Exception;

	void transActOrderStatus(ActOrderManageVO vo) throws Exception;

	void transActOrderGigan(ActOrderManageVO vo) throws Exception;

	void transActOrderPrice2(ActOrderManageVO vo) throws Exception;

	void transActOrderSinDate(ActOrderManageVO vo) throws Exception;

	void transActOrderClosing(ActOrderManageVO vo) throws Exception;

	void deleteActOrderCartExpired(ActOrderManageVO vo) throws Exception;

	void transActOrderJongLect(ActOrderManageVO vo) throws Exception;

}
