package gaia3d.domain.policy;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 2D, 3D 운영 정책
 * @author jeongdae
 *
 */
@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GeoPolicy {
    
	// 고유번호
	@NotNull
    private Long geoPolicyId;
	
	// javascript library. 기본 cesium 
	private String basicGlobe;
	// ceisum ion token
	private String cesiumIonToken;
	// Terrain 유형. geoserver, cesium-default, cesium-ion-default, cesium-ion-cdn : 우리 dem 을 업로딩, cesium-customer : cesium docker provier
	private String terrainType;
	// url 또는 cesium ion code 값
	private String terrainValue;
	
	// F4D converter file 정보 취득 api url
	private String dataApiUrl;
	// 데이터 서비스 Root Path
	private String dataServicePath;
	// 데이터 정보 변경 요청에 대한 처리. auto : 자동승인, approval : 결재(초기값)
	private String dataChangeRequestDecision;
	
	// geoserver 사용유무. Y : 사용(기본값), N : 미사용
	private Boolean geoserverEnable;
	// geoserver wms 버전. 기본 1.1.1
	private String geoserverWmsVersion;
	// geoserver 데이터 URL
	private String geoserverDataUrl;
	// geoserver 데이터 작업공간
	private String geoserverDataWorkspace;
	// geoserver 데이터 저장소
	private String geoserverDataStore;
	// geoserver 계정
	private String geoserverUser;
	// geoserver 비밀번호
	private String geoserverPassword;
	
	// geoserver imageprovider 사용 유무. 기본 false
	private Boolean geoserverImageproviderEnable;
	// geoserver imageprovider 요청 URL
	private String geoserverImageproviderUrl;
	// geoserver imageprovider 로 사용할 레이어명
	private String geoserverImageproviderLayerName;
	// geoserver imageprovider 에 사용할 스타일명
	private String geoserverImageproviderStyleName;
	// geoserver 레이어 이미지 가로크기
	private Integer geoserverImageproviderParametersWidth;
	// geoserver 레이어 이미지 세로크기
	private Integer geoserverImageproviderParametersHeight;
	// geoserver 레이어 포맷형식
	private String geoserverImageproviderParametersFormat;

	// geoserver terrainprovider 로 사용할 레이어명
	private String geoserverTerrainproviderLayerName;
	// geoserver terrainprovider 에 사용할 스타일명
	private String geoserverTerrainproviderStyleName;
	// geoserver 레이어 이미지 가로크기
	private Integer geoserverTerrainproviderParametersWidth;
	// geoserver 레이어 이미지 세로크기
	private Integer geoserverTerrainproviderParametersHeight;
	// geoserver 레이어 포맷형식
	private String geoserverTerrainproviderParametersFormat;
	
	// 초기 카메라 이동 유무. 기본 true
 	private Boolean initCameraEnable;
 	// 초기 카메라 이동 위도
 	private String initLatitude;
 	// 초기 카메라 이동 경도
 	private String initLongitude;
 	// 초기 카메라 이동 높이
 	private String initAltitude;
 	// 초기 카메라 이동 시간. 초 단위
 	private Integer initDuration;
 	// 기본 Terrain
 	private String initDefaultTerrain;
 	// field of view. 기본값 0(1.8 적용)
 	private Float initDefaultFov;
 	
 	// LOD0. 기본값 15M
 	private String lod0;
 	// LOD1. 기본값 60M
 	private String lod1;
 	// LOD2. 기본값 900M
 	private String lod2;
 	// LOD3. 기본값 200M
 	private String lod3;
 	// LOD3. 기본값 1000M
 	private String lod4;
 	// LOD3. 기본값 50000M
 	private String lod5;
 	
 	// 그림자 반경
  	private Float ssaoRadius;
  	// cullFace 사용유무. 기본 false
  	private Boolean cullFaceEnable;
  	// timeLine 사용유무. 기본 false
  	private Boolean timeLineEnable;
  	
  	// LOD0일시 PointCloud 데이터 파티션 개수. 기본값 4
  	private Integer maxPartitionsLod0;
	// LOD1일시 PointCloud 데이터 파티션 개수. 기본값 2
  	private Integer maxPartitionsLod1;
	// LOD2 이상 일시 PointCloud 데이터 파티션 개수. 기본값 1
  	private Integer maxPartitionsLod2OrLess;
	// 카메라와의 거리가 10미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 10
  	private Integer maxRatioPointsDist0m;
	// 카메라와의 거리가 100미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 120
  	private Integer maxRatioPointsDist100m;
  	// 카메라와의 거리가 200미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 240
  	private Integer maxRatioPointsDist200m;
  	// 카메라와의 거리가 400미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 480
  	private Integer maxRatioPointsDist400m;
  	// 카메라와의 거리가 800미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 960
  	private Integer maxRatioPointsDist800m;
  	// 카메라와의 거리가 1600미터 미만일때, PointCloud 점의 갯수의 비율의 분모, 기본값 1920
  	private Integer maxRatioPointsDist1600m;
  	// 카메라와의 거리가 1600미터 이상일때, PointCloud 점의 갯수의 비율의 분모, 기본값 3840
  	private Integer maxRatioPointsDistOver1600m;
  	// PointCloud 점의 최대 크기. 기본값 40.0
  	private BigDecimal maxPointSizeForPc;
  	// PointCloud 점의 최소 크기. 기본값 3.0
  	private BigDecimal minPointSizeForPc;
  	// PointCloud 점의 크기 보정치. 높아질수록 점이 커짐. 기본값 60.0
  	private BigDecimal pendentPointSizeForPc;
  	// GPU Memory Pool 사용유무. 기본값 false
  	private Boolean memoryManagement;
  	
  	// 레이어 원본 좌표계
  	private String layerSourceCoordinate;
  	// 레이어 좌표계 정의
  	private String layerTargetCoordinate;
 	
 	// 등록일
 	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
