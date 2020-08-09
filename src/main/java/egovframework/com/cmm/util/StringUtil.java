package egovframework.com.cmm.util;

import java.io.File;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.ArrayList;


public class StringUtil {

	public StringUtil() {
	}

	
	/**
	 * 문자열을 특정문자로 분리하여 사용
	 * 
	 * @param String
	 *            str 분리될 원본 문자열
	 * @param String
	 *            delim 구분자로 사용될 문자
	 * @return String[]
	 * 
	 * @sample StringUtil.strSplit("aaa,bbb", "," )
	 */
	public static String[] strSplit(String str, String delim) {
		StringTokenizer st = new StringTokenizer(str, delim);
		Vector vec = new Vector();
		int cnt = st.countTokens();
		String[] tokens = null;

		if (cnt == 1) {
			tokens = new String[1];
			tokens[0] = str;
		} else {
			for (int i = 0; i < cnt; i++)
				vec.addElement(st.nextToken());
			tokens = new String[cnt];
			vec.copyInto(tokens);
			vec.clear();
			vec = null;
		}
		return tokens;
	}
	
	/**
	 * 상품 옵션전용 스플릿
	 * 
	 * @param String
	 *            str 분리될 원본 문자열
	 * @param String
	 *            delim 구분자로 사용될 문자
	 * @return String[]
	 * 
	 * @sample StringUtil.strSplit("aaa,bbb", "," )
	 */
	public static String[] optStrSplit(String str, String delim) {
		
		StringTokenizer st = new StringTokenizer(str, delim);
		Vector vec = new Vector();
		int cnt = st.countTokens();
		String[] tokens = null;
		
		int delipos =  str.indexOf(delim);
		
			for (int i = 0; i < cnt; i++)
				vec.addElement(st.nextToken());
			
			tokens = new String[cnt];
			vec.copyInto(tokens);
			vec.clear();
			vec = null;
		
		return tokens;
	}
	
	/**
	 * Character Set를 ISO-8859-1로 컨버전
	 * 
	 * @param str
	 *            변환할 문자
	 * @return String 변환문자
	 */
	public static String convUs(String str) {
		String tmp = new String("");
		if (str == null || str.length() == 0)
			return "";
		try {
			tmp = new String(str.getBytes("EUC-KR"), "8859_1");
		} catch (Exception e) {

		}
		return tmp;
	}

	/**
	 * Character Set를 ISO-8859-1로 컨버전
	 * 
	 * @param str
	 *            변환할 문자
	 * @return String 변환문자
	 */
	public static String convUsObj(Object obj) {
		String tmp = new String("");
		if (obj == null )
			return "";
		try {
			tmp = new String(obj.toString().getBytes("EUC-KR"), "8859_1");
		} catch (Exception e) {

		}
		return tmp;
	}
	
	/**
	 * Character Set를 EUC-KR로 컨버전
	 * 
	 * @param str
	 *            변환할 문자
	 * @return String 변환문자
	 */
	public static String convKor(String str) {
		String tmp = new String("");
		if (str == null || str.length() == 0)
			return "";
		try {
			tmp = new String(str.getBytes("8859_1"), "EUC-KR");
		} catch (Exception e) {

		}
		return tmp;

	}	
	
	/**
	 * Character Set를 EUC-KR로 컨버전
	 * 
	 * @param str
	 *            변환할 문자
	 * @return String 변환문자
	 */
	public static String convKorObj(Object obj) {
		String tmp = new String("");
		if (obj == null )
			return "";
		try {
			tmp = new String(obj.toString().getBytes("8859_1"), "EUC-KR");
		} catch (Exception e) {

		}
		return tmp;

	}		
	
	/**
	 * 입력된 문자열이 null 일경우 기본문자열을 리턴한다.
	 * 
	 * @param str
	 *            문자열
	 * @param def
	 *            기본 문자열
	 * @return
	 */
	public static String convNull(String str, String def) {
		if (isNull(str))
			return def;
		return str;
	}

    /**
     * Object가 null 일경우 기본문자열을 리턴한다.
     * @param obj
     * @param def 기본 문자열
     * @return
     */
    public static String convNullObj(Object obj) {
        return convNullObj(obj,"");
    }
    
	/**
	 * Object가 null 일경우 기본문자열을 리턴한다.
	 * @param obj
	 * @param def 기본 문자열
	 * @return
	 */
	public static String convNullObj(Object obj, String def) {
		if (obj==null || obj=="")
			return def;
		return obj.toString();
	}
	
	/**
	 * Object가 null 일경우 기본문자열을 리턴한다.
	 * @param obj
	 * @param def 기본 문자열
	 * @return
	 */
	public static String convNullObjKor(Object obj, String def) {
		if (obj==null)
			return def;
		return convKor(obj.toString());
	}

	/**
	 * null 또는 공백문자인지 확인한다.
	 * 
	 * @param str
	 *            문자열
	 * @return
	 */
	public static boolean isNull(String str) {
		return (str == null || str.trim().length() < 1);
	}

	/**
	 * 문자 열 속에 포함 된 특정 문자를 새로운 문자로 변경
	 * 
	 * @param String
	 *            s1 문자열
	 * @param String
	 *            s2 이전문자
	 * @param String
	 *            s3 바뀔문자
	 * @return String 변환 된 문자열
	 */
	public static String strReplace(String s1, String s2, String s3) {
		if (s1 == null)
			return "";
		String res = "";
		StringTokenizer str = new StringTokenizer(s1, s2);

		while (str.hasMoreTokens()) {
			res += str.nextToken() + s3;
		}

		return res;
	}

