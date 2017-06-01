package com.gaia3d.service;

import com.gaia3d.domain.UserDevice;

/**
 * @author Cheon JeongDae
 *
 */
public interface UserDeviceService {
	
	/**
	 * 사용자 디바이스 정보 취득
	 * @param user_id
	 * @return
	 */
	public UserDevice getUserDeviceByUserId(String user_id);
	
	/**
	 * 사용자 디바이스 정보 취득
	 * @param userDevice
	 * @return
	 */
	public UserDevice getUserDeviceByUserIp(UserDevice userDevice);
	
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
