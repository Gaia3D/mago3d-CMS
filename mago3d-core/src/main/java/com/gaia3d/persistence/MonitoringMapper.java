package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.PGStatActivity;

/**
 * 모니터링 이력
 * @author jeongdae
 *
 */
@Repository
public interface MonitoringMapper {
	
	/**
	 * DB 세션 목록
	 * @return
	 */
	List<PGStatActivity> getListDBSession();
}
