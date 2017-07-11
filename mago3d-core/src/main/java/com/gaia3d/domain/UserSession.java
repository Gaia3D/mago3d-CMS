package com.gaia3d.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 세션에 저장될 사용자 정보
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserSession implements Serializable {
	
	private static final long serialVersionUID = -7648113594557708090L;
	public static final String KEY = "userSession";
	
	// 사용
	public static final String Y = "Y";
	// 사용안함
	public static final String N = "N";
	
	/******** 화면 오류 표시용 ********/
	private String error_code;
	/******* 세션 하이재킹 체크 *******/
	private String login_ip;
	
	// 사용자 그룹명
	private String user_group_name;
	
	
	/********** DB 사용 *************/
	// 고유번호
	private String user_id;
	// 사용자 그룹 고유번호
	private Long user_group_id;
	// 이름
	private String user_name;
	// 비밀번호
	private String password;
	// SALT
	private String salt;
	
	// 전화번호
	private String telephone;
	// 핸드폰 번호
	private String mobile_phone;
	// 이메일
	private String email;
	// 메신저 아이디
	private String messanger;
	// 사번
	private String employee_id;
	// 직급
	private String dept_name;
	// 부서명
	private String position;
	// 우편번호
	private String postal_code;
	// 주소
	private String address;
	// 상세주소
	private String address_etc;
	// 실명 인증 CI 고유값
	private String ci;
	// 실명 인증 DI 도메인 고유값
	private String di;
	// 로그인 횟수
	private Long login_count;
	// 로그인 실패 횟수
	private Integer fail_login_count;
	// 마지막 로그인 날짜
	private String last_login_date;
	// 개인정보 수정 날짜
	private String update_date;
	// 최초 로그인시 사용자 Role 권한 체크 패스 기능
	private String user_role_check_yn;
	// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_method=0), 6:임시비밀번호
	private String status;
	
	// 등록일
	private String insert_date;
	// 패스워드 변경 주기
	private String password_change_term;
	// 패스워드 변경 주기 값
	private Boolean password_change_term_over;
	// 일정 기간 동안 미 접속시 잠금 처리(예 3개월 90일)
	private String user_last_login_lock;
	// 일정 기간 동안 미 접속시 잠금 처리 결과 값
	private Boolean user_last_login_lock_over;
	
//	public String getViewTelePhone() {
//		return Crypt.decrypt(telephone);
//	}
//	
//	public String getMaskingTelePhone() {
//		return getMaskingData(telephone, "DEFAULT");
//	}
//	
//	public String getViewMaskingTelePhone() {
//		return getMaskingData(Crypt.decrypt(telephone), "DEFAULT");
//	}
//
//	public String getViewMobilePhone() {
//		return Crypt.decrypt(mobile_phone);
//	}
//	
//	public String getMaskingMobilePhone() {
//		return getMaskingData(mobile_phone, "DEFAULT");
//	}
//	
//	public String getViewMaskingMobilePhone() {
//		return getMaskingData(Crypt.decrypt(mobile_phone), "DEFAULT");
//	}
	
//	public String getViewEmail() {
//		return Crypt.decrypt(email);
//	}
//	
//	public String getMaskingEmail() {
//		return getMaskingData(email, "EMAIL");
//	}
//	
//	public String getViewMaskingEmail() {
//		return getMaskingData(Crypt.decrypt(email), "EMAIL");
//	}
//
//	public String getViewAddressEtc() {
//		return Crypt.decrypt(address_etc);
//	}
//	
//	public String getMakingAddressEtc() {
//		return getMaskingData(address_etc, "DEFAULT");
//	}
//	
//	public String getViewMakingAddressEtc() {
//		return getMaskingData(Crypt.decrypt(address_etc), "DEFAULT");
//	}
	
	public String getViewLastLoginDate() {
		if(this.last_login_date == null || "".equals( last_login_date)) {
			return "";
		}
		return last_login_date.substring(0, 19); 
	}

	public String getViewStatus() {
		// 사용자 상태. 0:사용중, 1사용중지
		if(this.status == null || "".equals(this.status)) {
			return "";
		}
		if("0".equals(this.status)) {
			return "사용중";
		} else {
			return "사용중지";
		}
	}

//	/**
//	 * 개인정보 마스킹 처리
//	 * @param value
//	 * @param type
//	 * @return
//	 */
//	public String getMaskingData(String value, String type) {
//		if(ConfigCache.isUserInfoMasking()) {
//			return Masking.getMasking(value, type);
//		}
//		return value;
//	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
