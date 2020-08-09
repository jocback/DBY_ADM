package egovframework.MUSE_Rte.sym.log.wlg.service.impl;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.MUSE_Rte.sym.log.wlg.service.WebLog;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : WebLogDAO.java
 * @Description : 웹로그 관리를 위한 데이터 접근 클래스
 * @Modification Information
 */
@Repository("webLogDAO")
public class WebLogDAO extends EgovComAbstractDAO {

	/**
	 * 웹 로그를 기록한다.
	 *
	 * @param WebLog
	 * @return
	 * @throws Exception
	 */
	public void logInsertWebLog(WebLog webLog) throws Exception{
		insert("WebLog.logInsertWebLog", webLog);
	}

}
