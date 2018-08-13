package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 파일 upload 이력
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class ConverterUploadLog extends FileInfo {
	
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
	private Long converter_upload_log_id;
	// user id
	private String user_id;
	// file name
	private String file_name;
	// file real name. Name of file uploaded by user
	private String file_real_name;
	// file path
	private String file_path;
	// file size
	private String file_size;
	// file ext
	private String file_ext;
	// f4d converter count
	private Integer converter_count;
	private String insert_date;
	
	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
}
