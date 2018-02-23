package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 파일 관리
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class FileInfo {
	
	// validation
	private String error_code;
	
	// 고유번호
	private Long file_info_id;
	// 사용자 아이디
	private String user_id;
	// 업무 타입
	private String job_type;
	// 파일 이름
	private String file_name;
	// 파일 실제 이름
	private String file_real_name;
	// 파일 경로
	private String file_path;
	// 파일 사이즈
	private String file_size;
	// 파일 확장자
	private String file_ext;
	// Excel 전체 데이터 건수
	private Integer total_count;
	// Excel 파싱 성공 건수
	private Integer parse_success_count;
	// Excel 파싱 오류
	private Integer parse_error_count;
	// Excel 데이터 Target Table SQL Insert 성공 건수
	private Integer insert_success_count;
	// Excel 데이터 Target Table SQL Insert 실패 건수
	private Integer insert_error_count;
	// Excel 데이터 Target Table SQL update 성공 건수
	private Integer update_success_count;
	// Excel 데이터 Target Table SQL Insert 실패 건수
	private Integer update_error_count;
	// 등록일
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
