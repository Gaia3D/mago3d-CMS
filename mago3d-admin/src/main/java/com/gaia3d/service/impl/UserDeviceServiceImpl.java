package com.gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.UserDevice;
import com.gaia3d.persistence.UserDeviceMapper;
import com.gaia3d.service.UserDeviceService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class UserDeviceServiceImpl implements UserDeviceService {
	
	@Autowired
	private UserDeviceMapper userDeviceMapper;

	/**
	 * 사용자 디바이스 정보 취득
	 * @param user_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserDevice getUserDeviceByUserId(String user_id) {
		UserDevice userDevice = userDeviceMapper.getUserDeviceByUserId(user_id);
		if(userDevice == null) {
			log.info("@@@@@@@@@@@ userDevice is Null");
			userDevice = new UserDevice();
		}
		return userDevice;
	}
	
	/**
	 * 사용자 디바이스 정보 취득
	 * @param userDevice
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserDevice getUserDeviceByUserIp(UserDevice userDevice) {
		return userDeviceMapper.getUserDeviceByUserIp(userDevice);
	}

	/**
	 * 사용자 디바이스 등록
	 * @param userDevice
	 * @return
	 */
    @Transactional
	public int insertUserDevice(UserDevice userDevice) {
		return userDeviceMapper.insertUserDevice(userDevice);
	}

	/**
	 * 사용자 디바이스 수정
	 * @param userDevice
	 * @return
	 */
    @Transactional
   	public int updateUserDevice(UserDevice userDevice) {
    	return userDeviceMapper.updateUserDevice(userDevice);
   	}

	/**
	 * 사용자 디바이스 삭제
	 * @param user_id
	 * @return
	 */
    @Transactional
   	public int deleteUserDeviceByUserId(String user_id) {
    	return userDeviceMapper.deleteUserDeviceByUserId(user_id);
    }
}
