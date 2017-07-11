package com.gaia3d.domain;

import com.gaia3d.util.StringUtil;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * issue 댓글(Comment)
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class IssueComment {
	
	// 사용자 이름
	private String user_name;
	
	// 고유번호
	private Long issue_comment_id;
	// 게시판 고유번호
	private Long issue_id;
	// 사용자 아이디
	private String user_id;
	// 댓글(Comment)
	private String comment;
	// 요청 IP
	private String client_ip;
	// 등록일
	private String insert_date;
	
	public String getViewComment() {
		if(this.comment == null || "".equals(this.comment)) {
			return "";
		}
		
		String str = StringUtil.getStringConvertForHtml(this.comment);
		str = StringUtil.getStringNewLineConvertForHtml(str);
		
		return str;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
