package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.config.CacheConfig;
import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.Result;
import com.gaia3d.security.Crypt;

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
	 * @throws JsonProcessingException 
	 */
	@RequestMapping(value = "call-cache.do")
	@ResponseBody
	public ResponseEntity<String> callCache(HttpServletRequest request) throws JsonProcessingException {
		
		log.info("@@@@@@@@@@@@@@@ mago3d-user callCache Start @@@@@@@@@@@@@@@@");
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = Result.FAIL.toString();
		String result_message = "";
		HttpStatus httpStatus = null;
		HttpHeaders responseHeaders = new HttpHeaders(); 
		responseHeaders.add("Content-Type", "application/json;charset=UTF-8");
		try {
			
			String authData = request.getParameter("auth_data");
			log.info("@@@@@@@@@ auth_data = {}", authData);
			authData = Crypt.decrypt(authData);
			log.info("@@@@@@@@@ auth_data = {}", authData);
			String[] keyValues = authData.split("&");
			
			CacheParams cacheParams = new CacheParams();
			for(String tempValue : keyValues) {
				String[] values = tempValue.split("=");
				if(values[0].equals("api-key")) {
					if(!propertiesConfig.getRestAuthKey().equals(Crypt.encrypt(values[1]))) {
						httpStatus = HttpStatus.UNAUTHORIZED;
						jSONObject.put("result", result);
						jSONObject.put("result_message", "REST API KEY가 유효하지 않습니다.");
						log.info(" *************** RestAuthKey Differerent. key = {}", Crypt.encrypt(values[1]));
						
						return new ResponseEntity<String>(mapper.writeValueAsString(jSONObject), responseHeaders, httpStatus);
					}
				} else if(values[0].equals("cache_name")) {
					cacheParams.setCacheName(CacheName.valueOf(values[1]));
				} else if(values[0].equals("project_id")) {
					if(values[1] != null && !"".equals(values[1])) cacheParams.setProject_id(Long.valueOf(values[1]));
				}
			}
			
			cacheConfig.loadCache(cacheParams);
			
			result = Result.SUCCESS.toString();
			httpStatus = HttpStatus.OK;
			
		} catch(Exception e) {
			e.printStackTrace();
			result_message = "db.exception";
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		
		jSONObject.put("result", result);
		jSONObject.put("result_message", result_message);
		
		log.info("@@@@@@@@@@@@@@@ mago3d-user callCache end @@@@@@@@@@@@@@@@");
		
		return new ResponseEntity<String>(mapper.writeValueAsString(jSONObject), responseHeaders, httpStatus);
	}
}
