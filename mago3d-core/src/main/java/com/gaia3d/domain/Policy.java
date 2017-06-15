package com.gaia3d.domain;

import com.gaia3d.security.Crypt;
import com.gaia3d.security.Masking;

import lombok.Data;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Data
public class Policy {
	public static final String Y = "Y";
	
	// 서버 시간 설정 쉘
	public static final String SERVER_DATE_SHELL = "config_date.sh";
	// 서버 하드웨어 시간 설정 쉘
	public static final String SERVER_DATE_HWCLOCK_SHELL = "config_date_hwclock.sh";
	
	// 사용자 논리적/물리적 삭제
	public static final String LOGICAL_DELETE_USER = "0";
	public static final String PHYSICAL_DELETE_USER = "1";
	
	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
	public static final String SECURITY_SESSION_HIJACKING_NOT_USE = "0";
	public static final String SECURITY_SESSION_HIJACKING_USE = "1";
	public static final String SECURITY_SESSION_HIJACKING_OTP = "2";
	
	// Single Sign-On 사용 안함
	public static final String SECURITY_SSO_USE_N = "0";
	// Single Sign-On Token 사용
	public static final String SECURITY_SSO_TOKEN = "1";
	
	// 통계 기본 검색 기간. 0 : 1년단위
	public static final String STATISTICS_YEAR = "0";
	// 통계 기본 검색 기간. 1 : 상/하반기
	public static final String STATISTICS_YEAR_HALF = "1";
	// 통계 기본 검색 기간. 2 : 분기별
	public static final String STATISTICS_QUARTER = "2";
	// 통계 기본 검색 기간. 3 : 월별
	public static final String STATISTICS_MONTH = "3";
	
	// 초기 패스워드 생성 방법. 0 : 사용자 아이디 + 초기문자(기본값), 1 : 초기문자
	public static final String PASSWORD_CREATE_WITH_USER_ID = "0";
	public static final String PASSWORD_CREATE_CREATE_CHAR = "1";
	
	// 서버 IP
	private String server_ip;
	// 고유번호
	private Long policy_id;
	
	// 사용자 아이디 최소 길이. 기본값 5
	private Integer user_id_min_length;
	// 사용자 로그인 실패 횟수
	private Integer user_fail_login_count;
	// 사용자 로그인 실패 잠금 해제 기간
	private String user_fail_lock_release;
	// 사용자 마지막 로그인으로 부터 잠금 기간
	private String user_last_login_lock;
	// 사용자 중복 로그인 허용 여부. Y : 허용, N : 허용안함(기본값)
	private String user_duplication_login_yn;
	// 사용자 로그인 인증 방법. 0 : 일반(아이디/비밀번호(기본값)), 1 : 기업용(사번추가), 2 : 일반 + OTP, 3 : 일반 + 인증서, 4 : OTP + 인증서, 5 : 일반 + OTP + 인증서
	private String user_login_type;
	// 사용자 정보 수정시 확인
	private String user_update_check;
	// 사용자 정보 삭제시 확인
	private String user_delete_check;
	// 사용자 정보 삭제 방법. 0 : 논리적(기본값), 1 : 물리적(DB 삭제)
	private String user_delete_type;
	// 사용자 디바이스 정보 수정여부. Y : 허용(기본값), N : 허용안함
	private String user_device_modify_yn;
	
	// 패스워드 변경 주기 기본 30일
	private String password_change_term;
	// 패스워드 최소 길이 기본 8
	private Integer password_min_length;
	// 패스워드 최대 길이 기본 32
	private Integer password_max_length;
	// 패스워드 영문 대문자 개수 기본 1
	private Integer password_eng_upper_count;
	// 패스워드 영문 소문자 개수 기본 1
	private Integer password_eng_lower_count;
	// 패스워드 숫자 개수 기본 1
	private Integer password_number_count;
	// 패스워드 특수 문자 개수 1
	private Integer password_special_char_count;
	// 패스워드 연속문자 제한 개수 3
	private Integer password_continuous_char_count;
	// 초기 패스워드 생성 방법. 0 : 사용자 아이디 + 초기문자(기본값), 1 : 초기문자
	private String password_create_type;
	// 초기 패스워드 생성 문자열. 엑셀 업로드 등
	private String password_create_char;
	// 패스워드로 사용할수 없는 특수문자(XSS). <,>,&,작은따음표,큰따움표
	private String password_exception_char;
	
