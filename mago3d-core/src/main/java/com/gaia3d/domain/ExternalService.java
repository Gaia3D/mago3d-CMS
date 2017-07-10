package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Private API
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class ExternalService {
	
	// 상태. 0 : 사용, 1 : 미사용, ??
	public static final String STATUS_USE = "0";
	public static final String STATUS_FIBID = "1";
	
	// 0 : Cache(캐시 Reload), 1 : HA
	public static final String EXTERNAL_CACHE = "0";
	public static final String HA = "1";
//	public static final String SESSION_USER = "3";
	
	public static final Integer SERVER_PORT = 8443;
	public static final Integer USER_PORT = 8445;

//	// 페이징 처리를 위한 시작 ROWNUM
//	private long startRownum;
//	// 페이징 처리를 위한 종료 ROWNUM
//	private long endRownum;
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
	
	/****** validator ********/
	private String method_mode;
	
	// 고유키
	private Long external_service_id;
	// 서비스 코드
	private String service_code;
	// 서비스명
	private String service_name;
	// 서비스 유형
	private String service_type;
	// 서버 IP
	private String server_ip;
	// 화면 표시용 서버 IP
	private String view_server_ip;
	// API KEY
	private String api_key;
	
	// 사용할 프로토콜
	private String url_scheme;
	// 호스트
	private String url_host;
	// 포트
	private Integer url_port;
	// 경로, 리소스 위치
	private String url_path;
	
	// 기본 표시 메뉴, Y : 기본, N : 선택
	private String default_yn;
	// 상태. 0 : 사용, 1 : 미사용
	private String status;
	// 설명
	private String description;
	// 여분 키 1
	private String extra_key1;
	// 여분 키 2
	private String extra_key2;
	// 여분 키 3
	private String extra_key3;
	// 여분 키 값 1
	private String extra_value1;
	// 여분 키 값 2
	private String extra_value2;
	// 여분 키 값 3
	private String extra_value3;
	// 등록일
	private String insert_date;
	
	public String getViewStatus() {
		// 사용자 상태. 0:사용중, 1사용중지
		if(this.status == null || "".equals(this.status)) {
			return "";
		}
		if("0".equals(this.status)) {
			return "사용중";
		} else {
			return "사용중지";
		}
	}

	public String validate() {
		/*if(this.service_code == null || "".equals(this.service_code)) {
			return "external_service.service_code.invalid";
		}*/
		if(this.service_name == null || "".equals(this.service_name)) {
			return "external_service.service_name.invalid";
		}
		if(this.server_ip == null || "".equals(this.server_ip)) {
			return "external_service.server_ip.invalid";
		}
		if(this.service_name == null || "".equals(this.service_name)) {
			return "external_service.service_name.invalid";
		}
		return null;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
