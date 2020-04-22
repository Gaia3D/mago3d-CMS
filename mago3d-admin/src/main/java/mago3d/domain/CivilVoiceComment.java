package mago3d.domain;

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

@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CivilVoiceComment extends Search {
	/**
	 * 화면 표시용
	 */
	private Boolean editable;

	/**
	 * DB
	 */
	private Long civilVoiceCommentId;
	private Long civilVoiceId;
	private String userId;
	private String clientIp;
	private String title;
	private String year;
	private String month;
	private String day;
	private String yearWeek;
	private String week;
	private String hour;
	private String minute;

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
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp updateDate;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Timestamp insertDate;
}
