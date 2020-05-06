package gaia3d.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import gaia3d.config.CSRFRequestDataValueProcessor;
import gaia3d.config.CSRFTokenManager;
import gaia3d.support.URLSupport;

/**
 * http POST, PUT, DELETE 요청의 경우 CSRF 토큰 검사
 * 
 * 
 * A Spring MVC <code>HandlerInterceptor</code> which is responsible to enforce CSRF token validity on incoming posts requests. The interceptor
 * should be registered with Spring MVC servlet using the following syntax:
 * <pre>
 *   &lt;mvc:interceptors&gt;
 *        &lt;bean class="com.eyallupu.blog.springmvc.controller.csrf.CSRFHandlerInterceptor"/&gt;
 *   &lt;/mvc:interceptors&gt;
 *   </pre>
 * @author Eyal Lupu
 * @see CSRFRequestDataValueProcessor
 */
@Slf4j
@Component
public class CSRFHandlerInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private ObjectMapper objectMapper;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		String uri = request.getRequestURI();
		log.info("CSRFHandlerInterceptor uri = {}", uri);
    	if(uri.indexOf("/error") >= 0) {
    		log.info("CSRFHandlerInterceptor error pass!!!");
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
    		return true;
    	}
    	
    	String loginUrl = URLSupport.SIGNIN_URL;
    	String method = request.getMethod();
    	
    	// GET 메서드의 경우 통과
		if(method.equalsIgnoreCase("GET")) {
			return true;
		} 
		
		// TODO 우선은 POST 요청만 체크
		if(method.equalsIgnoreCase("POST")) {
			String sessionToken = CSRFTokenManager.getTokenForSession(request.getSession());
			String requestToken = CSRFTokenManager.getTokenFromRequest(request);
			
			if (sessionToken.equals(requestToken)) {
				return true;
			} else {
				log.info("@@@@@@@@@@@@@ CSRF Token Different. uri = {}", uri);
				if(isAjax(request)) {
					Map<String, Object> unauthorizedResult = new HashMap<>();
					unauthorizedResult.put("statusCode", HttpStatus.UNAUTHORIZED.value());
					unauthorizedResult.put("errorCode", "csrf.token.invalid");
					unauthorizedResult.put("message", null);
					
					response.setContentType("application/json");       
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(objectMapper.writeValueAsString(unauthorizedResult));
					return false;
				} else {
					response.sendRedirect(loginUrl);
		    		return false;
				}
			}
		}
		
		return true;
	}
	
	private boolean isAjax(HttpServletRequest request) {
		return "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
	}
}
