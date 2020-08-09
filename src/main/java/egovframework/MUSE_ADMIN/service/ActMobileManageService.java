package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActMobileManageService {

	List<?> selectActMobileList(ActMobileManageVO freeVO) throws Exception;

	Map<String,Object> selectActMobileListCnt(ActMobileManageVO freeVO) throws Exception;

	Map<String,Object> selectActMobileTotCnt(ActMobileManageVO freeVO) throws Exception;

	void insertActMobileConf(ActMobileManageVO vo) throws Exception;

	void deleteMobileConf(ActMobileManageVO vo) throws Exception;

	void deleteMobileDevice(ActMobileManageVO vo) throws Exception;

}
