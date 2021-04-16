package gaia3d.domain.widget;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Widget {
	
	// 화면에서 위젯 정렬값
	private String widgetOrder;
	// 메인 화면에서 표시할 개수 제한을 위한 변수
	private Integer limit;

	// 고유번호
	private Long widgetId;
	// 이름
	private String widgetName;
	// Key
	private String widgetKey;
	// 나열 순서
	private Integer viewOrder;
	// 사용자 아이디
	private String userId;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
