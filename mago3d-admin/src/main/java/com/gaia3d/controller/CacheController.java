package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheParams;
import com.gaia3d.domain.CacheType;

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
	
	/**
	 * 캐시 갱신 요청
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-reload-config-cache.do")
	@ResponseBody
	public Map<String, Object> ajaxReloadConfigCache(HttpServletRequest request, String cacheName, String cacheType) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			if(cacheName == null || "".equals(cacheName) || cacheType == null || "".equals(cacheType)) {
				result = "cache.input.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			CacheParams cacheParams = new CacheParams();
			cacheParams.setCacheName(CacheName.valueOf(cacheName));
			cacheParams.setCacheType(CacheType.valueOf(cacheType));
			cacheConfig.loadCache(cacheParams);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		return jSONObject;
	}
}
