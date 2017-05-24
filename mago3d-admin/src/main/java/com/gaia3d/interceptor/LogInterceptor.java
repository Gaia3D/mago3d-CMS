package com.gaia3d.interceptor;

import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

/**
 * 모든 요청에 대한 이력을 남김
 * 
 * Ajax 같은 요청에 대한 변수를 위해서는 getReader를 적용하는게 맞음
 * 실시간 DB를 하는게 맞는건지, Active MQ 같은 Queue를 이용하는게 맞는건지, 아님 파일로 해야 하는지 나중에 테스트 하자.
 * 
 * @author jeongdae
 *
 */
@Slf4j
public class LogInterceptor extends HandlerInterceptorAdapter {
	
//	@Autowired
//	private LogService logService;
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	String uri = request.getRequestURI();
    	
    	// 로그 예외 URL, 사용이력, 이중화, 메인 위젯(main, ajax, widget 이건 너무 많아서 키워드로 Filter)
    	boolean isExceptionURI = false;
//    	if(uri.indexOf("main") >= 0 && uri.indexOf("ajax") >= 0 && uri.indexOf("widget") >= 0) {
//    		isExceptionURI = true;
//    	}
//    	if(!isExceptionURI) {
//	    	int exceptionURICount = URLHelper.LOG_EXCEPTION_URI.length;
//	    	for(int i=0 ; i<exceptionURICount; i++) {
//	    		if(uri.indexOf(URLHelper.LOG_EXCEPTION_URI[i]) >= 0) {
//	    			isExceptionURI = true;
//	    			break;
//	    		}
//	    	}
//    	}
//    	// 예외 URL 은 통과 처리
//    	if(isExceptionURI) {
//    		return true;
//    	}
//    	
//    	AccessLog accessLog = new AccessLog();
//    	accessLog.setRequest_uri(uri);
//    	accessLog.setClient_ip(WebUtil.getClientIp(request));
//    	
//    	HttpSession session = request.getSession();
//    	UserSession userSession = (UserSession)session.getAttribute(UserSession.KEY);
//    	if(userSession == null || userSession.getUser_id() == null || "".equals(userSession.getUser_id())) {
//    		accessLog.setUser_id("guest");
//    		accessLog.setUser_name("guest");
//    	} else {
//    		accessLog.setUser_id(userSession.getUser_id());
//    		accessLog.setUser_name(userSession.getUser_name());
//    	}
//    	
//    	boolean isMultipartURI = false;
//    	int multipartURICount = URLHelper.MULTIPART_REQUEST_URI.length;
//    	for(int i=0 ; i<multipartURICount; i++) {
//    		if(uri.indexOf(URLHelper.MULTIPART_REQUEST_URI[i]) >= 0) {
//    			isMultipartURI = true;
//    			break;
//    		}
//    	}
//    	
//    	if(isMultipartURI) {
//    		accessLog.setParameters(getMultipartRequestParameters(request));
//    	} else {
//    		accessLog.setParameters(getRequestParameters(request));
//    	}
//    		
//    	String userAgent = request.getHeader("User-Agent");
//    	if(userAgent != null && userAgent.length() > 256) {
//    		userAgent = userAgent.substring(0, 250) + "...";
//    	}
//    	String referer = request.getHeader("Referer");
//    	if(referer != null && referer.length() > 256) {
//    		referer = referer.substring(0, 250) + "...";
//    	}
//    	accessLog.setUser_agent(userAgent);
//    	accessLog.setReferer(referer);
//    	
//    	// TODO parameters 처리 부분은 추후 보강하자.
//    	logService.insertAccessLog(accessLog);
    	
        return true;
    }
    
    /**
	 * 검색조건 지정, 버그 있음 nullpassxxxxxx||| 이런 형태로 찍힘
	 * @param request
	 * @return
	 */
    private String getRequestParameters(HttpServletRequest request) {
		
    	// TODO 처리 해야 할 예외들이 너무 많음
    	if("GET".equals(request.getMethod())) {
    		return request.getQueryString();
    	}
    	
		Enumeration<String> paramterNames = request.getParameterNames();
		StringBuffer buffer = new StringBuffer(128);
		String parameterName = null; 
		while(paramterNames.hasMoreElements()) { 
			parameterName = paramterNames.nextElement();
			
			// 변수명에 password 관련 것들은 저장하지 않음
			if(parameterName.indexOf("password") >= 0) continue;
			
			buffer.append("&");
			buffer.append(parameterName);
			buffer.append("=");
			String[] parameterValues = request.getParameterValues(parameterName);
		    for(String value : parameterValues) {
		    	if(value == null) {
		    		// Null 값이 오나? 암튼 테스트가 필요함...
		    		buffer.append("null");
		    	} else if(value.length() > 100) {
		    		// 30자 이상 검색 조건은 검색 조건으로 판단하지 않음
		    		buffer.append(value.substring(0, 100));
		    	} else {
		    		buffer.append(value);
		    	}
		    	//builder.append("|||");
		    }
		}
		
		String requestParameters = buffer.toString();
		// 1000자가 넘어가면 그건 검색조건이라고 보기 힘듬
		if(requestParameters.length() > 1000) requestParameters = requestParameters.substring(0, 1000);
		
		return requestParameters;
	}
    
    /**
	 * 검색조건 지정, 버그 있음 nullpassxxxxxx||| 이런 형태로 찍힘
	 * @param request
	 * @return
	 */
    private String getMultipartRequestParameters(HttpServletRequest request) {
    	MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
    	Map<String, MultipartFile> multipleMap = multipartRequest.getFileMap();
    	StringBuilder builder = new StringBuilder(32);
    	
    	if(!multipleMap.isEmpty()) {
	    	for(MultipartFile multipartFile : multipleMap.values()) {
	    		builder.append("&");
				builder.append("file_name=" + multipartFile.getOriginalFilename());
				builder.append("&");
				builder.append("file_size=" + multipartFile.getSize());
	    	}
    	}
    	
		String requestParameters = builder.toString();
		
		return requestParameters;
	}
}
