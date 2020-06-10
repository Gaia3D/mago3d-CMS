package gaia3d.domain;

import java.io.Serializable;
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
 * Data 정보
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataInfo extends Search implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4527009012673017066L;
	
	public static final String F4D_PREFIX = "F4D_";
	
	/******** 화면 오류 표시용 ********/
	private String messageCode;
	private String errorCode;
	// 아이디 중복 확인 hidden 값
	private String duplicationValue;
	// 그룹 통계용
	private Long dataCount;
	// 3D 지도 표시 시 목록에서 온건지, 수정에서 온건지를 구분하기 위해.
	private String referrer;
	// 고유번호
	private Integer userGroupId;
	
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	
	// 사용자명
	private String userId;
	// 수정자 아이디
	private String updateUserId;
	private String userName;
	
	/****** validator ********/
	private MethodType methodType;

	// 고유번호
	private Long dataId;
	// Data Group 고유번호
	private Integer dataGroupId;
	// converter job 고유번호
	private Long converterJobId;
	// Data Group 이름
	private String dataGroupName;
	// admin : 관리자용 데이터 그룹, user : 일반 사용자용 데이터 그룹
	private String dataGroupTarget;
	// data group key
	private String dataGroupKey;
	// smart
	private Boolean tiling;
	
	// data 고유 식별번호
	private String dataKey;
	// data 고유 식별번호
	private String oldDataKey;
	// data 이름
	private String dataName;
	// 데이터 타입(중복). 3ds,obj,dae,collada,ifc,las,citygml,indoorgml,etc
	private String dataType;
	// common : 공통, public : 공개, private : 개인, group : 그룹
	private String sharing;
	// 부모 고유번호
	private Long parent;
	// 부모 이름(화면 표시용)
	private String parentName;
	
	// origin : latitude, longitude, height 를 origin에 맟춤. boundingboxcenter : latitude, longitude, height 를 boundingboxcenter에 맟춤.
	private String mappingType;

	// POINT(위도, 경도). 공간 검색 속도 때문에 altitude는 분리
	private String location;
	// 높이
	private BigDecimal altitude;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	
	// 조상
	private Integer childrenAncestor;
	// 부모
	private Integer childrenParent;
	// 깊이
	private Integer childrenDepth;
	// 순서
	private Integer childrenViewOrder;
	
	// 기본 정보
	private String metainfo;
	// data 상태. processing : 변환중, use : 사용중, unused : 사용중지(관리자), delete : 삭제(비표시)
	private String status;
	// 데이터 상태(ENUM)
	private DataStatus dataStatus;
	// 속성 존재 유무. true : 존재, false : 존재하지 않음(기본값)
	private Boolean attributeExist;
	// object 속성 존재 유무. true : 존재, false : 존재하지 않음(기본값)
	private Boolean objectAttributeExist;
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
	
	public String getViewMetainfo() {
		if(this.metainfo == null || "".equals( metainfo) || metainfo.length() < 20) {
			return metainfo;
		}
		return metainfo.substring(0, 20) + "...";
	}
}
