package com.gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gaia3d.domain.PGStatActivity;
import com.gaia3d.persistence.MonitoringMapper;
import com.gaia3d.service.MonitoringService;

/**
 * OTP 생성, 검증
 * @author jeongdae
 *
 */
@Service
public class MonitoringServiceImpl implements MonitoringService {
	
	@Autowired
	private MonitoringMapper monitoringMapper;
	
	/**
	 * DB 세션 목록
	 * @return
	 */
	public List<PGStatActivity> getListDBSession() {
		List<PGStatActivity> dbSessionList =  monitoringMapper.getListDBSession();
		if(dbSessionList == null) dbSessionList = new ArrayList<>();
		return dbSessionList;
	}
}
