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
	
}
