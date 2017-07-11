package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Issue Detail
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class IssueDetail {
	
	// 고유번호
	private Long issue_id;
	private Long issue_detail_id;
	private String contents;
	
	// 등록일
	private String insert_date;
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
