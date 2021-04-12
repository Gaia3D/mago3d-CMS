package gaia3d.domain.data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.format.annotation.DateTimeFormat;

import gaia3d.domain.common.Search;
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
	// 높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정
	private String heightReference;
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
	// 높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정
	private String beforeHeightReference;
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
	private LocalDateTime viewUpdateDate;

	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime viewInsertDate;

	public LocalDateTime getViewUpdateDate() {
		return this.updateDate;
	}
	public LocalDateTime getViewInsertDate() {
		return this.insertDate;
	}

	// 수정일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;

	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
}