	/**
	 * 문자열에서 HTML 태그 제거
	 * 
	 * @param s
	 * @return
	 */
	public static String removeTag(String s) {
		if (s == null)
			return "";
		final int NORMAL_STATE = 0;
		final int TAG_STATE = 1;
		final int START_TAG_STATE = 2;
		final int END_TAG_STATE = 3;
		final int SINGLE_QUOT_STATE = 4;
		final int DOUBLE_QUOT_STATE = 5;
		int state = NORMAL_STATE;
		int oldState = NORMAL_STATE;
		char[] chars = s.toCharArray();
		StringBuffer sb = new StringBuffer();
		char a;
		for (int i = 0; i < chars.length; i++) {
			a = chars[i];
			switch (state) {
			case NORMAL_STATE:
				if (a == '<')
					state = TAG_STATE;
				else
					sb.append(a);
				break;
			case TAG_STATE:
				if (a == '>')
					state = NORMAL_STATE;
				else if (a == '\"') {
					oldState = state;
					state = DOUBLE_QUOT_STATE;
				} else if (a == '\'') {
					oldState = state;
					state = SINGLE_QUOT_STATE;
				} else if (a == '/')
					state = END_TAG_STATE;
				else if (a != ' ' && a != '\t' && a != '\n' && a != '\r'
						&& a != '\f')
					state = START_TAG_STATE;
				break;
			case START_TAG_STATE:
			case END_TAG_STATE:
				if (a == '>')
					state = NORMAL_STATE;
				else if (a == '\"') {
					oldState = state;
					state = DOUBLE_QUOT_STATE;
				} else if (a == '\'') {
					oldState = state;
					state = SINGLE_QUOT_STATE;
				} else if (a == '\"')
					state = DOUBLE_QUOT_STATE;
				else if (a == '\'')
					state = SINGLE_QUOT_STATE;
				break;
			case DOUBLE_QUOT_STATE:
				if (a == '\"')
					state = oldState;
				break;
			case SINGLE_QUOT_STATE:
				if (a == '\'')
					state = oldState;
				break;
			}
		}
		return sb.toString();

	}

	/**
	 * Method cropByte. 문자열 바이트수만큼 끊어주고, 생략표시하기
	 * 
	 * @param str
	 *            문자열
	 * @param i
	 *            바이트수
	 * @param trail
	 *            생략 문자열. 예) "..."
	 * @return String
	 */
	public static String cropByte(String str, int i, String trail) {
		if (str == null)
			return "";
		String tmp = str;
		int slen = 0, blen = 0;
		char c;
		try {
			// if(tmp.getBytes("MS949").length>i) {//2-byte character..
			if (tmp.getBytes("UTF-8").length > i) {// 3-byte character..
				while (blen + 1 < i) {
					c = tmp.charAt(slen);
					blen++;
					slen++;
					if (c > 127)
						blen++;
				}
				tmp = tmp.substring(0, slen) + trail;
			}
		} catch (Exception e) {
		}
		return tmp;
	}
	/**
	 * Method cropByte. 문자열 라인수만큼 끊어주고, 생략표시하기
	 * 
	 * @param str
	 *            문자열
	 * @param i
	 *            바이트수
	 * @param trail
	 *            생략 문자열. 예) "..."
	 * @return String
	 */
	public static String cropLine(String str, int i, String trail,int line) {
		if (str == null)
			return "";
		String tmp = str;
		int slen = 0, blen = 0;
		char c;
		try {
			// if(tmp.getBytes("MS949").length>i) {//2-byte character..
			if (tmp.getBytes("UTF-8").length > i) {// 3-byte character..
				while (blen + 1 < i) {
					c = tmp.charAt(slen);
					blen++;
					slen++;
					if (c > 127)
						blen++;
				}
				tmp = tmp.substring(0, slen) + trail;
				String[] arrStr = tmp.split("<BR>");
				if(arrStr.length > line ){
					StringBuffer buf = new StringBuffer();
					for(int j=0 ; j < line ;j++){
						buf.append(arrStr[j]);
					}
					tmp = buf.toString();
				}
			}
		} catch (Exception e) {
		}
		return tmp;
	}

	/**
	 * DB에 저장된 enter key값을 <br>
	 * 로 변환한다.
	 * 
	 * @param String
	 * @return String
	 */
	public static String convertHtmlBr(String comment) {
		if (comment == null)
			return "";
		int length = comment.length();
		StringBuffer sb = new StringBuffer();

		for (int i = 0; i < length; ++i) {
			String comp = comment.substring(i, i + 1);
			if ("\r".compareTo(comp) == 0) {
				comp = comment.substring(++i, i + 1);
				if ("\n".compareTo(comp) == 0)
					sb.append("<BR>");
				else
					sb.append("\r");
			}
			sb.append(comp);
		}
		return sb.toString();

	}
	/**
	 * DB에 저장된 enter key값을 <br>
	 * 로 변환한다.
	 * 
	 * @param String
	 * @return String
	 */
	public static String convertHtmlBr(String comment,String preFix) {
		if (comment == null)
			return "";
		int length = comment.length();
		StringBuffer sb = new StringBuffer();
		sb.append(preFix);

		for (int i = 0; i < length; ++i) {
			String comp = comment.substring(i, i + 1);
			if ("\r".compareTo(comp) == 0) {
				comp = comment.substring(++i, i + 1);
				if ("\n".compareTo(comp) == 0){
					sb.append("<BR>");
					sb.append(preFix);
				}else{
					sb.append("\r");
					sb.append(preFix);
				}
			}
			sb.append(comp);
		}
		return sb.toString();

	}

	/**
	 * 각 인덱스의 문자가 소문자라면 대문자로 변환
	 * 
	 * @param str
	 *            문자열
	 * @return String
	 */
	public static String bigLetter(String str) {
		// String tmp = str;
		String convertStr = "";
		char[] charArray = str.toCharArray(); // Char[]로 변환

		for (int i = 0; i < str.length(); i++) {
			// System.out.println("Char["+i+"] = "+charArray[i]); //변환된 Char 출력
			if ((charArray[i] >= 97) && (charArray[i] <= 122)) {
				charArray[i] -= 32; // 각 인덱스의 문자가 소문자라면 대문자로 변환
				convertStr += charArray[i];
			}
		}

		return convertStr;
	}

	/**
	 * 각 인덱스의 문자가 대문자라면 소문자로 변환
	 * 
	 * @param str
	 *            문자열
	 * @return String
	 */
	public static String smallLetter(String str) {
		// String tmp = str;
		String convertStr = "";
		char[] charArray = str.toCharArray(); // Char[]로 변환

		for (int i = 0; i < str.length(); i++) {
			// System.out.println("Char["+i+"] = "+charArray[i]); //변환된 Char 출력
			if ((charArray[i] >= 65) && (charArray[i] <= 90)) {
				charArray[i] += 32; // 각 인덱스의 문자가 대문자라면 소문자로 변환
				convertStr += charArray[i];
			} else {
				convertStr += charArray[i];
			}
		}

		return convertStr;
	}
	
