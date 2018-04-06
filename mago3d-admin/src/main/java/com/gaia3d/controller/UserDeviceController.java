package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.UserDevice;
import com.gaia3d.service.UserDeviceService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user/")
public class UserDeviceController {
	
	@Autowired
	private UserDeviceService userDeviceService;
	
	/**
	 * 사용자 디바이스 등록
	 * @param request
	 * @param userDevice
	 * @return
	 */
	@PostMapping(value = "ajax-insert-user-device.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertUserDevice(HttpServletRequest request, UserDevice userDevice) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			userDevice.setMethod_mode("insert");
			String errorcode = userDevice.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {} " ,map.toString());
				return map;
			}			
			userDeviceService.insertUserDevice(userDevice);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 사용자 디바이스 수정
	 * @param request
	 * @param userDevice
	 * @return
	 */
	@PostMapping(value = "ajax-update-user-device.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateUserDevice(HttpServletRequest request, UserDevice userDevice) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ userDevice = {}", userDevice);
			
			UserDevice dbUserDevice = userDeviceService.getUserDeviceByUserId(userDevice.getUser_id());
			log.info("@@ dbUserDevice = {}", dbUserDevice);
			userDevice.setMethod_mode("update");
			
			String errorcode = userDevice.validate();
			log.info("@@@@@@@@@@@@ errorcode = {}", errorcode);
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				return map;
			}			
			if(dbUserDevice.getUser_device_id() == null || dbUserDevice.getUser_device_id().longValue() <= 0l) {
				userDeviceService.insertUserDevice(userDevice);
	    	} else {
	    		userDeviceService.updateUserDevice(userDevice);
	    	}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
}
