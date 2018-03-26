package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 그룹 메뉴 권한
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserGroupMenu {
	
	/****** 화면 표시용 ******/
	private String name;
	// 영어 메뉴명
	private String name_en;
	// 부모 고유번호
	private Long parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer view_order;
	// URL
	private String url;
	private String url_alias;
	// 설명
	private String descritpion;
	// 이미지
	private String image;
	// 이미지 alt
	private String image_alt;
	// css class명
	private String css_class;
	private String use_yn;
	private String default_yn;
	private String display_yn;
	
	/********* DB *********/
	// 고유번호
	private Long user_group_menu_id;
	// 사용자 그룹 고유키
	private Long user_group_id;
	// 메뉴 고유키
	private Long menu_id;
	// 메뉴 접근 모든 권한
	private String all_yn;
	// 읽기 권한
	private String read_yn;
	// 쓰기 권한
	private String write_yn;
	// 수정 권한
	private String update_yn;
	// 삭제 권한
	private String delete_yn;
	// 등록일
	private String insert_date;

	public String getViewUseYn() {
		if("Y".equals(this.use_yn)) {
			return "사용";
		} else if("N".equals(this.use_yn)) {
			return "미사용";
		} else {
			return "";
		}
	}
	
	public String getCheckedAllYn() {
		if(this.all_yn == null || "".equals(this.all_yn) || "N".equals(this.all_yn)) {
			return "";
		}
		return "checked=\"checked\"";
	}

	public String getCheckedReadYn() {
		if(this.read_yn == null || "".equals(this.read_yn) || "N".equals(this.read_yn)) {
			return "";
		}
		return "checked=\"checked\"";
	}

	public String getCheckedWriteYn() {
		if(this.write_yn == null || "".equals(this.write_yn) || "N".equals(this.write_yn)) {
			return "";
		}
		return "checked=\"checked\"";
	}

	public String getCheckedUpdateYn() {
		if(this.update_yn == null || "".equals(this.update_yn) || "N".equals(this.update_yn)) {
			return "";
		}
		return "checked=\"checked\"";
	}

	public String getCheckedDeleteYn() {
		if(this.delete_yn == null || "".equals(this.delete_yn) || "N".equals(this.delete_yn)) {
			return "";
		}
		return "checked=\"checked\"";
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
