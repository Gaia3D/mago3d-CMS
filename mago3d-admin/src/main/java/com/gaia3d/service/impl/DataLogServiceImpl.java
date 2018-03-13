package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.persistence.DataLogMapper;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.service.DataLogService;
import com.gaia3d.service.DataService;

/**
 * Data Change Request Log
 * @author jeongdae
 *
 */
@Service
public class DataLogServiceImpl implements DataLogService {

	@Autowired
	private DataService dataService;
	
	@Autowired
	private DataLogMapper dataLogMapper;
	
	/**
	 * Data 변경 요청 수
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataInfoLogTotalCount(DataInfoLog dataInfoLog) {
		return dataLogMapper.getDataInfoLogTotalCount(dataInfoLog);
	}
	
	/**
	 * 데이터 변경 요청 로그
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoLog> getListDataInfoLog(DataInfoLog dataInfoLog) {
		return dataLogMapper.getListDataInfoLog(dataInfoLog);
	}
	
	/**
	 * data info log 조회
	 * @param dataInfoLogId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfoLog getDataInfoLog(Long dataInfoLogId) {
		return dataLogMapper.getDataInfoLog(dataInfoLogId);
	}
	
	/**
	 * 데이터 로그 상태 변경
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public int updateDataInfoLogStatus(DataInfoLog dataInfoLog) {
		DataInfoLog dbDataInfoLog = dataLogMapper.getDataInfoLog(dataInfoLog.getData_info_log_id());
		if(DataInfoLog.STATUS_COMPLETE.equals(dataInfoLog.getStatus())) {
			if(!dbDataInfoLog.getStatus().equals(DataInfoLog.STATUS_REQUEST)) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// data_info 를 update
			DataInfo dataInfo = new DataInfo();
			dataInfo.setData_id(dbDataInfoLog.getData_id());
			if(dbDataInfoLog.getLatitude() != null && dbDataInfoLog.getLatitude().floatValue() != 0f &&
					dbDataInfoLog.getLongitude() != null && dbDataInfoLog.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dbDataInfoLog.getLongitude() + " " + dbDataInfoLog.getLatitude() + ")");
			}
			dataInfo.setLatitude(dbDataInfoLog.getLatitude());
			dataInfo.setLongitude(dbDataInfoLog.getLongitude());
			dataInfo.setHeight(dbDataInfoLog.getHeight());
			dataInfo.setHeading(dbDataInfoLog.getHeading());
			dataInfo.setPitch(dbDataInfoLog.getPitch());
			dataInfo.setRoll(dbDataInfoLog.getRoll());
			dataService.updateData(dataInfo);
		} else if(DataInfoLog.STATUS_REJECT.equals(dataInfoLog.getStatus())) {
			if(!dbDataInfoLog.getStatus().equals(DataInfoLog.STATUS_REQUEST)) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// 아무 처리도 하지 않음
		} else if(DataInfoLog.STATUS_RESET.equals(dataInfoLog.getStatus())) {
			if(!dbDataInfoLog.getStatus().equals(DataInfoLog.STATUS_COMPLETE)
					&& !dbDataInfoLog.getStatus().equals(DataInfoLog.STATUS_REJECT)) {
				throw new IllegalArgumentException("DataInfoLog Status Exception");
			}
			// data_info 의 상태를 원래대로 되돌림
			// data_info 를 update
			DataInfo dataInfo = new DataInfo();
			dataInfo.setData_id(dbDataInfoLog.getData_id());
			if(dbDataInfoLog.getLatitude() != null && dbDataInfoLog.getLatitude().floatValue() != 0f &&
					dbDataInfoLog.getLongitude() != null && dbDataInfoLog.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dbDataInfoLog.getLongitude() + " " + dbDataInfoLog.getLatitude() + ")");
			}
			dataInfo.setLatitude(dbDataInfoLog.getBefore_latitude());
			dataInfo.setLongitude(dbDataInfoLog.getBefore_longitude());
			dataInfo.setHeight(dbDataInfoLog.getBefore_height());
			dataInfo.setHeading(dbDataInfoLog.getBefore_heading());
			dataInfo.setPitch(dbDataInfoLog.getBefore_pitch());
			dataInfo.setRoll(dbDataInfoLog.getBefore_roll());
			dataService.updateData(dataInfo);
		}
		
		return dataLogMapper.updateDataInfoLogStatus(dataInfoLog);
	}
}
