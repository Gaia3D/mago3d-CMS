package com.gaia3d.domain;

import lombok.Data;

/**
 * Issue
 * @author jeongdae
 *
 */
@Data
public class Issue {
	
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
	
	// 댓글 개수
	private Integer comment_count;
	// 사용자명
	private String user_name;
	// 이슈 내용
	private String content;
	
	/************* 업무 처리 ***********/
    // 고유번호
	private Long issue_id;
	// 데이터 그룹
	private Long data_group_id;
	// 사용자 아이디
	private String user_id;
	// 이슈명
	private String title;
	// 우선순위. common_code 동적 생성
	private String priority;
	// 예정일. 마감일
	private String due_date;
	// 이슈 유형. common_code 동적 생성
	private String issue_type;
	// 상태. common_code 동적 생성
	private String status;
	// Data key
	private String data_key;
	// location(위도, 경도)
	private String location;
	// 위도
	private String latitude;
	// 경도
	private String longitude;
	// 요청 IP
	private String client_ip;
	
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
	
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
