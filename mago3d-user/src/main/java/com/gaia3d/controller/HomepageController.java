package com.gaia3d.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataGroup;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.SessionKey;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/homepage/")
public class HomepageController {

	/**
	 * 메인
	 * @param model
	 * @return
	 */
	@GetMapping(value = "index.do")
	public String index(HttpServletRequest request, Model model) {
		String lang = null;
		lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		return "/homepage/" + lang + "/index";
	}
	
	/**
	 * 메인
	 * @param model
	 * @return
	 */
	@GetMapping(value = "mago3d.do")
	public String about(HttpServletRequest request, Model model) {
		String lang = null;
		lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		return "/homepage/" + lang + "/mago3d";
	}
	
	/**
	 * 메인
	 * @param model
	 * @return
	 */
	@GetMapping(value = "demo.do")
	public String demo(HttpServletRequest request, Model model) {
		
		String lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		
		Gson gson = new Gson();
		List<DataGroup> projectDataGroupList = CacheManager.getProjectDataGroupList();
		Map<String, Map<String, DataInfo>> dataGroupMap = CacheManager.getDataGroupMap();
		Policy policy = CacheManager.getPolicy();
		
		model.addAttribute("projectDataGroupList", projectDataGroupList);
		model.addAttribute("dataGroupMap", gson.toJson(dataGroupMap));
		model.addAttribute("policyJson", gson.toJson(policy));
		
		log.info("@@@@@@ policy = {}", gson.toJson(policy));
		log.info("@@@@@@ dataGroupMap = {}", gson.toJson(dataGroupMap));
		
		return "/homepage/" + lang + "/demo";
	}
	
	/**
	 * 메인
	 * @param model
	 * @return
	 */
	@GetMapping(value = "download.do")
	public String download(HttpServletRequest request, Model model) {
		String lang = null;
		lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		return "/homepage/" + lang + "/download";
	}
	
	/**
	 * 메인
	 * @param model
	 * @return
	 */
	@GetMapping(value = "tutorial.do")
	public String tutorials(HttpServletRequest request, Model model) {
		String lang = null;
		lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		return "/homepage/" + lang + "/tutorial";
	}
}
