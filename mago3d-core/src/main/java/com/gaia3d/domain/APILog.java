package com.gaia3d.domain;

import com.gaia3d.security.Crypt;
import com.gaia3d.security.Masking;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * PM이 제공하는 서비스 API 호출 이력
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class APILog {
	
	// service_code = Single Sign-On Token 생성 요청
	public static final String CREATE_SSO_TOKEN = "CREATE_SSO_TOKEN";
	
	// 외부 호출
	public static final String API = "API";
	
	// 사용 매체( 0 : 웹, 1 : 기타)
	public static final String DEVICE_WEB = "0";
	public static final String DEVICE_MANAGER = "1";
	public static final String DEVICE_MOBILE = "2";
	public static final String DEVICE_ETC = "3";
	
	// 총건수
	private Long totalCount;
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
	
	/************* 업무 처리 ***********/
    // 사용자명
    private String user_name;
	
	// 고유키
	private Long api_log_id;
	
	/************* 필수 항목 ***********/
	// Web API 서비스명
    private String service_code;
	// Web API 서비스 코드
    private String service_name;
	// Web API 호출 Client IP, 127.0.0.1 또는 localhost 는 절대 금지
    private String client_ip;
    // 서비스 제공을 요청한 서버명
    private String client_server_name;
	// API KEY
    private String api_key;
    // 사용 매체( 0 : 웹, 1 : 기타)
    private String device_kind;
    // 서비스 요청 타입. 인증 : ADMIN_PASSWORD, 테스트 : ADMIN_TEST, 로그인 : ADMIN_LOGIN, 요청 : USER_MAIN, 테스트 : USER_TEST, 로그인 : USER_LOGIN, 외부 : API
 	private String request_type;
    // 사용자 아이디
    private String user_id;
    // 사용자 IP
    private String user_ip;
    // 데이터 건수
 	private Integer data_count;
 	// 데이터 구분자
 	private String data_delimiter;
    
    /************* 옵셥 항목 ***********/
	// 전화번호
    private String phone;
	// email
    private String email;
	// 메신저
    private String messanger;
	// 임시 필드1
    private String field1;
	// 임시 필드2
    private String field2;
	// 임시 필드3
    private String field3;
	// 임시 필드4
    private String field4;
	// 임시 필드5
    private String field5;
    
    /************* 결과 처리 ***********/
    // Http Status 
    private int http_status;
    // PM 서비스 API 호출 성공 유무( Y : 성공, N : 실패 )
    private String success_yn;
    // 업무 예외 발생 유무(오류가 발생했지만 무시해도 되는 경우, Y : 성공, N : 실패)
    private String business_success_yn;
    // 서비스 호출 메시지
    private String result_message;
    // 업무 호출 메시지
    private String business_result_message;
    // 결과값1
    private String result_value1;
    // 결과값2
    private String result_value2;
    // 결과값3
    private String result_value3;
    // 결과값4
    private String result_value4;
    // 결과값5
    private String result_value5;
    // 등록일
 	private String insert_date;
    
    public boolean validate() {
    	if(this.service_code == null || "".equals(this.service_code)
    		|| this.service_name == null || "".equals(this.service_name)
    		|| this.client_ip == null || "".equals(this.client_ip)
    		|| this.api_key == null || "".equals(this.api_key)
    		|| this.device_kind == null || "".equals(this.device_kind)) {
    		return false;
    	}
    	return true;
    }
    
	public String getViewDeviceKind() {
		if(this.device_kind == null || "".equals(this.device_kind)) {
			return "";
		}
		if("0".equals(this.device_kind)) {
			return "웹";
		} else {
			return "기타";
		}
	}
	
	public String getViewPhone() {
		return getMaskingData(Crypt.decrypt(phone), "DEFAULT");
	}

	public String getViewEmail() {
		return getMaskingData(Crypt.decrypt(email), "EMAIL");
	}

	public String getViewSuccessYn() {
		if(this.success_yn == null || "".equals(this.success_yn)) {
			return "";
		}
		if("Y".equals(this.success_yn)) {
			return "성공";
		} else {
			return "실패";
		}
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
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}
