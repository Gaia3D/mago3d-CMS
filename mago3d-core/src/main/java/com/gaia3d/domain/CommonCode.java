package com.gaia3d.domain;

import java.util.List;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * CommonCode
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class CommonCode {

	// 사용자 등록 유형
	public static final String USER_REGISTER_TYPE = "USER_REGISTER_TYPE";
	// 사용자 email 등록 타입
	public static final String USER_EMAIL = "USER_EMAIL";
	// 데이터 등록 유형
	public static final String DATA_REGISTER_TYPE = "DATA_REGISTER_TYPE";
	// 이슈 우선순위
	public static final String ISSUE_PRIORITY = "ISSUE_PRIORITY";
	// 이슈 유형
	public static final String ISSUE_TYPE = "ISSUE_TYPE";
	// 이슈 상태
	public static final String ISSUE_STATUS = "ISSUE_STATUS";
	
	/****** validator ********/
	private String order_word;
	private String order_value;
	
	// 이메일 목록
	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	private List<CommonCode> emailList;
	
	// 고유키
	private String code_key;
	// 코드 분류
	private String code_type;
	// 코드명
	private String code_name;
	// 영어 코드명
	private String code_name_en;
	// 코드값
	private String code_value;
	// db 코드값
	private String db_code_value;
	// 사용유무, Y : 사용(기본), N : 사용안함
	private String use_yn;
	// 표시 순서
	private Integer view_order;
	// css name
	private String css_class;
	// image full name
	private String image;
	
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
