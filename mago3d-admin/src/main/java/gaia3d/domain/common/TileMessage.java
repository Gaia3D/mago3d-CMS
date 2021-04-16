package gaia3d.domain.common;

import gaia3d.domain.ServerTarget;
import lombok.*;

import java.io.Serializable;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TileMessage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 스마트 타일링 고유번호
	private Integer tileId;
	// 타일명
	private String tileName;
	// 타일 Key
	private String tileKey;
	// 스마트 타일 경로
	private String tilePath;

	// 디렉토리 경로
	private String filePath;
	// json 파일명
	private String fileName;

	// 스마트 타일링 호출 서버정보 - USER(사용자에서 호출한 경우), ADMIN(관리자에서 호출한 경우)
	private ServerTarget serverTarget;

}
