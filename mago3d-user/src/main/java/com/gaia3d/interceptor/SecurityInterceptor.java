package com.gaia3d.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;
import com.gaia3d.helper.URLHelper;
import com.gaia3d.util.WebUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 보안 관련 체크 인터셉터
 * @author jeongdae
 *
 */
@Slf4j
@Component
public class SecurityInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	String uri = request.getRequestURI();
    	String requestIp = WebUtil.getClientIp(request);
    	log.info("## Requst URI = {}, Request Ip = {}, header = {}", uri, requestIp, request.getHeader("X-Requested-With"));
    	
    	// 홈페이지는 통과
    	if(uri.indexOf("/homepage/") >= 0) {
    		log.info("homepage pass!!!");
    		return true;
    	}
    	
    	if(uri.indexOf("/error") >= 0) {
    		log.info("error pass!!!");
    		return true;
    	}
    	
    	boolean isExceptionURI = false;
    	int exceptionURICount = URLHelper.EXCEPTION_URI.length;
    	for(int i=0 ; i<exceptionURICount; i++) {
    		if(uri.indexOf(URLHelper.EXCEPTION_URI[i]) >= 0) {
    			isExceptionURI = true;
    			break;
    		}
    	}
    	
    	// 예외 URL 은 통과 처리
    	if(isExceptionURI) {
    		return true;
    	}
    	
    	String loginUrl = URLHelper.LOGIN_URL;
    	if(uri.indexOf(URLHelper.POPUP_URL) >=0) {
    		loginUrl = URLHelper.POPUP_LOGIN_URL;
    	}
    	
		// 세션이 존재하지 않는 경우
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		if(userSession == null || userSession.getUser_id() == null || "".equals(userSession.getUser_id())) {
			log.info("Session is Null. userSession = {}", userSession);
			if(uri.indexOf(URLHelper.AJAX_URI) < 0) {
				log.info("## uri = {}, ajax_uri < 0 ", uri);
				response.sendRedirect(loginUrl);
	    		return false;
			} else {
				log.info("## uri = {}, ajax_uri >= 0 ", uri);
				ObjectMapper mapper = new ObjectMapper();
				Map<String, String> jSONObject = new HashMap<String, String>();
    			jSONObject.put("result", "user.session.empty");
    			response.getWriter().write(mapper.writeValueAsString(jSONObject));
    			
//    			사용자 정보가 없을 경우는 : 404 (Not Found)
//    			요청 정보가 정확하지 않을 경우 : 400 (Bad Request)
//    			인증 실패 : 401 (UNAUTHORIZED)
    			
    			return false;
			}
		}
		
		// 임시 비밀번호 사용자는 로그인, 패스워드 변경 페이지외에 갈수 없음
		if(UserInfo.STATUS_TEMP_PASSWORD.equals(userSession.getStatus())) {
			isExceptionURI = false;
	    	exceptionURICount = URLHelper.USER_STATUS_EXCEPTION_URI.length;
	    	for(int i=0 ; i<exceptionURICount; i++) {
	    		if(uri.indexOf(URLHelper.USER_STATUS_EXCEPTION_URI[i]) >= 0) {
	    			isExceptionURI = true;
	    			break;
	    		}
	    	}
	    	if(!isExceptionURI) {
	    		log.info("## 임시 비밀번호 사용자 접근 오류");
				response.sendRedirect(loginUrl);
	    		return false;
	    	}
		}
		
//		// 라이선스 수정 페이지인지 확인
//		boolean isLicenseExceptionURI = false;
//    	int licenseExceptionURICount = URLHelper.LICENSE_EXCEPTION_URI.length;
//    	for(int i=0 ; i<licenseExceptionURICount; i++) {
//    		if(uri.indexOf(URLHelper.LICENSE_EXCEPTION_URI[i]) >= 0) {
//    			isLicenseExceptionURI = true;
//    			break;
//    		}
//    	}
//    	
//    	// 라이선스가 유효하지 않은 경우
//    	if(!isLicenseExceptionURI) {
//    		if(!ConfigCache.isLicenseAvailable()) {
//    			response.sendRedirect(URLHelper.LICENSE_URL);
//        		return false;
//    		}
//    	}
		
    	Policy policy = CacheManager.getPolicy();
    	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
    	if( Policy.SECURITY_SESSION_HIJACKING_USE.equals(policy.getSecurity_session_hijacking()) ) {
	    	// 세션 하이재킹 체크. IPV6의 경우를 고려 하지 않았음.... 수정해야 함... 버그
			if(!WebUtil.isEqualIp(userSession.getLogin_ip(), requestIp)) {
				// TODO 로그인 세션 생성 시점의 IP랑 현재 IP가 다름. 동적 IP를 사용할 경우 다를수 있음. OTP 추가 인증 받자.
				response.sendRedirect(loginUrl);
	    		return false;
			}
    	}
        return true;
    }
}
