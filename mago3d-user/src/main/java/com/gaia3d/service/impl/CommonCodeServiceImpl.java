package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.CommonCode;
import com.gaia3d.persistence.CommonCodeMapper;
import com.gaia3d.service.CommonCodeService;

/**
 * 공통 코드
 * 
 * @author jeongdae
 *
 */
@Service
public class CommonCodeServiceImpl implements CommonCodeService {

	@Autowired
	private CommonCodeMapper commonCodeMapper;

	/**
	 * 공통 코드 목록
	 * 
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<CommonCode> getListCommonCode() {
		return commonCodeMapper.getListCommonCode();
	}

	/**
	 * 공통 코드 정보
	 * 
	 * @param commonCode
	 * @return
	 */
	@Transactional(readOnly = true)
	public CommonCode getCommonCode(CommonCode commonCode) {
		return commonCodeMapper.getCommonCode(commonCode);
	}

	/**
	 * 공통 코드 등록
	 * 
	 * @param commonCode
	 * @return
	 */
	@Transactional
	public int insertCommonCode(CommonCode commonCode) {
		return commonCodeMapper.insertCommonCode(commonCode);
	}

	/**
	 * 공통 코드 수정
	 * 
	 * @param commonCode
	 * @return
	 */
	@Transactional
	public int updateCommonCode(CommonCode commonCode) {
		return commonCodeMapper.updateCommonCode(commonCode);
	}

	/**
	 * 공통 코드 삭제
	 * 
	 * @param commonCode
	 * @return
	 */
	@Transactional
	public int deleteCommonCode(CommonCode commonCode) {
		return commonCodeMapper.deleteCommonCode(commonCode);
	}
}
