package com.gaia3d.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 f4d 변환 이력
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class ConverterLog {
	
	// 화면 표기용
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
	private Long converter_log_id;
	// 파일 변환 그룹 job
	private Long converter_job_id;
	// 파일 정보 고유번호
	private Long upload_log_id;
	// user id
	private String user_id;
	// 상태. 0: 준비, 1: step1, 2: step2, 3: step3, 4: step4, 5: 완료
	private String status;
	
	// geo information input status
	private String geo_status;	
	// origin : latitude, longitude, height 를 origin에 맟춤. boundingboxcenter : latitude, longitude, height 를 boundingboxcenter에 맟춤.
	private String mapping_type;
	// 위도, 경도 정보 geometry 타입
	private String location;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal height;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	// Data Control 속성
	private String attributes;
	// 에러 코드
	private String error_code;
	// visualize count
	private Integer visualize_count;
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
