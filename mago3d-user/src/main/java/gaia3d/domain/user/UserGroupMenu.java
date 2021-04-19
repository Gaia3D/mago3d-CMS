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
 * 사용자 그룹 메뉴 권한
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserGroupMenu {
	
	/****** 화면 표시용 ******/
	// 고유번호
	private Integer menuId;
	// 0 : URL 기반, 1 : HTML ID
	private String menuType;
	// 0 : 사용자 사이트, 1 : 관리자 사이트
	private String menuTarget;
	// 메뉴명
	private String name;
	// 영어 메뉴명
	private String nameEn;
	// 언어별
	private String lang;
	// 조상
	private Integer ancestor;
	// 부모 고유번호
	private Integer parent;
	// 깊이
	private Integer depth;
	// 이전 depth
	private Integer previousDepth;
	// 나열 순서
	private Integer viewOrder;
	// URL
	private String url;
	// URL Alias
	private String urlAlias;
	// 메뉴 타입이 HTML ID 일 경우 id값
	private String htmlId;
	// 메뉴 타입이 HTML ID 일 경우 메뉴와 한쌍으로 묶이는 content id값
	private String htmlContentId;
	// 이미지
	private String image;
	// 이미지 Alt
	private String imageAlt;
	// css class명
	private String cssClass;
	// 기본 표시 메뉴, Y : 기본, N : 선택
	private String defaultYn;
	// 사용유무, Y : 사용, N : 사용안함
	private String useYn;
	// 화면표시 여부, Y : 표시, N : 비표시
	private String displayYn;
	// 설명
	private String description;
	
	/********* DB *********/
	// 고유번호
	private Integer userGroupMenuId;
	// 사용자 그룹 고유키
	private Integer userGroupId;
	// 메뉴 접근 모든 권한
	private String allYn;
	// 읽기 권한
	private String readYn;
	// 쓰기 권한
	private String writeYn;
	// 수정 권한
	private String updateYn;
	// 삭제 권한
	private String deleteYn;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;

//	public String getViewInsertDate() {
//		if(getInsertDate() == null) {
//			return "";
//		}
//		
//		String tempDate = FormatUtil.getViewDateyyyyMMddHHmmss(getInsertDate());
//		return tempDate.substring(0, 19);
//	}
}
