package egovframework.MUSE_ADMIN.service;

import java.util.Map;

public interface ActOrderNoticeManageService {

	Map<String, Object> selectActOrderNoticeDetail(ActOrderNoticeManageVO vo) throws Exception;

	void updateActOrderNotice(ActOrderNoticeManageVO vo) throws Exception;

}
