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
@ToString(callSuper=true)
public class ConverterLog extends SearchDomain {
	
	// 화면 표기용
	private String file_name;	
	
	/****** validator ********/
	private String method_mode;
	
	// 고유번호
	private Long converter_log_id;
	// 파일 변환 그룹 job
	private Long converter_job_id;
	// 파일 정보 고유번호
	private Long converter_upload_log_id;
	// user id
	private String user_id;
	// Data project 고유번호
	private Long project_id;
	// Data project 이름
	private String project_name;
	// data 고유 식별번호
	private String data_key;
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
	// 상태. 0: 미등록, 1: 등록중, 2: 등록완료
	private String status;

  // 변환 결과. 0: 성공, 1: 확인필요, 2: 실패
	private String converter_result;	
	// 에러 코드
	private String error_code;
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
