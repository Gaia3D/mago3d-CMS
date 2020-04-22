package mago3d.domain;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * Data geometry 정보 변경 요청 이력
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataAdjustLog extends Search {

	// 사용자명
	private String userId;
	// 수정자 아이디
	private String updateUserId;
	private String userName;

	/****** validator ********/
	private String methodMode;

	// 고유번호
	private Long dataAdjustLogId;
	// Data group 고유번호
	private Integer dataGroupId;
	// Data project 이름
	private String dataGroupName;
	// Data 고유번호
	private Long dataId;
	// data 고유 식별번호
	private String dataKey;
	// data 이름
	private String dataName;
	// 위도, 경도 정보 geometry 타입
	private String location;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal altitude;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	// 변경전 위도, 경도 정보 geometry 타입
	private String beforeLocation;
	// 변경전 위도
	private BigDecimal beforeLatitude;
	// 변경전 경도
	private BigDecimal beforeLongitude;
	// 변경전 높이
	private BigDecimal beforeAltitude;
	// 변경전 heading
	private BigDecimal beforeHeading;
	// 변경전 pitch
	private BigDecimal beforePitch;
	// 변경전 roll
	private BigDecimal beforeRoll;
	// 상태. request : 요청, approval : 승인, reject : 기각, rollback : 원복
	private String status;
	// status 의 ajax 처리 값
	private String statusLevel;
	// 변경 타입
	private String changeType;
	// 설명
	private String description;

	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp viewUpdateDate;

	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp viewInsertDate;

	public Timestamp getViewUpdateDate() {
		return this.updateDate;
	}
	public Timestamp getViewInsertDate() {
		return this.insertDate;
	}

	// 수정일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;

	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
}
