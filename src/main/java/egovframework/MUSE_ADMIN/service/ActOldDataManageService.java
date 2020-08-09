package egovframework.MUSE_ADMIN.service;

import java.util.List;

import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;
import egovframework.MUSE_ADMIN.service.ActMembManageVO;

public interface ActOldDataManageService {

	List<BoardManageVO> selectActOldDataList(BoardManageVO boardVO) throws Exception;

	void insertActBookOld() throws Exception;

	void insertActLectureOld() throws Exception;

	void insertActMembOld() throws Exception;

	List<ActMembManageVO> selectActOldProfList(ActMembManageVO membVO) throws Exception;

	void insertActProfOld(ActMembManageVO vo) throws Exception;

	void updateActOldDataCn(BoardManageVO boardVO) throws Exception;

	void insertActDownCntOld() throws Exception;

	List<ActMembManageVO> selectOldMemberPass() throws Exception;

	void oldMemberPassTran(ActMembManageVO membVO) throws Exception;

}
