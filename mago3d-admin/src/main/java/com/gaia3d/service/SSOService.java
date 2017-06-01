package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.SSOLog;

/**
 * Single Sign-On
 * @author jeongdae
 *
 */
public interface SSOService {
	
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
	public SSOLog getCreateSSOToken(SSOLog sSOLog);
	
	/**
	 * Single Sign-On Token 검증
	 * @param sSOLog
	 * @return
	 */
	public SSOLog getVerifySSOToken(SSOLog sSOLog);
	
	/**
     * Single Sign-On TOKEN 검증 후 상태 수정
     * @param sSOLog
     * @return
     */
    int updateSSOLog(SSOLog sSOLog);
}
