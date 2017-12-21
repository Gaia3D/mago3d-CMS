package com.gaia3d.domain;

import java.math.BigDecimal;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Issue
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class Issue {
	
	public static final String TITLE = "title";
	
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
	private Long list_counter = 10l;
	
	// 이슈 상세 고유번호
	private Long issue_detail_id;
	// 댓글 개수
	private Integer comment_count;
	// 프로젝트명
	private String project_name;
	// 사용자명
	private String user_name;
	// 이슈 내용
	private String contents;
	// 이슈 댓글 고유번호
	private Long issue_comment_id;
	// comment
	private String comment;
	// 조회수
	private Integer view_count;
	// 대리자
	private String assignee;
	// 레포트
	private String reporter;
	// 첨부파일
	private String file_name;
	
	private MultipartFile multipartFile;
	
	/****** validator ********/
	private String method_mode;
	
	/************* 업무 처리 ***********/
    // 고유번호
	private Long issue_id;
	// 프로젝트 아이디
	private Long project_id;
	// 사용자 아이디
	private String user_id;
	// 이슈명
	private String title;
	// 우선순위. common_code 동적 생성
	private String priority;
	private String priority_name;
	private String priority_css_class;
	private String priority_image;
	
	// 예정일. 마감일
	private String due_date;
	private String due_day;
	private String due_hour;
	private String due_minute;
	// 이슈 유형. common_code 동적 생성
	private String issue_type;
	private String issue_type_name;
	private String issue_type_css_class;
	private String issue_type_images;
	// 상태. common_code 동적 생성
	private String status;
	// Data key
	private String data_key;
	// Object key
	private String object_key;
	// location(위도, 경도)
	private String location;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal height;
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
	
	// 수정일
	private String update_date;
	// 등록일
	private String insert_date;
	
	public String getViewDueDate() {
		if(this.due_date == null || "".equals( due_date)) {
			return "";
		} else {
			if(due_date.length() > 19) {
				return due_date.substring(0, 19);
			} else {
				return due_date;
			}
		}
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		} else {
			if(insert_date.length() > 19) {
				return insert_date.substring(0, 19);
			} else {
				return insert_date;
			}
		}
	}
	
	public String validate() {
		if(this.title == null || "".equals( title)) {
			return "title.invalid";
		}
		if(this.contents == null || "".equals( contents)) {
			return "contents.invalid";
		}
		return null;
	}
}
