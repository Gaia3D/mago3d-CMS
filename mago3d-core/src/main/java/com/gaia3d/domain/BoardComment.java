package com.gaia3d.domain;

import com.gaia3d.util.StringUtil;
import lombok.Data;

/**
 * 게시판 댓글(Comment)
 * @author jeongdae
 *
 */
@Data
public class BoardComment {
	
	// 사용자 이름
	private String user_name;
	
	// 고유번호
	private Long board_comment_id;
	// 게시판 고유번호
	private Long board_id;
	// 사용자 아이디
	private String user_id;
	// 댓글(Comment)
	private String comment;
	// 요청 IP
	private String client_ip;
	// 등록일
	private String register_date;
	
	public String getViewComment() {
		if(this.comment == null || "".equals(this.comment)) {
			return "";
		}
		
		String str = StringUtil.getStringConvertForHtml(this.comment);
		str = StringUtil.getStringNewLineConvertForHtml(str);
		
		return str;
	}
	
	public String getViewRegisterDate() {
		if(this.register_date == null || "".equals( register_date)) {
			return "";
		}
		return register_date.substring(0, 19);
	}
}
