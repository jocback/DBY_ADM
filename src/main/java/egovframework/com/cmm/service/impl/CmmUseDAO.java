package egovframework.com.cmm.service.impl;

import java.util.List;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.CmmnDetailCode;

import org.springframework.stereotype.Repository;

/**
 * @Class Name : CmmUse.java
 * @Description : 공통코드등 전체 업무에서 공용해서 사용해야 하는 서비스를 정의하기위한 데이터 접근 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Repository("cmmUseDAO")
public class CmmUseDAO extends EgovComAbstractDAO {

    /**
     * 주어진 조건에 따른 공통코드를 불러온다.
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public List<CmmnDetailCode> selectCmmCodeDetail(ComDefaultCodeVO vo) throws Exception {
	return selectList("CmmUse.selectCmmCodeDetail", vo);
    }

	public String commonCodeEtc1(ComDefaultCodeVO vo) {
		String listDao = "CmmUse.commonCodeEtc1"; 
		return (String) selectOne(listDao, vo);
	}

	public void updateCommonCodeEtc1(CmmnDetailCode vo) throws Exception {
		update("CmmUse.updateCommonCodeEtc1", vo);
	}

    public String selectFieldDataOne(ComDefaultCodeVO vo) throws Exception {
		return (String)selectOne("CmmUse.selectFieldDataOne", vo);
    }
}
