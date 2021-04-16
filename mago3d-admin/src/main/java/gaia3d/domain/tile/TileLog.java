package gaia3d.domain.tile;

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
 * 타일링 정보 생성 이력
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TileLog extends Search implements Serializable {

	private static final long serialVersionUID = -1803267095406770698L;

	// 타일링 정보 생성 이력 고유번호
	private Long tileLogId;
	// 스마트 타일링 고유번호
	private Integer tileId;
	// 사용자 아이디
	private String userId;
	//
	private String status;

	private String filePath;
	private String fileRealName;

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

	// 수정일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
