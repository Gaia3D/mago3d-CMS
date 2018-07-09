package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 f4d 변환 job
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class ConverterJob {
	
	// job에 포함된 변환 파일 갯수
	private Integer converter_file_count;
	
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
	
	// Primary Key
	private Long converter_job_id;
	// 사용자 고유번호
	private String user_id;
	// title
	private String title;
	// 0: 준비, 1: 성공, 2: 실패
	private String status;
	// 에러 코드
	private String error_code;
	// 등록일
	private String insert_date;

	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
