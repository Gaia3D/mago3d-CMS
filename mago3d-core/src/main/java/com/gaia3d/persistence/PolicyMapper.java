package com.gaia3d.persistence;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Policy;

/**
 * 운영 정책
 * @author jeongdae
 *
 */
@Repository
public interface PolicyMapper {

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
	 * 공간 정보 기본 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyGeo(Policy policy);
	
	/**
	 * Geo Server 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyGeoServer(Policy policy);
	
	/**
	 * CallBack Function 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyGeoCallBack(Policy policy);
	
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
	 * 서버 시간 변경
	 * @param Policy
	 * @return
	 */
	int updatePolicyOs(Policy Policy);
	
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
