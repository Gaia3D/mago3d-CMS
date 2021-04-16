package gaia3d.domain.apilog;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import gaia3d.domain.common.Search;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class APILog extends Search {
	
	private Search search;
	
	// 고유키
	private Long apiLogId;
	// client 고유키
	private Integer serverId;
	// client 명(중복 허용)
	private String serverName;
	// request ip
	private String requestIp;
	// 사용자 아이디
	private String userId;
	// url
	private String url;
	// http status code
	private Integer statusCode;
	// message
	private String message;
	
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
	
	public String getViewMessage() {
		if(this.message == null || "".equals(this.message)) {
			return "";
		}
		
		if(this.message.length() > 30) {
			return this.message.substring(0, 30) + "...";
		}
		
		return this.message;
	}
}
