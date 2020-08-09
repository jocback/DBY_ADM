package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActOrgManageService {

	Map<String, Object> selectActOrgDetail(ActOrgManageVO vo) throws Exception;

	List<?> selectActOrgList(ActManageDefaultVO searchVO) throws Exception;

	int selectActOrgListTotCnt(ActManageDefaultVO searchVO);

	String selectActOrgInfoOne(String actField, String empNo);

	void insertActOrg(ActOrgManageVO vo) throws Exception;

	void updateActOrg(ActOrgManageVO vo) throws Exception;

	void updateActOrgSeq(ActOrgManageVO vo) throws Exception;

	void deleteActOrg(ActOrgManageVO vo) throws Exception;

}
