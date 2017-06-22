package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.CommonCode;

/**
 * 공콩 코드
 * 
 * @author jeongdae
 *
 */
public interface CommonCodeService {

	/**
	 * 공통 코드 목록
	 * 
	 * @return
	 */
	List<CommonCode> getListCommonCode();

	/**
	 * 공통 코드 정보
	 * 
	 * @param commonCode
	 * @return
	 */
	CommonCode getCommonCode(CommonCode commonCode);

	/**
	 * 공통 코드 등록
	 * 
	 * @param commonCode
	 * @return
	 */
	int insertCommonCode(CommonCode commonCode);

	/**
	 * 공통 코드 수정
	 * 
	 * @param commonCode
	 * @return
	 */
	int updateCommonCode(CommonCode commonCode);

	/**
	 * 공통 코드 삭제
	 * 
	 * @param commonCode
	 * @return
	 */
	int deleteCommonCode(CommonCode commonCode);
}
