package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 파일 파싱 이력
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class FileParseLog {
	
	// Excel 데이터 파싱 로그
	public static final String FILE_PARSE_LOG = "0";
	// Excel 데이터 파싱 후 DB Insert 로그
	public static final String DB_INSERT_LOG = "1";
	// 엑셀 파일 한 row 파싱 성공
	public static final String EXCEL_PARSE_SUCCESS = "0";
	// 엑셀 파일 한 row 파싱 실패
	public static final String EXCEL_PARSE_FAIL = "1";
	
	// 고유번호
	private Long file_parse_log_id;
	// 파일 정보 고유번호
	private Long file_info_id;
	// 식별자 값
	private String identifier_value;
	// validation
	private String error_code;
	// 로그 타입 0: 파일, 1: insert
	private String log_type;
	// 상태. 0: success, 1: error
	private String status; 
	
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
