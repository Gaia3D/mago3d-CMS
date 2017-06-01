package com.gaia3d.domain;

import com.gaia3d.security.Crypt;
import com.gaia3d.security.Masking;

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
	
	/************* 업무 처리 ***********/
    // 사용자명
    private String user_name;
	
	// 고유키
	private Long issue_id;
	
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
