package egovframework.MUSE_Rte.cop.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;

/**
 * 게시판 속성 정보를 관리하기 위한 VO  클래스
 */
@SuppressWarnings("serial")
public class BoardMasterVO extends ActManageDefaultVO implements Serializable {
    
     /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

     private String id = "";
    
    /** 게시판 아이디 */
    private String bbsId = "";
    
    /** 게시판 소개 */
    private String bbsCn = "";
    
    /** 게시판 명 */
    private String bbsNm = "";
    
    /** 파일첨부가능여부 */
    private String fileYn = "";
    
    /** 첨부가능파일숫자 */
    private int fileCnt = 0;
    
    /** 첨부가능파일사이즈 */
    private String fileSize = null;
    
    /** 답장가능여부 */
    private String repYn = "";
    
    /** 코멘트가능여부 */
    private String cmtYn = "";
    
    /** 사용여부 */
    private String useYn = "";
    
    /** 게시판삭제 */
    private String useAt = "";
    
    /** 사용플래그 */
    private String bbsUseFlag = "";
    
    /** 대상 아이디 */
    private String trgetId = "";
    
    /** 등록구분코드 */
    private String registSeCode = "";
    
    /** 댓글 여부 */
    private String commentAt = "";
    
    private String mainYn = "";
    private String topYn = "";
    private String thumYn = "";
    private String linkYn = "";
    private String hideYn = "";
    private String lockYn = "";
    private String twoYn = "";
    private String newYn = "";
    private String newNo = "";
    private String hotYn = "";
    private String hotNo = "";
    private String cateYn = "";
    private String cateCd = "";
    private String extYn = "";
    private String extFld = "";
    private String seqYn = "";
    
    private String posblList="";
    private String posblView="";
    private String posblWrite="";

    
    /** 권한지정 여부 */
    private String authFlag = "";

    private String currDate = "";
    
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBbsId() {
		return bbsId;
	}
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}
	public String getBbsNm() {
		return bbsNm;
	}
	public void setBbsNm(String bbsNm) {
		this.bbsNm = bbsNm;
	}
	public String getBbsUseFlag() {
		return bbsUseFlag;
	}
	public void setBbsUseFlag(String bbsUseFlag) {
		this.bbsUseFlag = bbsUseFlag;
	}
	public String getTrgetId() {
		return trgetId;
	}
	public void setTrgetId(String trgetId) {
		this.trgetId = trgetId;
	}
	public String getRegistSeCode() {
		return registSeCode;
	}
	public void setRegistSeCode(String registSeCode) {
		this.registSeCode = registSeCode;
	}
	public String getCommentAt() {
		return commentAt;
	}
	public void setCommentAt(String commentAt) {
		this.commentAt = commentAt;
	}
	public String getExtFld() {
		return extFld;
	}
	public void setExtFld(String extFld) {
		this.extFld = extFld;
	}
	public String getPosblList() {
		return posblList;
	}
	public void setPosblList(String posblList) {
		this.posblList = posblList;
	}
	public String getPosblView() {
		return posblView;
	}
	public void setPosblView(String posblView) {
		this.posblView = posblView;
	}
	public String getPosblWrite() {
		return posblWrite;
	}
	public void setPosblWrite(String posblWrite) {
		this.posblWrite = posblWrite;
	}
	public String getAuthFlag() {
		return authFlag;
	}
	public void setAuthFlag(String authFlag) {
		this.authFlag = authFlag;
	}
	public String getCurrDate() {
		return currDate;
	}
	public void setCurrDate(String currDate) {
		this.currDate = currDate;
	}
	public String getBbsCn() {
		return bbsCn;
	}
	public void setBbsCn(String bbsCn) {
		this.bbsCn = bbsCn;
	}
	public String getFileYn() {
		return fileYn;
	}
	public void setFileYn(String fileYn) {
		this.fileYn = fileYn;
	}
	public int getFileCnt() {
		return fileCnt;
	}
	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getRepYn() {
		return repYn;
	}
	public void setRepYn(String repYn) {
		this.repYn = repYn;
	}
	public String getCmtYn() {
		return cmtYn;
	}
	public void setCmtYn(String cmtYn) {
		this.cmtYn = cmtYn;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getMainYn() {
		return mainYn;
	}
	public void setMainYn(String mainYn) {
		this.mainYn = mainYn;
	}
	public String getTopYn() {
		return topYn;
	}
	public void setTopYn(String topYn) {
		this.topYn = topYn;
	}
	public String getThumYn() {
		return thumYn;
	}
	public void setThumYn(String thumYn) {
		this.thumYn = thumYn;
	}
	public String getLinkYn() {
		return linkYn;
	}
	public void setLinkYn(String linkYn) {
		this.linkYn = linkYn;
	}
	public String getHideYn() {
		return hideYn;
	}
	public void setHideYn(String hideYn) {
		this.hideYn = hideYn;
	}
	public String getCateYn() {
		return cateYn;
	}
	public void setCateYn(String cateYn) {
		this.cateYn = cateYn;
	}
	public String getCateCd() {
		return cateCd;
	}
	public void setCateCd(String cateCd) {
		this.cateCd = cateCd;
	}
	public String getExtYn() {
		return extYn;
	}
	public void setExtYn(String extYn) {
		this.extYn = extYn;
	}
	public String getSeqYn() {
		return seqYn;
	}
	public void setSeqYn(String seqYn) {
		this.seqYn = seqYn;
	}
	public String getUseAt() {
		return useAt;
	}
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}
	public String getLockYn() {
		return lockYn;
	}
	public void setLockYn(String lockYn) {
		this.lockYn = lockYn;
	}
	public String getTwoYn() {
		return twoYn;
	}
	public void setTwoYn(String twoYn) {
		this.twoYn = twoYn;
	}
	public String getNewYn() {
		return newYn;
	}
	public void setNewYn(String newYn) {
		this.newYn = newYn;
	}
	public String getNewNo() {
		return newNo;
	}
	public void setNewNo(String newNo) {
		this.newNo = newNo;
	}
	public String getHotYn() {
		return hotYn;
	}
	public void setHotYn(String hotYn) {
		this.hotYn = hotYn;
	}
	public String getHotNo() {
		return hotNo;
	}
	public void setHotNo(String hotNo) {
		this.hotNo = hotNo;
	}
    


}
