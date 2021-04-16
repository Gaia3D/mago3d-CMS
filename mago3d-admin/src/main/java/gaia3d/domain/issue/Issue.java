package gaia3d.domain.issue;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import gaia3d.domain.common.Search;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * Issue
 * @author jeongdae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Issue extends Search {
	
	// 이슈 상세 고유번호
	private Long issueDetailId;
	// 댓글 개수
	private Integer commentCount;
	// 데이터 그룹명
	private String dataGroupName;
	// 사용자명
	private String userName;
	// 이슈 내용
	private String contents;
	// 이슈 댓글 고유번호
	private Long issueCommentId;
	// comment
	private String comment;
	// 조회수
	private Integer viewCount;
	// 대리자
	private String assignee;
	// 레포트
	private String reporter;
	// 첨부파일
	private String fileName;
	
	private MultipartFile multipartFile;
	
	/****** validator ********/
	private String methodMode;
	
	/************* 업무 처리 ***********/
    // 고유번호
	private Long issueId;
	// 데이터 그룹 고유 번호
	private Integer dataGroupId;
	// 데이터 고유 번호
	private Long dataId;
	// 데이터 키
	private String dataKey;
	// 오브젝트 키
	private String objectKey;	
	// 사용자 아이디
	private String userId;
	// 이슈명
	private String title;
	// 우선순위. common_code 동적 생성
	private String priority;
	private String priorityName;
	private String priorityCssClass;
	private String priorityImage;
	
	// 예정일. 마감일
	private String dueDate;
	private String dueDay;
	private String dueHour;
	private String dueMinute;
	// 이슈 유형. common_code 동적 생성
	private String issueType;
	private String issueTypeName;
	private String issueTypeCssClass;
	private String issueTypeImages;
	// 상태. common_code 동적 생성
	private String status;
	// location(위도, 경도)
	private String location;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal altitude;
	// 요청 IP
	private String clientIp;
	
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

	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime viewInsertDate;

	@Getter(AccessLevel.NONE)
	@Setter(AccessLevel.NONE)
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime viewUpdateDate;

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
}
