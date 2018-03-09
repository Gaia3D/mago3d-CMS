package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.DataInfoLog;

/**
 * Data Info 변경 이력
 * @author jeongdae
 *
 */
@Repository
public interface DataLogMapper {

	/**
	 * 데이터 변경 요청 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataInfoLogTotalCountByUserId(DataInfoLog dataInfoLog);
	
	/**
	 * 데이터 변경 요청 로그
	 * @param dataInfoLog
	 * @return
	 */
	List<DataInfoLog> getListDataInfoLogByUserId(DataInfoLog dataInfoLog);
	
	/**
	 * data info log 조회
	 * @param data_info_log_id
	 * @return
	 */
	DataInfoLog getDataInfoLog(Long data_info_log_id);
	
	/**
	 * Data Info 변경 이력을 저장
	 * @param dataInfoLog
	 * @return
	 */
	int insertDataInfoLog(DataInfoLog dataInfoLog);
}
