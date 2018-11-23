package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * membership management
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class Membership {

	// 고유번호
	private Long membership_id;
	// 사용자 아이디
	private String user_id;
	// 회원 타입. 0: Basic, 1 : 실버, 2 : 골드
	private String membership_type;
	// 요금타입. 0: 사용안함, 1 : 월정액, 2 : 년비
	private String charge_type;
	// 등록일
	private String insert_date;
}
