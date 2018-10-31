package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 스케줄
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString(callSuper=true)
public class Schedule extends SearchDomain {
	
	// 로그인 실패 건수 잠김 해제
	public static final String USER_LOGIN_FAIL_LOCK_RELEASE = "USER_LOGIN_FAIL_LOCK_RELEASE";
	
	/****** validator ********/
	private String method_mode;
	
	// 최근 실행 결과
	private String result;

	// 고유번호
	private Long schedule_id;
	// 스케줄명
	private String schedule_name;
	// 스케줄명
	private String schedule_code;
	// 스케줄 실행 Quartz 표현식
	private String expression;
	// 사용유무, Y : 사용, N : 사용안함
	private String use_yn;
	// 시작 시간
	private String start_date;
	// 종료 시간
	private String end_date;
	// 등록자 아이디
	private String user_id;
	// 실행 주체, 0 : WEB, 1 : 엔진
	private String execute_type;
	// 설명
	private String description;
	// 등록일
	private String insert_date;
	
	public String getViewExecuteType() {
		if("0".equals(this.execute_type)) {
			return "WEB";
		} else {
			return "";
		}
	}
	
	public String getViewUseYn() {
		if("Y".equals(this.use_yn)) {
			return "사용";
		} else if("N".equals(this.use_yn)) {
			return "미사용";
		} else {
			return "";
		}
	}

	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
