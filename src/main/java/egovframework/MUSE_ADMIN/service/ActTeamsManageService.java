package egovframework.MUSE_ADMIN.service;

import java.util.List;

public interface ActTeamsManageService {

	ActTeamsManageVO selectActTeamsDetail(ActTeamsManageVO vo) throws Exception;

	List<?> selectActTeamsList(ActManageDefaultVO searchVO) throws Exception;

	int selectActTeamsCnt(ActManageDefaultVO searchVO);

	void insertActTeams(ActTeamsManageVO vo) throws Exception;

	void updateActTeams(ActTeamsManageVO vo) throws Exception;

	void deleteActTeams(ActTeamsManageVO vo) throws Exception;

	List<?> selectActTeamEmpList(ActManageDefaultVO searchVO) throws Exception;

}
