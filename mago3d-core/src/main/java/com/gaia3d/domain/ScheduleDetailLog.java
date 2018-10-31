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
public class ScheduleDetailLog extends SearchDomain {
	
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
