package gaia3d.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class QueueMessage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	// 사용자에서 호출인지, 관리자에서 호출인지 구분하기 위함, enum 귀찮아서.....
	private String serverTarget;
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
}
