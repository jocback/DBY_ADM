package egovframework.MUSE_Rte.cop.bbs.service;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ToStringBuilder;

import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;

/**
 * 게시물 관리를 위한 VO 클래스
 */
@SuppressWarnings("serial")
public class BoardManageVO extends ActManageDefaultVO implements Serializable {

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }

	private String atchFileId = "";
	private String thumFileId = "";
	/**
	 * 게시판 아이디
	 */
	private String bbsId = "";
	/**
	 * 게시자 아이디
	 */
	private String ntcrId = "";
	/**
	 * 게시자명
	 */
	private String ntcrNm = "";
	private String ntcrNick = "";
	/**
	 * 게시물 내용
	 */
	private String nttCn = "";
	/**
	 * 게시물 아이디
	 */
	private long nttId = 0L;
	/**
	 * 게시물 아이디
	 */
	private long nttIdOr = 0L;
	/**
	 * 게시물 번호
	 */
	private long nttNo = 0L;
	/**
	 * 게시물 제목
	 */
	private String nttSj = "";
	/**
	 * 부모글번호
	 */
	private String replyNo = "0";
	/**
	 * 패스워드
	 */
	private String nttPsw = "";
	/**
	 * 조회수
	 */
	private int inqireCo = 0;
	private int rdcnt = 0;
	/**
	 * 답장여부
	 */
	private String replyAt = "";
	/**
	 * 답장위치
	 */
	private String replyLc = "0";
	/**
	 * 정렬순서
	 */
	private long sortOrdr = 0L;
	/**
	 * 사용여부
	 */
	private String useAt = "";
	
	private String nttLock = "";
	private String nttSeq = "";
	private String nttTop = "";
	private String nttMain = "";
	private String nttRegdt = "";
	private String nttHidden = "";
	private String nttUse = "";
	private String nttLink = "";
	private String bExt1 = "";
	private String bExt2 = "";
	private String bExt3 = "";
	private String bExt4 = "";
	private String bExt5 = "";
	private String bExt6 = "";
	private String bExt7 = "";
	private String bExt8 = "";
	private String bExt9 = "";
	private String bExt10 = "";
	private String preKNO = "";
	private String replyCnt = "";

	private String fileName = "";
	private String fileExt = "";
	private String fileSize = "";
	/**
	 * 카테고리
	 */
	private String nttCat = "";
	
	private String nttCatNm = "";
	private String nttLecNm = "";
	private String nttLecCdNm = "";
	
	/**
	 * 이전 게시판 게시판ID(preBoardId), 게시물번호(preNoteid)
	 */
	private String preBoardId = "";
	private String preNoteid = "";
	
	/**
	 * 확장필드 여부
	 */
	private String extYn = "";
	private String extField = "";

    /** 검색시작일 */
    private String searchBgnDe = "";
    
    /** 검색종료일 */
    private String searchEndDe = "";
    
    /** 로그인아이디 */
    private String searchUserId = "";
    
    /** 레코드 번호 */
    private int rowNo = 0;

    /** 최초 등록자명 */
    private String regnm = "";

    /** 최종 수정자명 */
    private String modnm = "";

    /** 유효여부 */
    private String isExpired = "N";

    /** 상위 정렬 순서 */
    private String parntsSortOrdr = "";

    /** 상위 답변 위치 */
    private String parntsReplyLc = "";

    /** 게시판 유형코드 */
    private String bbsTyCode = "";
    
    /** 게시판 속성코드 */
    private String bbsAttrbCode = "";

    /** 게시판 명 */
    private String bbsNm = "";

    /** 파일첨부가능여부 */
    private String fileAtchPosblAt = "";
    
    /** 첨부가능파일숫자 */
    private int posblAtchFileNumber = 0;
    
	/** 답장가능여부 */
    private String replyPosblAt = "";
    
    private String applyCn = "";
    
    private String applyId = "";

    private String replyCn = "";
    
    private String replyId = "";

    private String bmPic = "";

    private String bmSubject = "";

    private String subPageIndex = "";

    /** 조회 수 증가 여부 */
    private boolean plusCount = false;

    public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getThumFileId() {
		return thumFileId;
	}

	public void setThumFileId(String thumFileId) {
		this.thumFileId = thumFileId;
	}

	public String getBbsId() {
		return bbsId;
	}

	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	public String getNtcrId() {
		return ntcrId;
	}

	public void setNtcrId(String ntcrId) {
		this.ntcrId = ntcrId;
	}

	public String getNtcrNm() {
		return ntcrNm;
	}

	public void setNtcrNm(String ntcrNm) {
		this.ntcrNm = ntcrNm;
	}

	public String getNtcrNick() {
		return ntcrNick;
	}

	public void setNtcrNick(String ntcrNick) {
		this.ntcrNick = ntcrNick;
	}

	public String getNttCn() {
		return nttCn;
	}

	public void setNttCn(String nttCn) {
		this.nttCn = nttCn;
	}

	public long getNttId() {
		return nttId;
	}

	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	public long getNttIdOr() {
		return nttIdOr;
	}

	public void setNttIdOr(long nttIdOr) {
		this.nttIdOr = nttIdOr;
	}

	public long getNttNo() {
		return nttNo;
	}

	public void setNttNo(long nttNo) {
		this.nttNo = nttNo;
	}

	public String getNttSj() {
		return nttSj;
	}

	public void setNttSj(String nttSj) {
		this.nttSj = nttSj;
	}

	public String getNttPsw() {
		return nttPsw;
	}

	public void setNttPsw(String nttPsw) {
		this.nttPsw = nttPsw;
	}

	public int getInqireCo() {
		return inqireCo;
	}

	public void setInqireCo(int inqireCo) {
		this.inqireCo = inqireCo;
	}

	public String getReplyAt() {
		return replyAt;
	}

	public void setReplyAt(String replyAt) {
		this.replyAt = replyAt;
	}

	public String getReplyLc() {
		return replyLc;
	}

	public void setReplyLc(String replyLc) {
		this.replyLc = replyLc;
	}

	public long getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(long sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getNttTop() {
		return nttTop;
	}

	public void setNttTop(String nttTop) {
		this.nttTop = nttTop;
	}

	public String getNttMain() {
		return nttMain;
	}

	public void setNttMain(String nttMain) {
		this.nttMain = nttMain;
	}

	public String getNttRegdt() {
		return nttRegdt;
	}

	public void setNttRegdt(String nttRegdt) {
		this.nttRegdt = nttRegdt;
	}

	public String getNttHidden() {
		return nttHidden;
	}

	public void setNttHidden(String nttHidden) {
		this.nttHidden = nttHidden;
	}

	public String getNttUse() {
		return nttUse;
	}

	public void setNttUse(String nttUse) {
		this.nttUse = nttUse;
	}

	public String getNttLink() {
		return nttLink;
	}

	public void setNttLink(String nttLink) {
		this.nttLink = nttLink;
	}

	public String getbExt1() {
		return bExt1;
	}

	public void setbExt1(String bExt1) {
		this.bExt1 = bExt1;
	}

	public String getbExt2() {
		return bExt2;
	}

	public void setbExt2(String bExt2) {
		this.bExt2 = bExt2;
	}

	public String getbExt3() {
		return bExt3;
	}

	public void setbExt3(String bExt3) {
		this.bExt3 = bExt3;
	}

	public String getbExt4() {
		return bExt4;
	}

	public void setbExt4(String bExt4) {
		this.bExt4 = bExt4;
	}

	public String getbExt5() {
		return bExt5;
	}

	public void setbExt5(String bExt5) {
		this.bExt5 = bExt5;
	}

	public String getbExt6() {
		return bExt6;
	}

	public void setbExt6(String bExt6) {
		this.bExt6 = bExt6;
	}

	public String getbExt7() {
		return bExt7;
	}

	public void setbExt7(String bExt7) {
		this.bExt7 = bExt7;
	}

	public String getbExt8() {
		return bExt8;
	}

	public void setbExt8(String bExt8) {
		this.bExt8 = bExt8;
	}

	public String getbExt9() {
		return bExt9;
	}

	public void setbExt9(String bExt9) {
		this.bExt9 = bExt9;
	}

	public String getbExt10() {
		return bExt10;
	}

	public void setbExt10(String bExt10) {
		this.bExt10 = bExt10;
	}

	public String getPreKNO() {
		return preKNO;
	}

	public void setPreKNO(String preKNO) {
		this.preKNO = preKNO;
	}

	public String getReplyCnt() {
		return replyCnt;
	}

	public void setReplyCnt(String replyCnt) {
		this.replyCnt = replyCnt;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getNttCat() {
		return nttCat;
	}

	public void setNttCat(String nttCat) {
		this.nttCat = nttCat;
	}

	public String getNttCatNm() {
		return nttCatNm;
	}

	public void setNttCatNm(String nttCatNm) {
		this.nttCatNm = nttCatNm;
	}

	public String getPreBoardId() {
		return preBoardId;
	}

	public void setPreBoardId(String preBoardId) {
		this.preBoardId = preBoardId;
	}

	public String getPreNoteid() {
		return preNoteid;
	}

	public void setPreNoteid(String preNoteid) {
		this.preNoteid = preNoteid;
	}

	public String getExtField() {
		return extField;
	}

	public void setExtField(String extField) {
		this.extField = extField;
	}

	public String getSearchBgnDe() {
		return searchBgnDe;
	}

	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}

	public String getSearchEndDe() {
		return searchEndDe;
	}

	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}

	public String getSearchUserId() {
		return searchUserId;
	}

	public void setSearchUserId(String searchUserId) {
		this.searchUserId = searchUserId;
	}

	public int getRowNo() {
		return rowNo;
	}

	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}

	public String getIsExpired() {
		return isExpired;
	}

	public void setIsExpired(String isExpired) {
		this.isExpired = isExpired;
	}

	public String getParntsSortOrdr() {
		return parntsSortOrdr;
	}

	public void setParntsSortOrdr(String parntsSortOrdr) {
		this.parntsSortOrdr = parntsSortOrdr;
	}

	public String getParntsReplyLc() {
		return parntsReplyLc;
	}

	public void setParntsReplyLc(String parntsReplyLc) {
		this.parntsReplyLc = parntsReplyLc;
	}

	public String getBbsTyCode() {
		return bbsTyCode;
	}

	public void setBbsTyCode(String bbsTyCode) {
		this.bbsTyCode = bbsTyCode;
	}

	public String getBbsAttrbCode() {
		return bbsAttrbCode;
	}

	public void setBbsAttrbCode(String bbsAttrbCode) {
		this.bbsAttrbCode = bbsAttrbCode;
	}

	public String getBbsNm() {
		return bbsNm;
	}

	public void setBbsNm(String bbsNm) {
		this.bbsNm = bbsNm;
	}

	public String getFileAtchPosblAt() {
		return fileAtchPosblAt;
	}

	public void setFileAtchPosblAt(String fileAtchPosblAt) {
		this.fileAtchPosblAt = fileAtchPosblAt;
	}

	public int getPosblAtchFileNumber() {
		return posblAtchFileNumber;
	}

	public void setPosblAtchFileNumber(int posblAtchFileNumber) {
		this.posblAtchFileNumber = posblAtchFileNumber;
	}

	public String getReplyPosblAt() {
		return replyPosblAt;
	}

	public void setReplyPosblAt(String replyPosblAt) {
		this.replyPosblAt = replyPosblAt;
	}

	public String getApplyCn() {
		return applyCn;
	}

	public void setApplyCn(String applyCn) {
		this.applyCn = applyCn;
	}

	public String getApplyId() {
		return applyId;
	}

	public void setApplyId(String applyId) {
		this.applyId = applyId;
	}

	public boolean isPlusCount() {
		return plusCount;
	}

	public void setPlusCount(boolean plusCount) {
		this.plusCount = plusCount;
	}

	public String getReplyCn() {
		return replyCn;
	}

	public void setReplyCn(String replyCn) {
		this.replyCn = replyCn;
	}

	public String getReplyId() {
		return replyId;
	}

	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}

	public String getRegnm() {
		return regnm;
	}

	public void setRegnm(String regnm) {
		this.regnm = regnm;
	}

	public String getModnm() {
		return modnm;
	}

	public void setModnm(String modnm) {
		this.modnm = modnm;
	}

	public String getSubPageIndex() {
		return subPageIndex;
	}

	public void setSubPageIndex(String subPageIndex) {
		this.subPageIndex = subPageIndex;
	}

	public String getNttSeq() {
		return nttSeq;
	}

	public void setNttSeq(String nttSeq) {
		this.nttSeq = nttSeq;
	}

	public String getNttLock() {
		return nttLock;
	}

	public void setNttLock(String nttLock) {
		this.nttLock = nttLock;
	}

	public String getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(String replyNo) {
		this.replyNo = replyNo;
	}

	public int getRdcnt() {
		return rdcnt;
	}

	public void setRdcnt(int rdcnt) {
		this.rdcnt = rdcnt;
	}

	public String getExtYn() {
		return extYn;
	}

	public void setExtYn(String extYn) {
		this.extYn = extYn;
	}

	public String getNttLecNm() {
		return nttLecNm;
	}

	public void setNttLecNm(String nttLecNm) {
		this.nttLecNm = nttLecNm;
	}

	public String getNttLecCdNm() {
		return nttLecCdNm;
	}

	public void setNttLecCdNm(String nttLecCdNm) {
		this.nttLecCdNm = nttLecCdNm;
	}

	public String getBmPic() {
		return bmPic;
	}

	public void setBmPic(String bmPic) {
		this.bmPic = bmPic;
	}

	public String getBmSubject() {
		return bmSubject;
	}

	public void setBmSubject(String bmSubject) {
		this.bmSubject = bmSubject;
	}


}
