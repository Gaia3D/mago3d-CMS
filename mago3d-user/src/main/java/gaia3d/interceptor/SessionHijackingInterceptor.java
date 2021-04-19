package gaia3d.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

/**
 * 세션 하이재킹 처리, login 처리 부분과 ajax 부분을 통과
 * @author jeongdae
 *
 */
@Slf4j
@Component
public class SessionHijackingInterceptor extends HandlerInterceptorAdapter {


    private static final String[] EXCEPTION_URI = { "signin", "signout", "call-api" , "/guide/help" };

    private static final String POPUP_URL = "popup";
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	String uri = request.getRequestURI();
//    	String requestIp = WebUtil.getClientIp(request);
//    	log.info("## Requst URI = {}, Request Ip = {}", uri, requestIp);
//    	
//    	// 헤어 안에 저 값을 검사해서 Ajax 유무를 판별 
////    	if ((request.getHeader["X-Requested-With"] != null && request.Headers["X-Requested-With"].ToLower() equals("xmlhttprequest"))
////    		    || request.Headers["ORIGIN"] != null) {
////    		
////    	}
//    	
//    	boolean isExceptionURI = false;
//    	int exceptionURICount = EXCEPTION_URI.length;
//    	for(int i=0 ; i<exceptionURICount; i++) {
//    		if(uri.indexOf(EXCEPTION_URI[i]) >= 0) {
//    			isExceptionURI = true;
//    			break;
//    		}
//    	}
//    	
//    	if(!isExceptionURI) {
//    		// 세션 하이재킹을 검사
//    		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//    		if(userSession == null || userSession.getUser_id() == null || "".equals(userSession.getUser_id())) {
//    			log.info("## Session is Null");
//    			if(uri.indexOf(POPUP_URL) >=0) {
//    				// 팝업 화면
//    				response.sendRedirect("/login/popup-login.do");
//        			return false;
//    			} else {
//    				// 일반 화면
//    				response.sendRedirect("/login/login.do");
//        			return false;
//    			}
//    		} else {
//    			// IPV6의 경우를 고려 하지 않았음.... 수정해야 함... 버그
//    			if(!WebUtil.isEqualIp(userSession.getLogin_ip(), requestIp)) {
//    				// TODO 로그인 세션 생성 시점의 IP랑 현재 IP가 다름. 동적 IP를 사용할 경우 다를수 있음. OTP 추가 인증 받자.
//        			if(uri.indexOf(POPUP_URL) >=0) {
//        				// 팝업 화면
//        				response.sendRedirect("/login/popup-session-hijacking.do");
//            			return false;
//        			} else {
//        				// 일반 화면
//        				response.sendRedirect("/login/session-hijacking.do");
//            			return false;
//        			}
//    			}
//    		}
//    	}
    	
        return true;
    }
}
