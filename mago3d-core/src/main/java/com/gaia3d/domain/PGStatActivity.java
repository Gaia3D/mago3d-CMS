package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * DB 쿼리 통계 관련 정보
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class PGStatActivity {
	
	private String datid;
	private String datname;
	private String pid;
	private String usesysid;
	private String usename;
	private String application_name;
	private String client_addr;
	private String client_hostname;
	private String client_port;
	private String backend_start;
	private String xact_start;
	private String query_start;
	private String state_change;
	private String waiting;
	private String state;
	private String backend_xid;
	private String backend_xmin;
	private String query;
	
	public String getViewQuery() {
		if(this.query == null || "".equals(this.query)) {
			return "";
		}
		
		if(this.query.length() > 60) {
			return this.query.substring(0, 60) + "...";
		}
		
		return this.query;
	}
}
