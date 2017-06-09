package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.UserDevice;
import com.gaia3d.service.UserDeviceService;
import com.google.gson.Gson;

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
	@RequestMapping(value = "ajax-insert-user-device.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxInsertUserDevice(HttpServletRequest request, UserDevice userDevice) {
		
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			userDevice.setMethod_mode("insert");
			String errorcode = userDevice.validate();
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				log.info("validate error 발생: {} " ,jSONObject.toString());
				return jSONObject.toString();
			}			
			userDeviceService.insertUserDevice(userDevice);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 사용자 디바이스 수정
	 * @param request
	 * @param userDevice
	 * @return
	 */
	@RequestMapping(value = "ajax-update-user-device.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxUpdateUserDevice(HttpServletRequest request, UserDevice userDevice) {
		
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
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
				jSONObject.put("result", result);
				return jSONObject.toString();
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
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
}
