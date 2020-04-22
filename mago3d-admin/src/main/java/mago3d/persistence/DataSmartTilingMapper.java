package mago3d.persistence;

import org.springframework.stereotype.Repository;

import mago3d.domain.DataSmartTilingFileInfo;
import mago3d.domain.DataSmartTilingFileParseLog;

/**
 * Smart Tiling 데이터 파일 관리
 * @author jeongdae
 *
 */
@Repository
public interface DataSmartTilingMapper {
	
	/**
	 * Smart Tiling Data 파일 정보 등록
	 * @param dataSmartTilingFileInfo
	 * @return
	 */
	int insertDataSmartTilingFileInfo(DataSmartTilingFileInfo dataSmartTilingFileInfo);
	
	/**
	 * Smart Tiling Data 파일 파싱 정보 등록
	 * @param dataSmartTilingFileParseLog
	 * @return
	 */
	int insertDataSmartTilingFileParseLog(DataSmartTilingFileParseLog dataSmartTilingFileParseLog);
	
	/**
	 * Smart Tiling Data 정보 수정
	 * @param dataSmartTilingFileInfo
	 * @return
	 */
	int updateDataSmartTilingFileInfo(DataSmartTilingFileInfo dataSmartTilingFileInfo);
}
