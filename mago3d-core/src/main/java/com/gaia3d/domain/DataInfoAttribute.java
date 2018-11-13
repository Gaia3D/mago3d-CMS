package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Data Attribute 정보
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString(callSuper=true)
public class DataInfoAttribute extends SearchFilter {
	
	/******** 화면 오류 표시용 ********/
	private String message_code;
	private String error_code;
	// 논리 삭제 
	private String delete_flag;
	
	/****** validator ********/
	private String method_mode;
	
	// 프로젝트별 데이터 attribute 파일 경로
	private String project_data_attribute_path;

	// Data Attribute 고유번호
	private Long data_attribute_id;
	// Data 고유번호
	private Long data_id;
	// Data Group 고유번호
	private Long project_id;
	// Data Group 이름
	private String project_name;
	// data 고유 식별번호
	private String data_key;
	// data 이름
	private String data_name;
	// Data Control 속성
	private String attributes;
	// 수정일 
	private String update_date;
	// 등록일
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
