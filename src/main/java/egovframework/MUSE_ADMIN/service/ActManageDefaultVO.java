package egovframework.MUSE_ADMIN.service;

import java.io.Serializable;

public class ActManageDefaultVO implements Serializable {

	private static final long serialVersionUID = -2643416632006085656L;


	/** 검색조건 */
	private String searchCnd = "";
	private String searchCnd2 = "";
	private String searchCnd3 = "";

	/** view */
	private String pageView = "";

	private String actListMode = "";

	private String actListExcel = "";

	/** 검색Keyword */
	private String searchKeyword = "";

	private String searchWrd = "";

	private String searchSdt = "";

	private String searchEdt = "";

	private String searchSdt2 = "";

	private String searchEdt2 = "";

	private String searchYear = "";

	private String searchMonth = "";

	private String searchWorkpart = "";

	private String searchActgubun = "";

	private String searchActfield = "";

	private String searchActstt = "";

	private String searchActday = "";

	private String searchActSday = "";

	private String searchActEday = "";

	private String searchActGrIdx = "";

	private String searchMyAct = "";

	private String searchOp1 = "";

	private String searchOp2 = "";

	private String searchOp3 = "";

	private String searchOp4 = "";

	private String searchOp5 = "";
	
	private String searchOp6 = "";
	
	private String searchOp7 ="";

	private String[] searchArr1 = null;
	private String[] searchArr2 = null;

	private String regip;
	private String regid;
	private String regdt;
	private String modid;
	private String moddt;
	private String delid;
	private String deldt;
	private String searchChk;

	//반환 경고
	private String returnStt = "";

	//반환 필드
	private String[] returnItem = null;

	//실적 승인 상태
	private String sapStatus = "";

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

	private String frmTypeCode = "";
	private String frmTypeName = "";
	private String frmTypeValue = "";
	/**
	 * searchCnd attribute 를 리턴한다.
	 * @return the String
	 */
	public String getSearchCnd() {
		return searchCnd;
	}

