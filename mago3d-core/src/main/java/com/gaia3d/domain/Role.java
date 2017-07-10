package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Role
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class Role {

	public static final String DELIMITER = "!@#";
	
	// Role 유형. 0 : 사용자, 1 : 서버, 2 : 계정
	public static final String ROLE_TYPE_USER = "0";
	public static final String ROLE_TYPE_SERVER = "1";
	public static final String ROLE_TYPE_ACCOUNT = "2";
	
	/****** validator ********/
	private String method_mode;
	
	private String order_word;
	private String order_value;
	
	// 고유번호
	private Long role_id;
	// Role 명
	private String role_name;
	// Role KEY
	private String role_key;
	// Role 유형. 0 : 사용자, 1 : 서버, 2 : 계정
	private String role_type;
	// 업무 유형 0 : 로그인
	private String business_type;
	// 사용유무. Y : 사용, N : 사용안함
	private String use_yn;
	// 기본 사용유무. Y : 사용, N : 사용안함
	private String default_yn;
	// 설명
	private String description;
	// 등록일
	private String insert_date;
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	public String getViewRoleType() {
		// Role 유형. 0 : 사용자, 1 : 서버, 2 : 계정
		if("0".equals(this.role_type)) {
			return "사용자";
		} else if("1".equals(this.role_type)) {
			return "서버";
		} else if("2".equals(this.role_type)) {
			return "계정";
		} else {
			return "";
		}
	}

	public String getViewUseYn() {
		if("Y".equals(this.use_yn)) {
			return "사용";
		} else if("N".equals(this.use_yn)) {
			return "미사용";
		} else {
			return "";
		}
	}
	
	public String validate() {
		if(this.role_name == null || "".equals(this.role_name)) {
			return "role.role_name.invalid";
		}
		if("insert".equals(method_mode)) {
			// 등록시에만 검증
			if(this.role_key == null || "".equals(this.role_key)) {
				return "role.role_key.invalid";
			}
		}
		if(this.role_type == null || "".equals(this.role_type)) {
			return "role.role_type.invalid";
		}
		if(this.use_yn == null || "".equals(this.use_yn)) {
			return "role.use_yn.invalid";
		}
		return null;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
