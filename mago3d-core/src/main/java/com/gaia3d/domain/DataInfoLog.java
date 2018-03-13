package com.gaia3d.domain;

import java.math.BigDecimal;
import java.util.Map;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Data 정보 이력
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class DataInfoLog {
	
	// Data 변경 대기중
	public static final String STATUS_REQUEST = "0";
	// Data 변경 완료
	public static final String STATUS_COMPLETE = "1";
	// Data 변경 요청 기각
	public static final String STATUS_REJECT = "2";
	// Data 변경 요청 되돌리기
	public static final String STATUS_RESET = "3";
	
	// Data info Log Confirm
	public static final String STATUS_LEVEL_CONFIRM = "CONFIRM";
	public static final String STATUS_LEVEL_REJECT = "REJECT";
	public static final String STATUS_LEVEL_RESET = "RESET";
	
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
	
	// 사용자명
	private String user_id;
	private String user_name;
	
	/****** validator ********/
	private String method_mode;

	// 고유번호
	private Long data_info_log_id;
	// Data project 고유번호
	private Long project_id;
	// Data project 이름
	private String project_name;
	// Data 고유번호
	private Long data_id;
	// data 고유 식별번호
	private String data_key;
	// data 이름
	private String data_name;
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
	// 변경전 위도
	private BigDecimal before_latitude;
	// 변경전 경도
	private BigDecimal before_longitude;
	// 변경전 높이
	private BigDecimal before_height;
	// 변경전 heading
	private BigDecimal before_heading;
	// 변경전 pitch
	private BigDecimal before_pitch;
	// 변경전 roll
	private BigDecimal before_roll;
	// data 상태. 0:사용중, 1:사용중지(관리자), 2:기타
	private String status;
	// status 의 ajax 처리 값
	private String status_level;
	// data 등록 방법. 기본 : SELF
	private String data_insert_type;
	// 설명
	private String description;
	// 수정일 
	private String update_date;
	// 표시용 등록일
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	private String view_insert_date;
	// 등록일
	private String insert_date;
	
	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
		
	public String getViewDataInsertType() {
		// TODO 이건 뭔가 아닌거 같은데... 어떻게 처리 하지?
		if(this.data_insert_type == null || "".equals(this.data_insert_type)) {
			return "";
		}
		
		Map<String, Object> commonCodeMap = CacheManager.getCommonCodeMap();
		CommonCode commonCode = (CommonCode)commonCodeMap.get(this.data_insert_type);
		if(commonCode == null) return "";
		else return commonCode.getCode_name();
	}
	
	public String setViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}

	public String getView_insert_date() {
		if(this.insert_date == null || "".equals( insert_date)) {
			view_insert_date = "";
		} else {
			this.view_insert_date = insert_date.substring(0, 19);
		}
		return view_insert_date;
	}

	public void setView_insert_date(String view_insert_date) {
		if(this.insert_date == null || "".equals( insert_date)) {
			view_insert_date = "";
		} else {
			this.view_insert_date = insert_date.substring(0, 19);
		}
	}
}
