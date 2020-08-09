package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActGroupManageService {

	List<?> popActGroupList(ActManageDefaultVO searchVO) throws Exception;

	/**
	 * GROUP 글을 조회한다.
	 * @param vo
	 * @return 조회한 글
	 * @exception Exception
	 */
	Map<String, Object> selectActGroupDetail(ActGroupManageVO vo) throws Exception;

	/**
	 * GROUP 글 목록을 조회한다.
	 * @param searchVO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectActGroupList(ActManageDefaultVO searchVO) throws Exception;

	/**
	 * GROUP 글 총 갯수를 조회한다.
	 * @param searchVO
	 * @return 글 총 갯수
	 */
	int selectActGroupListTotCnt(ActManageDefaultVO searchVO);

	/**
	 * GROUP글을 등록한다.
	 * @param vo
	 * @exception Exception
	 */
	void insertActGroup(ActGroupManageVO vo) throws Exception;

	/**
	 * GROUP 글을 수정한다.
	 * @param vo
	 * @exception Exception
	 */
	void updateActGroup(ActGroupManageVO vo) throws Exception;

	/**
	 * GROUP 글을 삭제한다.
	 * @param vo
	 * @exception Exception
	 */
	void deleteActGroup(ActGroupManageVO vo) throws Exception;

	String selectActGroupInfoOne(String grField, String idx);

	String selectActGroupInfoOne(String grField, String idx, String grName);

	int selectActAuthInfoOne(String grId, String mnCd);

	//그룹 권한 관리
	List<?> selectActGroupAuthList(ActGroupManageVO vo) throws Exception;

	void insertActGroupAuth(ActGroupManageVO vo) throws Exception;

	boolean deleteActGroupAuth(ActGroupManageVO vo) throws Exception;

}
