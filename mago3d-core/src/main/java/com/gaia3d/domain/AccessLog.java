package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 서비스 요청 이력
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class AccessLog {
	
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
	
	// 고유번호
	private Long access_log_id;
	// 사용자 아이디
	private String user_id;
	// 사용자 이름
	private String user_name;
	// 요청 IP
	private String client_ip;
	// URI
	private String request_uri;
	// 요청 Paramter
	private String parameters;
	// User-Agent
	private String user_agent;
	// Referer
	private String referer;
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
	// 등록일
	private String insert_date;
	
	public String getViewRequestUri() {
		if(this.request_uri == null || "".equals(this.request_uri)) {
			return "";
		}
		if(this.request_uri.length() > 60) {
			return this.request_uri.substring(0, 60) + "...";
		}
		return this.request_uri;
	}
	
	public String getViewParameters() {
		if(this.parameters == null || "".equals(this.parameters)) {
			return "";
		}
		
		if(this.parameters.length() > 30) {
			return this.parameters.substring(0, 30) + "...";
		}
		
		return this.parameters;
	}
	public String getViewUserAgent() {
		String userAgent = this.user_agent;
    	if(userAgent != null && userAgent.length() > 256) {
    		userAgent = userAgent.substring(0, 250) + "...";
    	}
    	return userAgent;
	}
	public String getViewReferer() {
		String referer = this.referer;
    	if(referer != null && referer.length() > 256) {
    		referer = referer.substring(0, 250) + "...";
    	}
    	return referer;
	}
	
	public String getViewRegisterDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
