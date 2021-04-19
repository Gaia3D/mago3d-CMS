package gaia3d.domain.uploaddata;

import java.io.Serializable;
import java.math.BigDecimal;
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
 * 사용자 업로드 파일 정보 
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UploadDataFile extends Search implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4068618702385916892L;
	
	private Integer dataGroupId;
	private String sharing;
	private String dataType;
	
	/****** validator ********/
	private String methodMode;
	
	/****** upload_data join ********/
	// 데이터명
	private String dataName;
	// 기본값 origin : latitude, longitude, height를 origin에 맞춤. boundingboxcenter : latitude, longitude, height를 boundingboxcenter 맞춤
	private String mappingType;
	// 높이 설정 방법. none : 해발 고드, clampToGround : Terrain(지형)에 맞춤, relativeToGround : Terrain(지형)으로 부터 높이 설정
	private String heightReference;
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 높이
	private BigDecimal altitude;
		
	// 고유번호
	private Long uploadDataFileId;
	// 사용자 업로드 정보 고유번호
	private Long uploadDataId;
	// converter 대상 파일 유무. true : 대상, false : 대상아님(기본값)
	private Boolean converterTarget;
	// 사용자 아이디
	private String userId;
	// 사용자명
	private String userName;
	
	// 디렉토리/파일 구분. D : 디렉토리, F : 파일
	private String fileType;
	// 파일 이름
	private String fileName;
	// 파일 실제 이름
	private String fileRealName;
	// 파일 경로
	private String filePath;
	// 공통 디렉토리 이하 부터의 파일 경로
	private String fileSubPath;
	// 계층구조 깊이. 1부터 시작
	private Integer depth;
	// 파일 사이즈
	private String fileSize;
	// 파일 확장자
	private String fileExt;
	
	// 오류 메시지
	private String errorMessage;
	
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
		
	public String validate() {
		// TODO 구현해야 한다.
		return null;
	}
	
	public Long getViewFileSizeUnitKB() {
		if(this.fileSize == null || "".equals(this.fileSize)) {
			return 0l;
		} else {
			Long size = Long.valueOf(this.fileSize);
			return size / 1000l;
		}
	}
}
