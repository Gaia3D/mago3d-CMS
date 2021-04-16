package gaia3d.support;

public class URLSupport {

	public static final String SIGNIN_URL = "/sign/signin";
	public static final String POPUP_SIGNIN_URL = "/sign/popup-signin";
	public static final String POPUP_URL = "popup";
	public static final String FORBIDDEN_MENU = "/forbidden/menu";
	
	// login 의 경우 통과
	public static final String[] EXCEPTION_URI = { "error", "/sign", "/api-internal", "swagger", "/forbidden/menu" };
	public static final String[] USER_STATUS_EXCEPTION_URI = { "/sign/signin", "/sign/process-signin", "/user/modify-password", "/user/update-password"};
	
	// 로그 예외 URL, 사용이력, 이중화, 메인 위젯(main, ajax, widget 이건 너무 많아서 키워드로 Filter)
    public static final String[] LOG_EXCEPTION_URI = { "error", "access/list", "accesses", "/forbidden/menu" };
    
    // 파일 업로딩 URL
    public static final String[] MULTIPART_REQUEST_URI = { "/upload-datas", "/layers/" };
 	
//	public static final Pattern STATIC_RESOURCES = Pattern.compile("(^/js/.*)|(^/css/.*)|(^/images/.*)|(^/externlib/.*)|(/favicon.ico)");
}
