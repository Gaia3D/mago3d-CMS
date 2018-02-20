package com.gaia3d.domain;

import java.math.BigDecimal;
import java.util.Map;

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
	private Long data_id;
	// Data Group 고유번호
	private Long project_id;
	// Data Group 이름
	private String project_name;
	// data 고유 식별번호
	private String data_key;
	// data 고유 식별번호
	private String old_data_key;
	// 부모 data 고유 식별번호
	private String parent_data_key;
	// data 이름
	private String data_name;
	// 부모 고유번호
	private Long parent;
	// 부모 이름(화면 표시용)
	private String parent_name;
	// 부모 깊이
	private Integer parent_depth;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer view_order;
	// 자식 존재 유무, Y : 존재, N : 존재안함(기본)
	private String child_yn;
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
	// 속성
	private String attributes;
	// data 상태. 0:사용중, 1:사용중지(관리자), 2:기타
	private String status;
	// 사용유무, Y : 사용, N : 사용안함
	private String use_yn;
	// 공개 유무. 기본값 비공개 N
	private String public_yn;
	// data 등록 방법. 기본 : SELF
	private String data_insert_type;
	// 설명
	private String description;
	// 수정일 
	private String update_date;
	// 등록일
	private String insert_date;
	
	private String search_data_name;
	private String search_except_data_name;
	
	public String getViewStatus() {
		// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:기타)
		if(this.status == null || "".equals(this.status)) {
			return "";
		}
		if("0".equals(this.status)) {
			return "사용중";
		} else if("1".equals(this.status)) {
			return "사용중지";
		} else if("2".equals(this.status)) {
			return "기타";
		}
		return "";
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
	
	public String getViewAttributes() {
		if(this.attributes == null || "".equals( attributes) || attributes.length() < 20) {
			return attributes;
		}
		return attributes.substring(0, 20) + "...";
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
