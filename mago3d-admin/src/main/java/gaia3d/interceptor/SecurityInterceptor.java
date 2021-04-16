package gaia3d.interceptor;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gaia3d.domain.Key;
import gaia3d.domain.user.UserSession;
import gaia3d.domain.user.UserStatus;
import gaia3d.support.URLSupport;
import gaia3d.utils.WebUtils;
import lombok.extern.slf4j.Slf4j;

/**
 * 보안 관련 체크 인터셉터
 * @author jeongdae
 *
 */
@Slf4j
@Component
public class SecurityInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private ObjectMapper objectMapper;
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	String uri = request.getRequestURI();
    	String requestIp = WebUtils.getClientIp(request);
    	log.info("## Requst URI = {}, Method = {}, Request Ip = {}, referer={}", uri, request.getMethod(), requestIp, request.getHeader("referer"));
    	
    	if(uri.indexOf("/error") >= 0) {
    		log.info("error pass!!!");
    		printHead(request);
    		return true;
    	}
    	
    	boolean isExceptionURI = false;
    	int exceptionURICount = URLSupport.EXCEPTION_URI.length;
    	for(int i=0 ; i<exceptionURICount; i++) {
    		if(uri.indexOf(URLSupport.EXCEPTION_URI[i]) >= 0) {
    			isExceptionURI = true;
    			break;
    		}
    	}
    	
    	// 예외 URL 은 통과 처리
    	if(isExceptionURI) {
//    		log.info("################################### exception uri");
    		return true;
    	}
    	
    	String loginUrl = URLSupport.SIGNIN_URL;
    	if(uri.indexOf(URLSupport.POPUP_URL) >=0) {
    		loginUrl = URLSupport.POPUP_SIGNIN_URL;
    	}
    	
		// 세션이 존재하지 않는 경우
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		if(userSession == null || userSession.getUserId() == null || "".equals(userSession.getUserId())) {
			log.info("Session is Null. userSession = {}", userSession);
			if(isAjax(request)) {
				log.info("## ajax call session null. uri = {}", uri);
				
				Map<String, Object> unauthorizedResult = new HashMap<>();
				unauthorizedResult.put("statusCode", HttpStatus.UNAUTHORIZED.value());
				unauthorizedResult.put("errorCode", "user.session.empty");
				unauthorizedResult.put("message", null);
				
				response.setContentType("application/json");       
				response.setCharacterEncoding("UTF-8");
//				response.setStatus(HttpStatus.UNAUTHORIZED.value());
				response.getWriter().write(objectMapper.writeValueAsString(unauthorizedResult));
				return false;
			} else {
				response.sendRedirect(loginUrl);
	    		return false;
			}
		}
		
		// 임시 비밀번호 사용자는 로그인, 패스워드 변경 페이지외에 갈수 없음
		if(UserStatus.TEMP_PASSWORD == UserStatus.findBy(userSession.getStatus())) {
			isExceptionURI = false;
	    	exceptionURICount = URLSupport.USER_STATUS_EXCEPTION_URI.length;
	    	for(int i=0 ; i<exceptionURICount; i++) {
	    		if(uri.indexOf(URLSupport.USER_STATUS_EXCEPTION_URI[i]) >= 0) {
	    			isExceptionURI = true;
	    			break;
	    		}
	    	}
	    	if(!isExceptionURI) {
	    		log.info(" =========== Temporary Password User Access Error =========== ");
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
		
//    	Policy policy = CacheManager.getPolicy();
//    	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
//    	if( Policy.SECURITY_SESSION_HIJACKING_USE.equals(policy.getSecurity_session_hijacking()) ) {
//	    	// 세션 하이재킹 체크. IPV6의 경우를 고려 하지 않았음.... 수정해야 함... 버그
//			if(!WebUtil.isEqualIp(userSession.getLogin_ip(), requestIp)) {
//				// TODO 로그인 세션 생성 시점의 IP랑 현재 IP가 다름. 동적 IP를 사용할 경우 다를수 있음. OTP 추가 인증 받자.
//				response.sendRedirect(loginUrl);
//	    		return false;
//			}
//    	}
        return true;
    }
    
    private boolean isAjax(HttpServletRequest request) {
		return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
	}
    
    private void printHead(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		String statusMsg = status.toString();
		HttpStatus httpStatus = HttpStatus.valueOf(Integer.parseInt(statusMsg));
		log.info(" ================ httpStatus = {}", httpStatus);
		log.info(" ================ message = {}", httpStatus.getReasonPhrase());

    	Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
        	String headerName = headerNames.nextElement();
        	log.info("headerName = {}", headerName);
        	Enumeration<String> headers = request.getHeaders(headerName);
        	while (headers.hasMoreElements()) {
        		String headerValue = headers.nextElement();
        		log.info(" ---> headerValue = {}", headerValue);
        	}
        }
    }
}
