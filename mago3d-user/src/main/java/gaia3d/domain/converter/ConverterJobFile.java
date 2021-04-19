package gaia3d.domain.converter;

import java.math.BigDecimal;
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
 * converter 대상 파일
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ConverterJobFile extends Search {

	// 화면 표기용
	private String sharing;
	private String dataType;
	private String fileName;
	private BigDecimal usf;

	/****** validator ********/
	private String methodMode;

	// 고유번호
	private Long converterJobFileId;
	// 파일 변환 그룹 job
	private Long converterJobId;
	// 업로딩 정보 고유번호
	private Long uploadDataId;
	// 업로딩 파일 고유번호
	private Long uploadDataFileId;
	// Data 그룹 고유번호
	private Integer dataGroupId;
	// Data 그룹명
	private String dataGroupName;
	// user id
	private String userId;
	// 상태. ready : 준비, success : 성공, fail : 실패
	private String status;
	// 에러 코드
	private String errorCode;

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

	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;

	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
	
}
