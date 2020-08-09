package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActFreeLectManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActFreeLectManageDAO")
public class ActFreeLectManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActFreeLectDetail(ActFreeLectManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActFreeLectManage.selectActFreeLectDetail", vo);
	}
	/*목록*/
	public List<?> selectActFreeLectList(ActFreeLectManageVO freeVO) throws Exception {
		if((freeVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActFreeLectManage.selectActFreeLectListExcel", freeVO);
		}else{
			return selectList("ActFreeLectManage.selectActFreeLectList", freeVO);
		}
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActFreeLectListCnt(ActFreeLectManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActFreeLectManage.selectActFreeLectList", vo);
	}
	public String selectActFreeLectMaxIdx(ActFreeLectManageVO vo) {
		return (String) selectOne("ActFreeLectManage.selectActFreeLectMaxIdx", vo);
	}
	/*등록*/
	public void insertActFreeLect(ActFreeLectManageVO vo) throws Exception {
		insert("ActFreeLectManage.insertActFreeLect", vo);
	}
	/*수정*/
	public void updateActFreeLect(ActFreeLectManageVO vo) throws Exception {
		update("ActFreeLectManage.updateActFreeLect", vo);
	}
	/*삭제*/
	public void deleteActFreeLect(ActFreeLectManageVO vo) throws Exception {
		delete("ActFreeLectManage.deleteActFreeLect", vo);
	}

	public void deleteActFreeLectSub(ActFreeLectManageVO vo) throws Exception {
		if("LEC".equals(vo.getFsGb())){
			delete("ActFreeLectManage.deleteActFreeLectSubLec", vo);
		}else{
			delete("ActFreeLectManage.deleteActFreeLectSubUsr", vo);
		}
	}

	public void insertActFreeLectSub(ActFreeLectManageVO vo) throws Exception {
		if("LEC".equals(vo.getFsGb())){
			insert("ActFreeLectManage.insertActFreeLectSubLec", vo);
		}else{
			insert("ActFreeLectManage.insertActFreeLectSubUsr", vo);
		}
	}
	public List<?> selectActFreeLectSub(ActFreeLectManageVO vo) throws Exception {
		return selectList("ActFreeLectManage.selectActFreeLectSub", vo);
	}

}
