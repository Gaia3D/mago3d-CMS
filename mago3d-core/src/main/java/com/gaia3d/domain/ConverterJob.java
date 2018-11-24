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
	
	public static final String JOB_READY = "0";
	public static final String JOB_SUCCESS = "1";
	public static final String JOB_CONFIRM = "2";
	public static final String JOB_FAIL = "3";
	
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
	// 업로드 고유키
	private Long upload_data_id;
	// 사용자 고유번호
	private String user_id;
	// title
	private String title;
	// 변환 템플릿. 0 : 정밀(공장배관), 1 : 기본, 2 : 큰 건물, 3 : 초대형 건물
	private String converter_type;
	// 대상 file 개수
	private Integer file_count;
	// 0: 준비, 1: 성공, 2: 확인필요, 3: 실패
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