	/**
	 * 파라미터값을 체크 
	 * 한글이 넘어오면 URLEncoder
	 * @param str
	 *            변환할 문자
	 * @return String 변환문자
	 */
	public static String paramCheck(String str) {
		String tmp = new String("");
		if (str == null || str.length() == 0)
			return "";
		try {
			// 첫번째 문자값을 읽음..
	        int i = str != null && str.length() > 0 ? str.charAt(0) : -1;
	        // 만일 164(%A4)이상 200(%C8)이하라면 iso-8859-1로 인코딩 한것이므로,

	        // 이때는 다시 인코딩을 조정한다.
	        str = str != null ? (i >= 164 && i <= 200 ? new String (str.getBytes("iso-8859-1"), "euc-kr") : str) : null;

	        //tmp = URLEncoder.encode(str);
	        tmp = URLEncoder.encode(str, "euc-kr");
	        
		} catch (Exception e) {

		}
		return tmp;
	}
	
	

	/**
	 * getParameterMap() 으로 받은 파라미터를 HashMap으로 치환
	 * 
	 * @version
	 * @param Map
	 *            requestMap
	 * @return HashMap hm
	 * @throws Exception
	 * 
	 */
	public static Map paramsToHashMap(Map requestMap) throws Exception {
		HashMap hm = new HashMap();

		try {
			Iterator it = requestMap.keySet().iterator();
			Object key = null;
			String[] value = null;

			while (it.hasNext()) {
				key = it.next();
				value = (String[]) requestMap.get(key);

				for (int i = 0; i < value.length; i++) {
					hm.put(key, value[i].toString());
				}
			}
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		return hm;
	}

	/**
	 * getParameterMap() 으로 받은 파라미터를 QueryString으로 치환
	 *
	 * @version
	 * @param Map
	 *            requestMap
	 * @return String (a=1&b=2&c=3....)
	 * @throws Exception
	 *
	 */
	public static String paramsToQueryString(Map requestMap)
			throws Exception {
		StringBuffer sp = new StringBuffer();
		int loopCnt = 0;

		try {
			Iterator it = requestMap.keySet().iterator();
			Object key = null;
			String[] value = null;

			while (it.hasNext()) {
				key = it.next();
				value = (String[]) requestMap.get(key);

				for (int i = 0; i < value.length; i++) {
					if (loopCnt > 0){
						sp.append("&");
					}
					sp.append(key.toString() + "=" + value[i].toString());
				}

				loopCnt++;
			}
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		return sp.toString();
	}

	/**
	 * getParameterMap() 으로 받은 파라미터를 hidden tag로 변환된 String으로리턴
	 *
	 * @version
	 * @param Map
	 *            requestMap
	 * @return String (<input type='hidden' name='' value=''>)
	 * @throws Exception
	 *
	 */
	public static String paramsToQueryStringHiddenTag(Map requestMap)
			throws Exception {
		StringBuffer sp = new StringBuffer();
		int loopCnt = 0;

		try {
			Iterator it = requestMap.keySet().iterator();
			Object key = null;
			String[] value = null;

			while (it.hasNext()) {
				key = it.next();
				value = (String[]) requestMap.get(key);

				for (int i = 0; i < value.length; i++) {

					sp.append("<input type='hidden' name='");
					sp.append(key.toString());
					sp.append("' ");

					sp.append("value='");
					sp.append(value[i].toString());
					sp.append("'>");
				}

			}
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		return sp.toString();
	}

	/**
	 * getParameterMap() 으로 받은 파라미터를 QueryString으로 치환 cmd포함
	 * 
	 * @version
	 * @param Map
	 *            requestMap
	 * @return String (a=1&b=2&c=3....)
	 * @throws Exception
	 * 
	 */
	public static String paramsToQueryStringWithCmd(Map requestMap)
			throws Exception {
		StringBuffer sp = new StringBuffer();
		int loopCnt = 0;

		try {
			Iterator it = requestMap.keySet().iterator();
			Object key = null;
			String[] value = null;

			while (it.hasNext()) {
				key = it.next();
				value = (String[]) requestMap.get(key);

				for (int i = 0; i < value.length; i++) {
					if (loopCnt > 0)
						sp.append("&");
					sp.append(key.toString() + "=" + paramCheck(value[i].toString()));
					//sp.append(key.toString() + "=" + convEUCKR(value[i].toString()));
				}

				loopCnt++;
			}
		} catch (Exception e) {
			throw new Exception(e.toString());
		}

		return sp.toString();
	}

	/**
	 * 문자열을 토큰으로 구분해서 1차원 배열로 리턴한다.
	 * 
	 * @param s -
	 *            토큰을 가진 문자열
	 * @param token -
	 *            구분자
	 * @return 구분자로 분리된 1차원배열
	 */
	public static String[] cutTokenToArray(String s, String token) {
		StringTokenizer stz = new StringTokenizer(s, token);
		String result[] = new String[stz.countTokens()];
		try {
			for (int j = 0; j < result.length; j++)
				result[j] = stz.nextToken();
		} catch (Exception exception) {
		}
		return result;
	}

	/**
	 * XML 구조로 String 생성
	 * 
	 * @param List
	 *            list
	 * @param String
	 *            formName
	 * @param String
	 *            targetName
	 * @return String
	 */
	public String processXML(List list, String formName, String targetName,
			String strSelectValue) {
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n");
		sb.append("<cbo-list>\n");
		sb.append("<selectChoice>\n");
		sb.append("<selectElement>\n");
		sb.append("<formName>" + formName + "</formName>\n");
		sb.append("<targetName>" + targetName + "</targetName>\n");
		if (strSelectValue.equals("")) {
			sb.append("<strSelectValue>empty</strSelectValue>\n");
		} else {
			sb.append("<strSelectValue>" + strSelectValue
					+ "</strSelectValue>\n");
		}
		sb.append("</selectElement>\n");
		sb.append("</selectChoice>\n");
		
		if(list != null){
			for (int i = 0; i < list.size(); i++) {
				Map map = (Map) list.get(i);
				sb.append("<cbo>\n");
				sb.append("<code>" + map.get("CODE").toString() + "</code>\n");
				sb.append("<value>" + map.get("VALUE").toString() + "</value>\n");
				sb.append("</cbo>\n");
			}
		}
		sb.append("</cbo-list>");
		// System.out.println(sb.toString());
		return sb.toString();
	}
	
    /**
     * XML 구조로 String 생성 
     * @param List list
     * @param String formName
     * @param String targetName
     * @param String codeColName		:	code 데이터가 들어있는 컬럼명 
     * @param String textColName	:	text가 들어있는 컬럼
     * @return  String
     */
	public String processXML(List list, String formName, String targetName, String strSelectValue, String codeColName, String textColName){
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n");
	    sb.append("<cbo-list>\n");
	    sb.append("<selectChoice>\n");
	    sb.append("<selectElement>\n");
	    sb.append("<formName>"+formName+"</formName>\n");
	    sb.append("<targetName>"+targetName+"</targetName>\n");
	    if(strSelectValue.equals("")){
	    	sb.append("<strSelectValue>empty</strSelectValue>\n");
	    }else{
	    	sb.append("<strSelectValue>"+strSelectValue+"</strSelectValue>\n");
	    }
	    sb.append("</selectElement>\n");
	    sb.append("</selectChoice>\n");
    
	    for(int i=0;i<list.size();i++){
	    	Map map = (Map)list.get(i);
	    	sb.append("<cbo>\n");
	    	sb.append("<code>"+map.get(codeColName).toString()+"</code>\n");
	    	sb.append("<value>"+StringUtil.convKorObj(map.get(textColName))+"</value>\n");
	    	sb.append("</cbo>\n");
	    }
	    sb.append("</cbo-list>");
	    return sb.toString();
	}	
	
	/**
	 * XML 구조로 String 생성
	 * 
	 * @param List
	 *            list
	 * @param String
	 *            formName
	 * @param String
	 *            targetName
	 * @return String
	 */
	public String riaXML(List list, String category){
		StringBuffer sb = new StringBuffer();
		sb.append("<?xml version=\"1.0\" encoding=\"euc-kr\"?>\n");
		sb.append("<result>\n");
		sb.append("<"+category+">\n");
		for(int i=0;i<list.size();i++){
			Map map = (Map)list.get(i);
			sb.append("<item name=\""+map.get("NAME").toString()+"\" code=\""+map.get("CODE").toString()+"\"/>\n");
		}
		sb.append("</"+category+">\n");
		sb.append("</result>\n");
//		System.out.println(sb.toString());
		return sb.toString();
	}
	
	
	/**
	 * 휴대폰번호국번을 배열로 리턴
	 * 
	 * @return 구분자로 분리된 1차원배열
	 */
	public static String[] getMobileNo() {
		String mobileNo = "010,011,016,017,018,019";

		return mobileNo.split(",");
	}

	/**
	 * 일반전화국번을 배열로 리턴
	 * 
	 * @return 구분자로 분리된 1차원배열
	 */
	public static String[] getTelNo() {
		String telNo = "02,031,032,033,041,042,043,051,052,053,054,055,061,062,063,064";

		return telNo.split(",");
	}

	/**
	 * Email 한글리스트를 배열로 리턴
	 * 
	 * @return 구분자로 분리된 1차원배열
	 */
	public static String[] getEmailKor() {
		String emailAddr = "야후,한메일,한미르,라이코스,코리아닷컴,네이버,핫메일,하나포스,네띠앙,엠파스,프리첼,오르지오,네이트,파란,인티즌,기타(직접입력)";

		return emailAddr.split(",");
	}

	/**
	 * Email 영문리스트를 배열로 리턴
	 * 
	 * @return 구분자로 분리된 1차원배열
	 */
	public static String[] getEmailEng() {
		String emailAddr = "yahoo.co.kr,hanmail.net,hanmir.com,lycos.co.kr,korea.com,naver.com,hotmail.com,hanafos.co.kr,netian.com,empal.com,freechal.com,orgio.net,nate.com,paran.com,intizen.com,99";

		return emailAddr.split(",");
	}
	
	/**
	 * Email 영문리스트를 배열로 리턴
	 * 
	 * @return 구분자로 분리된 1차원배열
	 */
	public static String[] getEmail() {
		String emailAddr = "yahoo.co.kr/야후,hanmail.net/한메일,hanmir.com/한미르,lycos.co.kr/라이코스,korea.com/코리아닷컴,naver.com/네이버" +
				",hotmail.com/핫메일,hanafos.co.kr/하나포스,netian.com/네띠앙,empal.com/엠파스,freechal.com/프리첼" +
				",orgio.net/오르지오,nate.com/네이트,paran.com/파란,intizen.com/인티즌,99/기타(직접입력)";

		return emailAddr.split(",");
	}
	
	/**
	 * 가격을 ###,###,###,### 형태로 리턴(int형)
	 * 
	 * @return ###,###,###,### 형태의 String
	 */
	public static String comma1(int aa) {
		DecimalFormat fmt1 = new DecimalFormat("###,###,###,###");
		String str = fmt1.format(aa);
		return str;
	}
	
	/**
	 * 가격을 만원단위로 변환
	 * 
	 * @return ###,###,###,### 형태의 String
	 */
	public static String comma2(int aa) {
		return comma1(Math.round(aa / 10000));
	}
	
	/**
	 * 가격을 ###,###,###,### 형태로 리턴(long형)
	 * 
	 * @return ###,###,###,### 형태의 String
	 */
	public static String comma3(long aa) {
		DecimalFormat fmt1 = new DecimalFormat("###,###,###,###");
		String str = fmt1.format(aa);
		return str;
	}
	
    /**
     * 숫자형 String의 포멧을  변형한다
     * ###,### 의 형태 <==> #####
     * @param numStr
     * @return
     */
	public static String convNumStrFormat(String numStr)	
    {
	    if(numStr == null || "".equals(numStr))
        {
	        return "0";
        }
        
        long numInt;
        
        try
        {
            numInt = Long.parseLong(numStr);
        }
        catch(NumberFormatException  ne)
        {
            String newNumStr = numStr.replace(",", "");
            return newNumStr;
        }
        
        DecimalFormat dfmt = new DecimalFormat("###,##0");
        String retunStr = dfmt.format(numInt);

        return retunStr;
    }
	
	/**
	 * 파일이 서버에 실제로 있는지 확인 유무 후 이미지 소스를 리턴
	 * 
	 * @param String
	 *            imgPathKey
	 * @param String
	 *            fileName DB에서 가져오는 파일 네임(null 제외)
	 * @param String
	 *            noImg 서버에 실제 파일이 없을 경우 리턴될 노이미지
	 * @return String 
	 * 				이미지 소스
	 * @sample StringUtil.imgSrcCheck(imgPathKey, "fileName","noImg"  )
	 */
	public static String imgSrcCheck(String imgPathKey, String fileName, String noImg) {

		ResourceBundle rb = ResourceBundle.getBundle("com/lgfs/properties/system"); 
		
		String imgUpPath = rb.getString(imgPathKey);			//업로드 이미지 path
		String imgViewPath = rb.getString(imgPathKey+"_view");  	//view 이미지 path

		if(imgPathKey.equals("productPath"))
		{
			imgUpPath = imgUpPath + fileName.substring(0,2) +System.getProperty("file.separator");
			imgViewPath =  imgViewPath + fileName.substring(0,2) +"/";
		}
		String imgSrc = "";		
		String[] imgTokens = StringUtil.strSplit(fileName, "/");		
		
		if(imgViewPath == null || "".equals(imgViewPath)){
			imgSrc = noImg;
		}else{
			if(imgTokens.length > 1){
				imgViewPath += imgTokens[imgTokens.length - 2] + "/";
				fileName = imgTokens[imgTokens.length -1];
			}
			
			File dir = new File(imgUpPath);
			if (!dir.exists() || !dir.isDirectory()) {
				imgSrc = noImg;
	        }else{
	        	File aFile = new File(imgUpPath,fileName);
				
				if (!aFile.exists()) {
					imgSrc = noImg;
				} else {
					imgSrc = imgViewPath + fileName;
				}
	        }			
			
		}
		
		//임시로 파일을 보기 위해서 처리 해놨음. 테스트 이후 삭제해야함.
		//imgSrc = imgViewPath + fileName;
		
		return imgSrc;
	}
	
	
	/**
	 * 파일이 서버에 실제로 있는지 확인 유무 리턴
	 * 
	 * @param String
	 *            imgPathKey
	 * @param String
	 *            fileName DB에서 가져오는 파일 네임(null 제외)
	 * @return boolean 
	 * 				Y/N
	 * @sample StringUtil.imgSrcCheck(imgPathKey, "fileName" )
	 */
	public static boolean imgSrcCheckYn(String imgPathKey, String fileName) {

		ResourceBundle rb = ResourceBundle.getBundle("com/lgfs/properties/system"); 
		
		String imgUpPath = rb.getString(imgPathKey);			//업로드 이미지 path
		String imgViewPath = rb.getString(imgPathKey+"_view");  	//view 이미지 path
		
		if(imgPathKey.equals("productPath"))
		{
			imgUpPath = imgUpPath + fileName.substring(0,2) +System.getProperty("file.separator");
			imgViewPath =  imgViewPath + fileName.substring(0,2) +"/";
		}		
		
		boolean isTrue = false;		
		String[] imgTokens = StringUtil.strSplit(fileName, "/");		
		
		if(imgViewPath == null || "".equals(imgViewPath)){
			isTrue = false;		
		}else{
			if(imgTokens.length > 1){
				imgViewPath += imgTokens[imgTokens.length - 2] + "/";
				fileName = imgTokens[imgTokens.length -1];
			}
			
			File dir = new File(imgUpPath);
			if (!dir.exists() || !dir.isDirectory()) {
				isTrue = false;		
	        }else{
	        	File aFile = new File(imgUpPath,fileName);
				
				if (!aFile.exists()) {
					isTrue = false;		
				} else {
					isTrue = true;		
				}
	        }
			
			//임시로 파일을 보기 위해서 처리 해놨음. 테스트 이후 삭제해야함.
			//isTrue = true;
			
		}
		
		return isTrue;
	}
	
	
	/**
	 * 파일 Path별 이미지 Max사이즈 
	 * 
	 * @param String
	 *            imgPathKey
	 * @return String 
	 * 				MaxSize
	 * @sample StringUtil.getImgMaxSize(imgPathKey)
	 */
	public static String getImgMaxSize(String imgPathKey) {

		ResourceBundle rb = ResourceBundle.getBundle("com/lgfs/properties/system"); 
		
		String maxSize = rb.getString(imgPathKey+"_maxSize");
		
		return maxSize;
	}
	
	/**
	 * 특수 문자 제거
	 * 
	 * @param String str
	 * @return String str
	 * @sample StringUtil.StringReplace(str)
	 */
	public static String StringReplace(String str){
	    String str_imsi   = ""; 
	    String[] filter_word = {" ","\\.","\\?","\\/","\\~","\\!","\\@","\\#","\\$","\\%","\\^","\\&","\\*","\\(","\\)","\\_","\\+","\\=","\\|","\\}","\\]","\\{","\\[","\\\"","\\'","\\:","\\;","\\<","\\,","\\>"};
	
	    for(int i=0;i<filter_word.length;i++){
	        str_imsi = str.replaceAll(filter_word[i],"");
	        str = str_imsi;
	    }
	
	    return str;
	}
    
    /**
     * nl을 제거한다
     * @param str
     * @return
     */
    public static String removeNl(Object obj)
    {
        String str ="";
        
        if (obj==null)
            str = "";
        str = obj.toString();

        String str_imsi   = ""; 
        String[] filter_word = {"\n","\r\n"};
        
        for(int i=0;i<filter_word.length;i++){
            str_imsi = str.replace("\r\n"," ");
            str_imsi = str_imsi.replace("\n"," ");
            str = str_imsi;
        }
        return str;        
    }
	
    /**
     * nl을 제거한다
     * @param str
     * @return
     */
    public static String removeNl(Object obj,String resultStr)
    {
        String str ="";
        
        if (obj==null)
            str = "";
        str = obj.toString();

        String str_imsi   = ""; 
        String[] filter_word = {"\n","\r\n"};
        
        for(int i=0;i<filter_word.length;i++){
            str_imsi = str.replace("\r\n", resultStr);
            str_imsi = str_imsi.replace("\n", resultStr);
            str = str_imsi;
        }
        return str;        
    }    
    /**
     * 개행시 입력문자 삽입
     * @param str
     * @return
     */
    public static String addStartLine(Object obj,String addStr)
    {
        String str ="";
        
        if (obj==null)
            str = "";
        str = obj.toString();

        StringBuffer buf = new StringBuffer();
        String[] ary = str.split("\n");
        for(int i=0;i<ary.length;i++){
        	buf.append(addStr + ary[i] +"\n");
        }
        return buf.toString();        
    }    
    
    
	/**
	 * 입력 문자열에서 시작 regax와 끝나는 regax 사이의 문자열을 ArrayList로 리턴한다.
	 * @since 2007.12.06 
	 * @author 신준호
	 * @param inputStr	: 대상 문자열
	 * @param startRegax :시작 구분자
	 * @param endRegax	: 종료 구분자
	 * @return
	 */
	public  static List getSplit(String inputStr, String startRegax, String endRegax)
	{
		List returnList  = new ArrayList();
		String targetStr = inputStr;
		
		while(targetStr.indexOf(startRegax)>-1)
		{
			returnList.add( targetStr.substring(targetStr.indexOf(startRegax)+startRegax.length(), targetStr.indexOf(endRegax)));		
			targetStr = targetStr.substring(targetStr.indexOf(endRegax)+endRegax.length());
		}
		return returnList;
	}
    
    /**
     * dataset에 있는 파일정보를 이용하여 ActiveX에서 test.txt/test_1061475974.txt/2001/1/FALSE|test.txt/test_1061475974.txt/2001/1/FALSE정보를 만든다
     * @since 2008.07.14
     * @param fileList 파일 정보 리스트
     * @return string 파일정보
     */
    public static String getConvertFileInfo(List fileList)
    {
        StringBuffer fileStr = new StringBuffer();
        
        for(int i=0; i< fileList.size(); i++)
        {
            if( i !=0 )
                fileStr.append("|");
                        
            Map fileMap = (Map)fileList.get(i);
            fileStr.append(fileMap.get("VCFILENAME")+"/");  //파일 네임
            fileStr.append(fileMap.get("VCFILEPATH")+"/");   //파일 정보
            fileStr.append(fileMap.get("IFILESIZE")+"/");       //파일 사이즈
            fileStr.append(fileMap.get("IREFKEY1")+"/");           //필드 아이디
            fileStr.append("FALSE");                                    //적용 여부
        }
        return fileStr.toString();
    }
    
    /**
     * 정렬 String 을 받아서 다음 값을 만들어 리턴한다. 
     * @param orderStr 순서String
     * @return
     */
    public static String getNextOrderStr(String orderStr)
    { 
        int lastDotIndex =  orderStr.lastIndexOf(".");
        
        String parentOrdStr = orderStr.substring(0, lastDotIndex+1);
        String ordStr = orderStr.substring(lastDotIndex+1);
        
        int ordInt = Integer.parseInt(ordStr);
        ordInt += 1;
        String nextOrdStr = String.valueOf(ordInt);
        
        while(nextOrdStr.length()<4)
        {
            nextOrdStr = "0"+nextOrdStr;
        }
        
        String returnStr = parentOrdStr + nextOrdStr;
        
        return returnStr;
    }
	
    /**
     * 리소스 번들의 값을 리턴한다.
     * @param rbKey
     * @return
     */
    public static String getRBValue(String rbKey) {

        ResourceBundle rb = ResourceBundle.getBundle("pmex/properties/system"); 
        
       return rb.getString(rbKey);      

    }
    
    /**
	 * 주민등록번호 또는 사업자번호에 '-'를 첨가
	 * 
	 * @param str
	 * @return 주민등록번호 또는 사업자번호에 '-'를 첨가된 String
	 */
	public static String convRegnNo(String str) {

		try{
			String temp = "";
			int len = str.length();
			if ((len != 13) && (len !=10)){
				return str;
			}
			// 사업자번호
			StringBuffer sbTmp = new StringBuffer();
			if(len == 10){
				sbTmp.append(str.substring(0,3));
				sbTmp.append("-");
				sbTmp.append(str.substring(3,5));
				sbTmp.append("-");
				sbTmp.append(str.substring(5,10));
				//return temp = str.substring(0,3) + "-"+ str.substring(3,5) + "-"+ str.substring(5,10);
				return sbTmp.toString();
			}else if( len ==13 && (str.startsWith("000"))) {
				sbTmp.append(str.substring(3,6));
				sbTmp.append("-");
				sbTmp.append(str.substring(6,8));
				sbTmp.append("-");
				sbTmp.append(str.substring(8,13));
				//return temp = str.substring(3,6) + "-"+ str.substring(6,8) + "-"+ str.substring(8,13);
				return sbTmp.toString();
			}else if( len ==16 ) {
				sbTmp.append(str.substring(0,4));
				sbTmp.append("-");
				sbTmp.append(str.substring(4,8));
				sbTmp.append("-");
				sbTmp.append(str.substring(8,12));
				sbTmp.append("-");
				sbTmp.append(str.substring(12,16));
				//return temp = str.substring(3,6) + "-"+ str.substring(6,8) + "-"+ str.substring(8,13);
				return sbTmp.toString();				
			}else{
				sbTmp.append(str.substring(0,6));
				sbTmp.append("-");
				sbTmp.append(str.substring(6,13));
				//return temp = str.substring(0,6) + "-" + str.substring(6,13);
				return sbTmp.toString();
			}
		} catch(Exception ex){
			return "";
		}
	}
	
	
    /**
	 * 카드번호에 '-'를 첨가
	 * 
	 * @param str
	 * @return 카드번호에 '-'를 첨가된 String
	 */
	public static String convCardNo(String str) {

		try{
			String temp = "";
			int len = str.length();
			if (len != 16){
				return str;
			}
			// 카드번호
			StringBuffer sbTmp = new StringBuffer();
			if( len ==16 ) {
				sbTmp.append(str.substring(0,4));
				sbTmp.append("-");
				sbTmp.append(str.substring(4,8));
				sbTmp.append("-");
				sbTmp.append(str.substring(8,12));
				sbTmp.append("-");
				sbTmp.append(str.substring(12,16));
				//return temp = str.substring(3,6) + "-"+ str.substring(6,8) + "-"+ str.substring(8,13);
				return sbTmp.toString();				
			}else{
				sbTmp.append(str.substring(0,6));
				sbTmp.append("-");
				sbTmp.append(str.substring(6,13));
				//return temp = str.substring(0,6) + "-" + str.substring(6,13);
				return sbTmp.toString();
			}
		} catch(Exception ex){
			return "";
		}
	}
	
	/**
     * from apache commons
     * @param text
     * @param searchList
     * @param replacementList
     * @param repeat
     * @param timeToLive
     * @return
     */
    private static String replaceEach(String text, String[] searchList, String[] replacementList, 
            boolean repeat, int timeToLive) 
	{
	
    	// mchyzer Performance note: This creates very few new objects (one major goal)
    	// let me know if there are performance requests, we can create a harness to measure
	
		if (text == null || text.length() == 0 || searchList == null || 
				searchList.length == 0 || replacementList == null || replacementList.length == 0) 
		{
			return text;
		}
	
		// if recursing, this shouldnt be less than 0
		if (timeToLive < 0) {
			throw new IllegalStateException("TimeToLive of " + timeToLive + " is less than 0: " + text);
		}
		
		int searchLength = searchList.length;
		int replacementLength = replacementList.length;
		
		// make sure lengths are ok, these need to be equal
		if (searchLength != replacementLength) 
		{
			throw new IllegalArgumentException("Search and Replace array lengths don't match: "
					+ searchLength
					+ " vs "
					+ replacementLength);
		}
		
		// keep track of which still have matches
		boolean[] noMoreMatchesForReplIndex = new boolean[searchLength];
		
		// index on index that the match was found
		int textIndex = -1;
		int replKTDreamSchoolndex = -1;
		int tempIndex = -1;
		
		// index of replace array that will replace the search string found
		// NOTE: logic duplicated below START
		for (int i = 0; i < searchLength; i++) {
			if (noMoreMatchesForReplIndex[i] || searchList[i] == null || 
				searchList[i].length() == 0 || replacementList[i] == null) 
			{
				continue;
			}
			tempIndex = text.indexOf(searchList[i]);
		
			// see if we need to keep searching for this
			if (tempIndex == -1) {
				noMoreMatchesForReplIndex[i] = true;
			} else {
				if (textIndex == -1 || tempIndex < textIndex) {
					textIndex = tempIndex;
					replKTDreamSchoolndex = i;
				}
			}
		}
		// NOTE: logic mostly below END
		
		// no search strings found, we are done
		if (textIndex == -1) {
			return text;
		}
		
		int start = 0;
		
		// get a good guess on the size of the result buffer so it doesnt have to double if it goes over a bit
		int increase = 0;
		
		// count the replacement text elements that are larger than their corresponding text being replaced
		for (int i = 0; i < searchList.length; i++) {
			if (searchList[i] == null || replacementList[i] == null) {
				continue;
			}
			int greater = replacementList[i].length() - searchList[i].length();
			if (greater > 0) {
				increase += 3 * greater; // assume 3 matches
			}
		}
		// have upper-bound at 20% increase, then let Java take over
		increase = Math.min(increase, text.length() / 5);
		
		StringBuffer buf = new StringBuffer(text.length() + increase);
		
		while (textIndex != -1) {
		
			for (int i = start; i < textIndex; i++) {
				buf.append(text.charAt(i));
			}
			buf.append(replacementList[replKTDreamSchoolndex]);
		
			start = textIndex + searchList[replKTDreamSchoolndex].length();
		
			textIndex = -1;
			replKTDreamSchoolndex = -1;
			tempIndex = -1;
			// find the next earliest match
			// NOTE: logic mostly duplicated above START
			for (int i = 0; i < searchLength; i++) {
				if (noMoreMatchesForReplIndex[i] || searchList[i] == null || 
						searchList[i].length() == 0 || replacementList[i] == null) 
				{
					continue;
				}
				tempIndex = text.indexOf(searchList[i], start);
		
				// see if we need to keep searching for this
				if (tempIndex == -1) {
					noMoreMatchesForReplIndex[i] = true;
				} else {
					if (textIndex == -1 || tempIndex < textIndex) {
						textIndex = tempIndex;
						replKTDreamSchoolndex = i;
					}
				}
			}
		// NOTE: logic duplicated above END
		
		}
		int textLength = text.length();
		for (int i = start; i < textLength; i++) {
			buf.append(text.charAt(i));
		}
		String result = buf.toString();
		if (!repeat) {
			return result;
		}
		
		return replaceEach(result, searchList, replacementList, repeat, timeToLive - 1);
	}
    
    /**
     * from apache commons
     * <p>
     * Replaces all occurrences of Strings within another String.
     * </p>
     * 
     * <p>
     * A <code>null</code> reference passed to this method is a no-op, or if
     * any "search string" or "string to replace" is null, that replace will be
     * ignored. This will not repeat. For repeating replaces, call the
     * overloaded method.
     * </p>
     * 
     * <pre>
     *  StringUtils.replaceEach(null, *, *)        = null
     *  StringUtils.replaceEach("", *, *)          = ""
     *  StringUtils.replaceEach("aba", null, null) = "aba"
     *  StringUtils.replaceEach("aba", new String[0], null) = "aba"
     *  StringUtils.replaceEach("aba", null, new String[0]) = "aba"
     *  StringUtils.replaceEach("aba", new String[]{"a"}, null)  = "aba"
     *  StringUtils.replaceEach("aba", new String[]{"a"}, new String[]{""})  = "b"
     *  StringUtils.replaceEach("aba", new String[]{null}, new String[]{"a"})  = "aba"
     *  StringUtils.replaceEach("abcde", new String[]{"ab", "d"}, new String[]{"w", "t"})  = "wcte"
     *  (example of how it does not repeat)
     *  StringUtils.replaceEach("abcde", new String[]{"ab", "d"}, new String[]{"d", "t"})  = "dcte"
     * </pre>
     * 
     * @param text
     *            text to search and replace in, no-op if null
     * @param searchList
     *            the Strings to search for, no-op if null
     * @param replacementList
     *            the Strings to replace them with, no-op if null
     * @return the text with any replacements processed, <code>null</code> if
     *         null String input
     * @throws IndexOutOfBoundsException
     *             if the lengths of the arrays are not the same (null is ok,
     *             and/or size 0)
     * @since 2.4
     */
    public static String replaceEach(String text, String[] searchList, String[] replacementList) {
        return replaceEach(text, searchList, replacementList, false, 0);
    }
    
    /**
     * 필터링 된 값을 해제 한다.
     * 입력된 문자열이 null일 경우 사용한다 
     * @param text
     * @return
     */
    public static String fillteringClear(String text)
    {
    	String[] replacementList = {"&", " ", "\"", "'", "<", ">", "/"};
    	String[] searchList = {"&amp;", "&nbsp;", "&quot;", "&apos;", "&lt;", "&gt;", "&frasl;"};
    	
    	text = convNull(text, "");
    	
    	return replaceEach(text, searchList, replacementList, false, 0);
    }


    /**
	 * escape를 통해 변환된 문자를 원래 상태로 복구한다.
	 * @param inp
	 * @return 복구된 문자 String
	 */
    public static String unescape(String inp) {
        StringBuffer rtnStr = new StringBuffer();
        char [] arrInp = inp.toCharArray();
        int i;
        for(i=0;i<arrInp.length;i++) {
            if(arrInp[i] == '%') {
                String hex;
                if(arrInp[i+1] == 'u') {    //유니코드.
                    hex = inp.substring(i+2, i+6);
                    i += 5;
                } else {    //ascii
                    hex = inp.substring(i+1, i+3);
                    i += 2;
                }
                try{
                    rtnStr.append(Character.toChars(Integer.parseInt(hex, 16)));
                } catch(NumberFormatException e) {
                 rtnStr.append("%");
                    i -= (hex.length()>2 ? 5 : 2);
                }
            } else {
             rtnStr.append(arrInp[i]);
            }
        }
     
        return rtnStr.toString();
    }
    
    
    //-------------------------------------------
	// 형변환 - 안종철
	//-------------------------------------------
	/**
	 * int를 String로 변환 
	 * @param num 변환할 int
	 * @return 변환된 문자열
	 */
	public static String toString(int num){
		return toString(num, "");
	}
	/**
	 * int를 String로 변환 
	 * @param num 변환할 int
	 * @param defaultStr 기본값
	 * @return 변환된 문자열
	 */
	public static String toString(int num, String defaultStr){
		String str;
		try{
			str = Integer.toString(num);
		}catch(Exception e){
			str =defaultStr;
		}
		return str;
	}
	
	/**
	 * long를 String로 변환 
	 * @param num 변환할 long
	 * @return 변환된 문자열
	 */
	public static String toString(long num){
		return toString(num, "");
	}
	/**
	 * long를 String로 변환 
	 * @param num 변환할 long
	 * @param defaultStr 기본문자열
	 * @return 변환된 문자열
	 */
	public static String toString(long num, String defaultStr){
		String str;
		try{
			str = Long.toString(num);
		}catch(Exception e){
			str =defaultStr;
		}
		return str;
	}

	/**
	 * String를 String로 변환
	 * @param str 변환할 문자열
	 * @return
	 */
	public static String toString(String str){
		return toString(str, "");
	}
	/**
	 * String를 String로 변환
	 * @param str 변환문자
	 * @param defaultStr 기본문자열
	 * @return 변환된문자(null일경우 기본문자열반환)
	 */
	public static String toString(String str, String defaultStr){
		if(str == null)		return defaultStr;
		return str;
	}
	
	/**
	 * Object 를 String로 변환
	 * @param obj 변환할 Object
	 * @return 변환된 문자열
	 */
	public static String toString(Object obj){
		return toString(obj, "");
	}
	/**
	 * Object 를 String로 변환
	 * @param obj 변환할 Object
	 * @param defaultStr 기본값
	 * @return 변환된 문자열
	 */
	public static String toString(Object obj, String defaultStr){
		if(obj == null) return defaultStr;
		String str;
		try{
			if(obj instanceof Integer)
				str = Integer.toString((Integer)obj);
			else if(obj instanceof Long)
				str = Long.toString((Long)obj);
			else
				str = obj.toString();
		}catch(Exception e){
			str = defaultStr;
		}
		return str;
	}
	/**
	 * int를 01,02,03등으로 변환 
	 * @param num 변환 할 숫자 
	 * @return 변환된 문자열 형태의 정수 
	 */
	public static String toStringWithZero(int num){
		if(num < 0 )
			return "0";
		if(num < 10)
			return "0" + num;
		return toString(num);
	}
	
	/**
	 * 파일명변환 한글 인코딩 (ISO8859 -> KSC5601)
	 * @param strEn (ISO8859 코드의 문자열)
	 * @return (KSC5601로 인코딩된 문자열)
	 */
	public static String getEngToKoFileName(String strEn) {
		if ( strEn == null ) {
			return "";
		}
		try {
			return new String( strEn.getBytes( "8859_1" ), "KSC5601" );
		} catch ( Exception e ){
			return strEn;
		}
	}

	/**
	 * 한글 인코딩 (ISO8859 -> KSC5601)
	 * @param strKo (KSC5601 코드의 문자열)
	 * @return (ISO8859로 인코딩된 문자열)
	 */
	public static String getKoToEngFileName(String strKo) {
		if ( strKo == null ) {
			return "";
		}
		try {
			return new String( strKo.getBytes( "KSC5601" ), "8859_1" );
		}
		catch ( Exception e ) {
			return strKo;
		} 
	} 

}
