package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.SSOLog;
import com.gaia3d.persistence.SSOMapper;
import com.gaia3d.security.SSO;
import com.gaia3d.service.SSOService;

/**
 * Single Sign-On 토큰 생성, 검증
 * @author jeongdae
 *
 */
@Service
public class SSOServiceImpl implements SSOService {
	
	@Autowired
	private SSOMapper sSOMapper;
	
	/**
	 * Single Sign-On 이력 총 건수
	 * @param sSOLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getSSOLogTotalCount(SSOLog sSOLog) {
		return sSOMapper.getSSOLogTotalCount(sSOLog);
	}
	
	/**
	 * Single Sign-On 이력 목록
	 * @param sSOLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<SSOLog> getListSSOLog(SSOLog sSOLog) {
		return sSOMapper.getListSSOLog(sSOLog);
	}
	
	/**
	 * Single Sign-On 이력 정보 취득
	 * @param sso_log_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public SSOLog getSSOLog(Long sso_log_id) {
		return sSOMapper.getSSOLog(sso_log_id);
	}
	
	/**
	 * Single Sign-On Token 생성
	 * @param sSOLog
	 * @return
	 */
	@Transactional
	public SSOLog getCreateSSOToken(SSOLog sSOLog) {
		String token = SSO.getUUIDToken();
		sSOLog.setToken(token);
		sSOLog.setToken_status(SSOLog.TOKEN_CREATE);
		sSOMapper.insertSSOLog(sSOLog);
		return sSOLog;
	}
	
	/**
	 * Single Sign-On Token 검증
	 * @param sSOLog
	 * @return
	 */
	@Transactional
	public SSOLog getVerifySSOToken(SSOLog sSOLog) {
//		return sSOMapper.getVerifySSOToken(sSOLog);
		return null;
	}
	
	/**
     * Single Sign-On TOKEN 검증 후 상태 수정
     * @param sSOLog
     * @return
     */
	@Transactional
	public int updateSSOLog(SSOLog sSOLog) {
		return sSOMapper.updateSSOLog(sSOLog);
	}
}
