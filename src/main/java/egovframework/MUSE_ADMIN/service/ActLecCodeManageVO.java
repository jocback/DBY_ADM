package egovframework.MUSE_ADMIN.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class ActLecCodeManageVO extends ActManageDefaultVO implements Serializable {

	private String codeId = "";
	private String codeNm = "";
	private String codeDc = "";
	private String codeSq = "";
	private String useYn = "";
	private String regDt = "";
	private String regId = "";
	private String modDt = "";
	private String modId = "";
	private String delDt = "";
	private String delId = "";
	private String codeGb = "";

	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getCodeNm() {
		return codeNm;
	}
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}
	public String getCodeDc() {
		return codeDc;
	}
	public void setCodeDc(String codeDc) {
		this.codeDc = codeDc;
	}
	public String getCodeSq() {
		return codeSq;
	}
	public void setCodeSq(String codeSq) {
		this.codeSq = codeSq;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getModDt() {
		return modDt;
	}
	public void setModDt(String modDt) {
		this.modDt = modDt;
	}
	public String getModId() {
		return modId;
	}
	public void setModId(String modId) {
		this.modId = modId;
	}
	public String getDelDt() {
		return delDt;
	}
	public void setDelDt(String delDt) {
		this.delDt = delDt;
	}
	public String getDelId() {
		return delId;
	}
	public void setDelId(String delId) {
		this.delId = delId;
	}
	public String getCodeGb() {
		return codeGb;
	}
	public void setCodeGb(String codeGb) {
		this.codeGb = codeGb;
	}



}
