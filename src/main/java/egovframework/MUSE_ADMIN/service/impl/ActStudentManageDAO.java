package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActStudentManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActStudentManageDAO")
public class ActStudentManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActStudentDetail(ActStudentManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActStudentManage.selectActStudentDetail", vo);
	}
	/*목록*/
	public List<?> selectActStudentList(ActStudentManageVO freeVO) throws Exception {
		if((freeVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActStudentManage.selectActStudentListExcel", freeVO);
		}else{
			return selectList("ActStudentManage.selectActStudentList", freeVO);
		}
	}
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActStudentListCnt(ActStudentManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActStudentManage.selectActStudentList", vo);
	}
	public String selectActStudentMaxIdx(ActStudentManageVO vo) {
		return (String) selectOne("ActStudentManage.selectActStudentMaxIdx", vo);
	}
	/*등록*/
	public void insertActStudent(ActStudentManageVO vo) throws Exception {
		insert("ActStudentManage.insertActStudent", vo);
	}
	/*수정*/
	public void updateActStudent(ActStudentManageVO vo) throws Exception {
		update("ActStudentManage.updateActStudent", vo);
	}
	/*삭제*/
	public void deleteActStudent(ActStudentManageVO vo) throws Exception {
		delete("ActStudentManage.deleteActStudent", vo);
	}

}
