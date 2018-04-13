package com.gaia3d.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 통계
 * @author
 */
@Getter
@Setter
@ToString
public class ReportMaintenance {
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
		
	private String start_date;
	private String end_date;
	private String order_word;
	private String order_value;
	
	private Long report_maintenance_id;
	
	// 일자
	private String report_date;
	// 시간
	private String report_time;
	// 서비스명
	private String service_name;
	// 버전
	private String version;
	// 호스트명
	private String host_name;
	// IP
	private String ip;
	
	// 년
	private String year;
	// 월
	private String month;
	// 올해
	private String this_year;
	
	// CPU 사용율
	private Float cpu_usage;
	// 메모리 사용율
	private Float memory_usage;
	// 디스크 사용율
	private Float disk_usage;
	// DB 사용율
	private Integer db_size;
	// WEB 상태 On/Off. A:ALIVE, D:DEAD, U:UNKNOWN
	private String web_status;
	// DB 상태  On/Off. A:ALIVE, D:DEAD, U:UNKNOWN
	private String db_state;
	
	// 올해 서버수
	private Long this_year_server_total_count;
	// 서버 총건수
	private Long server_total_count;
	// 올해 사용자 총건수
	private Long this_year_user_total_count;
	// 사용자 총건수
	private Long user_total_count;
	
	// 이미지 로그
	private String company_logo;
	
	// 등록일
	private String insert_date;
	
	private String method_mode;
	
	public String getViewRegisterDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
