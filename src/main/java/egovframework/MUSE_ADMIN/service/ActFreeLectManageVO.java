package egovframework.MUSE_ADMIN.service;

@SuppressWarnings("serial")
public class ActFreeLectManageVO extends ActManageDefaultVO {

	private String fmIdx;
	private String fmSubject;
	private String fmEq;
	private String fmGigan;
	private String fmSdt;
	private String fmSta;

	private String fsGb;
	private String[] mvIdxArr;
	private String[] mIdArr;
	private String mvIdx;
	private String mId;
	private String mvSubject;
	private String mName;
	
	public String getFmIdx() {
		return fmIdx;
	}
	public void setFmIdx(String fmIdx) {
		this.fmIdx = fmIdx;
	}
	public String getFmSubject() {
		return fmSubject;
	}
	public void setFmSubject(String fmSubject) {
		this.fmSubject = fmSubject;
	}
	public String getMvIdx() {
		return mvIdx;
	}
	public void setMvIdx(String mvIdx) {
		this.mvIdx = mvIdx;
	}
	public String getFmEq() {
		return fmEq;
	}
	public void setFmEq(String fmEq) {
		this.fmEq = fmEq;
	}
	public String getFmGigan() {
		return fmGigan;
	}
	public void setFmGigan(String fmGigan) {
		this.fmGigan = fmGigan;
	}
	public String getFmSdt() {
		return fmSdt;
	}
	public void setFmSdt(String fmSdt) {
		this.fmSdt = fmSdt;
	}
	public String getFmSta() {
		return fmSta;
	}
	public void setFmSta(String fmSta) {
		this.fmSta = fmSta;
	}
	public String getFsGb() {
		return fsGb;
	}
	public void setFsGb(String fsGb) {
		this.fsGb = fsGb;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getMvSubject() {
		return mvSubject;
	}
	public void setMvSubject(String mvSubject) {
		this.mvSubject = mvSubject;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String[] getMvIdxArr() {
		return mvIdxArr;
	}
	public void setMvIdxArr(String[] mvIdxArr) {
		this.mvIdxArr = mvIdxArr;
	}
	public String[] getmIdArr() {
		return mIdArr;
	}
	public void setmIdArr(String[] mIdArr) {
		this.mIdArr = mIdArr;
	}
	
}
