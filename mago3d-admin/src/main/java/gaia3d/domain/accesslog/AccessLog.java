package gaia3d.domain.accesslog;

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
 * 서비스 요청 이력
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccessLog extends Search implements Serializable {

	private static final long serialVersionUID = 8776365534382891724L;
	
	// 총건수
	private Long totalCount;
	
	// 고유번호
	private Long accessLogId;
	// 사용자 아이디
	private String userId;
	// 사용자 이름
	private String userName;
	// 요청 IP
	private String clientIp;
	// URI
	private String requestUri;
	// 요청 Paramter
	private String parameters;
	// User-Agent
	private String userAgent;
	// Referer
	private String referer;
	// 년도
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년중 몇주
	private String yearWeek;
	// 이번달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
	
	public String getViewRequestUri() {
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
	}
}
