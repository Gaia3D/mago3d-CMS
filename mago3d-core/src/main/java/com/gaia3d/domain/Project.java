package com.gaia3d.domain;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * project
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class Project {

	// 임시 그룹
	public static final Long TEMP_GROUP = 2l;
	
	// 상태 : 사용중
	public static final String IN_USE = "Y";
	
	/****** 화면 표시용 *******/
	// 그룹에 등록된 사용자 수
	private String open = "open";
	private String node_type = "folder";
	private String parent_name;
	private Integer data_count;
	// up : 위로, down : 아래로
	private String update_type;

	/****** validator ********/
	private String method_mode;
	
	// 아이디 중복 확인 hidden 값
	private String duplication_value;

	// 고유번호
	private Long project_id;
	// 링크 활용 등을 위한 확장 컬럼
	private String project_key;
	// old 고유 식별번호
	private String old_project_key;
	// 그룹명
	private String project_name;
	// 나열 순서
	private Integer view_order;
	// 기본 사용 삭제불가, Y : 기본, N : 선택
	private String default_yn;
	// 사용유무, Y : 사용, N : 사용안함
	private String use_yn;
	// 위도, 경도 정보 geometry 타입
	private String location;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal height;
	// flyTo 이동시간
	private Integer duration;
	// 설명
	private String description;
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

	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
