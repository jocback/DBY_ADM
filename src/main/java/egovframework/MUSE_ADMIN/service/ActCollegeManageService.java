package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActCollegeManageService {

	List<?> selectActCollegeLectList(ActCollegeManageVO vo) throws Exception;

	Map<String, Object> selectActCollegeDetail(ActCollegeManageVO vo) throws Exception;

	List<?> selectActCollegeList(ActManageDefaultVO searchVO) throws Exception;

	int selectActCollegeListTotCnt(ActManageDefaultVO searchVO);

	String selectActCollegeMaxIdx(ActCollegeManageVO vo);

	void insertActCollege(ActCollegeManageVO vo) throws Exception;

	void updateActCollege(ActCollegeManageVO vo) throws Exception;

	void deleteActCollege(ActCollegeManageVO vo) throws Exception;

    public void updateSeqSwitch(ActCollegeManageVO vo) throws Exception;

	/*금액등록*/
	void insertActCollegePrice(ActCollegeManageVO vo) throws Exception;
	void deleteActCollegePrice(ActCollegeManageVO vo) throws Exception;
	List<?> selectActCollegePrice(ActCollegeManageVO vo) throws Exception;
	/*동영상등록*/
	void insertActCollegeLect(ActCollegeManageVO vo) throws Exception;
	void deleteActCollegeLect(ActCollegeManageVO vo) throws Exception;
	List<?> selectActCollegeLect(ActCollegeManageVO vo) throws Exception;
	/*동영상택일설정*/
	void insertActCollegeOpt(ActCollegeManageVO vo) throws Exception;
	void deleteActCollegeOpt(ActCollegeManageVO vo) throws Exception;
	List<?> selectActCollegeOpt(ActCollegeManageVO vo) throws Exception;

}
