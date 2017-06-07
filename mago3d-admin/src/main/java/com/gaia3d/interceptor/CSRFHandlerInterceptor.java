package com.gaia3d.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.gaia3d.config.CSRFRequestDataValueProcessor;

import lombok.extern.slf4j.Slf4j;

/**
 * A Spring MVC <code>HandlerInterceptor</code> which is responsible to enforce CSRF token validity on incoming posts requests. The interceptor
 * should be registered with Spring MVC servlet using the following syntax:
 * <pre>
 *   &lt;mvc:interceptors&gt;
 *        &lt;bean class="com.eyallupu.blog.springmvc.controller.csrf.CSRFHandlerInterceptor"/&gt;
 *   &lt;/mvc:interceptors&gt;
 *   </pre>
 * @author Eyal Lupu
 * @see CSRFRequestDataValueProcessor
 *
 */
@Slf4j
@Component
public class CSRFHandlerInterceptor extends HandlerInterceptorAdapter{
	
	private static final String LOGIN_URL = "/login/login.do";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// TODO SecurityInterceptor랑 중복인데...
		
		String uri = request.getRequestURI();
    	
//    	boolean isExceptionURI = false;
//    	int exceptionURICount = URLHelper.EXCEPTION_URI.length;
//    	for(int i=0 ; i<exceptionURICount; i++) {
//    		if(uri.indexOf(URLHelper.EXCEPTION_URI[i]) >= 0) {
//    			isExceptionURI = true;
//    			break;
//    		}
//    	}
//    	
//    	// 예외 URL 은 통과 처리
//    	if(isExceptionURI) {
//    		return true;
//    	}
//    	
//    	// Ajax 의 경우 통과 처리
//    	if(uri.indexOf(URLHelper.AJAX_URI) >= 0) {
//    		log.info("## CSRFHandlerInterceptor uri = {}, ajax_uri >= 0 ", uri);
//			return true;
//		} 
//		
//		// GET 메소드 통과 처리
//		if (!request.getMethod().equalsIgnoreCase("POST") ) {
//			// Not a POST - allow the request
//			return true;
//		} 
//		
//		// This is a POST request - need to check the CSRF token
//		String sessionToken = CSRFTokenManager.getTokenForSession(request.getSession());
//		String requestToken = CSRFTokenManager.getTokenFromRequest(request);
//		if (sessionToken.equals(requestToken)) {
//			return true;
//		} else {
////			response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bad or missing CSRF value");
//			log.info("@@@@@@@@@@@@@ CSRF 취약점. Post 입력 토큰과 세션 토큰이 다름");
//			response.sendRedirect(LOGIN_URL);
//			return false;
//		}
		return true;
	}
}
