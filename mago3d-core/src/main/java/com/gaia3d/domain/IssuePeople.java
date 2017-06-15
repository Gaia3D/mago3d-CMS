package com.gaia3d.domain;

import lombok.Data;

/**
 * Issue People
 * @author jeongdae
 *
 */
@Data
public class IssuePeople {
	
	// 고유번호
	private Long issue_people_id;
	private Long issue_id;
	// 이슈 관계자 유형. 1 : 대리자, 2 : 담당자
	private String role_type;
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
