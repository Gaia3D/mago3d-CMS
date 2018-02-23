package com.gaia3d.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 그룹별 Role
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserGroupRole {
	
	// Role 유형. 0 : 사용자
	public static final String ROLE_TYPE_USER = "0";
	
	// 관리자 페이지 접근 권한
	public static final String USER_ADMIN_LOGIN = "USER_ADMIN_LOGIN";
	// 사용자 페이지 접근 권한
	public static final String USER_USER_LOGIN = "USER_USER_LOGIN";
	// Single Sign-On 토큰 생성/검증 시 Role
	public static final String USER_CREATE_SSO_TOKEN = "USER_CREATE_SSO_TOKEN";
	public static final String USER_VERIFY_SSO_TOKEN = "USER_VERIFY_SSO_TOKEN";
	
	// 프로젝트 삭제 권한
	public static final String PROJECT_DELETE = "PROJECT_DELETE";
	// 데이터 삭제 권한
	public static final String DATA_DELETE = "DATA_DELETE";
	
	
	/****** validator ********/
	private String method_mode;
	
	// user_group 에 등록되지 않은 Role
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	private Long[] role_all_id;
	// user_group 에 등록된 Role
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	private Long[] role_select_id;

	// 고유번호
	private Long user_group_role_id;
	// 사용자 그룹 고유키
	private Long user_group_id;
	// Role 고유키
	private Long role_id;
	// Role 명
	private String role_name;
	// Role KEY
	private String role_key;
	// Role 유형. 0 : 사용자, 1 : 서버, 2 : 계정
	private String role_type;
	// 사용유무. Y : 사용, N : 사용안함
	private String use_yn;
	// 설명
	private String description;
	// 등록일
	private String insert_date;
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	// 사용자ID
	private String user_id;
	
	/********** 검색 조건 ************/
	private String search_role_name;
	private String search_except_role_name;
	
	public Long[] getRole_all_id() {
		return role_all_id;
	}
	public void setRole_all_id(Long[] role_all_id) {
		this.role_all_id = role_all_id;
	}
	public Long[] getRole_select_id() {
		return role_select_id;
	}
	public void setRole_select_id(Long[] role_select_id) {
		this.role_select_id = role_select_id;
	}
	
	public String getViewUseYn() {
		if(this.use_yn == null || "".equals(this.use_yn)) {
			return "";
		}
		if("Y".equals(this.use_yn)) {
			return "사용";
		} else {
			return "미사용";
		}
	}

	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
