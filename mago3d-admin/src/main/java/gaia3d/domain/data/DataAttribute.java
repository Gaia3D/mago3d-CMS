package gaia3d.domain.data;

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
 * Data Attribute 정보
 * @author Cheon JeongDae
 *
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataAttribute extends Search {
	
	/******** 화면 오류 표시용 ********/
	private String messageCode;
	private String errorCode;
	
	// 논리 삭제 
	private String deleteFlag;
	
	/****** validator ********/
	private String methodMode;
	
	// 데이터 그룹별 데이터 attribute 파일 경로
	private String dataGroupDataAttributePath;

	// Data Attribute 고유번호
	private Long dataAttributeId;
	// Data 고유번호
	private Long dataId;
	// Data Group 고유번호
	private Integer dataGroupId;
	// Data Group 이름
	private String dataGroupName;
	// data 고유 식별번호
	private String dataKey;
	// data 이름
	private String dataName;
	// Data Control 속성
	private String attributes;
	// 수정일 
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;
	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
}