	// view library. 기본 cesium
	private String geo_view_library;
	// data 폴더. 기본 /data
	private String geo_data_path;
	// cullFace 사용유무. 기본 false
	private String geo_cull_face_enable;
	// timeLine 사용유무. 기본 false
	private String geo_time_line_enable;
	
	// 초기 카메라 이동 유무. 기본 true
	private String geo_init_camera_enable;
	// 초기 카메라 이동 위도
	private String geo_init_latitude;
	// 초기 카메라 이동 경도
	private String geo_init_longitude;
	// 초기 카메라 이동 높이
	private String geo_init_height;
	// 초기 카메라 이동 시간. 초 단위
	private Long geo_init_duration;
	
	// geo server 사용유무
	private String geo_server_enable;
	// geo server url
	private String geo_server_url;
	// geo server layers
	private String geo_server_layers;
	// geo server service 변수값
	private String geo_server_parameters_service;
	// geo server version 변수값
	private String geo_server_parameters_version;
	// geo server request 변수값
	private String geo_server_parameters_request;
	// geo server transparent 변수값
	private String geo_server_parameters_transparent;
	// geo server format 변수값
	private String geo_server_parameters_format;
	
	// 콜백 function 사용유무. 기본값 false
	private String geo_callback_enable;
	// object 선택 callback function 이름
	private String geo_callback_selectedobject;
	
	// 알림 서비스 사용 유무. Y : 사용, N : 미사용(기본값)
	private String notice_service_yn;
	// 알림 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저
	private String notice_service_send_type;
	// 알림 결재 요청/대기시. Y : 사용, N 미사용(기본값)
	private String notice_approval_request_yn;
	// 알림 결재 완료시. Y : 사용, N 미사용(기본값)
	private String notice_approval_sign_yn;
	// 알림 관리 계정 패스워드 변경시. Y : 사용, N 미사용(기본값)
	private String notice_password_update_yn;
	// 알림 결재 대기시. Y : 사용, N 미사용(기본값)
	private String notice_approval_delay_yn;
	// 알림 장애 발생시. Y : 사용, N 미사용(기본값)
	private String notice_risk_yn;
	// 알림 장애 발송 매체. 0 : SMS(기본값), 1 : 이메일, 2 : 메신저
	private String notice_risk_send_type;
	// 알림 발송 장애 등급. 1 : 1등급(기본값), 2 : 2등급, 3 : 3등급
	private String notice_risk_grade;
	
	// 보안 세션 타임아웃. Y : 사용, N 미사용(기본값)
	private String security_session_timeout_yn;
	// 보안 세션 타임아웃 시간. 30분
	private String security_session_timeout;
	// 로그인 시 사용자 등록 IP 체크 유무. Y : 사용, N 미사용(기본값)
	private String security_user_ip_check_yn;
	// 보안 세션 하이재킹 처리. 0 : 미사용, 1 : 사용(기본값), 2 : OTP 추가 인증
	private String security_session_hijacking;
	// 보안 SSO. 0 : 사용안함(기본값), 1 : TOKEN 인증
	private String security_sso;
	// 보안 Single Sign-On 토큰 유효시간(분단위). 기본 3분
	private Integer security_sso_token_verify_time;
	// 보안 로그 보존 방법. 1 : DB(기본값), 2 : 파일
	private String security_log_save_type;
	// 보안 로그 보존 기간. 2년 기본값
	private String security_log_save_term;
	// 보안 동적 차단. Y : 사용, N 미사용(기본값)
	private String security_dynamic_block_yn;
	// API 결과 암호화 사용. Y : 사용, N 사용안함(기본값)
	private String security_api_result_secure_yn;
	// 개인정보 마스킹 처리. Y : 사용(기본값), N 사용안함
	private String security_masking_yn;
	
	// 메인 화면 위젯 표시 갯수. 기본 6개
	private Integer content_main_widget_count;
	// 메인 화면 위젯 Refresh 간격. 기본 65초(모니터링 간격 60초에 대한 시간 간격 고려)
	private Integer content_main_widget_interval;
	// 대몬에서 WAS 모니터링 감시 간격(분단위). 기본 1분
	private Integer content_monitoring_interval;
	// 통계 기본 검색 기간. 0 : 1년단위, 1 : 상/하반기, 2 : 분기별, 3 : 월별
	private String content_statistics_interval;
	// 현재 서버가 Active, Standby 인지 상태를 표시하는 주기
	private Integer content_load_balancing_interval;
	// 메뉴 그룹 최상위 그룹명
	private String content_menu_group_root;
	// 사용자 그룹 최상위 그룹명
	private String content_user_group_root;
	// 서버 그룹 최상위 그룹명
	private String content_server_group_root;
	// 계정 그룹 최상위 그룹명
	private String content_data_group_root;
	
