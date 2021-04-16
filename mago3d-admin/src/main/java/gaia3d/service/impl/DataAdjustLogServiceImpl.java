package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.ApprovalStatus;
import gaia3d.domain.data.DataAdjustLog;
import gaia3d.domain.data.DataInfo;
import gaia3d.persistence.DataAdjustLogMapper;
import gaia3d.service.CommonService;
import gaia3d.service.DataAdjustLogService;
import gaia3d.service.DataService;
import lombok.extern.slf4j.Slf4j;

/**
 * 데이터 geometry 변경 이력
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataAdjustLogServiceImpl implements DataAdjustLogService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private DataService dataService;
	
	@Autowired
	private DataAdjustLogMapper dataAdjustLogMapper;
	
	/**
	 * 데이터 geometry 변경 요청 수
	 * @param dataAdjustLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataAdjustLogTotalCount(DataAdjustLog dataAdjustLog) {
		return dataAdjustLogMapper.getDataAdjustLogTotalCount(dataAdjustLog);
	}
	
	/**
	 * 데이터 geometry 변경 요청 목록
	 * @param dataAdjustLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataAdjustLog> getListDataAdjustLog(DataAdjustLog dataAdjustLog) {
		return dataAdjustLogMapper.getListDataAdjustLog(dataAdjustLog);
	}
	
	/**
	 * 데이터 geometry 조회
	 * @param dataAdjustLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataAdjustLog getDataAdjustLog(Long dataAdjustLog) {
		return dataAdjustLogMapper.getDataAdjustLog(dataAdjustLog);
	}

	/**
	 * 최근 데이터 geometry 변경 요청 목록
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataAdjustLog> getListRecentDataAdjustLog() {
		return dataAdjustLogMapper.getListRecentDataAdjustLog();
	}
	
	/**
	 * 스케줄러에 의한 다음년도 파티션 테이블 자동 생성
	 * @param tableName
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@Transactional
	public int createPartitionTable(String tableName, String startTime, String endTime) {
		Boolean exist = commonService.isTableExist("data_adjust_log_" + tableName);
		log.info("@@@ dataAdjustLog tableName = {}, isTableExist = {}", tableName, exist);

		if(!exist) return dataAdjustLogMapper.createPartitionTable(tableName, startTime, endTime);

		return 0;
	}
	
	/**
	 * 데이터 geometry 변경 요청 상태 변경
	 * @param dataAdjustLog
	 * @return
	 */
	@Transactional
	public int updateDataAdjustLogStatus(DataAdjustLog dataAdjustLog) {
		
		DataAdjustLog dbDataInfoAdjustLog = dataAdjustLogMapper.getDataAdjustLog(dataAdjustLog.getDataAdjustLogId());
		
		DataInfo dataInfo = new DataInfo();
		if(ApprovalStatus.APPROVAL == ApprovalStatus.valueOf(dataAdjustLog.getStatus().toUpperCase())) {
			// 화면에서 승인으로 상태 변경을 요청한 경우. 대기 상태여야 함
			if(ApprovalStatus.REQUEST != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus().toUpperCase())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			
			// data_info 를 update
			dataInfo.setDataId(dbDataInfoAdjustLog.getDataId());
			dataInfo.setLocation("POINT(" + dbDataInfoAdjustLog.getLongitude() + " " + dbDataInfoAdjustLog.getLatitude() + ")");
			dataInfo.setAltitude(dbDataInfoAdjustLog.getAltitude());
			dataInfo.setHeading(dbDataInfoAdjustLog.getHeading());
			dataInfo.setPitch(dbDataInfoAdjustLog.getPitch());
			dataInfo.setRoll(dbDataInfoAdjustLog.getRoll());
			dataInfo.setHeightReference(dbDataInfoAdjustLog.getHeightReference());
			dataService.updateData(dataInfo);
		} else if(ApprovalStatus.REJECT == ApprovalStatus.valueOf(dataAdjustLog.getStatus().toUpperCase())) {
			// 화면에서 기각으로 상태 변경을 요청한 경우. 대기 상태여야 함
			if(ApprovalStatus.REQUEST != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus().toUpperCase())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// 아무 처리도 하지 않음
		} else if(ApprovalStatus.ROLLBACK == ApprovalStatus.valueOf(dataAdjustLog.getStatus().toUpperCase())) {
			// 화면에서 원복으로 상태 변경을 요청한 경우. 승인 또는 기각 상태여야 함
			
			if(ApprovalStatus.APPROVAL != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus().toUpperCase())
					&& ApprovalStatus.REJECT != ApprovalStatus.valueOf(dbDataInfoAdjustLog.getStatus())) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// data_info 의 상태를 원래대로 되돌림. 를 update
			dataInfo.setDataId(dbDataInfoAdjustLog.getDataId());
			dataInfo.setLocation("POINT(" + dbDataInfoAdjustLog.getBeforeLongitude() + " " + dbDataInfoAdjustLog.getBeforeLatitude() + ")");
			dataInfo.setAltitude(dbDataInfoAdjustLog.getBeforeAltitude());
			dataInfo.setHeading(dbDataInfoAdjustLog.getBeforeHeading());
			dataInfo.setPitch(dbDataInfoAdjustLog.getBeforePitch());
			dataInfo.setRoll(dbDataInfoAdjustLog.getBeforeRoll());
			dataInfo.setHeightReference(dbDataInfoAdjustLog.getBeforeHeightReference());
			dataService.updateData(dataInfo);
		}
		
		return dataAdjustLogMapper.updateDataAdjustLogStatus(dataAdjustLog);
	}
}
