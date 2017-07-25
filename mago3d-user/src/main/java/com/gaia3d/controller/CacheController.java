package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.Result;

import lombok.extern.slf4j.Slf4j;

/**
 * 메뉴
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/cache/")
public class CacheController {

	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	/**
	 * HttpClient 로 Cache 요청이 왔을때 실행되는 메서드
	 * @param request
	 * @param policy
	 * @return
	 */
	@RequestMapping(value = "call-cache.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> callCache(HttpServletRequest request) {
		
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		
		String result = Result.FAIL.toString();
		String result_message = "";
		HttpStatus httpStatus = null;
		try {
			
			String authData = request.getParameter("auth_data");
//			authData = Crypt.decrypt(authData);
			log.info("@@@@@@@@@ auth_data = {}", authData);
			String[] values = authData.split("&");
			String[] keyInfo = values[0].split("=");
			String[] cacheName = values[1].split("=");
			log.info("@@@@@@@@@ REST_AUTH_KEY = {}, cache_name = {}", keyInfo[1], cacheName[1]);
//			if(!propertiesConfig.getRestAuthKey().equals(Crypt.encrypt(keyInfo[1]))) {
//				httpStatus = HttpStatus.BAD_REQUEST;
//				jSONObject.put("success_yn", success_yn);
//				jSONObject.put("result_message", "REST API KEY가 유효하지 않습니다.");
//				return new ResponseEntity<String>(gson.toJson(jSONObject), httpStatus);
//			}
			
			cacheConfig.loadCache( CacheName.valueOf(cacheName[1]), CacheType.SELF);
			
			result = Result.SUCCESS.toString();
			httpStatus = HttpStatus.OK;
			
		} catch(Exception e) {
			e.printStackTrace();
			result_message = "db.exception";
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		
		jSONObject.put("result", result);
		jSONObject.put("result_message", result_message);
		
		return new ResponseEntity<Map<String, Object>>(jSONObject, httpStatus);
	}
}
