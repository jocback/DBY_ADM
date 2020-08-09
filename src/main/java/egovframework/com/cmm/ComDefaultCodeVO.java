package egovframework.com.cmm;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 *  클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2009.3.11   이삼섭          최초 생성
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class ComDefaultCodeVO implements Serializable {
    /** 코드 ID */
    private String codeId = "";
    
    /** 상세코드 */
    private String code = "";
    
    /** 코드명 */
    private String codeNm = "";
    
    /** 코드설명 */
    private String codeDc = "";
    
    /** 특정테이블명 */
    private String tableNm = "";	//특정테이블에서 코드정보를추출시 사용
    
    /** 상세 조건 여부 */
    private String haveDetailCondition = "N";
    
    /** 상세 조건 */
    private String detailCondition = "";
    
    /** 기타 항목1 */
    private String codeEtc1 = "";
    
    /** 순서 */
    private String seq = "";
    
    /** 기타 항목2 */
    private String codeEtc2 = "";
    
    /** 해당 코드목록 중 LIKE 매칭  */
    private String codeLike = "";
    
    /** 권한 메뉴 코드 호출 시  */
    private String codeAuth = "";
    
    /** 서브메뉴 호출 시  */
    private String subMenuPath = "";
    
    /** 서브메뉴 호출 시  */
    private String menuCode = "";
    
    /**
     * codeId attribute를 리턴한다.
     * 
     * @return the codeId
     */
    public String getCodeId() {
	return codeId;
    }

    /**
     * codeId attribute 값을 설정한다.
     * 
     * @param codeId
     *            the codeId to set
     */
    public void setCodeId(String codeId) {
	this.codeId = codeId;
    }

    /**
     * code attribute를 리턴한다.
     * 
     * @return the code
     */
    public String getCode() {
	return code;
    }

    /**
     * code attribute 값을 설정한다.
     * 
     * @param code
     *            the code to set
     */
    public void setCode(String code) {
	this.code = code;
    }

    /**
     * codeNm attribute를 리턴한다.
     * 
     * @return the codeNm
     */
    public String getCodeNm() {
	return codeNm;
    }

    /**
     * codeNm attribute 값을 설정한다.
     * 
     * @param codeNm
     *            the codeNm to set
     */
    public void setCodeNm(String codeNm) {
	this.codeNm = codeNm;
    }

    /**
     * codeDc attribute를 리턴한다.
     * 
     * @return the codeDc
     */
    public String getCodeDc() {
	return codeDc;
    }

    /**
     * codeDc attribute 값을 설정한다.
     * 
     * @param codeDc
     *            the codeDc to set
     */
    public void setCodeDc(String codeDc) {
	this.codeDc = codeDc;
    }

    /**
     * tableNm attribute를 리턴한다.
     * 
     * @return the tableNm
     */
    public String getTableNm() {
	return tableNm;
    }

    /**
     * tableNm attribute 값을 설정한다.
     * 
     * @param tableNm
     *            the tableNm to set
     */
    public void setTableNm(String tableNm) {
	this.tableNm = tableNm;
    }

    /**
     * haveDetailCondition attribute를 리턴한다.
     * 
     * @return the haveDetailCondition
     */
    public String getHaveDetailCondition() {
	return haveDetailCondition;
    }

    /**
     * haveDetailCondition attribute 값을 설정한다.
     * 
     * @param haveDetailCondition
     *            the haveDetailCondition to set
     */
    public void setHaveDetailCondition(String haveDetailCondition) {
	this.haveDetailCondition = haveDetailCondition;
    }

    /**
     * detailCondition attribute를 리턴한다.
     * 
     * @return the detailCondition
     */
    public String getDetailCondition() {
	return detailCondition;
    }

    /**
     * detailCondition attribute 값을 설정한다.
     * 
     * @param detailCondition
     *            the detailCondition to set
     */
    public void setDetailCondition(String detailCondition) {
	this.detailCondition = detailCondition;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

	public String getCodeEtc1() {
		return codeEtc1;
	}

	public void setCodeEtc1(String codeEtc1) {
		this.codeEtc1 = codeEtc1;
	}

	public String getCodeEtc2() {
		return codeEtc2;
	}

	public void setCodeEtc2(String codeEtc2) {
		this.codeEtc2 = codeEtc2;
	}

	public String getCodeLike() {
		return codeLike;
	}

	public void setCodeLike(String codeLike) {
		this.codeLike = codeLike;
	}

	public String getCodeAuth() {
		return codeAuth;
	}

	public void setCodeAuth(String codeAuth) {
		this.codeAuth = codeAuth;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getSubMenuPath() {
		return subMenuPath;
	}

	public void setSubMenuPath(String subMenuPath) {
		this.subMenuPath = subMenuPath;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
}
