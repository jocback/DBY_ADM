package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOrderExtManageDAO")
public class ActOrderExtManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderExtDetail(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderExtManage.selectActOrderExtDetail", vo);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrderExtCancel(ActOrderManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrderExtManage.selectActOrderExtCancel", vo);
	}
	/*목록*/
	public List<?> selectActOrderExtList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActOrderExtManage.selectActOrderExtListExcel", searchVO);
		}else if("type".equals(searchVO.getActListMode())){
			return selectList("ActOrderExtManage.selectActOrderExtType", searchVO);
		}else{
			return selectList("ActOrderExtManage.selectActOrderExtList", searchVO);
		}
	}
	public List<?> selectActOrderExtDtList(ActOrderManageVO vo) throws Exception {
		return selectList("ActOrderExtManage.selectActOrderExtDtList", vo);
	}
	/*수정*/
	public void updateActOrderExt(ActOrderManageVO vo) throws Exception {
		update("ActOrderExtManage.updateActOrderExt", vo);
	}
	public void updateActOrderExtCancel(ActOrderManageVO vo) throws Exception {
		update("ActOrderExtManage.updateActOrderExtCancel", vo);
	}
	/*삭제*/
	public void deleteActOrderExt(ActOrderManageVO vo) throws Exception {
		delete("ActOrderExtManage.deleteActOrderExt", vo);
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActMovingExtStatSum(ActOrderManageVO vo) throws Exception {
		if("TOTAL".equals(vo.getActListMode())){
			return (Map<String, Object>) selectOne("ActOrderExtManage.selectActOrderExtTotCnt", vo);
		}else{
			return (Map<String, Object>) selectOne("ActOrderExtManage.selectActOrderExtList", vo);
		}
	}

}
