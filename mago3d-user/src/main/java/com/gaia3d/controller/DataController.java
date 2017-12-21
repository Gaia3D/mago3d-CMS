package com.gaia3d.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;

import lombok.extern.slf4j.Slf4j;

/**
 * Data
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class DataController {
	
	/**
	 * 프로젝트에 등록된 Data 목록
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "ajax-project-data-by-project-id.do")
	@ResponseBody
	public Map<String, Object> ajaxProjectDataByProjectId(HttpServletRequest request, @RequestParam("project_id") Long project_id) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {		
			String projectDataJson =  CacheManager.getProjectDataJson(project_id);
			jSONObject.put("projectDataJson", projectDataJson);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		return jSONObject;
	}
}