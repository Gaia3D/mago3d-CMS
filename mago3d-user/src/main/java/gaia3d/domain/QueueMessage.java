package gaia3d.domain;

import gaia3d.domain.uploaddata.UploadDataType;
import lombok.*;

import java.io.Serializable;
import java.math.BigDecimal;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QueueMessage implements Serializable {

	private static final long serialVersionUID = 3921739919596885061L;

	private ConverterType converterType;
	private ServerTarget serverTarget;
	private String userId;

	private Long converterJobId;
	private Long converterJobFileId;
	private String inputFolder;
	private String outputFolder;
	private String meshType;
	private String skinLevel;
	private String logPath;
	private String indexing;

	// unit scale factor. 설계 파일의 1이 의미하는 단위. 기본 1 = 0.01m
	private BigDecimal usf;
	private String isYAxisUp;

	// cityGML, indoorGML 구분을 위해..
	private UploadDataType uploadDataType;
}
