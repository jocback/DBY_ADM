package egovframework.MUSE_ADMIN.web;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActGroupManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_Rte.sym.log.wlg.service.EgovWebLogService;
import egovframework.MUSE_Rte.sym.log.wlg.service.WebLog;
import egovframework.MUSE_Rte.utl.fcc.service.EgovStringUtil;
import egovframework.MUSE_Rte.utl.sim.service.EgovClntInfo;
import egovframework.MUSE_Rte.utl.sim.service.EgovFileTool;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class ActCommonController {

	@Resource(name = "ActGroupManageService")
	private ActGroupManageService actGroupManageService;

    @Resource(name = "propertiesService")
    private EgovPropertyService propertyService;
    
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

	@Resource(name="EgovWebLogService")
	private EgovWebLogService webLogService;
	
	@Resource(name="ActStatManageService")
	private ActStatManageService actStatManageService;
	
	final String MENU_AUTH_REDIRECT = EgovProperties.getProperty("Globals.MenuAuthRedirect");

	public String convNull(String str, String def) {
		if (isNull(str))
			return def;
		return str;
	}
	public boolean isNull(String str) {
		return (str == null || str.trim().length() < 1);
	}
	//숫자인지 체크
	public static boolean isNumeric(String s) {
		try {
			Double.parseDouble(s);
			return true;
		}catch(NumberFormatException e) {
			return false;
		}
	}

	/**
	 * 체크할 숫자 중에서 숫자인지 아닌지 체크하는 기능
	 * 숫자이면 True, 아니면 False를 반환한다
	 * @param checkStr - 체크문자열
	 * @return 숫자여부
	 * @see
	 */
	public static Boolean numberValidCheck(String checkStr) {
		int i;
		//String sourceStr = String.valueOf(sourceInt);
		int checkStrLt = checkStr.length();
		for (i = 0; i < checkStrLt; i++) {
			// 아스키코드값( '0'-> 48, '9' -> 57)
			if (checkStr.charAt(i) > 47 && checkStr.charAt(i) < 58) {
				continue;
			} else {
				return false;
			}
		}
		return true;
	}

	/**
     * 이메일 체크.
     */
	public static boolean isEmail(String email) {
		if (email==null) return false;
		boolean b = Pattern.matches("[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+",email.trim());
		return b;
	} 

	@SuppressWarnings("static-access")
	public String getCurrMonthMath(String yr, String mn, int am){
		//특정월의 앞뒤 월 추출
		Calendar cal = Calendar.getInstance();
		cal.set (Integer.parseInt(yr), Integer.parseInt(mn) - 1, Integer.parseInt ("1"));
		cal.add(cal.MONTH, am);
		SimpleDateFormat mTime = new SimpleDateFormat ( "yyyyMM" );
		String monthMath = mTime.format(cal.getTime());
		return monthMath;
	}
	
	@SuppressWarnings("static-access")
	public String getCurrMonthMath(int am){
		//특정월의 앞뒤 월 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(cal.MONTH, am);
		SimpleDateFormat mTime = new SimpleDateFormat ( "yyyyMMdd" );
		String monthMath = mTime.format(cal.getTime());
		return monthMath;
	}
	
	public String getCurrYear(){
		//현재날짜 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat mTime = new SimpleDateFormat("yyyy");
		String currYear = mTime.format(cal.getTime());
		return currYear;
	}
	
	public String getCurrMonth(){
		//현재날짜 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat mTime = new SimpleDateFormat("MM");
		String currYear = mTime.format(cal.getTime());
		return currYear;
	}
	
	public static String getCurrDate(){
		//현재날짜 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat mTime = new SimpleDateFormat("yyyyMMdd");
		String currDate = mTime.format(cal.getTime());
		return currDate;
	}
	
	//시간리스트를 맵으로 반환한다.
	//getTimeList(시작시간, 종료시간, 분간격, 옵션:1;마지막시간분단위미포함 0;마지막시간분단위포함)
	public Map<String, String> getTimeList(Integer st, Integer et, Integer dt, Integer op){
		Map<String, String> map = new LinkedHashMap<String, String>();
		int subLoop = 60/dt;
		int min;
		String minStr = "";
		String hourStr = "";
		for(int i = st;i<=et-op;i++){
			for(int j = 0;j<subLoop;j++){
				min = dt*j;
				minStr = String.format("%02d", min);
				hourStr = String.format("%02d", i);
				map.put(hourStr+minStr, hourStr+":"+minStr);
			}
		}
		if(op == 1){
			map.put(String.format("%02d", et)+"00", String.format("%02d", et)+":00");
		}
		return map;
	}
	
	public String getCurrTime(){
		//현재날짜 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat mTime = new SimpleDateFormat("HHmm");
		String currTime = mTime.format(cal.getTime());
		return currTime;
	}
	
	public String getBefTime(){
		//현재날짜 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.MINUTE, -30);
		DateFormat mTime = new SimpleDateFormat("HHmm");
		String befTime = mTime.format(cal.getTime());
		return befTime;
	}
	
	public String getCurrDates(){
		//현재날짜 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat mTime = new SimpleDateFormat("yyyyMMddhhmmss a");
		String currTime = mTime.format(cal.getTime());
		return currTime;
	}
	public int getCurrWeek(){
		//현재요일 추출
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int dayNum = cal.get(Calendar.DAY_OF_WEEK);
		return dayNum;
	}
	public int getDateDay(String date) throws ParseException{
		DateFormat mTime = new SimpleDateFormat("yyyy-MM-dd");
		Date rDate = mTime.parse(date);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(rDate);
		
		int dayNum = cal.get(Calendar.DAY_OF_WEEK);
		
		return dayNum;
	}
	public static String addDateDay(String sDate, int year, int month, int day) {
		String dateStr = validChkDate(sDate);
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
		try {
			cal.setTime(sdf.parse(dateStr));
		} catch (ParseException e) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
		if (year != 0) {
			cal.add(Calendar.YEAR, year);
		}
		if (month != 0) {
			cal.add(Calendar.MONTH, month);
		}
		if (day != 0) {
			cal.add(Calendar.DATE, day);
		}
		return sdf.format(cal.getTime());
	}
	public static String validChkDate(String dateStr) {
		if (dateStr == null || !(dateStr.trim().length() == 8 || dateStr.trim().length() == 10)) {
			throw new IllegalArgumentException("Invalid date format: " + dateStr);
		}
		if (dateStr.length() == 10) {
			return EgovStringUtil.removeMinusChar(dateStr);
		}
		return dateStr;
	}

    //게시판의 확장필드는 쉼표로 구분하여 명칭:폼타입 으로 바인딩하여 입력한다.
    //예) 기간:input,공연정보:input,장소:input,동의:radio
	public Map<String, String> getExtMapList(String extFld){
		Map<String, String> map = new LinkedHashMap<String, String>();
		String[] extFldArr = extFld.split(",");
		for(int i = 0;i<extFldArr.length;i++){
			map.put(extFldArr[i].split(":")[0], extFldArr[i].split(":")[1]);
		}
		return map;
	}
	
	public String getCodeEtc(String codeId, String code, String field) throws Exception {
	    	ComDefaultCodeVO codeVo = new ComDefaultCodeVO();
			codeVo.setCodeId(codeId);
			codeVo.setCode(code);
			codeVo.setTableNm(field);
			return cmmUseService.commonCodeEtc1(codeVo);
	}
	
	public String getDateTransStr(String dt){
		//8자리 일자 데이터를 str 반환  20161022
		return dt.substring(0,4)+"년"+dt.substring(4,6)+"월"+dt.substring(6,8)+"일";
	}
	public static String getDateTransStrSp(String dt, String sp){
		//8자리 일자 데이터를 str 반환  20161022
		return dt.substring(0,4)+sp+dt.substring(4,6)+sp+dt.substring(6,8);
	}
	
	//두 날짜 사이의 일수
	public static int getDaysCnt(String sDate1, String sDate2) {
		String dateStr1 = validChkDate(sDate1);
		String dateStr2 = validChkDate(sDate2);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

		Date date1 = null;
		Date date2 = null;
		try {
			date1 = sdf.parse(dateStr1);
			date2 = sdf.parse(dateStr2);
		} catch (ParseException e) {
			throw new IllegalArgumentException("Invalid date format: args[0]=" + dateStr1 + " args[1]=" + dateStr2);
		}

		if (date1 != null && date2 != null) {
			int days1 = (int) ((date1.getTime() / 3600000) / 24);
			int days2 = (int) ((date2.getTime() / 3600000) / 24);
			return (days2+1) - days1;
		} else {
			return 0;
		}

	}

	protected boolean isMenuAuthCheck(String menuCode) throws Exception{
		webLogInsert(menuCode,0);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated){
			return false;
		}else{
			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			int authCnt = actGroupManageService.selectActAuthInfoOne(loginVO.getActGrIdx(),menuCode);
			if(authCnt > 0 || Integer.parseInt(loginVO.getGroupLvl()) > 19){
				return true;
			}else{
				return false;
			}
		}
	}
	
	protected void webLogInsert(String mncd,int dscMode) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebLog webLog = new WebLog();
		String reqURL = request.getRequestURI();
		String userId = "";
    	/* Authenticated  */
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated.booleanValue()) {
			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
			userId = user.getId();
    	}
    	String refDom = request.getHeader("referer");
    	refDom = unscript(refDom);
    	String refMthod = (request.getMethod());
    	String webMode = unscript(request.getParameter("webMode"));
    	//메뉴 클릭했을 경우만 기록
    	//webLogInser 메소드 직접 호출하여 dscMode를 1로 주었을 경우 기록
    	if((webMode != null && webMode.length() > 0) || dscMode == 1){
			try {
				webLog.setMenuCd(mncd);
				webLog.setUrl(reqURL);
				webLog.setBbsId(unscript(request.getParameter("bbsId")));
				webLog.setRqesterId(userId);
				webLog.setRqesterIp(request.getRemoteAddr());
				webLog.setClntOs(EgovClntInfo.getClntOsInfo(request));
				webLog.setClntWk(EgovClntInfo.getClntWebKind(request));
				webLog.setClntWv(EgovClntInfo.getClntWebVer(request));
				webLog.setRefDom(refDom);
				webLog.setRefMthod(refMthod);
				webLogService.logInsertWebLog(webLog);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
	}

	public String menuAuthIllegal(){
		return "/boffice/contents/redirect";
	}
	/**
     * 아작스 파일 업로드 시 이미지만 허용하기 위한 체크 메서드.
     * 
     * @param data
     * @return
     */
	@SuppressWarnings("rawtypes")
	public boolean checkImgUpLoadFile(final MultipartHttpServletRequest multiRequest, int ckMode) throws Exception {
		boolean returnV = true;
		Iterator fileIter = multiRequest.getFileNames();
		String regex = "^\\S+.(?i)(png|jpg|bmp|gif)$"; 
		String regexDoc = "^\\S+.(?i)(png|jpg|bmp|gif|hwp|doc|docx|xls|xlsx|ppt|pptx|txt|pdf|zip|alz)$"; 
		String regexBad = "^\\S+.(?i)(jsp|php|asp|html|htm|perl|exe|com)$";
		if(ckMode == 2){
			regex = regexDoc;
		}else if(ckMode == 3){
			regex = regexBad;
		}
		while (fileIter.hasNext()) {
			MultipartFile mFile = multiRequest.getFile((String)fileIter.next());
			if(!mFile.isEmpty()){
				String orginFileName = mFile.getOriginalFilename();
				orginFileName = orginFileName.toLowerCase();
				orginFileName = orginFileName.replace(" ", "");
				if(!matched(regex, orginFileName) && ckMode != 3){
					returnV = false;
				}
				if(matched(regex, orginFileName) && ckMode == 3){
					returnV = false;
				}
			}
		}
		return returnV;
	}
	private boolean matched(String regex, String inputTxt) { 
		return Pattern.matches(regex, inputTxt); 
	} 

	/**
     * 파일 삭제 처리.
     * 
     * @param data
     * @return
     */
	public boolean deleteUpLoadFile(FileVO fileVO) throws Exception {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			//파일 삭제
			FileVO fvo = fileService.selectFileInf(fileVO);
			EgovFileTool.deleteFile(fvo.getFileStreCours()+"/"+fvo.getStreFileNm());
			//파일 삭제
		    fileService.deleteFileInf(fileVO);
		}
		return true;
	}

	/* 관리자 로그 기로 */
	protected void commonLogInsert(ActManageDefaultVO defVO) throws Exception {
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		defVO.setRegid(loginVO.getId());
		defVO.setRegip(getRemoteAddr());
		actStatManageService.insertCommonLog(defVO);
	}

    protected boolean chkTagScript(String data) {
    	boolean reRst = false;
        if (data == null || data.trim().equals("")) {
            return reRst;
        }
		// XSS에 사용되는 문자 패턴
		String xssCharList = "<>";
		// 서버로 전달된 파라미터를 변수에 저장
		String xssStr = data;
		// 인코딩 우회를 방지하기 위한 디코딩
		String decodeValue;
		try {
			decodeValue = URLDecoder.decode(xssStr, Charset.defaultCharset().name());
			// XSS에 사용되는 문자가 존재하는지 확인
			for ( char c : decodeValue.toCharArray() ) {
			// 문자가 존재할 경우
				if ( xssCharList.indexOf(c) != -1 ) {
					reRst = true;
			    }
			 }
		} catch (UnsupportedEncodingException e) {
			reRst = true;
			e.printStackTrace();
		}
        return reRst;
    }

	/**
     * XSS 방지 처리.
     * 
     * @param data
     * @return
     */
    protected String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;/embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;/form");

        ret = ret.replaceAll("<(H|h)(T|t)(M|m)(L|l)", "&lt;html");
        ret = ret.replaceAll("</(H|h)(T|t)(M|m)(L|l)", "&lt;/html");

        ret = ret.replaceAll("<(M|m)(E|e)(T|t)(A|a)", "&lt;meta");
        ret = ret.replaceAll("</(M|m)(E|e)(T|t)(A|a)", "&lt;/meta");

        ret = ret.replaceAll("<(B|b)(O|o)(D|d)(Y|y)", "&lt;body");
        ret = ret.replaceAll("</(B|b)(O|o)(D|d)(Y|y)", "&lt;/body");

        ret = ret.replaceAll("<(H|h)(E|e)(A|a)(D|d)", "&lt;head");
        ret = ret.replaceAll("</(H|h)(E|e)(A|a)(D|d)", "&lt;/head");

        ret = ret.replaceAll("<(S|s)(V|v)(G|g)", "&lt;svg");


        return ret;
    }

	public String getRemoteAddr() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		//HttpServletResponse response = servletContainer.getResponse();
		String ip = null;
		ip = request.getHeader("X-Forwarded-For");
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (isNull(ip) || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

}
