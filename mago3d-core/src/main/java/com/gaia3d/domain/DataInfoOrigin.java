package com.gaia3d.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Data 변환전 정보(origin)
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class DataInfoOrigin {
	
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

	// 고유번호
	private Long data_origin_id;
	// 고유번호
	private Long data_id;
	// data origin 이름
	private String data_origin_name;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal height;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	// link
	private String link;
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
