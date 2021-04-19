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
}
