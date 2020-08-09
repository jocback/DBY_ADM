package egovframework.MUSE_ADMIN.service;

@SuppressWarnings("serial")
public class ActMobileManageVO extends ActManageDefaultVO {

	private String sno;
	private String userId;
	private String deviceCnt;
	private String deviceMsg;
	private String downCnt;
	private String downMsg;
	private String editId;
	private String date;
	private String tableNm;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getDeviceCnt() {
		return deviceCnt;
	}
	public void setDeviceCnt(String deviceCnt) {
		this.deviceCnt = deviceCnt;
	}
	public String getDeviceMsg() {
		return deviceMsg;
	}
	public void setDeviceMsg(String deviceMsg) {
		this.deviceMsg = deviceMsg;
	}
	public String getDownCnt() {
		return downCnt;
	}
	public void setDownCnt(String downCnt) {
		this.downCnt = downCnt;
	}
	public String getDownMsg() {
		return downMsg;
	}
	public void setDownMsg(String downMsg) {
		this.downMsg = downMsg;
	}
	public String getEditId() {
		return editId;
	}
	public void setEditId(String editId) {
		this.editId = editId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTableNm() {
		return tableNm;
	}
	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}

	
}
