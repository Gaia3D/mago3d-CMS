package gaia3d.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.ServerTarget;
import gaia3d.domain.SharingType;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataSmartTilingFileInfo;
import gaia3d.domain.data.DataSmartTilingFileParseLog;
import gaia3d.domain.data.DataStatus;
import gaia3d.parser.DataSmartTilingFileParser;
import gaia3d.parser.impl.DataSmartTilingFileJsonParser;
import gaia3d.persistence.DataSmartTilingMapper;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import gaia3d.service.DataSmartTilingService;
import lombok.extern.slf4j.Slf4j;

/**
 * 데이터 속성 관리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataSmartTilingServiceImpl implements DataSmartTilingService {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private DataSmartTilingMapper dataSmartTilingMapper;
	
	/**
	 * Smart Tiling 데이터 등록/수정
	 */
	@Transactional
	public DataSmartTilingFileInfo upsertDataSmartTiling(DataSmartTilingFileInfo dataSmartTilingFileInfo) {
		
		Integer dataGroupId = dataSmartTilingFileInfo.getDataGroupId();
		String userId = dataSmartTilingFileInfo.getUserId();
		
		// 파일 이력을 저장
		dataSmartTilingMapper.insertDataSmartTilingFileInfo(dataSmartTilingFileInfo);
		
		DataSmartTilingFileParser dataSmartTilingFileParser = new DataSmartTilingFileJsonParser();
		Map<String, Object> map = dataSmartTilingFileParser.parse(dataGroupId, dataSmartTilingFileInfo);
		
		DataGroup dataGroup = DataGroup.builder().dataGroupId(dataGroupId).build();
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		@SuppressWarnings("unchecked")
		List<DataInfo> dataInfoList = (List<DataInfo>) map.get("dataInfoList");
		
		DataSmartTilingFileParseLog dataSmartTilingFileParseLog = new DataSmartTilingFileParseLog();
		dataSmartTilingFileParseLog.setDataSmartTilingFileInfoId(dataSmartTilingFileInfo.getDataSmartTilingFileInfoId());
		dataSmartTilingFileParseLog.setLogType(DataSmartTilingFileParseLog.DB);
		
		int insertSuccessCount = 0;
		int updateSuccessCount = 0;
		int insertErrorCount = 0;
		String dataGroupTarget = ServerTarget.ADMIN.name().toLowerCase();
		String sharing = SharingType.COMMON.name().toLowerCase();
		String status = DataStatus.USE.name().toLowerCase();
		
		for(DataInfo dataInfo : dataInfoList) {
			// TODO 계층 관련 코딩이 있어야 함
			try {
				dataInfo.setDataGroupId(dataGroupId);
				DataInfo dbDataInfo = dataService.getDataByDataKey(dataInfo);
				if(dbDataInfo == null) {
					dataInfo.setDataGroupTarget(dataGroupTarget);
					dataInfo.setSharing(sharing);
					dataInfo.setUserId(userId);
					dataInfo.setStatus(status);
					dataService.insertData(dataInfo);
					insertSuccessCount++;
				} else {
					dataInfo.setDataId(dbDataInfo.getDataId());
					dataService.updateData(dataInfo);
					updateSuccessCount++;
				}
			} catch(DataAccessException e) {
				log.info("@@@@@@@@@@@@ dataAccess exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				dataSmartTilingFileParseLog.setIdentifierValue(dataSmartTilingFileInfo.getUserId());
				dataSmartTilingFileParseLog.setErrorCode(e.getMessage());
				dataSmartTilingMapper.insertDataSmartTilingFileParseLog(dataSmartTilingFileParseLog);
				insertErrorCount++;
			} catch(RuntimeException e) {
				log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				dataSmartTilingFileParseLog.setIdentifierValue(dataSmartTilingFileInfo.getUserId());
				dataSmartTilingFileParseLog.setErrorCode(e.getMessage());
				dataSmartTilingMapper.insertDataSmartTilingFileParseLog(dataSmartTilingFileParseLog);
				insertErrorCount++;
			} catch(Exception e) {
				log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				dataSmartTilingFileParseLog.setIdentifierValue(dataSmartTilingFileInfo.getUserId());
				dataSmartTilingFileParseLog.setErrorCode(e.getMessage());
				dataSmartTilingMapper.insertDataSmartTilingFileParseLog(dataSmartTilingFileParseLog);
				insertErrorCount++;
			}
		}
		
		dataSmartTilingFileInfo.setTotalCount((Integer) map.get("totalCount"));
		dataSmartTilingFileInfo.setParseSuccessCount((Integer) map.get("parseSuccessCount"));
		dataSmartTilingFileInfo.setParseErrorCount((Integer) map.get("parseErrorCount"));
		dataSmartTilingFileInfo.setInsertSuccessCount(insertSuccessCount);
		dataSmartTilingFileInfo.setUpdateSuccessCount(updateSuccessCount);
		dataSmartTilingFileInfo.setInsertErrorCount(insertErrorCount);
		
		dataSmartTilingMapper.updateDataSmartTilingFileInfo(dataSmartTilingFileInfo);
		
		// data group update
		int dataCount = dataGroup.getDataCount() + insertSuccessCount;
		dataGroup = DataGroup.builder()
				.dataGroupId(dataGroupId)
				.dataCount(dataCount)
				.build();
		dataGroupService.updateDataGroup(dataGroup);
		
		return dataSmartTilingFileInfo;
	}
}
