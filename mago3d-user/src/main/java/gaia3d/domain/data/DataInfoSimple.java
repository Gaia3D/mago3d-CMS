package gaia3d.domain.data;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * Data 정보(간략)
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataInfoSimple implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7463973515357920931L;
	
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정
	private String heightReference;

	// 고유번호
	private Long dataId;
	// Data Group 고유번호
	private Integer dataGroupId;
	// Data Group 이름
	private String dataGroupName;
	// admin : 관리자용 데이터 그룹, user : 일반 사용자용 데이터 그룹
	private String dataGroupTarget;
	// data group key
	private String dataGroupKey;
	// data 고유 식별번호
	private String dataKey;
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

	// 높이
	private BigDecimal altitude;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	
	// 기본 정보
	private String metainfo;
	// 라벨. data_name과 다른 이름으로 style을 활용하기 위함. 줄바꿈 \n
	private String label;
	// 라벨 템플릿. 데이터에 적용할 라벨 템플릿 타입을 저장
	private String labelTemplate;
	// data 상태. processing : 변환중, use : 사용중, unused : 사용중지(관리자), delete : 삭제(비표시)
	private String status;
	// 속성 존재 유무. true : 존재, false : 존재하지 않음(기본값)
	private Boolean attributeExist;
	// object 속성 존재 유무. true : 존재, false : 존재하지 않음(기본값)
	private Boolean objectAttributeExist;
	
}
