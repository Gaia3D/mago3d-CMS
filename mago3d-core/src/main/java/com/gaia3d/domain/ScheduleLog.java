package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 스케줄 실행 이력
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString(callSuper=true)
public class ScheduleLog extends SearchDomain {

	// 성공
	public static final String EXECUTE_RESULT_SUCCESS = "0";
	// 실패
	public static final String EXECUTE_RESULT_FAIL = "1";
	// 부분 성공
	public static final String EXECUTE_RESULT_SUBSUCCESS = "2";
	
	// 스케줄명
	private String schedule_name;
	
	// 고유번호
	private Long schedule_log_id;
	// 스케줄 고유번호
	private Long schedule_id;
	// 실행 전체 결과. 0 : 성공, 1 : 실패, 2 : 부분성공
	private String execute_result;
	// 실행 결과 총 건수
	private Integer execute_total_count;
	// 실행 결과 상세 내용
	private String execute_message;
	// 등록일
	private String insert_date;
	
	public String getViewExecuteResult() {
		if("0".equals(this.execute_result)) {
			return "성공";
		} else if("1".equals(this.execute_result)) {
			return "실패";
		} else if("2".equals(this.execute_result)) {
			return "부분성공";
		}
		return "";
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
