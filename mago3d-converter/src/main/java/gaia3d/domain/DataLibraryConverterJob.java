package gaia3d.domain;

import lombok.*;

import java.io.Serializable;

/**
 * TODO 상속을 할까? ㅠ.ㅠ
 * 데이터 라이브러리 변환 job
 * @author jeongdae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataLibraryConverterJob extends Converter implements Serializable {

	private static final long serialVersionUID = -1896808915157573372L;

	private Long dataLibraryConverterJobFileId;
	
	// Primary Key
	private Long dataLibraryConverterJobId;
	// 업로드 고유키
	private Long dataLibraryUploadId;
	// [중복] admin : 관리자용 데이터 라이브러리 그룹, user : 일반 사용자용 데이터 라이브러리 그룹
	private String dataLibraryGroupTarget;

	// 데이터 변환 상태 집계
	private Long statusCount;
}
