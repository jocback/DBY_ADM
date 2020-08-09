package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActMembManageService {

	Map<String, Object> selectActMembDetail(ActMembManageVO vo) throws Exception;

	List<?> selectActMembList(ActManageDefaultVO searchVO) throws Exception;
	List<?> selectActMembExcelList(ActManageDefaultVO searchVO) throws Exception;

	int selectActMembListTotCnt(ActManageDefaultVO searchVO);
	int selectActMembExcelListTotCnt(ActManageDefaultVO searchVO);

	void insertActMemb(ActMembManageVO vo) throws Exception;

	void updateActMemb(ActMembManageVO vo) throws Exception;

	void deleteActMemb(ActMembManageVO vo) throws Exception;

	void updateProfSeq(ActMembManageVO vo) throws Exception;

	List<?> selectActEquipList(ActMembManageVO vo) throws Exception;

	void deleteActEquip(ActManageDefaultVO searchVO) throws Exception;

	List<?> selectActMembDelList(ActManageDefaultVO searchVO) throws Exception;
	int selectActMembDelListTotCnt(ActManageDefaultVO searchVO);

	void cancelDelActMemb(ActMembManageVO vo) throws Exception;

	void withdrawActMembInfo(ActMembManageVO vo) throws Exception;

	void delMemoActMembInfo(ActMembManageVO vo) throws Exception;

	Map<String, Object> selectActMemTotCnt(ActManageDefaultVO searchVO) throws Exception;

	Map<String, Object> selectActMemLoginTotCnt(ActManageDefaultVO searchVO) throws Exception;

	Map<String, Object> selectActMemCondTotCnt(ActManageDefaultVO searchVO) throws Exception;

}