	/**
	 * searchCnd attribute 값을 설정한다.
	 * @return searchCnd String
	 */
	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}
	
	public String getSearchCnd2() {
		return searchCnd2;
	}

	public void setSearchCnd2(String searchCnd2) {
		this.searchCnd2 = searchCnd2;
	}

	public String getSearchCnd3() {
		return searchCnd3;
	}

	public void setSearchCnd3(String searchCnd3) {
		this.searchCnd3 = searchCnd3;
	}


	/**
	 * searchKeyword attribute 를 리턴한다.
	 * @return the String
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * searchKeyword attribute 값을 설정한다.
	 * @return searchKeyword String
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * searchUseYn attribute 를 리턴한다.
	 * @return the String
	 */
	public String getSearchUseYn() {
		return searchUseYn;
	}

	/**
	 * searchUseYn attribute 값을 설정한다.
	 * @return searchUseYn String
	 */
	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	/**
	 * pageIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * pageIndex attribute 값을 설정한다.
	 * @return pageIndex int
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * pageUnit attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * pageUnit attribute 값을 설정한다.
	 * @return pageUnit int
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * pageSize attribute 를 리턴한다.
	 * @return the int
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * pageSize attribute 값을 설정한다.
	 * @return pageSize int
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * firstIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * firstIndex attribute 값을 설정한다.
	 * @return firstIndex int
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * lastIndex attribute 를 리턴한다.
	 * @return the int
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * lastIndex attribute 값을 설정한다.
	 * @return lastIndex int
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * recordCountPerPage attribute 를 리턴한다.
	 * @return the int
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @return recordCountPerPage int
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getSearchYear() {
		return searchYear;
	}

	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}

	public String getSearchMonth() {
		return searchMonth;
	}

	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}

	public String getSearchWorkpart() {
		return searchWorkpart;
	}

	public void setSearchWorkpart(String searchWorkpart) {
		this.searchWorkpart = searchWorkpart;
	}

	public String getSearchActgubun() {
		return searchActgubun;
	}

	public void setSearchActgubun(String searchActgubun) {
		this.searchActgubun = searchActgubun;
	}

	public String getSearchActstt() {
		return searchActstt;
	}

	public void setSearchActstt(String searchActstt) {
		this.searchActstt = searchActstt;
	}

	public String getSearchActday() {
		return searchActday;
	}

	public void setSearchActday(String searchActday) {
		this.searchActday = searchActday;
	}

	public String getActListMode() {
		return actListMode;
	}

	public void setActListMode(String actListMode) {
		this.actListMode = actListMode;
	}

	public String getSearchActSday() {
		return searchActSday;
	}

	public void setSearchActSday(String searchActSday) {
		this.searchActSday = searchActSday;
	}

	public String getSearchActEday() {
		return searchActEday;
	}

	public void setSearchActEday(String searchActEday) {
		this.searchActEday = searchActEday;
	}

	public String getPageView() {
		return pageView;
	}

	public void setPageView(String pageView) {
		this.pageView = pageView;
	}

	public String getSearchActGrIdx() {
		return searchActGrIdx;
	}

	public void setSearchActGrIdx(String searchActGrIdx) {
		this.searchActGrIdx = searchActGrIdx;
	}

	public String getSearchMyAct() {
		return searchMyAct;
	}

	public void setSearchMyAct(String searchMyAct) {
		this.searchMyAct = searchMyAct;
	}

	public String getSearchActfield() {
		return searchActfield;
	}

	public void setSearchActfield(String searchActfield) {
		this.searchActfield = searchActfield;
	}

	public String getActListExcel() {
		return actListExcel;
	}

	public void setActListExcel(String actListExcel) {
		this.actListExcel = actListExcel;
	}

	public String getSapStatus() {
		return sapStatus;
	}

	public void setSapStatus(String sapStatus) {
		this.sapStatus = sapStatus;
	}

	public String getRegid() {
		return regid;
	}

	public void setRegid(String regid) {
		this.regid = regid;
	}

	public String getReturnStt() {
		return returnStt;
	}

	public void setReturnStt(String returnStt) {
		this.returnStt = returnStt;
	}

	public String getSearchOp1() {
		return searchOp1;
	}

	public void setSearchOp1(String searchOp1) {
		this.searchOp1 = searchOp1;
	}

	public String getSearchOp2() {
		return searchOp2;
	}

	public void setSearchOp2(String searchOp2) {
		this.searchOp2 = searchOp2;
	}

	public String getSearchOp3() {
		return searchOp3;
	}

	public void setSearchOp3(String searchOp3) {
		this.searchOp3 = searchOp3;
	}

	public String getSearchOp4() {
		return searchOp4;
	}

	public void setSearchOp4(String searchOp4) {
		this.searchOp4 = searchOp4;
	}

	public String getSearchOp5() {
		return searchOp5;
	}

	public void setSearchOp5(String searchOp5) {
		this.searchOp5 = searchOp5;
	}

	public String getSearchOp6() {
		return searchOp6;
	}

	public void setSearchOp6(String searchOp6) {
		this.searchOp6 = searchOp6;
	}

	public String getSearchOp7() {
		return searchOp7;
	}

	public void setSearchOp7(String searchOp7) {
		this.searchOp7 = searchOp7;
	}
	
	public String getSearchSdt() {
		return searchSdt;
	}

	public void setSearchSdt(String searchSdt) {
		this.searchSdt = searchSdt;
	}

	public String getSearchEdt() {
		return searchEdt;
	}

	public void setSearchEdt(String searchEdt) {
		this.searchEdt = searchEdt;
	}

	public String getSearchWrd() {
		return searchWrd;
	}

	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	public String getFrmTypeCode() {
		return frmTypeCode;
	}

	public void setFrmTypeCode(String frmTypeCode) {
		this.frmTypeCode = frmTypeCode;
	}

	public String getFrmTypeName() {
		return frmTypeName;
	}

	public void setFrmTypeName(String frmTypeName) {
		this.frmTypeName = frmTypeName;
	}

	public String getFrmTypeValue() {
		return frmTypeValue;
	}

	public void setFrmTypeValue(String frmTypeValue) {
		this.frmTypeValue = frmTypeValue;
	}

	public String getRegdt() {
		return regdt;
	}

	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}

	public String getModid() {
		return modid;
	}

	public void setModid(String modid) {
		this.modid = modid;
	}

	public String getModdt() {
		return moddt;
	}

	public void setModdt(String moddt) {
		this.moddt = moddt;
	}

	public String getDelid() {
		return delid;
	}

	public void setDelid(String delid) {
		this.delid = delid;
	}

	public String getDeldt() {
		return deldt;
	}

	public void setDeldt(String deldt) {
		this.deldt = deldt;
	}

	public String getRegip() {
		return regip;
	}

	public void setRegip(String regip) {
		this.regip = regip;
	}

	public String getSearchChk() {
		return searchChk;
	}

	public void setSearchChk(String searchChk) {
		this.searchChk = searchChk;
	}

	public String[] getReturnItem() {
		return returnItem;
	}

	public void setReturnItem(String[] colNmArr) {
		this.returnItem = colNmArr;
	}

	public String[] getSearchArr1() {
		return searchArr1;
	}

	public void setSearchArr1(String[] searchArr1) {
		this.searchArr1 = searchArr1;
	}

	public String[] getSearchArr2() {
		return searchArr2;
	}

	public void setSearchArr2(String[] searchArr2) {
		this.searchArr2 = searchArr2;
	}

	public String getSearchSdt2() {
		return searchSdt2;
	}

	public void setSearchSdt2(String searchSdt2) {
		this.searchSdt2 = searchSdt2;
	}

	public String getSearchEdt2() {
		return searchEdt2;
	}

	public void setSearchEdt2(String searchEdt2) {
		this.searchEdt2 = searchEdt2;
	}







}
