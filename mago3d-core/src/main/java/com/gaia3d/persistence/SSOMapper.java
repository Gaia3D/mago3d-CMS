package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.SSOLog;


/**
 * Single Sign-On
 * @author jeongdae
 *
 */
@Repository
public interface SSOMapper {
	
	/**
	 * Single Sign-On 이력 총 건수
	 * @param sSOLog
	 * @return
	 */
	Long getSSOLogTotalCount(SSOLog sSOLog);
	
	/**
	 * Single Sign-On 이력 목록
	 * @param sSOLog
	 * @return
	 */
	List<SSOLog> getListSSOLog(SSOLog sSOLog);
	
	/**
	 * Single Sign-On 이력 정보 취득
	 * @param sso_log_id
	 * @return
	 */
	SSOLog getSSOLog(Long sso_log_id);
	
	/**
	 * Single Sign-On Token 생성
	 * @param sSOLog
	 * @return
	 */
	public String getCreateSSOToken(SSOLog sSOLog);
	
	/**
	 * 최근 생성한 Single Sign-On 토큰 정보
	 * @param sSOLog
	 * @return
	 */
	SSOLog getSSOToken(SSOLog sSOLog);
	
	/**
	 * Single Sign-On 토큰 생성 등록
	 * @param sSOLog
	 * @return
	 */
	int insertSSOLog(SSOLog sSOLog);
	
	/**
     * Single Sign-On TOKEN 검증 후 상태 수정
     * @param sSOLog
     * @return
     */
    int updateSSOLog(SSOLog sSOLog);
}
