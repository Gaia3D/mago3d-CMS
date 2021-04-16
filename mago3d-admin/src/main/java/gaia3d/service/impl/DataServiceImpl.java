package gaia3d.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.MethodType;
import gaia3d.domain.ServerTarget;
import gaia3d.domain.SharingType;
import gaia3d.domain.data.DataFileInfo;
import gaia3d.domain.data.DataFileParseLog;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataInfoLog;
import gaia3d.domain.data.DataInfoSimple;
import gaia3d.domain.data.DataStatus;
import gaia3d.parser.DataFileParser;
import gaia3d.parser.impl.DataFileJsonParser;
import gaia3d.persistence.DataMapper;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataLogService;
import gaia3d.service.DataRelationService;
import gaia3d.service.DataService;
import lombok.extern.slf4j.Slf4j;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataServiceImpl implements DataService {

	@Autowired
	private DataMapper dataMapper;
	
	@Autowired
	private DataRelationService dataRelationService;
	
	@Autowired
	private DataGroupService dataGroupService;
	
	@Autowired
	private DataLogService dataLogService;
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCount(DataInfo dataInfo) {
		return dataMapper.getDataTotalCount(dataInfo);
	}
	
	@Transactional(readOnly = true)
	public Long getDataRelationCount(Long dataRelationId) {
		return dataMapper.getDataRelationCount(dataRelationId);
	}

	/**
	 * 데이터 상태별 통계 정보
	 * @param status
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCountByStatus(String status) {
		return dataMapper.getDataTotalCountByStatus(status);
	}
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListData(DataInfo dataInfo) {
		return dataMapper.getListData(dataInfo);
	}
	
	/**
	 * 데이터 그룹에 포함되는 모든 데이터를 취득
	 * @param dataGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoSimple> getListAllDataByDataGroupId(Integer dataGroupId) {
		return dataMapper.getListAllDataByDataGroupId(dataGroupId);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getData(DataInfo dataInfo) {
		return dataMapper.getData(dataInfo);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getDataByDataKey(DataInfo dataInfo) {
		return dataMapper.getDataByDataKey(dataInfo);
	}
	
	/**
	 * 최상위 root dataInfo 정보 취득
	 * @param dataGroupId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getRootDataByDataGroupId(Integer dataGroupId) {
		return dataMapper.getRootDataByDataGroupId(dataGroupId);
	}
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getDataByConverterJob(DataInfo dataInfo) {
		return dataMapper.getDataByConverterJob(dataInfo);
	}

	/**
	 * 데이터 현황
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getDataTypeCount() {
		return dataMapper.getDataTypeCount();
	}
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int insertData(DataInfo dataInfo) {
		dataMapper.insertData(dataInfo);
		DataInfoLog dataInfoLog = new DataInfoLog(dataInfo);
		dataInfoLog.setChangeType(MethodType.INSERT.name().toLowerCase());
		return dataLogService.insertDataInfoLog(dataInfoLog);
	}
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateData(DataInfo dataInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		dataMapper.updateData(dataInfo);
		dataInfo = dataMapper.getData(dataInfo);
		DataInfoLog dataInfoLog = new DataInfoLog(dataInfo);
		dataInfoLog.setChangeType(MethodType.UPDATE.name().toLowerCase());
		dataInfoLog.setUpdateUserId(dataInfo.getUserId());
		return dataLogService.insertDataInfoLog(dataInfoLog);
	}
	
	/**
	 * Data Bulk 등록
	 * @param dataFileInfo
	 * @return
	 */
	@Transactional
	public DataFileInfo upsertBulkData(DataFileInfo dataFileInfo) {
		Integer dataGroupId = dataFileInfo.getDataGroupId();
		String userId = dataFileInfo.getUserId();
		
		// 파일 이력을 저장
		dataMapper.insertDataFileInfo(dataFileInfo);
		
		DataFileParser dataFileParser = new DataFileJsonParser();
		Map<String, Object> map = dataFileParser.parse(dataGroupId, dataFileInfo);
		
		DataGroup dataGroup = DataGroup.builder().dataGroupId(dataGroupId).build();
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		@SuppressWarnings("unchecked")
		List<DataInfo> dataInfoList = (List<DataInfo>) map.get("dataInfoList");
		
		DataFileParseLog dataFileParseLog = new DataFileParseLog();
		dataFileParseLog.setDataFileInfoId(dataFileInfo.getDataFileInfoId());
		dataFileParseLog.setLogType(DataFileParseLog.DB);
		
		BigDecimal firstLongitude = BigDecimal.ZERO;
		BigDecimal firstLatitude = BigDecimal.ZERO;
		BigDecimal firstAltitude = BigDecimal.ZERO;
		int insertSuccessCount = 0;
		int updateSuccessCount = 0;
		int insertErrorCount = 0;
		String dataGroupTarget = ServerTarget.ADMIN.name().toLowerCase();
		String sharing = SharingType.COMMON.name().toLowerCase();
		String status = DataStatus.USE.name().toLowerCase();
		int count = 0;
		for(DataInfo dataInfo : dataInfoList) {
			if(count == 0) {
				// 데이터 그룹의 위치
				firstLongitude = dataInfo.getLongitude();
				firstLatitude = dataInfo.getLatitude();
				firstAltitude = dataInfo.getAltitude();
			}
			// TODO 계층 관련 코딩이 있어야 함
			try {
				dataInfo.setDataGroupId(dataGroupId);
				DataInfo dbDataInfo = dataMapper.getDataByDataKey(dataInfo);
				if(dbDataInfo == null) {
					dataInfo.setDataGroupTarget(dataGroupTarget);
					dataInfo.setSharing(sharing);
					dataInfo.setUserId(userId);
					dataInfo.setStatus(status);
					if(dataInfo.getDataId() == null || dataInfo.getDataId() == 0L) {
						dataMapper.insertBulkDataWithDataId(dataInfo);
					} else {
					dataMapper.insertBulkData(dataInfo);
					}
					insertSuccessCount++;
				} else {
					dataInfo.setDataId(dbDataInfo.getDataId());
					dataMapper.updateData(dataInfo);
					updateSuccessCount++;
				}
			} catch(DataAccessException e) {
				log.info("@@@@@@@@@@@@ dataAccess exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				dataFileParseLog.setIdentifierValue(dataFileInfo.getUserId());
				dataFileParseLog.setErrorCode(e.getMessage());
				dataMapper.insertDataFileParseLog(dataFileParseLog);
				insertErrorCount++;
			} catch(RuntimeException e) {
				log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				dataFileParseLog.setIdentifierValue(dataFileInfo.getUserId());
				dataFileParseLog.setErrorCode(e.getMessage());
				dataMapper.insertDataFileParseLog(dataFileParseLog);
				insertErrorCount++;
			} catch(Exception e) {
				log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
				dataFileParseLog.setIdentifierValue(dataFileInfo.getUserId());
				dataFileParseLog.setErrorCode(e.getMessage());
				dataMapper.insertDataFileParseLog(dataFileParseLog);
				insertErrorCount++;
			}
			count++;
		}
		
		dataFileInfo.setTotalCount((Integer) map.get("totalCount"));
		dataFileInfo.setParseSuccessCount((Integer) map.get("parseSuccessCount"));
		dataFileInfo.setParseErrorCount((Integer) map.get("parseErrorCount"));
		dataFileInfo.setInsertSuccessCount(insertSuccessCount);
		dataFileInfo.setUpdateSuccessCount(updateSuccessCount);
		dataFileInfo.setInsertErrorCount(insertErrorCount);
		
		dataMapper.updateDataFileInfo(dataFileInfo);
		
		// data group update
		String dataGroupLocation = null;
		if(dataGroup.getLongitude() == null || dataGroup.getLongitude().longValue() <= 0) {
			dataGroupLocation = "POINT(" + firstLongitude + " " + firstLatitude + ")";
		}
		
		int dataCount = dataGroup.getDataCount() + insertSuccessCount;
		dataGroup = DataGroup.builder()
				.dataGroupId(dataGroupId)
				.dataCount(dataCount)
				.build();
		if(dataGroupLocation != null) {
			dataGroup.setLocation(dataGroupLocation);
			dataGroup.setAltitude(firstAltitude);
		}
		dataGroupService.updateDataGroup(dataGroup);
		
		return dataFileInfo;
	}
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int updateDataStatus(DataInfo dataInfo) {
		return dataMapper.updateDataStatus(dataInfo);
	}
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int deleteData(DataInfo dataInfo) {
		// 데이터 그룹 count -1
		dataInfo = dataMapper.getData(dataInfo);
		
		DataGroup dataGroup = new DataGroup();
		dataGroup.setDataGroupId(dataInfo.getDataGroupId());
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		DataGroup tempDataGroup = DataGroup.builder()
				.dataGroupId(dataGroup.getDataGroupId())
				.dataCount(dataGroup.getDataCount() - 1).build();
		dataGroupService.updateDataGroup(tempDataGroup);
		
		// data_relation 삭제
		Long dataRelationId = dataInfo.getDataRelationId();
		if (dataMapper.getDataRelationCount(dataRelationId) == 1) {
			dataRelationService.deleteDataRelation(dataInfo.getDataRelationId());
		}

		return dataMapper.deleteData(dataInfo);
		// TODO 디렉토리도 삭제 해야 함
	}
	
	/**
	 * 일괄 Data 삭제
	 * @param checkIds
	 * @return
	 */
	@Transactional
	public int deleteDataList(String userId, String checkIds) {
		// TODO sql in 으로 한번 query 가능 함. 수정해야 함
		
		String[] dataIds = checkIds.split(",");
		for(String dataId : dataIds) {
			DataInfo dataInfo = new DataInfo();
			dataInfo.setUserId(userId);
			dataInfo.setDataId(Long.valueOf(dataId));
			return dataMapper.deleteData(dataInfo);
		}
		
		return checkIds.length();
	}
	
	/**
	 * Data 에 속하는 모든 Object ID를 삭제
	 * @param dataId
	 * @return
	 */
	@Transactional
	public int deleteDataObjects(Long dataId) {
		return dataMapper.deleteDataObjects(dataId);
	}
	
	/**
	 * Data 삭제
	 * @param dataInfo
	 * @return
	 */
	@Transactional
	public int deleteDataByConverterJob(DataInfo dataInfo) {
		return dataMapper.deleteDataByConverterJob(dataInfo);
	}
	
	/**
	 * user data 삭제
	 */
	@Transactional
	public int deleteDataByUserId(String userId) {
		return dataMapper.deleteDataByUserId(userId);
	}
}
