package egovframework.MUSE_Rte.cop.bbs.service;

import org.apache.commons.lang3.builder.ToStringBuilder;

import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;

/**
 * 댓글관리 서비스를 위한 VO 클래스
 */
@SuppressWarnings("serial")
public class BoardCmtVO extends ActManageDefaultVO {
     /** 댓글번호 */
    private String commentNo = "";
    
    /** 게시판 ID */
    private String bbsId = "";
    
    /** 게시물 번호 */
    private long nttId = 0L;
    
    /** 작성자 ID */
    private String wrterId = "";
    
    /** 작성자명 */
    private String wrterNm = "";
    
    /** 패스워드 */
    private String commentPassword = "";
    
    /** 댓글 내용 */
    private String commentCn = "";
    
    /** 사용 여부 */
    private String useAt = "";

    /** 최초등록자 아이디 */
    private String frstRegisterId = "";
    
    /** 최초 등록자명 */
    private String frstRegisterNm = "";
    
    /** 최초등록시점 */
    private String frstRegisterPnttm = "";
    
    /** 최종수정자 아이디 */
    private String lastUpdusrId = "";
    
    /** 최종수정시점 */
    private String lastUpdusrPnttm = "";
    
    /** 확인 패스워드 */
    private String confirmPassword = "";

    private long sortOrdr = 0L;

    /** 현재페이지 */
    private int subPageIndex = 1;

    /** 페이지갯수 */
    private int subPageUnit = 10;

    /** 페이지사이즈 */
    private int subPageSize = 10;

    /** 첫페이지 인덱스 */
    private int subFirstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int subLastIndex = 1;

    /** 페이지당 레코드 개수 */
    private int subRecordCountPerPage = 10;

    /** 레코드 번호 */
    private int subRowNo = 0;
    
    /** 호출 TYPE (head or body)*/
    private String type = "";
    
    /** 수정 처리 여부 */
    private boolean isModified = false;

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

	public String getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}

	public String getBbsId() {
		return bbsId;
	}

	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	public long getNttId() {
		return nttId;
	}

	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	public String getWrterId() {
		return wrterId;
	}

	public void setWrterId(String wrterId) {
		this.wrterId = wrterId;
	}

	public String getWrterNm() {
		return wrterNm;
	}

	public void setWrterNm(String wrterNm) {
		this.wrterNm = wrterNm;
	}

	public String getCommentPassword() {
		return commentPassword;
	}

	public void setCommentPassword(String commentPassword) {
		this.commentPassword = commentPassword;
	}

	public String getCommentCn() {
		return commentCn;
	}

	public void setCommentCn(String commentCn) {
		this.commentCn = commentCn;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	public String getFrstRegisterNm() {
		return frstRegisterNm;
	}

	public void setFrstRegisterNm(String frstRegisterNm) {
		this.frstRegisterNm = frstRegisterNm;
	}

	public String getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	public void setFrstRegisterPnttm(String frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	public String getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public long getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	public int getSubPageIndex() {
		return subPageIndex;
	}

	public void setSubPageIndex(int subPageIndex) {
		this.subPageIndex = subPageIndex;
	}

	public int getSubPageUnit() {
		return subPageUnit;
	}

	public void setSubPageUnit(int subPageUnit) {
		this.subPageUnit = subPageUnit;
	}

	public int getSubPageSize() {
		return subPageSize;
	}

	public void setSubPageSize(int subPageSize) {
		this.subPageSize = subPageSize;
	}

	public int getSubFirstIndex() {
		return subFirstIndex;
	}

	public void setSubFirstIndex(int subFirstIndex) {
		this.subFirstIndex = subFirstIndex;
	}

	public int getSubLastIndex() {
		return subLastIndex;
	}

	public void setSubLastIndex(int subLastIndex) {
		this.subLastIndex = subLastIndex;
	}

	public int getSubRecordCountPerPage() {
		return subRecordCountPerPage;
	}

	public void setSubRecordCountPerPage(int subRecordCountPerPage) {
		this.subRecordCountPerPage = subRecordCountPerPage;
	}

	public int getSubRowNo() {
		return subRowNo;
	}

	public void setSubRowNo(int subRowNo) {
		this.subRowNo = subRowNo;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isModified() {
		return isModified;
	}

	public void setModified(boolean isModified) {
		this.isModified = isModified;
	}


}
