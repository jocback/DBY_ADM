package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOrderManageDAO")
public class ActOrderManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderDetail(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderManage.selectActOrderDetail", vo);
	}
	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderSubDetail(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderManage.selectActOrderSubDetail", vo);
	}
	/*취소정보 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderCancel(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderManage.selectActOrderCancel", vo);
	}
	/*목록*/
	public List<?> selectActOrderList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActOrderManage.selectActOrderListExcel", searchVO);
		}else if("type".equals(searchVO.getActListMode())){
			return selectList("ActOrderManage.selectActOrderType", searchVO);
		}else{
			if((searchVO.getSearchOp1()).equals("동영상")){
			return selectList("ActOrderManage.selectActOrderList", searchVO);
			}else{
			return selectList("ActOrderManage.selectActOrderBookList", searchVO);
			}
		}
	}
	/*총 갯수*/
	public int selectActOrderListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActOrderManage.selectActOrderListTotCnt", searchVO);
	}
	public List<?> selectActOrderSubList(ActOrderManageVO vo) throws Exception {
		return selectList("ActOrderManage.selectActOrderSubList", vo);
	}
	public String selectActOrderMaxIdx(ActOrderManageVO vo) {
		return (String) selectOne("ActOrderManage.selectActOrderMaxIdx", vo);
	}
	/*등록*/
	public void insertActOrder(ActOrderManageVO vo) throws Exception {
		insert("ActOrderManage.insertActOrder", vo);
	}
	/*수정*/
	public void updateActOrder(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.updateActOrder", vo);
	}
	public void updateActOrderBasic(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.updateActOrderBasic", vo);
	}
	public void updateActOrderCancel(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.updateActOrderCancel", vo);
	}
	/*삭제*/
	public void deleteActOrder(ActOrderManageVO vo) throws Exception {
		delete("ActOrderManage.deleteActOrder", vo);
	}
	/*장바구니 리스트*/
	public List<?> selectActOrderCartList(ActOrderManageVO vo) throws Exception {
		return selectList("ActOrderManage.selectActOrderCartList", vo);
	}
	public void deleteActOrderCart(ActOrderManageVO vo) throws Exception {
		delete("ActOrderManage.deleteActOrderCart", vo);
	}
	public void transActOrderStatus(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.transActOrderStatus", vo);
	}
	public void transActOrderGigan(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.transActOrderGigan", vo);
	}
	public void transActOrderPrice2(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.transActOrderPrice2", vo);
	}
	public void transActOrderSinDate(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.transActOrderSinDate", vo);
	}
	public void transActOrderClosing(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.transActOrderClosing", vo);
	}
	public void deleteActOrderCartExpired(ActOrderManageVO vo) throws Exception {
		delete("ActOrderManage.deleteActOrderCartExpired", vo);
	}
	public void transActOrderJongLect(ActOrderManageVO vo) throws Exception {
		update("ActOrderManage.transActOrderJongLect", vo);
	}
}
