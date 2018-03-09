package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoLog;
import com.gaia3d.domain.Policy;
import com.gaia3d.persistence.DataLogMapper;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.service.DataLogService;
import com.gaia3d.service.DataService;

/**
 * Data 변경 요청 로그
 * @author jeongdae
 *
 */
@Service
public class DataLogServiceImpl implements DataLogService {

	@Autowired
	private DataLogMapper dataLogMapper;
	
	/**
	 * Data 변경 요청 수
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataInfoLogTotalCountByUserId(DataInfoLog dataInfoLog) {
		return dataLogMapper.getDataInfoLogTotalCountByUserId(dataInfoLog);
	}
	
	/**
	 * 데이터 변경 요청 로그
	 * @param dataInfoLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfoLog> getListDataInfoLogByUserId(DataInfoLog dataInfoLog) {
		return dataLogMapper.getListDataInfoLogByUserId(dataInfoLog);
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
}
