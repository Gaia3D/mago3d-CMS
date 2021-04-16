package gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.policy.Policy;
import gaia3d.persistence.PolicyMapper;
import gaia3d.service.PolicyService;

/**
 * mago3d 운영 정책
 * @author jeongdae
 *
 */
@Service
public class PolicyServiceImpl implements PolicyService {

	@Autowired
	private PolicyMapper policyMapper;
	
	/**
	 * 운영 정책 정보
	 * @return
	 */
	@Transactional(readOnly=true)
	public Policy getPolicy() {
		return policyMapper.getPolicy();
	}
	
	/**
	 * 업로딩 가능 확장자 조회
	 * @return 업로딩 가능 확장자
	 */
	@Transactional(readOnly=true)
	public String getUserUploadType() {
		String userUploadType = policyMapper.getUserUploadType();
		String[] userUploadTypes = userUploadType.split(",");
		List<String> acceptedFiles = new ArrayList<>();
		for (String uploadType : userUploadTypes) {
			uploadType = "." + uploadType;
			acceptedFiles.add(uploadType);
		}
		return String.join(",", acceptedFiles);
	}
	
	/**
	 * 운영 정책 사용자 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyUser(Policy policy) {
		return policyMapper.updatePolicyUser(policy);
	}
	
	/**
	 * 운영 정책 패스워드 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyPassword(Policy policy) {
		return policyMapper.updatePolicyPassword(policy);
	}
	
	/**
	 * 운영 정책 알림 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyNotice(Policy policy) {
		return policyMapper.updatePolicyNotice(policy);
	}
	
	/**
	 * 운영 정책 보안 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicySecurity(Policy policy) {
		return policyMapper.updatePolicySecurity(policy);
	}
	
	/**
	 * 운영 정책 기타 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyContent(Policy policy) {
		return policyMapper.updatePolicyContent(policy);
	}
	
	/**
	 * 사용자 파일 업로딩 정책 수정
	 * @param policy
	 * @return
	 */
	@Transactional
	public int updatePolicyUserUpload(Policy policy) {
		return policyMapper.updatePolicyUserUpload(policy);
	}

}
