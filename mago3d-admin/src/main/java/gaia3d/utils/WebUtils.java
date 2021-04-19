package gaia3d.utils;

import javax.servlet.http.HttpServletRequest;

public class WebUtils {
	
	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) {
			// IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		} else if (header.indexOf("Safari") > -1) {
			return "Safari";
		}
		
		return "Firefox";
	}

	/**
	 * 사용자 IP 를 획득
	 * @param request
	 * @return
	 */
	public static String getClientIp(HttpServletRequest request) {
		
		String ip = request.getHeader("X-FORWARDED-FOR");
		
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null || "".equals(ip) || "unknown".equals(ip.toLowerCase())) {
			ip = request.getRemoteAddr();
		}

//		if(ip != null && !"".equals(ip) && ip.length() > 15) {
//			log.error("@@ Client Ip = {}", ip);
//            if( ip.indexOf(",") > -1) {
//                StringTokenizer stringTokenizer = new StringTokenizer(ip, ",");
//                ip = stringTokenizer.nextToken();
//                log.error("@@ Client First Ip = {}", ip);
//            }
//        }
		
		// ipv6 (ipv4 127.0.0.1) localhost 접속시
		if("0:0:0:0:0:0:0:1".equals(ip)) {
			ip = "127.0.0.1";
		}
		
		return ip;
	}
}
