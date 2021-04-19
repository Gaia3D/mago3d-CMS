package gaia3d.domain.apilog;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import gaia3d.domain.common.Search;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * API 요청 이력
 * @author hansang
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ApiLog extends Search implements Serializable {
	
	private static final long serialVersionUID = 8776365534382891724L;

	// 총건수
	private Long totalCount;
	
	// 고유번호
	private Long apiLogId;
	// 서비스 코드
	private String serviceCode;
	// 서비스 명
	private String serviceName;
	// Client IP
	private String clientIp;
	// Client Server 명
	private String clientServerName;
	// 요청 URI
	private String requestUri;
	// http 상태코드
	private Integer statusCode;
	// API Key
	private String apiKey;
	// 기기 종류
	private String deviceKind;
	// 요청 type
	private String requestType;
	// 사용자 아이디
	private String userId;
	// 사용자 Ip
	private String userIp;
	// phone
	private String phone;
	// email
	private String email;
	// 메신저
	private String messenger;
	// 성공여부
	private String successYn;
	// business 성공여부
	private String businessSuccessYn;
	// 결과 메시지
	private String resultMessage;
	// business 결과 메시지
	private String businessResultMessage;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
	
	/*public String getViewRequestUri() {
		if(this.requestUri == null || "".equals(this.requestUri)) {
			return "";
		}
		if(this.requestUri.length() > 60) {
			return this.requestUri.substring(0, 60) + "...";
		}
		return this.requestUri;
	}
	
	public String getViewParameters() {
		if(this.parameters == null || "".equals(this.parameters)) {
			return "";
		}
		
		if(this.parameters.length() > 20) {
			return this.parameters.substring(0, 20) + "...";
		}
		
		return this.parameters;
	}
	public String getViewUserAgent() {
		String userAgent = this.userAgent;
    	if(userAgent != null && userAgent.length() > 20) {
    		userAgent = userAgent.substring(0, 20) + "...";
    	}
    	return userAgent;
	}
	public String getViewReferer() {
		String referer = this.referer;
    	if(referer != null && referer.length() > 25) {
    		referer = referer.substring(0, 25) + "...";
    	}
    	return referer;
	}*/
}
