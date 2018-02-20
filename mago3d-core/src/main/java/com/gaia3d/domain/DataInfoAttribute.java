package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Data Attribute 정보
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class DataInfoAttribute {
	
	/******** 화면 오류 표시용 ********/
	private String message_code;
	private String error_code;
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

	// Data Attribute 고유번호
	private Long data_attribute_id;
	// Data 고유번호
	private Long data_id;
	// Data Group 고유번호
	private Long project_id;
	// Data Group 이름
	private String project_name;
	// data 고유 식별번호
	private String data_key;
	// data 이름
	private String data_name;
	// Data Control 속성
	private String attributes;
	// 수정일 
	private String update_date;
	// 등록일
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
