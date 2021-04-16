package gaia3d.service;

import gaia3d.domain.policy.Policy;

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
	 * 업로딩 가능 확장자 조회
	 * @return 업로딩 가능 확장자
	 */
	String getUserUploadType();
	
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
	 * 사용자 파일 업로딩 정책 수정
	 * @param policy
	 * @return
	 */
	int updatePolicyUserUpload(Policy policy);
}
