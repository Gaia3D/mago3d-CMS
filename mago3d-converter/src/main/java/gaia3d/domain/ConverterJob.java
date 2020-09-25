package gaia3d.domain;

import lombok.*;

import java.io.Serializable;

/**
 * f4d converter 변환 job
 * @author jeongdae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ConverterJob extends Converter implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 3901358416749962840L;

	private Long converterJobFileId;
	
	/****** validator ********/
	private String methodMode;
	
	// Primary Key
	private Long converterJobId;
	// 업로드 고유키
	private Long uploadDataId;

	// [중복] admin : 관리자용 데이터 그룹, user : 일반 사용자용 데이터 그룹
	private String dataGroupTarget;

	// 데이터 변환 상태 집계
	private Long statusCount;
}
