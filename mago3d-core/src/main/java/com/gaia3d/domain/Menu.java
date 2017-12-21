package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 메뉴
 * 
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class Menu {

	/******** 화면 트리 표시용 ********/
	private String open = "open";
	private String node_type = "folder";
	private String parent_name;
	// up : 위로, down : 아래로
	private String update_type;
	// Page Header 표시용
	private String alias_name;

	// 고유번호
	private Long menu_id;
	// 메뉴명
	private String name;
	// 영어 메뉴명
	private String name_en;
	// 언어별
	private String lang;
	// 부모 고유번호
	private Long parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer view_order;
	// URL
	private String url;
	// 이미지
	private String image;
	// 이미지 Alt
	private String image_alt;
	// css class명
	private String css_class;
	// 기본 표시 메뉴, Y : 기본, N : 선택
	private String default_yn;
	// 사용유무, Y : 사용, N : 사용안함
	private String use_yn;
	// 설명
	private String description;
	// 등록일
	private String insert_date;

	public String getViewUseYn() {
		if ("Y".equals(this.use_yn)) {
			return "사용";
		} else if ("N".equals(this.use_yn)) {
			return "미사용";
		} else {
			return "";
		}
	}

	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
