package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActEmpManageService {

	Map<String, Object> selectActEmpDetail(ActEmpManageVO vo) throws Exception;

	List<?> selectActEmpList(ActManageDefaultVO searchVO) throws Exception;

	int selectActEmpListTotCnt(ActManageDefaultVO searchVO);

	String selectActEmpInfoOne(String actField, String empNo);

	void insertActEmp(ActEmpManageVO vo) throws Exception;

	void updateActEmp(ActEmpManageVO vo) throws Exception;

	void deleteActEmp(ActEmpManageVO vo) throws Exception;

	List<?> selectActGroupList(ActEmpManageVO vo) throws Exception;

	List<?> searchInfoEmp(ActManageDefaultVO searchVO) throws Exception;

}
