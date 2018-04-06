package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Issue People
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class IssuePeople {
	
	// TODO enum 으로 바꿔야 할거 같은데.... ㅠ.ㅠ
	public static final String ASSIGNEE = "1";
	public static final String REPORTER = "2";
	
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
