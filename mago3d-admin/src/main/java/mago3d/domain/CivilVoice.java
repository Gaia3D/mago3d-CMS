package mago3d.domain;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

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
 *
 * @author kimhj
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CivilVoice extends Search implements Serializable {

	private static final long serialVersionUID = -7636814381604940705L;

	/******** 화면 오류 표시용 ********/
	private String messageCode;
	private String errorCode;

	/**
	 * 화면 표시용
	 *
	 */
	// 위도
	private String latitude;
	// 경도
	private String longitude;
	// 본인 게시글에 수정/삭제 표시 위해 사용
	private Boolean editable;


	/********** DB 사용 *************/
    // 고유번호
	private Long civilVoiceId;
    // 사용자 아이디
	private String userId;
	// 제목
	@NotBlank
	@Size(max = 256)
	private String title;
	// 내용
	@NotBlank
	private String contents;
	// 위치
	private String location;
	// 높이
	private Float altitude;
	// 사용유무
	private Boolean available;
	// 사용자 IP
	private String clientIp;
	// 조회수
	private Integer viewCount;
	// 댓글수
	private Integer commentCount;
	// 년
	private String year;
	// 월
	private String month;
	// 일
	private String day;
	// 일년 중 몇주
	private String yearWeek;
	// 이번 달 몇주
	private String week;
	// 시간
	private String hour;
	// 분
	private String minute;
	// 시도 코드
	private String sidoCd;
	// 시군구 코드
	private String sggCd;
	// 읍면동 코드
	private String emdCd;

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


}
