package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.config.CacheConfig;
import gaia3d.domain.cache.CacheName;
import gaia3d.domain.cache.CacheParams;
import lombok.extern.slf4j.Slf4j;

/**
 * 사용자 Cache 갱신
 * 분류 상으로는 api 에 가야 하지만 보안상 여기에 둠
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/cache")
public class CacheRestController {

	@Autowired
	private CacheConfig cacheConfig;
	
	/**
	 * HttpClient 로 Cache 요청이 왔을때 실행되는 메서드
	 * @param request
	 * @param authData
	 * @return
	 */
	@PostMapping(value = "/reload")
	public Map<String, Object> reload(HttpServletRequest request, @RequestBody String authData) {
		log.info("@@@@@@@@@@@@@@@ user cache reload @@@@@@@@@@@@@@@@");

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		HttpHeaders responseHeaders = new HttpHeaders(); 
		responseHeaders.add("Content-Type", "application/json;charset=UTF-8");
			
		log.info("@@@@@@@@@ auth_data = {}", authData);
		String[] keyValues = authData.split("&");
		
		CacheParams cacheParams = new CacheParams();
		// TODO validation
		for(String tempValue : keyValues) {
			String[] values = tempValue.split("=");
			cacheParams.setCacheName(CacheName.valueOf(values[1]));
		}
		
		cacheConfig.loadCache(cacheParams);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
