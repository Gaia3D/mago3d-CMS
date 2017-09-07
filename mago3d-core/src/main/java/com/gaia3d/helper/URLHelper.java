package com.gaia3d.helper;

public class URLHelper {

    public static final String AJAX_URI = "ajax";
    public static final String POPUP_URL = "popup";
    public static final String LOGIN_URL = "/login/login.do";
    public static final String POPUP_LOGIN_URL = "/login/popup-login.do";
    
    // login 의 경우 통과
    public static final String[] EXCEPTION_URI = { 	"error", "login", "call-api", "call-radius", "call-cache", "call-ha-status", "call-list-user-session", "call-icmp-duplication-check", 
    												"call-dbcp" };
    public static final String[] USER_STATUS_EXCEPTION_URI = { "/login/login.do", "/login/process-login.do", "/user/modify-password.do", "/user/update-password.do"};
    public static final String[] LICENSE_EXCEPTION_URI = { "modify-license", "update-license", "ajax-update-license" };
    public static final String LICENSE_URL = "/config/modify-license.do";
    // 로그 예외 URL, 사용이력, 이중화, 메인 위젯(main, ajax, widget 이건 너무 많아서 키워드로 Filter)
    public static final String[] LOG_EXCEPTION_URI = { "error", "ajax-loadbalancing-status", "list-access-log", "ajax-list-access-log" };
	// 엑셀 파일 처리 관련 URL
	public static final String[] MULTIPART_REQUEST_URI = { "insert-excel" };
	// 화면 표시용 Alias Menu 정보 
	public static final String[][] ALIAS_URI = new String[][] { 
		{ "/user/modify-password.do", "/user/list-user.do", "사용자 비밀번호 변경" },
		{ "/user/update-password.do", "/user/list-user.do", "사용자 비밀번호 변경" },
		{ "/user/modify-user.do", "/user/list-user.do", "사용자 정보 수정" },
		{ "/user/detail-user.do", "/user/list-user.do", "사용자 상세 정보" },
		{ "/role/input-role.do", "/role/list-role.do", "Role 등록" },
		{ "/role/modify-role.do", "/role/list-role.do", "Role 수정" },
		{ "/role/detail-role.do", "/role/list-role.do", "Role 정보" },
		{ "/server/modify-server.do", "/server/list-server.do", "서버 수정" },
		{ "/server/detail-server.do", "/server/list-server.do", "서버 상세 정보" },
		{ "/loadbalancing/modify-interface.do", "/loadbalancing/list-interface.do", "인터페이스 설정" },
		{ "/loadbalancing/input-vrrp-interface.do", "/loadbalancing/index.do", "VRRP Interface 추가" },
		{ "/loadbalancing/modify-vrrp-interface.do", "/loadbalancing/index.do", "VRRP Interface 수정" },
		{ "/loadbalancing/input-icmp-info.do", "/loadbalancing/index.do", "ICMP 추가" },
		{ "/loadbalancing/modify-icmp-info.do", "/loadbalancing/index.do", "ICMP 수정" },
		{ "/api/modify-external-service.do", "/api/list-external-service.do", "Private API 수정" },
		{ "/code/modify-code.do", "/code/list-code.do", "공통 코드 수정" },
		{ "/board/modify-board.do", "/board/list-board.do", "공지사항 수정" },
		{ "/board/detail-board.do", "/board/list-board.do", "공지사항 상세 정보" }
	};
}
