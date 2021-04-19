package gaia3d.domain.layer;

import java.io.Serializable;
import java.time.LocalDateTime;

import org.hibernate.validator.constraints.Range;
import org.springframework.format.annotation.DateTimeFormat;

import gaia3d.domain.common.Search;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 레이어
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Layer extends Search implements Serializable {

    /**
    * 레이어 목록 표시
    */
    private static final long serialVersionUID = -4668268071028609827L;

    // 경도
    private String longitude;
    // 위도
    private String latitude;
    // POINT
    private String point;
    
    // 리스트 펼치기
    private String open;
    // 계층 타입
    private String nodeType;
    
    // 수정 유형
    private String updateType;
    // 쓰기 모드
    private String writeMode;
    
    // 화면 ui
    private Integer parent;
    private String parentName;
    private Integer depth;
    // 순서
    private Integer viewOrder;
    
    // shape file 인코딩
    private String shapeEncoding;
    
	// style file 내용
	private String styleFileContent;
    
    // DB
    // layer 아이디
    private Integer layerId;
    // layer 그룹 아이디
    private Integer layerGroupId;
    //
    private String layerGroupName;
    // layer 키
    private String layerKey;
    // layer 명
    private String layerName;
    
    // 업로딩 아이디
    private String userId;
    
    // 공유 타입. 0 : 공개, 1 : 개인, 2 : 그룹
    private String sharing;
    // OGC Web Services (wms, wfs, wcs, wps)
    private String ogcWebServices;
    // 레이어 타입 (Raster, Vector)	
    private String layerType;
    // 도형 타입 (point, line, polygon)
    private String geometryType;
    
    // 레이어 색상
    private String layerFillColor;
    // 레이어 선 색상
    private String layerLineColor;
    // 레이어 선 스타일(두께)
    @Range(min=1, max=5)	
    private Float layerLineStyle;
    // 레이어 투명도
    @Range(min=1, max=100)	
    private Float layerAlphaStyle;
    
    // 지도 레이어 표시 우선 순위
    private Integer zIndex;
    public Integer getViewZIndex() {
        return this.zIndex;
    }

    // 기본 표시 여부
    private Boolean defaultDisplay;
    // 사용 유무
    private Boolean available;
    // 레이블 표시 유무. Y : 표시, N : 비표시(기본값)
    private Boolean labelDisplay;
    
    private Boolean cacheAvailable;
    // 좌표계
    private String coordinate;
    // 설명
    private String description;
    
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
