package gaia3d.domain.data;

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
public class DataSmartTilingFileInfo extends FileInfo {
	
	//
	private String userId;
	
	// 고유번호
	private Long dataSmartTilingFileInfoId;
	// 데이터 그룹 고유번호
	private Integer dataGroupId;
	
	// 전체 데이터 건수
	private Integer totalCount;
	// 파싱 성공 건수
	private Integer parseSuccessCount;
	// 파싱 오류
	private Integer parseErrorCount;
	// 데이터 Target Table SQL Insert 성공 건수
	private Integer insertSuccessCount;
	// 데이터 Target Table SQL Insert 실패 건수
	private Integer insertErrorCount;
	// 데이터 Target Table SQL update 성공 건수
	private Integer updateSuccessCount;
	// 데이터 Target Table SQL Insert 실패 건수
	private Integer updateErrorCount;
}
