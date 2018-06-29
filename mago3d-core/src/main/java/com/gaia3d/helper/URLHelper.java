package com.gaia3d.helper;

public class URLHelper {

    public static final String AJAX_URI = "ajax";
    public static final String POPUP_URL = "popup";
    public static final String LOGIN_URL = "/login/login.do";
    public static final String POPUP_LOGIN_URL = "/login/popup-login.do";
    
    // login 의 경우 통과
    public static final String[] EXCEPTION_URI = { 	"error", "login", "call-api", "call-cache", "call-list-user-session", "call-dbcp" };
    public static final String[] USER_STATUS_EXCEPTION_URI = { "/login/login.do", "/login/process-login.do", "/user/modify-password.do", "/user/update-password.do"};
    public static final String[] LICENSE_EXCEPTION_URI = { "modify-license", "update-license", "ajax-update-license" };
    public static final String LICENSE_URL = "/config/modify-license.do";
    // 로그 예외 URL, 사용이력, 이중화, 메인 위젯(main, ajax, widget 이건 너무 많아서 키워드로 Filter)
    public static final String[] LOG_EXCEPTION_URI = { "error", "ajax-loadbalancing-status", "list-access-log", "ajax-list-access-log" };
	// 엑셀 파일 처리 관련 URL
	public static final String[] MULTIPART_REQUEST_URI = { "insert-excel" };
}
