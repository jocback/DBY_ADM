package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActEmpManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActEmpManageDAO")
public class ActEmpManageDAO extends EgovComAbstractDAO {

	/*상세*/
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectActEmpDetail(ActEmpManageVO vo) throws Exception {
		return (Map<String, Object>) selectOne("ActEmpManage.selectActEmpDetail", vo);
	}
	/*목록*/
	public List<?> selectActEmpList(ActManageDefaultVO searchVO) throws Exception {
		if((searchVO.getActListExcel()).equals("EXCEL")){
			return selectList("ActEmpManage.selectActEmpListExcel", searchVO);
		}else{
			return selectList("ActEmpManage.selectActEmpList", searchVO);
		}
	}
	/*총 갯수*/
	public int selectActEmpListTotCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActEmpManage.selectActEmpListTotCnt", searchVO);
	}
	/*회원 정보 한가지 추출*/
	public String selectActEmpInfoOne(ActManageDefaultVO searchVO) {
		return (String) selectOne("ActEmpManage.selectActEmpInfoOne", searchVO);
	}
	/*등록*/
	public void insertActEmp(ActEmpManageVO vo) throws Exception {
		if((Integer) selectOne("ActEmpManage.selectEmpAuthCnt", vo)<1){
			insert("ActEmpManage.insertEmpAuth", vo);
		}
		insert("ActEmpManage.insertActEmp", vo);
	}
	/*수정*/
	public void updateActEmp(ActEmpManageVO vo) throws Exception {
		if(vo.getOtpRegcd() != null && (vo.getOtpRegcd()).length() != 0){
			update("ActEmpManage.updateActEmpOtpRegcd", vo);
		}else{
			update("ActEmpManage.updateActEmp", vo);
		}
	}
	/*삭제*/
	public void deleteActEmp(ActEmpManageVO vo) throws Exception {
		delete("ActEmpManage.deleteActEmp", vo);
	}

	public List<?> selectActGroupList(ActEmpManageVO vo) throws Exception {
		return selectList("ActEmpManage.selectActGroupList", vo);
	}

    public List<?> searchInfoEmp(ActManageDefaultVO searchVO){
        return selectList("ActEmpManage.searchInfoEmp", searchVO);
    }

}
