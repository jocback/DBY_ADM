package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActMovingManageService {

	Map<String, Object> selectActMovingDetail(ActMovingManageVO vo) throws Exception;

	List<?> selectActMovingList(ActManageDefaultVO searchVO) throws Exception;

	int selectActMovingListTotCnt(ActManageDefaultVO searchVO);

	String selectActMovingMaxIdx(ActMovingManageVO vo);

	void insertActMoving(ActMovingManageVO vo) throws Exception;

	void updateActMoving(ActMovingManageVO vo) throws Exception;

	void deleteActMoving(ActMovingManageVO vo) throws Exception;

	/*교재등록*/
	void insertActLectureBook(ActMovingManageVO vo) throws Exception;
	void deleteActLectureBook(ActMovingManageVO vo) throws Exception;
	List<?> selectActLectureBook(ActMovingManageVO vo) throws Exception;
	/*동영상등록*/
	void insertActLectureClip(ActMovingManageVO vo) throws Exception;
	void deleteActLectureClip(ActMovingManageVO vo) throws Exception;
	List<?> selectActLectureClip(ActMovingManageVO vo) throws Exception;

}
