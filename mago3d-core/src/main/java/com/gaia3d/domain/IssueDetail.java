package com.gaia3d.domain;

import com.gaia3d.security.Crypt;
import com.gaia3d.security.Masking;

import lombok.Data;

/**
 * Issue Detail
 * @author jeongdae
 *
 */
@Data
public class IssueDetail {
	
	
	// 고유키
	private Long issue_id;
	private Long issue_detail_id;
	
	// 등록일
	private String insert_date;
	
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
