package com.gaia3d.service;

import com.gaia3d.domain.Policy;

/**
 * 위젯
 * @author jeongdae
 *
 */
public interface PolicyService {
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	Policy getPolicy();
	
	/**
	 * 운영 정책 사용자 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyUser(Policy policy);
	
	/**
	 * 운영 정책 패스워드 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyPassword(Policy policy);
	
	/**
	 * 운영 정책 알림 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyNotice(Policy policy);
	
	/**
	 * 운영 정책 보안 수정
	 * @param policy
	 * @return
	 */
	int updatePolicySecurity(Policy policy);
	
	/**
	 * 운영 정책 기타 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyContent(Policy policy);
	
	/**
	 * 사이트 정보 수정
	 * @param policy
	 * @return
	 */
	int updatePolicySite(Policy policy);
	
	/**
	 * 서버 시간 설정
	 * @param policy
	 * @return
	 */
	int updatePolicyOs(Policy policy);
	
	/**
	 * BackOffice 설정
	 * @param policy
	 * @return
	 */
	int updatePolicyBackoffice(Policy policy);
	
	/**
	 * 제품정보 설정
	 * @param policy
	 * @return
	 */
	int updatePolicySolution(Policy policy);
}
