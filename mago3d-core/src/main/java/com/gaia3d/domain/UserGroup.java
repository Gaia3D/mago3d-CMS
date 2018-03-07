package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserGroup {
	
	// 임시 그룹
	public static final Long TEMP_GROUP = 2l;
	
	// 상태 : 사용중
	public static final String IN_USE = "Y";
	
	/****** 화면 표시용 *******/
	private String open = "open";
	private String node_type = "folder";
	private String parent_name;
	private Integer user_count;
	// up : 위로, down : 아래로
	private String update_type;

	/****** validator ********/
	private String method_mode;

	// 고유번호
	private Long user_group_id;
	// 링크 활용 등을 위한 확장 컬럼
	private String group_key;
	// 그룹명
	private String group_name;
	// 조상 고유번호
	private Long ancestor;
	// 부모 고유번호
	private Long parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer view_order;
	// 기본 사용 삭제불가, Y : 기본, N : 선택
	private String default_yn;
	// 사용유무, Y : 사용, N : 사용안함
	private String use_yn;
	// 자식 존재 유무, Y : 존재, N : 존재안함(기본)
	private String child_yn;
	// 설명
	private String description;
	// 등록일
	private String insert_date;

//	public String getViewUseYn() {
//		if("Y".equals(this.use_yn)) {
//			return "사용";
//		} else if("N".equals(this.use_yn)) {
//			return "미사용";
//		} else {
//			return "";
//		}
//	}

	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
