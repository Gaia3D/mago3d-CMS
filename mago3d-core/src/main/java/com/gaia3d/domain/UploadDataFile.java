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
	
	private SearchFilter searchFilter;
	
	/****** validator ********/
	private String method_mode;
	
	// 고유번호
	private Long upload_data_file_id;
	// 사용자 업로드 정보 고유번호
	private Long upload_data_id;
	// 프로젝트 고유키
	private Long project_id;
	// 공유 타입. 0 : common, 1: public, 2 : private, 3 : sharing
	private String sharing_type;
	// 데이터 타입. 3ds, .obj, .dae, .ifc, citygml, indoorgml
	private String data_type;
	// 사용자 아이디
	private String user_id;
	// 사용자명
	private String user_name;
	
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
	// 등록일
	private String insert_date;
		
	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
}
