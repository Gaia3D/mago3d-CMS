package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * converter 대상 파일
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class ConverterJobFile {
	
	// 화면 표기용
	private String sharing_type;
	private String data_type;
	private String file_name;	
	
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
	private Long converter_job_file_id;
	// 파일 변환 그룹 job
	private Long converter_job_id;
	// 업로딩 정보 고유번호
	private Long upload_data_id;
	// 업로딩 파일 고유번호
	private Long upload_data_file_id;
	// Data project 고유번호
	private Integer project_id;
	// Data project 이름
	private String project_name;
	// user id
	private String user_id;
	// 상태. 0: 성공, 1: 확인필요, 2: 실패
	private String status;
	// 에러 코드
	private String error_code;
	
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
	
	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
