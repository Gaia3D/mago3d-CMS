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
@ToString
public class ScheduleDetailLog {
	
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;

	// 스케줄 실행 상세 이력 고유번호
	private Long schedule_detail_log_id;
	// 스케줄 실행 이력 고유번호
	private Long schedule_log_id;
	// 실행 결과. 0 : 성공, 1 : 실패
	private String execute_detail_result;
	// 실행 결과 상세 내용
	private String execute_detail_message;
	// 등록일
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
