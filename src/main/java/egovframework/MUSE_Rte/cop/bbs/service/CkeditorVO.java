package egovframework.MUSE_Rte.cop.bbs.service;

import org.springframework.web.multipart.MultipartFile;

public class CkeditorVO{

	/** 에디터 업로드 관련 */
    private MultipartFile upload;
    private String CKEditor;
    private String CKEditorFuncNum;
    private String langCode;
    
    public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	
	public String getCKEditor() {
		return CKEditor;
	}
	public void setCKEditor(String cKEditor) {
		CKEditor = cKEditor;
	}
	public String getCKEditorFuncNum() {
		return CKEditorFuncNum;
	}
	public void setCKEditorFuncNum(String cKEditorFuncNum) {
		CKEditorFuncNum = cKEditorFuncNum;
	}
	public String getLangCode() {
		return langCode;
	}
	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}
    
}
