package gaia3d.domain.user;

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
public class UserGroup {

	// 임시 그룹
	public static final Integer GUEST = 6;
	public static final Integer TEMP = 7;
	
	/****** 화면 표시용 *******/
	private String open;
	private String nodeType;
	private String parentName;
	private Integer userCount;
	// up : 위로, down : 아래로
	private String updateType;

	/****** validator ********/
	private String methodMode;

	// 그룹Key 중복 확인 hidden 값
	private String duplicationValue;

	// 고유번호
	private Integer userGroupId;
	// 링크 활용 등을 위한 확장 컬럼
	private String userGroupKey;
	// 그룹명
	private String userGroupName;
	// 부서번호
	private String deptNo;
	// 부서명
	private String deptName;
	// 조상 고유번호
	private Integer ancestor;
	// 부모 고유번호
	private Integer parent;
	// 깊이
	private Integer depth;
	// 나열 순서
	private Integer viewOrder;
	// 자식 존재 유무
	private Integer children;

	// true : 기본, false : 선택
	private Boolean basic;
	// true : 사용, false : 사용안함
	private Boolean available;
	private String viewUseYn;

	// 설명
	private String description;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
	
//	public String getViewInsertDate() {
//		if(getInsertDate() == null) {
//			return "";
//		}
//
//		String tempDate = FormatUtils.getViewDateyyyyMMddHHmmss(getInsertDate());
//		return tempDate.substring(0, 19);
//	}
}
