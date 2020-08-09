package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActStudentManageService {

	Map<String, Object> selectActStudentDetail(ActStudentManageVO vo) throws Exception;

	List<?> selectActStudentList(ActStudentManageVO freeVO) throws Exception;

	Map<String, Object> selectActStudentListCnt(ActStudentManageVO vo) throws Exception;

	String selectActStudentMaxIdx(ActStudentManageVO vo);

	void insertActStudent(ActStudentManageVO vo) throws Exception;

	void updateActStudent(ActStudentManageVO vo) throws Exception;

	void deleteActStudent(ActStudentManageVO vo) throws Exception;

}
