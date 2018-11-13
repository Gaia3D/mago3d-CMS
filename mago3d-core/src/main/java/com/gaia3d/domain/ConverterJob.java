package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 f4d 변환 job
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString(callSuper=true)
public class ConverterJob extends SearchFilter {
	
	public static final String JOB_READY = "0";
	public static final String JOB_SUCCESS = "1";
	public static final String JOB_MIX = "2";
	public static final String JOB_FAIL = "3";
	
	// job에 포함된 변환 파일 갯수
	private Integer converter_file_count;
	
	/****** validator ********/
	private String method_mode;
	
	// Primary Key
	private Long converter_job_id;
	// 사용자 고유번호
	private String user_id;
	// title
	private String title;
	// converter_type is '0: 기본, 1: 큰 메쉬 하나';
	private String converter_type;
	// 0: 준비, 1: 성공, 2: 실패
	private String status;
	// 에러 코드
	private String error_code;
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
