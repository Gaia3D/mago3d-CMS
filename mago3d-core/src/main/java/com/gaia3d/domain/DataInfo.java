package com.gaia3d.domain;

import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Data 정보
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class DataInfo {
	
	// Data 상태가 사용중
	public static final String STATUS_USE = "0";
	// Data 상태가 중지(관리자)
	public static final String STATUS_FORBID = "1";
	// Data 상태가 잠금(비밀번호 실패횟수 초과)
	public static final String STATUS_FAIL_LOGIN_COUNT_OVER = "2";
	// Data 상태가 휴면(로그인 기간)
	public static final String STATUS_SLEEP = "3";
	// Data 상태가 만료(사용기간 종료)
	public static final String STATUS_TERM_END = "4";
	// Data 상태가 삭제(화면 비표시)
	public static final String STATUS_LOGICAL_DELETE = "5";
	// Data 상태가 임시 비밀번호(비밀번호 찾기, 관리자 설정에 의한 임시 비밀번호 발급 시)
	public static final String STATUS_TEMP_PASSWORD = "6";
	
	// data_group 에 등록되지 않은 Data
	private String[] data_all_id;
	// data_group 에 등록된 Data
	private String[] data_select_id;
	
	/******** 화면 오류 표시용 ********/
	private String message_code;
	private String error_code;
	// 아이디 중복 확인 hidden 값
	private String duplication_value;
	// 논리 삭제 
	private String delete_flag;
	
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
	private Long list_counter = 10l;
	
	/****** validator ********/
	private String method_mode;

	// 고유번호
	private Long data_id;
	// Data Group 고유번호
	private Long data_group_id;
	// Data Group 이름
	private String data_group_name;
	// data 고유 식별번호
	private String data_key;
	// data 이름
	private String data_name;
	// 위도, 경도 정보 geometry 타입
	private String location;
	// 위도
	private String latitude;
	// 경도
	private String longitude;
	// 높이
	private String height;
	// heading
	private String heading;
	// pitch
	private String pitch;
	// roll
	private String roll;
	// data 상태. 0:사용중, 1:사용중지(관리자), 2:기타
	private String status;
	// data 등록 방법. 기본 : SELF
	private String data_insert_type;
	// 수정일 
	private String update_date;
	// 등록일
	private String insert_date;
	
	private String search_data_name;
	private String search_except_data_name;
	
	public String getViewStatus() {
		// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:기타)
		if(this.status == null || "".equals(this.status)) {
			return "";
		}
		if("0".equals(this.status)) {
			return "사용중";
		} else if("1".equals(this.status)) {
			return "사용중지";
		} else if("2".equals(this.status)) {
			return "기타";
		}
		return "";
	}
	
	public String getViewDataInsertType() {
		// TODO 이건 뭔가 아닌거 같은데... 어떻게 처리 하지?
		if(this.data_insert_type == null || "".equals(this.data_insert_type)) {
			return "";
		}
		
		Map<String, Object> commonCodeMap = CacheManager.getCommonCodeMap();
		CommonCode commonCode = (CommonCode)commonCodeMap.get(this.data_insert_type);
		if(commonCode == null) return "";
		else return commonCode.getCode_name();
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
