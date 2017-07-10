package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 위젯
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class Widget {
	
	// 화면에서 위젯 정렬값
	private String widget_order;
	// 메인 화면에서 표시할 개수 제한을 위한 변수
	private Integer limit;

	// 고유번호
	private Long widget_id;
	// 이름
	private String name;
	// 나열 순서
	private Integer view_order;
	// 사용자 아이디
	private String user_id;
	// 등록일
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
