package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActOrgManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActOrgManageDAO")
public class ActOrgManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActOrgDetail(ActOrgManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActOrgManage.selectActOrgDetail", vo);
	}
	/*목록*/
	public List<?> selectActOrgList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActOrgManage.selectActOrgListExcel", searchVO);
		}else{
			return selectList("ActOrgManage.selectActOrgList", searchVO);
		}
	}
	/*총 갯수*/
	public int selectActOrgListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActOrgManage.selectActOrgListTotCnt", searchVO);
	}
	/*회원 정보 한가지 추출*/
	public String selectActOrgInfoOne(ActManageDefaultVO searchVO) {
		return (String) selectOne("ActOrgManage.selectActOrgInfoOne", searchVO);
	}
	/*등록*/
	public void insertActOrg(ActOrgManageVO vo) throws Exception {
		insert("ActOrgManage.insertActOrg", vo);
	}
	/*수정*/
	public void updateActOrg(ActOrgManageVO vo) throws Exception {
		update("ActOrgManage.updateActOrg", vo);
	}
	public void updateActOrgSeq(ActOrgManageVO vo) throws Exception {
		update("ActOrgManage.updateActOrgSeq", vo);
	}
	/*삭제*/
	public void deleteActOrg(ActOrgManageVO vo) throws Exception {
		delete("ActOrgManage.deleteActOrg", vo);
	}

}
