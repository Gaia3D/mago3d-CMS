package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Single Sign-On Token 생성, 검증
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class SSOLog {
	
	// Token 상태 생성
	public static final String TOKEN_CREATE = "0";
	// Token 상태 검증성공
	public static final String TOKEN_SUCCESS = "1";
	// Token 상태 실패
	public static final String TOKEN_FAIL = "2";
	// Token 상태 시간만료
	public static final String TOKEN_EXPIRE = "3";
	
	// 총건수
	private Long totalCount;
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	/********** 검색 조건 ************/
	private String search_word;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String search_option;
	private String search_value;
	private String start_date;
	private String end_date;
	private String order_word;
	private String order_value;
	
	// Single Sign-On 토큰 유효시간(분단위). 기본 3분
	private Integer security_sso_token_verify_time;
	
	// 에러 코드
	private String error_code;
	
	// 고유키
	private Long sso_log_id;
	// 사용자 아이디
	private String user_id;
	// 서버 ip
	private String server_ip;
	// 토큰
	private String token;
	// 토큰 상태. 0 : 생성, 1 : 검증성공, 2 : 실패, 3 : 시간만료
	private String token_status;
	// 사용 매체( 0 : 웹, 1 : Manager(Engine), 2 : Tray, 3 : 기타)
	private String device_kind;
	// 관리자 요청 : ADMIN_REQUEST, 사용자 요청 : USER_REQUEST
	private String request_type;
	// SSO 인증 후 이동할 URL
	private String redirect_url;
	// 수정일
	private String update_date;
	// 년도
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년중 몇주
	private String year_week;
	// 이번달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;
	// 설명
	private String description;
	// 등록일
	private String insert_date;
	
	public String getViewTokenStatus() {
		// 토큰 상태. 0 : 생성, 1 : 검증성공, 2 : 실패, 3 : 시간만료
		if("0".equals(this.token_status)) {
			return "생성";
		} else if("1".equals(token_status)) {
			return "인증성공";
		} else if("2".equals(token_status)) {
			return "인증실패";
		} else if("3".equals(token_status)) {
			return "시간만료";
		}
		return "";
	}
	
	public String getViewDeviceKind() {
		if(this.device_kind == null || "".equals(this.device_kind)) {
			return "";
		}
		if("0".equals(this.device_kind)) {
			return "웹";
		} else {
			return "기타";
		}
	}
	
	public String getViewUpdateDate() {
		if(this.update_date == null || "".equals( update_date)) {
			return "";
		}
		return update_date.substring(0, 19); 
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
