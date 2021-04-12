package gaia3d.domain.data;

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
 * 파일 파싱 이력
 * @author jeongdae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataSmartTilingFileParseLog extends Search {
	
	// Excel 데이터 파싱 로그
	public static final String FILE = "file";
	// Excel 데이터 파싱 후 DB Insert 로그
	public static final String DB = "db";
	// 엑셀 파일 한 row 파싱 성공
	public static final String SUCCESS = "success";
	// 엑셀 파일 한 row 파싱 실패
	public static final String FAIL = "fail";
	
	// 고유번호
	private Long dataSmartTilingFileParseLogId;
	// 파일 정보 고유번호
	private Long dataSmartTilingFileInfoId;
	// 식별자 값
	private String identifierValue;
	// validation
	private String errorCode;
	// 로그 타입. file: 파일, db: DB insert
	private String logType;
	// 상태. success, error
	private String status; 
	
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
