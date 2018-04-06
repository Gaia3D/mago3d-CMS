package com.gaia3d.domain;

import com.gaia3d.util.StringUtil;
import lombok.Data;

/**
 * 게시판
 * @author jeongdae
 *
 */
@Data
public class Board {
	
	// validation
	private String error_code;
	
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
	private String order_word;
	private String order_value;
	
	/****** validator ********/
	private String method_mode;
	
	// 댓글 개수
	private Integer comment_count;
	
	/*********** 테이블 *************/
	// 게시물 상세 고유번호
	private Long board_detail_id;
	// 내용
	private String contents;
	// 게시판 댓글 고유번호
	private Long board_comment_id;
	// comment
	private String comment;
	
	// 고유번호
	private Long board_id;
	// 제목
	private String title;
	// 사용자 아이디
	private String user_id;
	// 사용자 이름
	private String user_name;
	// 게시 시작시간
	private String start_date;
	private String start_day;
	private String start_hour;
	private String start_minute;
	// 게시 종료시간
	private String end_date;
	private String end_day;
	private String end_hour;
	private String end_minute;	
	
	// 사용유무, Y : 사용, N : 사용안함
	private String use_yn;
	// 요청 IP
	private String client_ip;
	// 조회수
	private Long view_count;
	// 등록일
	private String register_date;

	public String getViewContents() {
		if(this.contents == null || "".equals(this.contents)) {
			return "";
		}
		
		String str = StringUtil.getStringConvertForHtml(this.contents);
		str = StringUtil.getStringNewLineConvertForHtml(str);
		
		return str;
	}
	
	public String getViewUseYn() {
		if("Y".equals(this.use_yn)) {
			return "사용";
		} else if("N".equals(this.use_yn)) {
			return "사용안함";
		} else {
			return "";
		}
	}
	
	public String validate() {
		if(this.title == null || "".equals( title)) {
			return "boardcomment.invalid";
		}
		if(this.contents == null || "".equals( contents)) {
			return "boardcomment.invalid";
		}
		return null;
	}
	
	public String getViewStartDate() {
		if(this.start_date == null || "".equals( start_date)) {
			return "";
		}
		return start_date.substring(0, 19);
	}
	public String getViewEndDate() {
		if(this.end_date == null || "".equals( end_date)) {
			return "";
		}
		return end_date.substring(0, 19);
	}
	public String getViewRegisterDate() {
		if(this.register_date == null || "".equals( register_date)) {
			return "";
		}
		return register_date.substring(0, 19);
	}
}
