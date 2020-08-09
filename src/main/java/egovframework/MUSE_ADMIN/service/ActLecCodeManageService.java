package egovframework.MUSE_ADMIN.service;

import java.util.List;

/**
 *
 * 공통코드에 관한 서비스 인터페이스 클래스를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
public interface ActLecCodeManageService {

	List<?> selectLecCodeManageList(ActLecCodeManageVO lecCodeManageVO) throws Exception;

	ActLecCodeManageVO selectLecCodeManageDetail(ActLecCodeManageVO lecCodeManageVO) throws Exception;

	void insertLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception;

	void updateLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception;

	void deleteLecCodeManage(ActLecCodeManageVO lecCodeManageVO) throws Exception;

	void updateActLecCodeSeq(ActLecCodeManageVO lecCodeManageVO) throws Exception;

}
