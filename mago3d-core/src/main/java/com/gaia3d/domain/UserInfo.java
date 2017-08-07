package com.gaia3d.domain;

import java.util.Map;

import com.gaia3d.security.Crypt;
import com.gaia3d.security.Masking;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 정보 테이블
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserInfo {
	
	// 사용자 상태가 사용중
	public static final String STATUS_USE = "0";
	// 사용자 상태가 중지(관리자)
	public static final String STATUS_FORBID = "1";
	// 사용자 상태가 잠금(비밀번호 실패횟수 초과)
	public static final String STATUS_FAIL_LOGIN_COUNT_OVER = "2";
	// 사용자 상태가 휴면(로그인 기간)
	public static final String STATUS_SLEEP = "3";
	// 사용자 상태가 만료(사용기간 종료)
	public static final String STATUS_TERM_END = "4";
	// 사용자 상태가 삭제(화면 비표시)
	public static final String STATUS_LOGICAL_DELETE = "5";
	// 사용자 상태가 임시 비밀번호(비밀번호 찾기, 관리자 설정에 의한 임시 비밀번호 발급 시)
	public static final String STATUS_TEMP_PASSWORD = "6";
	
	/********* 로그인 타입 ***********/
	// 사용자 로그인 인증 방법. 0 : 일반(아이디/비밀번호(기본값)), 1 : 기업용(사번추가), 2 : 일반 + OTP, 3 : 일반 + 인증서, 4 : OTP + 인증서, 5 : 일반 + OTP + 인증서
	private String login_type;
	
	// user_group 에 등록되지 않은 사용자
	private String[] user_all_id;
	// user_group 에 등록된 사용자
	private String[] user_select_id;
	
	private Long server_group_user_id;
	private Long server_group_id;
	
	/******** 화면 오류 표시용 ********/
	private String message_code;
	private String error_code;
	// 일정 기간 동안 미 접속시 잠금 처리(예 3개월 90일)
	private String user_last_login_lock;
	// 아이디 중복 확인 hidden 값
	private String duplication_value;
	// 논리 삭제 
	private String delete_flag;
	
	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	/********** 검색 조건 ************/
	private String search_word;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String search_option;
	private String search_value;
	private String start_date;
	private String end_date;
	private String order_word;
	private String order_value;
	private Long list_counter = 10l;
	
	/****** validator ********/
	private String method_mode;
	
	/********** Policy ************/
	// 사용자 로그인 실패 잠금 해제 기간
	private String user_fail_lock_release;
	
	/********** DB 사용 *************/
	// 고유번호
	private String user_id;
	// 사용자 그룹 고유번호
	private Long user_group_id;
	// 사용자 그룹명
	private String user_group_name;
	// 이름
	private String user_name;
	// 비밀번호
	private String password;
	// 비밀번호 확인
	private String password_confirm;
	// SALT
	private String salt;
	// 전화번호1
	private String telephone1;
	// 전화번호2
	private String telephone2;
	// 전화번호3
	private String telephone3;
	// 전화번호
	private String telephone;
	// 핸드폰 번호1
	private String mobile_phone1;
	// 핸드폰 번호2
	private String mobile_phone2;
	// 핸드폰 번호3
	private String mobile_phone3;
	// 핸드폰 번호
	private String mobile_phone;
	// 이메일
	private String email;
	// 이메일1
	private String email1;
	// 이메일2
	private String email2;
	// 메신저 아이디
	private String messanger;
	// 사번
	private String employee_id;
	// 부서명
	private String dept_name;
	// 직급
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
	// 마지막 로그인 비밀번호 변경 날짜
	private String last_password_change_date;
	// 마지막 로그인 날짜
	private String last_login_date;
	// 개인정보 수정 날짜
	private String update_date;
	// 최초 로그인시 사용자 Role 권한 체크 패스 기능
	private String user_role_check_yn;
	// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_method=0), 6:임시비밀번호
	private String status;
	// 현재 사용자 상태값
	private String db_status;
	// 사용자 등록 방법. 기본 : SELF
	private String user_insert_type;
	// Single Sign-On 사용유무. 기본값 N : 사용안함
	private String sso_use_yn;
	// 웹 아이디 사용 시작일
	private String user_id_start_date;
	// 웹 아이디 사용 종료일
	private String user_id_end_date;
	// 등록일
	private String insert_date;
	// 새로운 비밀번호
	private String new_password;
	// 새로운 비밀번호 확인
	private String new_password_confirm;
	// 패스워드 변경 주기
	private String password_change_term;
	// 패스워드 변경 주기 값
	private Boolean password_change_term_over;
	// 이메일 From
	private String from;
	// 이메일 Subject
	private String subject;
	// 임시 비밀번호
	private String temp_password;
	//pin_number
	private String pin_number;
	
	/********** 검색 조건 ************/
	private String search_user_name;
	private String search_except_user_name;
	
	public String getViewTelePhone() {
		return Crypt.decrypt(telephone);
	}
	
	public String getMaskingTelePhone() {
		return getMaskingData(telephone, "DEFAULT");
	}
	
	public String getViewMaskingTelePhone() {
		return getMaskingData(Crypt.decrypt(telephone), "DEFAULT");
	}

	public String getViewMobilePhone() {
		return Crypt.decrypt(mobile_phone);
	}
	
	public String getMaskingMobilePhone() {
		return getMaskingData(mobile_phone, "DEFAULT");
	}
	
	public String getViewMaskingMobilePhone() {
		return getMaskingData(Crypt.decrypt(mobile_phone), "DEFAULT");
	}
	
	public String getViewEmail() {
		return Crypt.decrypt(email);
	}
	
	public String getMaskingEmail() {
		return getMaskingData(email, "EMAIL");
	}
	
	public String getViewMaskingEmail() {
		return getMaskingData(Crypt.decrypt(email), "EMAIL");
	}
	
	public String getViewAddressEtc() {
		return Crypt.decrypt(address_etc);
	}
	
	public String getMaskingAddressEtc() {
		return getMaskingData(address_etc, "DEFAULT");
	}
	
	public String getViewMaskingAddressEtc() {
		return getMaskingData(Crypt.decrypt(address_etc), "DEFAULT");
	}

	public String getViewLastPasswordChangeDate() {
		if(this.last_password_change_date == null || "".equals( last_password_change_date)) {
			return "";
		}
		return last_password_change_date.substring(0, 19); 
	}

	public String getViewLastLoginDate() {
		if(this.last_login_date == null || "".equals( last_login_date)) {
			return "";
		}
		return last_login_date.substring(0, 19); 
	}

	public String getViewStatus() {
		// 사용자 상태. 0:사용중, 1:사용중지(관리자), 2:잠금(비밀번호 실패횟수 초과), 3:휴면(로그인 기간), 4:만료(사용기간 종료), 5:삭제(화면 비표시, policy.user_delete_method=0)
		if(this.status == null || "".equals(this.status)) {
			return "";
		}
		if("0".equals(this.status)) {
			return "사용중";
		} else if("1".equals(this.status)) {
			return "사용중지";
		} else if("2".equals(this.status)) {
			return "잠금(실패횟수)";
		} else if("3".equals(this.status)) {
			return "휴면";
		} else if("4".equals(this.status)) {
			return "만료";
		} else if("5".equals(this.status)) {
			return "삭제";
		} else if("6".equals(this.status)) {
			return "임시 비밀번호";
		}
		return "";
	}
	
	public String getViewSsoUseYn() {
		if(this.sso_use_yn == null || "".equals(this.sso_use_yn)) {
			return "";
		}
		if ("Y".equals(this.sso_use_yn)) {
			return "사용";
		} else if ("N".equals(this.sso_use_yn)) {
			return "사용 안함";
		}
		return "";
	}
	
	/**
	 * 개인정보 마스킹 처리
	 * @param value
	 * @param type
	 * @return
	 */
	public String getMaskingData(String value, String type) {
		if(CacheManager.isUserInfoMasking()) {
			return Masking.getMasking(value, type);
		}
		return value;
	}
	
	public String getViewUserInsertType() {
		// TODO 이건 뭔가 아닌거 같은데... 어떻게 처리 하지?
		if(this.user_insert_type == null || "".equals(this.user_insert_type)) {
			return "";
		}
		
		Map<String, Object> commonCodeMap = CacheManager.getCommonCodeMap();
		CommonCode commonCode = (CommonCode)commonCodeMap.get(this.user_insert_type);
		if(commonCode == null) return "";
		else return commonCode.getCode_name();
	}
	
	public String getValueUserIdStartDate() {
		if(this.user_id_start_date == null || "".equals( user_id_start_date)) {
			return "";
		}
		String value = user_id_start_date.substring(0, 19);
		value = value.replaceAll("\\p{Space}", "");
		value = value.replaceAll("-", "");
		value = value.replaceAll(":", "");
		return value;
	}
	
	public String getValueUserIdEndDate() {
		if(this.user_id_end_date == null || "".equals( user_id_end_date)) {
			return "";
		}
		String value = user_id_end_date.substring(0, 19);
		value = value.replaceAll("\\p{Space}", "");
		value = value.replaceAll("-", "");
		value = value.replaceAll(":", "");
		return value;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
