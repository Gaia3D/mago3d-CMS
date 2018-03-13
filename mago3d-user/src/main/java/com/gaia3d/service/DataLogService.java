package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.DataInfoLog;

/**
 * Data 변경 요청 관리
 * @author jeongdae
 *
 */
public interface DataLogService {
	
	/**
	 * 데이터 변경 요청 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataInfoLogTotalCount(DataInfoLog dataInfoLog);
	
	/**
	 * 데이터 변경 요청 로그
	 * @param dataInfoLog
	 * @return
	 */
	List<DataInfoLog> getListDataInfoLog(DataInfoLog dataInfoLog);
	
	/**
	 * data info log 조회
	 * @param dataInfoLogId
	 * @return
	 */
	DataInfoLog getDataInfoLog(Long dataInfoLogId);
}
