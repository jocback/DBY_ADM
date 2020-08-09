package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

import egovframework.MUSE_Rte.cop.bbs.service.BoardManageVO;

public interface ActStatManageService {

	List<?> selectActStatMoving(ActOrderManageVO orderVO) throws Exception;

	Map<String,String> selectActStatSum(ActOrderManageVO orderVO) throws Exception;
	
	int selectActStatTotalCnt(ActOrderManageVO orderVO) throws Exception;

	List<?> selectActStatBook(ActOrderManageVO orderVO) throws Exception;

	Map<String,String> selectActStatBookSum(ActOrderManageVO orderVO) throws Exception;
	
	int selectActStatBookTotalCnt(ActOrderManageVO orderVO) throws Exception;

	List<?> selectActStatProf(ActOrderManageVO orderVO) throws Exception;

	List<?> selectActStatQna(ActOrderManageVO orderVO) throws Exception;

	List<?> selectActStatPds(BoardManageVO bbsVO) throws Exception;

	List<?> selectActStatBbsDw(BoardManageVO bbsVO) throws Exception;

	Map<String,String> selectActStatPdsSum(BoardManageVO bbsVO) throws Exception;
	
	List<?> selectActStatMain(ActOrderManageVO orderVO) throws Exception;

	List<?> selectActStatMain1(ActOrderManageVO orderVO) throws Exception;

	void insertCommonLog(ActManageDefaultVO orderVO) throws Exception;

	List<?> selectActCommonLog(ActOrderManageVO orderVO) throws Exception;

}
