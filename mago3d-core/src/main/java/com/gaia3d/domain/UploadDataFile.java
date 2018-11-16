package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 업로드 파일 정보 
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class UploadDataFile {
	
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
	private Long upload_data_file_id;
	// 사용자 업로드 정보 고유번호
	private Long upload_data_id;
	// 프로젝트 고유키
	private Integer project_id;
	// 공유 타입. 0 : common, 1: public, 2 : private, 3 : sharing
	private String sharing_type;
	// 데이터 타입. 3ds, .obj, .dae, .ifc, citygml, indoorgml
	private String data_type;
	// 사용자 아이디
	private String user_id;
	// 사용자명
	private String user_name;
	
	// 디렉토리/파일 구분. D : 디렉토리, F : 파일
	private String file_type;
	// 파일 이름
	private String file_name;
	// 파일 실제 이름
	private String file_real_name;
	// 파일 경로
	private String file_path;
	// 계층구조 깊이. 1부터 시작
	private Integer depth;
	// 파일 사이즈
	private String file_size;
	// 파일 확장자
	private String file_ext;
	
	// 오류 메시지
	private String error_message;
	// converter 횟수
	private Integer converter_count;
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
