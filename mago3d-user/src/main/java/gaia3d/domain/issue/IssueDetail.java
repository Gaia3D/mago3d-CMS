package gaia3d.domain.issue;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * Issue Detail
 * @author jeongdae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IssueDetail {
	
	// 고유번호
	private Long issueId;
	private Long issueDetailId;
	private String contents;
	
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
