package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.data.DataInfoLog;
import gaia3d.persistence.DataLogMapper;
import gaia3d.service.CommonService;
import gaia3d.service.DataLogService;
import lombok.extern.slf4j.Slf4j;

/**
 * Data Change Request Log
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataLogServiceImpl implements DataLogService {

	@Autowired
	private CommonService commonService;

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
	 * 스케줄러에 의한 다음년도 파티션 테이블 자동 생성
	 * @param tableName
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	@Transactional
	public int createPartitionTable(String tableName, String startTime, String endTime) {
		Boolean exist = commonService.isTableExist("data_info_log_" + tableName);
		log.info("@@@ dataLog tableName = {}, isTableExist = {}", tableName, exist);

		if(!exist) return dataLogMapper.createPartitionTable(tableName, startTime, endTime);

		return 0;
	}
	
	/**
	 * 데이터 변경 이력 등록
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional
	public int insertDataInfoLog(DataInfoLog dataInfoLog) {
		return dataLogMapper.insertDataInfoLog(dataInfoLog);
	}
}
