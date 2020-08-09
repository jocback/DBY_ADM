package egovframework.MUSE_ADMIN.service.impl;

import java.util.List;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActTeamsManageVO;

import org.springframework.stereotype.Repository;

@Repository("ActTeamsManageDAO")
public class ActTeamsManageDAO extends EgovComAbstractDAO {

	/*상세*/
	ActTeamsManageVO selectActTeamsDetail(ActTeamsManageVO vo) throws Exception {
		return (ActTeamsManageVO) selectOne("ActTeamsManage.selectActTeamsDetail", vo);
	}
	/*목록*/
	public List<?> selectActTeamsList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActTeamsManage.selectActTeamsList", searchVO);
	}
	/*총 갯수*/
	public int selectActTeamsCnt(ActManageDefaultVO searchVO) {
		return (Integer) selectOne("ActTeamsManage.selectActTeamsCnt", searchVO);
	}
	/*등록*/
	public void insertActTeams(ActTeamsManageVO vo) throws Exception {
		vo.setaSeq((String) selectOne("ActTeamsManage.selectActTeamsSeq", vo));
		insert("ActTeamsManage.insertActTeams", vo);
	}
	/*수정*/
	public void updateActTeams(ActTeamsManageVO vo) throws Exception {
		update("ActTeamsManage.updateActTeams", vo);
	}
	/*삭제*/
	public void deleteActTeams(ActTeamsManageVO vo) throws Exception {
		delete("ActTeamsManage.deleteActTeams", vo);
	}

	/*목록*/
	public List<?> selectActTeamEmpList(ActManageDefaultVO searchVO) throws Exception {
		return selectList("ActTeamsManage.selectActTeamEmpList", searchVO);
	}
}
