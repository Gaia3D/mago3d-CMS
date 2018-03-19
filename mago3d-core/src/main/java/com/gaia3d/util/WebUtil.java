package com.gaia3d.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.gaia3d.helper.CommonsExecHelper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class WebUtil {
	
	public static final String LOCALHOST = "localhost";
	
	/**
	 * 숫자 유효성 체크
	 * @param number
	 * @return
	 */
	public static boolean isNumber(String number) {
		return Pattern.matches("[+-]?\\d+", number);
	}
	
	/**
	 * 안전한 String 유효성 체크
	 * @param str
	 * @return
	 */
	public static boolean isSafeString(String str) {
		return Pattern.matches("^[.\\p{Alnum}\\p{Space}]{0,1024}$", str);
	}
	
	/**
	 * 핸드폰번호 유효성 체크. 반드시 앞자리가 010,010,016~9사이를 충족해야 하며, "-"로 구분. 자리수도 충족
	 * @param mobilephone
	 * @return
	 */
	public static boolean isMobilePhone(String mobilephone) {  
		return Pattern.matches("^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$", mobilephone);
	}  
	
	/**
	 * 전화번호 유효성 체크
	 * @param telephone
	 * @return
	 */
	public static boolean isTelePhone(String telephone) {  
		return Pattern.matches("^\\d{2,3}-\\d{3,4}-\\d{4}$", telephone);
	}  
	
	/**
	 * 이메일 형식 유효성 체크
	 * @param email
	 * @return
	 */
	public static boolean isEmail(String email) {
		return Pattern.matches("^[A-Za-z0-9._%'-]+@[A-Za-z0-9.-]+\\.[a-zA-Z]{2,4}$", email);
	}
	
	/**
	 * IP 형식 유효성 체크
	 * @param email
	 * @return
	 */
	public static boolean isIP(String ip) {
		return Pattern.matches("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip);
	}
	
	/**
	 * URL 형식 유효성 체크
	 * @param email
	 * @return
	 */
	public static boolean isURL(String url) {
		return Pattern.matches("^(ht|f)tp(s?)\\:\\/\\/[0-9a-zA-Z]([-.\\w]*[0-9a-zA-Z])*(:(0-9)*)*(\\/?)([a-zA-Z0-9\\-\\.\\?\\,\\:\\'\\/\\\\\\+=&amp;%\\$#_]*)?$", url);
	}
	
	/**
	 * 날짜 형식 유효성 체크
	 * @param date
	 * @return
	 */
	public static boolean isDate(String date) {
		return Pattern.matches("^((19|20)\\d\\d)?([- /.])?(0[1-9]|1[012])([- /.])?(0[1-9]|[12][0-9]|3[01])$", date);
	}
	
	/**
	 * 사용자 IP 를 획득
	 * @param request
	 * @return
	 */
	public static String getClientIp(HttpServletRequest request) {
		
		String ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("X-Forwarded-For");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("REMOTE_ADDR");
		}		
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getRemoteAddr();
		}

		// Win7은 기본이 IPV6, IPV6 의 경우 0:0:0:0:0:0:0:1 가 127.0.0.1 에 해당됨
		
//		if(ip != null && !"".equals(ip) && ip.length() > 15) {
//			log.error("@@ Client Ip = {}", ip);
//            if( ip.indexOf(",") > -1) {
//                StringTokenizer stringTokenizer = new StringTokenizer(ip, ",");
//                ip = stringTokenizer.nextToken();
//                log.error("@@ Client First Ip = {}", ip);
//            }
//        }
		
		return ip;
	}
	
	/**
	 * TODO 가장 바람직한 것은 관리자 설정에서 사용자의 동적 IP 허용 유무를 설정할수 있고
	 * 동적 IP인 경우 추가 패스워드를 하나 더 받아서 사용하게 해 주는것이 가장 이상적일거 같음
	 * 
	 * 세션 하이재킹 처리를 위한 세션 IP와 현재 접속 IP가 동일한지를 체크
	 * 동적 IP 때문에 C 클래스 까지만 동일한지 검사
	 * @param loginSessionIp
	 * @param clientIp
	 * @return
	 */
	public static boolean isEqualIp(String loginSessionIp, String clientIp) {
		if(loginSessionIp.equals(clientIp)) return true;
		
		int loginSessionIpCClassIndex = loginSessionIp.lastIndexOf(".");
		int requestIpCClassIndex = clientIp.lastIndexOf(".");
		
		log.error("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ loginSessionIp = {}, loginSessionIpCClassIndex = {}", loginSessionIp, loginSessionIpCClassIndex);
		String cClassLoginSessionIp = loginSessionIp.substring(0, loginSessionIpCClassIndex);
		log.error("@@@ loginSessionIp = {}, clientIp = {}, loginSessionIpCClassIndex = {}, requestIpCClassIndex = {}", loginSessionIp, clientIp, loginSessionIpCClassIndex, requestIpCClassIndex);
		String cClassRequestIp = clientIp.substring(0, requestIpCClassIndex);
		
		log.error("@@ Session User Ip And Now User Ip is different!");
		log.error("@@ loginSessionIp = {}, clientIp = {}", loginSessionIp, clientIp);
		if(cClassLoginSessionIp.equals(cClassRequestIp)) {
			log.error("@@ C Class Ip is Equal");
			return true;
		} else {
			log.error("@@ C Class Ip is Different");
			return false;
		}
	}
	
	/**
	 * 환경 설정에 등록된 서버 IP를 돌려줌
	 * @param fileName
	 * @return
	 */
	public static String getServerIp(String fileName) {
		String serverIp = null;
		File cacheFile =  new File(fileName);
		if(!cacheFile.exists()) {
			log.error("@@@@@@@@@@@@ Error. Cache file not exist");
		}
		
		try (FileInputStream fileInputStream = new FileInputStream(cacheFile)) {	
			Properties properties = new Properties();
			properties.load(fileInputStream);
			serverIp = properties.getProperty("server_ip");
		} catch (Exception e) {
			log.error("@@@@@@@@@@@@ Cache file Read Error");
			e.printStackTrace();
		}
		return serverIp;
	}
	
	/**
	 * 환경 설정에 등록된 서버 IP를 돌려줌
	 * @param fileName
	 * @param serverIp
	 * @return
	 */
	public static String setServerIp(String fileName, String serverIp) {
		
		File cacheFile =  new File(fileName);
		if(!cacheFile.exists()) {
			log.error("@@@@@@@@@@@@ Error. Cache file not exist");
		}
		
		try (FileInputStream fileInputStream = new FileInputStream(cacheFile); FileOutputStream fileOutputStream = new FileOutputStream(cacheFile)) {	
			Properties properties = new Properties();
			properties.load(fileInputStream);
			properties.setProperty("server_ip", serverIp);
			properties.store(fileOutputStream, null);
		} catch (Exception e) {
			log.error("@@@@@@@@@@@@ Cache file Read Error");
			e.printStackTrace();
		} 
		return serverIp;
	}
	
//	/**
//	 * 서버의 실제 IP를 획득
//	 * @return
//	 */
//	public static String getServerIp() {
//		String hostAddr = LOCALHOST;
//		try {
//			Enumeration<NetworkInterface> networkInterfaceEnum = NetworkInterface.getNetworkInterfaces();
//			while (networkInterfaceEnum.hasMoreElements()) {
//				NetworkInterface networkInterface = networkInterfaceEnum.nextElement();
//				Enumeration<InetAddress> inetAddressEnum = networkInterface.getInetAddresses();
//				while (inetAddressEnum.hasMoreElements()) {
//					InetAddress inetAddress = inetAddressEnum.nextElement();
//					if (!inetAddress.isLoopbackAddress() && !inetAddress.isLinkLocalAddress()
//							&& inetAddress.isSiteLocalAddress()) {
//						hostAddr = inetAddress.getHostAddress().toString();
//					}
//				}
//			}
//		} catch (SocketException e) {
//			e.printStackTrace();
//		}
//		return hostAddr;
//	}
	
	public static String getHostName() {
		Map<String, Object> result = new HashMap<>();
		result = CommonsExecHelper.execute("hostname");
		return (String)result.get("message");
	}
}