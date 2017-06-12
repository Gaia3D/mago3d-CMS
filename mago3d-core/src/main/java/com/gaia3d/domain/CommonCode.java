package com.gaia3d.domain;

import java.util.List;

import lombok.AccessLevel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

/**
 * CommonCode
 * @author jeongdae
 *
 */
@Data
public class CommonCode {

	// 외부 시스템 연동 사용자 등록
	public static final String EXTERNAL_USER_REGISTER = "EXTERNAL_USER_REGISTER";
	public static final String USER_REGISTER = "USER_REGISTER";
	public static final String USER_REGISTER_EMAIL = "USER_REGISTER_EMAIL";
	public static final String EXTERNAL_OBJECT_REGISTER = "EXTERNAL_OBJECT_REGISTER";
	public static final String OBJECT_REGISTER = "OBJECT_REGISTER";
	
	/****** validator ********/
	private String order_word;
	private String order_value;
	
	// 이메일 목록
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	private List<CommonCode> emailList;
	
	// 코드키
	private String code_key;
	// 코드명
	private String code_name;
	// 영어 코드명
	private String code_name_en;
	// 코드 분류
	private String code_type;
	// 코드값
	private String code_value;
	// db 코드값
	private String db_code_value;
	// 사용유무, Y : 사용(기본), N : 사용안함
	private String use_yn;
	// 표시 순서
	private Integer view_order;
	
	// 설명
	private String description;
	// 등록일
	private String insert_date;
	
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	public String getViewUseYn() {
		if("Y".equals(this.use_yn)) {
			return "사용";
		} else if("N".equals(this.use_yn)) {
			return "미사용";
		} else {
			return "";
		}
	}
	
	public List<CommonCode> getEmailList() {
		return emailList;
	}

	public void setEmailList(List<CommonCode> emailList) {
		this.emailList = emailList;
	}
	
	public String validate() {
		if(this.code_key == null || "".equals(this.code_key)) {
			return "common_code.code_key.required";
		}
		if(this.code_name == null || "".equals(this.code_name)) {
			return "common_code.code_name.required";
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
