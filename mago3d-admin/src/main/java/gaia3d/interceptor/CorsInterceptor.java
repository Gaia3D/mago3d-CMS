package gaia3d.interceptor;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * Same Origin Policy
 * @author Cheon JeongDae
 *
 */
@Component
public class CorsInterceptor implements HandlerInterceptor {
    
    private static final String ACCESS_CONTROL_ALLOW_ORIGIN = "Access-Control-Allow-Origin";
    private static final String ACCESS_CONTROL_ALLOW_CREDENTIALS = "Access-Control-Allow-Credentials";
    private static final String REQUEST_HEADER_ORIGIN = "Origin";
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String origin = request.getHeader(REQUEST_HEADER_ORIGIN);

    	// Bug Fix : The program defines an overly permissive Cross-Origin Resource Sharing (CORS) policy
        if ("*".equals(origin)) return false;
        
        // CORS 가능하도록 응답 헤더 추가
        if (StringUtils.hasLength(origin)) {
            // 요청한 도메인에 대해 CORS 를 허용한다. 제한이 필요하다면 필요한 값으로 설정한다.
        	
        	// Bug Fix : HTTP parameter directly written to HTTP header output in
        	origin = URLEncoder.encode(origin, StandardCharsets.UTF_8.displayName());
        	response.setHeader(ACCESS_CONTROL_ALLOW_ORIGIN, origin);
            
            // credentials 허용
            response.setHeader(ACCESS_CONTROL_ALLOW_CREDENTIALS, "true");
        }
        
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // do nothing
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        // do nothing
    }
}
