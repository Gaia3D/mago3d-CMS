package com.gaia3d.persistence;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.UserDevice;

@Repository
public interface UserDeviceMapper {
	
	/**
	 * 사용자 디바이스 정보 취득
	 * @param user_id
	 * @return
	 */
	UserDevice getUserDeviceByUserId(String user_id);
	
	/**
	 * 사용자 디바이스 정보 취득
	 * @param userDevice
	 * @return
	 */
	UserDevice getUserDeviceByUserIp(UserDevice userDevice);
	
	/**
	 * 사용자 디바이스 등록
	 * @param userDevice
	 * @return
	 */
	int insertUserDevice(UserDevice userDevice);
	
	/**
	 * 사용자 디바이스 수정
	 * @param userDevice
	 * @return
	 */
	int updateUserDevice(UserDevice userDevice);
	
	/**
	 * 사용자 디바이스 삭제
	 * @param user_id
	 * @return
	 */
	int deleteUserDeviceByUserId(String user_id);
}
