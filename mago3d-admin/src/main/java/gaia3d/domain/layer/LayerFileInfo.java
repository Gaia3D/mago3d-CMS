package gaia3d.domain.layer;

import gaia3d.domain.common.FileInfo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LayerFileInfo extends FileInfo {
	
	public static final String ZIP_EXTENSION = "zip";
	public static final String SHAPE_EXTENSION = "shp";
	
	// 고유 번호
	private Integer layerFileInfoId;
	// 레이어 고유번호
	private Integer layerId;
	// shape 파일을 같은 파일명으로 그룹핑 한것. shp 파일의 layer_file_id 가 group_id가 됨
	private Integer layerFileInfoGroupId;
	// 레이어명
	private String layerName;
	// layer 활성화 유무. Y: 활성화, N: 비활성화
	private String enableYn;
	// shape 파일 인코딩
	private String shapeEncoding;
	
	// shape 파일 update용, sysc 컬럼
	private String update;
	// shape 파일 버전 정보
	private Integer versionId;
}
