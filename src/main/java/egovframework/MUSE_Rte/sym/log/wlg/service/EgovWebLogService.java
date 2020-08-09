package egovframework.MUSE_Rte.sym.log.wlg.service;

/**
 * @Class Name : EgovWebLogService.java
 * @Description : 웹로그 관리를 위한 서비스 인터페이스
 * @Modification Information
 */

public interface EgovWebLogService {

	/**
	 * 웹 로그를 기록한다.
	 *
	 * @param WebLog
	 */
	public void logInsertWebLog(WebLog webLog) throws Exception;

}
