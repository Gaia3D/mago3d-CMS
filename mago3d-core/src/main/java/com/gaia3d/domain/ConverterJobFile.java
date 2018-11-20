package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * converter 대상 파일
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString(callSuper=true)
public class ConverterJobFile {
	
	// 화면 표기용
	private String file_name;	
	
	/****** validator ********/
	private String method_mode;
	
	// 고유번호
	private Long converter_job_file_id;
	// 파일 변환 그룹 job
	private Long converter_job_id;
	// 업로딩 정보 고유번호
	private Long upload_data_id;
	// 업로딩 파일 고유번호
	private Long upload_data_file_id;
	// Data project 고유번호
	private Integer project_id;
	// Data project 이름
	private String project_name;
	// user id
	private String user_id;
	// 상태. 0: 성공, 1: 확인필요, 2: 실패
	private String status;
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
