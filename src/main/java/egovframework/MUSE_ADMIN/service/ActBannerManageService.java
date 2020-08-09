package egovframework.MUSE_ADMIN.service;

import java.util.List;
import java.util.Map;

public interface ActBannerManageService {

	Map<String, Object> selectActBannerDetail(ActBannerManageVO vo) throws Exception;

	List<?> selectActBannerList(ActManageDefaultVO searchVO) throws Exception;

	int selectActBannerListTotCnt(ActManageDefaultVO searchVO);

	List<?> selectActBannerMonthly(ActBannerManageVO vo) throws Exception;

	String selectActBannerInfoOne(String actField, String empNo);

	void insertActBanner(ActBannerManageVO vo) throws Exception;

	void updateActBanner(ActBannerManageVO vo) throws Exception;

	void deleteActBanner(ActBannerManageVO vo) throws Exception;

	void updateActBannerSeq(ActBannerManageVO vo) throws Exception;

}
