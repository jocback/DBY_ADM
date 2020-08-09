package egovframework.com.cmm.service;

import javax.annotation.Resource;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.service.EgovCmmUseService;

@Component("EmailSender")
public class EmailSender {

	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	public String getCodeEtc(String codeId, String code, String field) throws Exception {
    	ComDefaultCodeVO codeVo = new ComDefaultCodeVO();
		codeVo.setCodeId(codeId);
		codeVo.setCode(code);
		codeVo.setTableNm(field);
		return cmmUseService.commonCodeEtc1(codeVo);
	}
	
	@SuppressWarnings("deprecation")
	public String send(String addTo, String subject, String mailHtml) throws Exception {
		//발신 이메일 정보 호출
		String EmailInfo1 = getCodeEtc("COM090","111","CODE_ETC1"); //발신자 이름
		String EmailInfo2 = getCodeEtc("COM090","111","CODE_ETC1"); //발신자 이메일
		//String authEmailId = "kangdevmail";
		//String authEmailPw = "roqkfapdlf2019@#";
		String[] addToArr = addTo.split(",");
		//String authEmailId = EgovProperties.getProperty("Globals.gmailId");
		//String authEmailPw = EgovProperties.getProperty("Globals.gmailPw");
		
		try {
			HtmlEmail email = new HtmlEmail();
			//email.setHostName("smtp.gmail.com");
			//email.setSmtpPort(465);
			email.setHostName("222.234.3.55");
			email.setSmtpPort(25);
			email.setSSL(false);
			//email.setSSL(true);
			//email.setTLS(true);
			//email.setAuthentication(authEmailId, authEmailPw);
			for(int i=0;i<addToArr.length;i++){
				email.addTo(addToArr[i], "member");
			}
			email.setFrom(EmailInfo1, EmailInfo2);
			email.setSubject(subject);
			email.setHtmlMsg(mailHtml);
			return email.send();
		} catch (EmailException e) {
			e.printStackTrace();
			return "error";
		}
	}

}
