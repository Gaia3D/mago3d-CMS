package com.gaia3d.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 통계
 * @author
 */
@Getter
@Setter
@ToString
public class Statistic {
	
	private String year_month_day;
	
	private String select_title;
	
	private String user_total_count;
	private String this_year_user_total_count;
	private String user_otp_total_count;
	private String this_year_user_otp_total_count;
	private String not_user_otp_total_count;
	private String this_year_not_user_otp_total_count;
	// OTP 상태 미설정
	private String user_otp_not_config_total_count;
	private String this_year_user_otp_not_config_total_count;
	
	private String user_otp_request_total_count;
	private String this_year_user_otp_request_total_count;
	private String user_otp_verify_total_count;
	private String this_year_user_otp_verify_total_count;
	private String user_otp_verify_success_total_count;
	private String this_year_user_otp_verify_success_total_count;
	private String user_otp_verify_fail_total_count;
	private String this_year_user_otp_verify_fail_total_count;
}