	// Java TimeZone 설정. Asia/Seoul(기본), UTC(Universal Time Coordinated, 세계협정시)
	private String os_timezone;
	// 서버 시간 설정 방법. 0 : 직접 이력, 1 : KT, 2 : LG, 3 : 아이네트, 4 : 마이크로소프트
	private String os_ntp;
	// 시스템 시간 설정을 위한 임시 파라미터
	private String os_ntp_day;
	private String os_ntp_hour;
	private String os_ntp_minute;
	// Radius Key
	private String os_radius_secret;
	
	// 서비스명
	private String site_name;
	// 사이트 관리자명
	private String site_admin_name;
	// 사이트 관리자 핸드폰 번호
	private String site_admin_mobile_phone;
	// 사이트 관리자 이메일
	private String site_admin_email;
//	private MultipartFile uploadfile_top;
//	private MultipartFile uploadfile_bottom;
	private String uploadfile_top_value;
	private String uploadfile_bottom_value;
	private String site_product_log;
	private String site_company_log;
	
	// Email 연동 서버 host
	private String backoffice_email_host;
	// Email 연동 서버 포트
	private Integer backoffice_email_port;
	// Email 연동 서버 사용자
	private String backoffice_email_user;
	// Email 연동 서버 비밀번호
	private String backoffice_email_password;
	// 사용자 DB 연동 Driver
	private String backoffice_user_db_driver;
	// 사용자 DB 연동 URL
	private String backoffice_user_db_url;
	// 사용자 DB 연동 사용자
	private String backoffice_user_db_user;
	// 사용자 DB 연동 비밀번호
	private String backoffice_user_db_password;
	
	// 제품명
	private String solution_name;
	// 제품 버전
	private String solution_version;
	// 제품 회사명
	private String solution_company;
	// 제품 회사 연락처
	private String solution_company_phone;
	// 제품 회사 담당자
	private String solution_manager;
	// 제품 회사 담당자 전화번호
	private String solution_manager_phone;
	// 제품 회사 담당자 이메일
	private String solution_manager_email;
	
	// 등록일
	private String insert_date;
	
	public String getViewSiteAdminMobilePhone() {
		return Crypt.decrypt(site_admin_mobile_phone);
	}
	
	public String getMaskingSiteAdminMobilePhone() {
		return getMaskingData(site_admin_mobile_phone, "PHONE");
	}
	
	public String getViewMaskingSiteAdminMobilePhone() {
		return getMaskingData(Crypt.decrypt(site_admin_mobile_phone), "PHONE");
	}

	public String getViewSiteAdminEmail() {
		return Crypt.decrypt(site_admin_email);
	}
	
	public String getMaskingSiteAdminEmail() {
		return getMaskingData(site_admin_email, "EMAIL");
	}
	
	public String getViewMaskingSiteAdminEmail() {
		return getMaskingData(Crypt.decrypt(site_admin_email), "EMAIL");
	}
	
	public String getViewSolutionCompanyPhone() {
		return Crypt.decrypt(solution_company_phone);
	}
	
	public String getMaskingSolutionCompanyPhone() {
		return getMaskingData(solution_company_phone, "PHONE");
	}
	
	public String getViewMaskingSolutionCompanyPhone() {
		return getMaskingData(Crypt.decrypt(solution_company_phone), "PHONE");
	}
	
	public String getViewSolutionManagerPhone() {
		return Crypt.decrypt(solution_manager_phone);
	}
	
	public String getMaskingSolutionManagerPhone() {
		return getMaskingData(solution_manager_phone, "PHONE");
	}
	
	public String getViewMaskingSolutionManagerPhone() {
		return getMaskingData(Crypt.decrypt(solution_manager_phone), "PHONE");
	}
	
	public String getViewSolutionManagerEmail() {
		return Crypt.decrypt(solution_manager_email);
	}
	
	public String getMaskingSolutionManagerEmail() {
		return getMaskingData(solution_manager_email, "EMAIL");
	}
	
	public String getViewMaskingSolutionManagerEmail() {
		return getMaskingData(Crypt.decrypt(solution_manager_email), "EMAIL");
	}
	
	/**
	 * 개인정보 마스킹 처리
	 * @param value
	 * @param type
	 * @return
	 */
	public String getMaskingData(String value, String type) {
		if(CacheManager.isUserInfoMasking()) {
			return Masking.getMasking(value, type);
		}
		return value;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
