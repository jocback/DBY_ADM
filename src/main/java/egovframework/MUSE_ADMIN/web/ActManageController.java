package egovframework.MUSE_ADMIN.web;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;

import egovframework.MUSE_ADMIN.web.ActCommonController;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.MUSE_ADMIN.service.ActEmpManageService;
import egovframework.MUSE_ADMIN.service.ActManageDefaultVO;
import egovframework.MUSE_ADMIN.service.ActMembManageService;
import egovframework.MUSE_ADMIN.service.ActMovingManageService;
import egovframework.MUSE_ADMIN.service.ActOrderManageVO;
import egovframework.MUSE_ADMIN.service.ActStatManageService;
import egovframework.MUSE_ADMIN.service.ActEmpManageVO;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageService;
import egovframework.MUSE_ADMIN.service.ActLecCodeManageVO;
import egovframework.MUSE_Rte.cop.bbs.service.BoardManageService;
import egovframework.MUSE_Rte.uat.uia.service.EgovLoginService;
import egovframework.MUSE_Rte.utl.sim.service.EgovFileTool;
import egovframework.rte.fdl.property.EgovPropertyService;

import javax.annotation.Resource;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base32;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ActManageController extends ActCommonController{

   @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** actMovingManageService */
	@Resource(name = "ActMovingManageService")
	private ActMovingManageService actMovingManageService;

	@Resource(name = "ActLecCodeManageService")
    private ActLecCodeManageService actLecCodeManageService;

	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	// 첨부파일 관련
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	@Resource(name = "ActStatManageService")
	private ActStatManageService actStatManageService;
	
	@Resource(name = "ActMembManageService")
	private ActMembManageService actMembManageService;
    
	@Resource(name = "BoardManageService")
    private BoardManageService bbsMngService;
	
	/** actEmpManageService */
	@Resource(name = "ActEmpManageService")
	private ActEmpManageService actEmpManageService;

	@Autowired
	ServletContext context;
	
	final String MENU_AUTH_NO = "100";
	/**
	 * 로그인 화면으로 들어간다
	 */
	@RequestMapping(value = "/boffice/museAdmLogin.do")
	public String loginUsrView(HttpServletRequest request, @ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("Proxy-Client-IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("WL-Proxy-Client-IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("HTTP_CLIENT_IP");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
		}  
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
		    ip = request.getRemoteAddr();  
		}
		//out.println("ip:"+ip+"<br/>");

		/*String shortip = "";
		if(!"".equals(ip) && ip.length()>10){
			shortip = ip.substring(0,10);
		}*/
		//System.out.println("shortip:"+shortip+"<br/>");

		/*if(!shortip.equals("0:0:0:0:0:") && !ip.equals("192.168.1.10") && !shortip.equals("192.168.3.") && !shortip.equals("192.168.7.") && !ip.equals("220.76.203.171")){//&& !ip.equals("0:0:0:0:0:0:0:1")
			return "redicret:/";
		}*/
		return "boffice/login";
	}

	@RequestMapping(value = "/boffice/museAdmLoginOtp.do")
	public String loginUsrOtp(HttpServletRequest request, ModelMap model) throws ServletException, IOException {
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String optRCd = actEmpManageService.selectActEmpInfoOne("OTP_REGCD",loginVO.getId());
		if(isNull(optRCd)){
			model.addAttribute("encodedKey", "NONE");
		}else{
			model.addAttribute("encodedKey", "EXIT");
		}
        return "boffice/loginOtp";
	}
	
	/**
	 *	코드목록 조회 아작스
	 * @throws Exception
	 */
	@RequestMapping("/boffice/museAdmLoginOtpReg.do")
    @ResponseBody
	public ModelAndView museAdmLoginOtpReg(@ModelAttribute("actEmpManageVO") ActEmpManageVO actEmpManageVO, HttpServletRequest request)
			throws ServletException, IOException, Exception {
		//Allocating the buffer
		//byte[] buffer = new byte[secretSize + numOfScratchCodes * scratchCodeSize];
		byte[] buffer = new byte[5 + 5 * 5];
		 
		// Filling the buffer with random numbers.
		// Notice: you want to reuse the same random generator
		// while generating larger random number sequences.
		        new Random().nextBytes(buffer);
		 
		        // Getting the key and converting it to Base32
		Base32 codec = new Base32();
		//byte[] secretKey = Arrays.copyOf(buffer, secretSize);
		byte[] secretKey = Arrays.copyOf(buffer, 10);
		byte[] bEncodedKey = codec.encode(secretKey);
		 
		// 생성된 Key!
		String encodedKey = new String(bEncodedKey);
		 
		System.out.println("encodedKey : " + encodedKey);
		 
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String lastUpdusrId = loginVO.getId();
		actEmpManageVO.setModemp(lastUpdusrId); // 최종수정자ID
		actEmpManageVO.setEmpId(lastUpdusrId);
		actEmpManageVO.setOtpRegcd(encodedKey);
		actEmpManageService.updateActEmp(actEmpManageVO);
		
		//String url = getQRBarcodeURL(userName, hostName, secretKeyStr);
		// userName과 hostName은 변수로 받아서 넣어야 하지만, 여기선 테스트를 위해 하드코딩 해줬다.
		String url = getQRBarcodeURL("manager", "yulimgosi.com", encodedKey); // 생성된 바코드 주소!
		System.out.println("URL : " + url);
		 
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsonView");
		mv.addObject("encodedKey", encodedKey);
		mv.addObject("url", url);
		return mv;
	}

	public static String getQRBarcodeURL(String user, String host, String secret) {
		String format = "http://chart.apis.google.com/chart?cht=qr&chs=300x300&chl=otpauth://totp/%s@%s%%3Fsecret%%3D%s&chld=H|0";
		return String.format(format, user, host, secret);
	}

	/**
	 * 일반(세션) 로그인을 처리한다
	 */
	@RequestMapping(value = "/boffice/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		// 1. 일반 로그인 처리
		
		LoginVO resultVO = loginService.actionLogin(loginVO);
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			// 2-1. 로그인 정보를 세션에 저장
			request.getSession().setAttribute("loginVO", resultVO);
			//return "redirect:/uat/uia/actionMain.do";
			return "redirect:/boffice/main.do";
		} else {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "redirect:/boffice/museAdmLogin.do";
		}
	}

	/**
	 * 일반(세션) 로그인을 처리한다
	 */
	@RequestMapping("/boffice/actionOtpCheck.do")
    @ResponseBody
	public ModelAndView actionOtpCheck(@ModelAttribute("actEmpManageVO") ActEmpManageVO actEmpManageVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		//임시
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if("0:0:0:0:0:0:0:1".equals(getRemoteAddr()) && loginVO != null){
			loginVO.setOtpRCd("OK");
			mv.setViewName("jsonView");
			mv.addObject("message", "Success");
		}else{
		//임시
			String user_codeStr = actEmpManageVO.getOtpRegcd();
			//System.out.println("user_codeStr==>>"+user_codeStr);
			if(!numberValidCheck(user_codeStr)){
				user_codeStr = "0";
			}
			long user_code = Integer.parseInt(user_codeStr);
			boolean check_code = false;
			// 로그인VO에서  사용자 정보 가져오기
			String retStr = "Error"; 
			if(loginVO != null){
				String encodedKey = actEmpManageService.selectActEmpInfoOne("OTP_REGCD",loginVO.getId());
				long l = new Date().getTime();
				long ll =  l / 30000;
	
				try {
					// 키, 코드, 시간으로 일회용 비밀번호가 맞는지 일치 여부 확인.
					check_code = check_code(encodedKey, user_code, ll);
				} catch (InvalidKeyException e) {
					e.printStackTrace();
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				}
			}else{
				retStr = "NLOG";
			}
			// 일치한다면 true.
			//System.out.println("check_code : " + check_code);
			mv.setViewName("jsonView");
			if(check_code){
				loginVO.setOtpRCd("OK");
				retStr = "Success";
			} else {
				retStr = "NEQ";
			}
			//System.out.println("retStr ==>"+retStr);
			mv.addObject("message", retStr);
		}
		return mv;
	}

	private static boolean check_code(String secret, long code, long t) throws NoSuchAlgorithmException, InvalidKeyException {
		Base32 codec = new Base32();
		byte[] decodedKey = codec.decode(secret);
		
		// Window is used to check codes generated in the near past.
		// You can use this value to tune how far you're willing to go.
		int window = 3;
		for (int i = -window; i <= window; ++i) {
			long hash = verify_code(decodedKey, t + i);
			if (hash == code) {
				return true;
			}
		}
		// The validation code is invalid.
		return false;
	}
     
    private static int verify_code(byte[] key, long t)
            throws NoSuchAlgorithmException, InvalidKeyException {
        byte[] data = new byte[8];
        long value = t;
        for (int i = 8; i-- > 0; value >>>= 8) {
            data[i] = (byte) value;
        }
 
        SecretKeySpec signKey = new SecretKeySpec(key, "HmacSHA1");
        Mac mac = Mac.getInstance("HmacSHA1");
        mac.init(signKey);
        byte[] hash = mac.doFinal(data);
 
        int offset = hash[20 - 1] & 0xF;
 
        // We're using a long because Java hasn't got unsigned int.
        long truncatedHash = 0;
        for (int i = 0; i < 4; ++i) {
            truncatedHash <<= 8;
            // We are dealing with signed bytes:
            // we just keep the first byte.
            truncatedHash |= (hash[offset + i] & 0xFF);
        }
 
        truncatedHash &= 0x7FFFFFFF;
        truncatedHash %= 1000000;
 
        return (int) truncatedHash;
    }
    
    /**
	 * 로그아웃한다.
	 */
	@RequestMapping(value = "/boffice/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		/*String userIp = EgovClntInfo.getClntIP(request);
		// 1. Security 연동
		return "redirect:/j_spring_security_logout";*/
		request.getSession().setAttribute("loginVO", null);
		return "redirect:/boffice/museAdmLogin.do";
	}

	@RequestMapping("/boffice/main.do")
	public String selectActIndexList(ActManageDefaultVO searchVO, ModelMap model) throws Exception {
		// 미인증 사용자에 대한 보안처리
		webLogInsert(MENU_AUTH_NO,1);
		//현재날짜 추출
		String currYear = getCurrYear();
		if(searchVO.getSearchYear().equals("") || searchVO.getSearchYear() == null){
			searchVO.setSearchYear(currYear);
		}
		model.addAttribute("currYear", currYear);
		
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId("COM062");
		List<?> codeResult62 = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult62", codeResult62);

		ActOrderManageVO orderVO = new ActOrderManageVO();
		orderVO.setSearchOp1(getDateTransStrSp(addDateDay(getCurrDate(),0,-12,0),"-"));
		List<?> statMain = actStatManageService.selectActStatMain(orderVO);
		model.addAttribute("statMain", statMain);
		List<?> statMain1 = actStatManageService.selectActStatMain1(orderVO);
		model.addAttribute("statMain1", statMain1);

		return "boffice/main";
	}

	/**
	 *	코드목록 조회 아작스
	 * @throws Exception
	 */
	@RequestMapping("/boffice/activity/actCodeList.do")
    @ResponseBody
	public ModelAndView selectAjaxCodeList(@ModelAttribute("codeVO") ComDefaultCodeVO codeVO) throws Exception {
		//코드정보로부터 조회
		List<?> codeResult = cmmUseService.selectCmmCodeDetail(codeVO);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("jsonView");
        mv.addObject("ajaxCodeResult", codeResult);
        return mv;
	}

	/**
	 *	코드목록 조회 아작스
	 * @throws Exception
	 */
	@RequestMapping("/boffice/activity/actFrmType.do")
	public String selectFrmTypeLoad(@ModelAttribute("frmTypeVO") ActManageDefaultVO frmTypeVO, ModelMap model) throws Exception {
		ComDefaultCodeVO codevo = new ComDefaultCodeVO();
		codevo.setCodeId(frmTypeVO.getFrmTypeCode());
		List<?> codeResult = cmmUseService.selectCmmCodeDetail(codevo);
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("frmTypeVO", frmTypeVO);
		return "/com/cmm/common/frmModel";
	}

	/**
	 *	코드목록 조회 아작스
	 * @throws Exception
	 */
	@RequestMapping("/boffice/activity/actLecType.do")
	public String selectLecTypeLoad(@ModelAttribute("frmTypeVO") ActManageDefaultVO frmTypeVO, ModelMap model) throws Exception {
		frmTypeVO.setActListMode("type");
		List<?> codeResult = actMovingManageService.selectActMovingList(frmTypeVO);
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("frmTypeVO", frmTypeVO);
		return "/com/cmm/common/frmModel";
	}

	/**
	 *	코드목록 조회 아작스
	 * @throws Exception
	 */
	@RequestMapping("/boffice/activity/actLecCdType.do")
	public String selectLecCdTypeLoad(@ModelAttribute("frmTypeVO") ActLecCodeManageVO frmTypeVO, ModelMap model) throws Exception {
		frmTypeVO.setSearchOp1("Y");
		List<?> codeResult = actLecCodeManageService.selectLecCodeManageList(frmTypeVO);
		model.addAttribute("codeResult", codeResult);
		model.addAttribute("frmTypeVO", frmTypeVO);
		return "/com/cmm/common/frmModel";
	}

	/**
	 *	코드목록 조회 아작스
	 * @throws Exception
	 */
	@RequestMapping("/boffice/activity/actMenuCodeList.do")
    @ResponseBody
	public ModelAndView selectAjaxMenuCodeList(@ModelAttribute("codeVO") ComDefaultCodeVO codeVO) throws Exception {
		// 로그인VO에서  사용자 정보 가져오기
		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//코드정보로부터 조회
		if(!"G000001".equals(loginVO.getActGrIdx())){
			codeVO.setCodeAuth(loginVO.getActGrIdx());
		}
		List<?> codeResult = cmmUseService.selectCmmCodeDetail(codeVO);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("jsonView");
        mv.addObject("ajaxCodeResult", codeResult);
        return mv;
	}

	@RequestMapping("/boffice/activity/deleteActUpFile.do")
	@ResponseBody
	public String deleteActUpFile(@ModelAttribute("searchVO") FileVO fileVO) throws Exception {
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			//파일 삭제
			FileVO fvo = fileService.selectFileInf(fileVO);
			EgovFileTool.deleteFile(fvo.getFileStreCours()+"/"+fvo.getStreFileNm());
			//파일 삭제
			fileService.deleteFileInf(fileVO);
		}
		return "success";
	}

}
