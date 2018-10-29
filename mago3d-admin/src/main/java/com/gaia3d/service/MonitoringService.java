package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.PGStatActivity;
/**
 * postgresql 현황
 * @author jeongdae
 *
 */
public interface MonitoringService {
	
	/**
	 * DB 세션 목록
	 * @return
	 */
	public List<PGStatActivity> getListDBSession();
}
