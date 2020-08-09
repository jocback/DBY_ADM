package egovframework.MUSE_Rte.sym.log.wlg.service;

import java.io.Serializable;

/**
 * @Class Name : WebLog.java
 * @Description : 웹 로그 관리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일         수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.   이삼섭         최초생성
 *    2011. 7. 01.   이기하         패키지 분리(sym.log -> sym.log.wlg)
 *    2011.09.14     서준식       화면에 검색일자를 표시하기위한 멤버변수 추가.
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
public class WebLog implements Serializable {

	private static final long serialVersionUID = -7768865822788140496L;

	/**
	 * 요청아이디
	 */
	private long requstId = 0L;

	private String webMod = "";
	/**
	 * 발생일자
	 */
	private String occrrncDe = "";

	/**
	 * URL
	 */
	private String menuCd = "";
	private String url = "";
	private String bbsId = "";

	/**
	 * 요청자아이디
	 */
	private String rqesterId = "";

	/**
	 * 요청자 이름
	 */
	private String rqsterNm = "";

	/**
	 * 요청자 아이디(추가)
	 */
	private String userId = "";

	/**
	 * 요청아이피
	 */
	private String rqesterIp = "";

	/**
	 * 클라이언트웹브라이저 OS정보
	 */
	private String clntOs = "";

	/**
	 * 클라이언트웹브라이저 종류
	 */
	private String clntWk = "";

	/**
	 * 클라이언트웹브라이저 버전
	 */
	private String clntWv = "";

	/**
	 * 리퍼러
	 */
	private String refDom = "";

	/**
	 * 전송방식
	 */
	private String refMthod = "";

	/**
	 * 등록일
	 */
	private String regDate = "";

	/**
	 * 검색시작일
	 */
	private String searchBgnDe = "";

	/**
	 * 검색조건
	 */
	private String searchCnd = "";

	/**
	 * 검색종료일
	 */
	private String searchEndDe = "";

	/**
	 * 검색단어
	 */
	private String searchWrd = "";

	/**
	 * 정렬순서(DESC,ASC)
	 */
	private String sortOrdr = "";

	/** 검색사용여부 */
    private String searchUseYn = "";

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;

    /** rowNo  */
	private int rowNo = 0;

	/**
	 * 검색시작일_화면용
	 */
	private String searchBgnDeView = "";//2011.09.14

	/**
	 * 검색종료일_화면용
	 */
	private String searchEndDeView = "";//2011.09.14

	public String getSearchEndDeView() {
		return searchEndDeView;
	}
	public void setSearchEndDeView(String searchEndDeView) {
		this.searchEndDeView = searchEndDeView;
	}
	public String getSearchBgnDeView() {
		return searchBgnDeView;
	}
	public void setSearchBgnDeView(String searchBgnDeView) {
		this.searchBgnDeView = searchBgnDeView;
	}

	public String getOccrrncDe() {
		return occrrncDe;
	}

	public void setOccrrncDe(String occrrncDe) {
		this.occrrncDe = occrrncDe;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRqesterId() {
		return rqesterId;
	}

	public void setRqesterId(String rqesterId) {
		this.rqesterId = rqesterId;
	}

	public String getRqsterNm() {
		return rqsterNm;
	}

	public void setRqsterNm(String rqsterNm) {
		this.rqsterNm = rqsterNm;
	}

	public String getRqesterIp() {
		return rqesterIp;
	}

	public void setRqesterIp(String rqesterIp) {
		this.rqesterIp = rqesterIp;
	}

	public String getSearchBgnDe() {
		return searchBgnDe;
	}

	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}

	public String getSearchCnd() {
		return searchCnd;
	}

	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}

	public String getSearchEndDe() {
		return searchEndDe;
	}

	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}

	public String getSearchWrd() {
		return searchWrd;
	}

	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	public String getSortOrdr() {
		return sortOrdr;
	}

	public void setSortOrdr(String sortOrdr) {
		this.sortOrdr = sortOrdr;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public int getRowNo() {
		return rowNo;
	}

	public void setRowNo(int rowNo) {
		this.rowNo = rowNo;
	}
	public String getClntOs() {
		return clntOs;
	}
	public void setClntOs(String clntOs) {
		this.clntOs = clntOs;
	}
	public String getClntWk() {
		return clntWk;
	}
	public void setClntWk(String clntWk) {
		this.clntWk = clntWk;
	}
	public String getClntWv() {
		return clntWv;
	}
	public void setClntWv(String clntWv) {
		this.clntWv = clntWv;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRefDom() {
		return refDom;
	}
	public void setRefDom(String refDom) {
		this.refDom = refDom;
	}
	public String getRefMthod() {
		return refMthod;
	}
	public void setRefMthod(String refMthod) {
		this.refMthod = refMthod;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public long getRequstId() {
		return requstId;
	}
	public void setRequstId(long requstId) {
		this.requstId = requstId;
	}
	public String getBbsId() {
		return bbsId;
	}
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}
	public String getMenuCd() {
		return menuCd;
	}
	public void setMenuCd(String menuCd) {
		this.menuCd = menuCd;
	}
	public String getWebMod() {
		return webMod;
	}
	public void setWebMod(String webMod) {
		this.webMod = webMod;
	}


}
