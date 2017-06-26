package com.gaia3d.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.DataGroup;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.SessionKey;
import com.google.gson.Gson;

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
	@GetMapping(value = "about.do")
	public String about(HttpServletRequest request, Model model) {
		String lang = null;
		lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		return "/homepage/" + lang + "/about";
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
		@SuppressWarnings("unchecked")
		List<CommonCode> issuePriorityList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_PRIORITY);
		@SuppressWarnings("unchecked")
		List<CommonCode> issueTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_TYPE);
		
		model.addAttribute("issue", new Issue());
		model.addAttribute("projectDataGroupList", projectDataGroupList);
		model.addAttribute("dataGroupMap", gson.toJson(dataGroupMap));
		model.addAttribute("policyJson", gson.toJson(policy));
		model.addAttribute("issuePriorityList", issuePriorityList);
		model.addAttribute("issueTypeList", issueTypeList);
		
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
	@GetMapping(value = "tutorials.do")
	public String tutorials(HttpServletRequest request, Model model) {
		String lang = null;
		lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		return "/homepage/" + lang + "/tutorials";
	}
}
