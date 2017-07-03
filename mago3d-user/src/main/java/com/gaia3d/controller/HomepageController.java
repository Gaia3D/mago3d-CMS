package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.DataGroup;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.SessionKey;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.IssueService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/homepage/")
public class HomepageController {
	
	@Autowired
	private IssueService issueService;

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
		log.info("@@ lang = {}", lang);
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
	public String demo(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		String lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
		if(lang == null || "".equals(lang)) {
			lang = "ko";
		}
		
		Issue issue = new Issue();
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		if(userSession == null) {
			issue.setUser_id("guest");
			issue.setUser_name("guest");
		} else {
			issue.setUser_id(userSession.getUser_id());
			issue.setUser_name(userSession.getUser_name());
		}
		
		log.info("@@ issue = {}", issue);
		if(StringUtil.isNotEmpty(issue.getStart_date())) {
			issue.setStart_date(issue.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(issue.getEnd_date())) {
			issue.setEnd_date(issue.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = issueService.getIssueTotalCountByUserId(issue);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(issue), totalCount, Long.valueOf(pageNo).longValue(), 5l);
		log.info("@@ pagination = {}", pagination);
		
		issue.setOffset(pagination.getOffset());
		issue.setLimit(pagination.getPageRows());
		List<Issue> issueList = new ArrayList<Issue>();
		if(totalCount > 0l) {
			issueList = issueService.getListIssueByUserId(issue);
		}
		
		Gson gson = new Gson();
		List<DataGroup> projectDataGroupList = CacheManager.getProjectDataGroupList();
		Map<String, Map<String, DataInfo>> dataGroupMap = CacheManager.getDataGroupMap();
		Policy policy = CacheManager.getPolicy();
		@SuppressWarnings("unchecked")
		List<CommonCode> issuePriorityList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_PRIORITY);
		@SuppressWarnings("unchecked")
		List<CommonCode> issueTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_TYPE);
		
		model.addAttribute("issue", issue);
		model.addAttribute(pagination);
		model.addAttribute("issueList", issueList);
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
	@GetMapping(value = "ajax-list-issue.do", produces="application/json; charset=utf8")
	@ResponseBody
	public String ajaxListIssue(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo) {
		
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			Issue issue = new Issue();
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			if(userSession == null) {
				issue.setUser_id("guest");
				issue.setUser_name("guest");
			} else {
				issue.setUser_id(userSession.getUser_id());
				issue.setUser_name(userSession.getUser_name());
			}
			
			log.info("@@ issue = {}", issue);
			if(StringUtil.isNotEmpty(issue.getStart_date())) {
				issue.setStart_date(issue.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isNotEmpty(issue.getEnd_date())) {
				issue.setEnd_date(issue.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
			long totalCount = issueService.getIssueTotalCountByUserId(issue);
			
			Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(issue), totalCount, Long.valueOf(pageNo).longValue(), 5l);
			log.info("@@ pagination = {}", pagination);
			
			issue.setOffset(pagination.getOffset());
			issue.setLimit(pagination.getPageRows());
			List<Issue> issueList = new ArrayList<Issue>();
			if(totalCount > 0l) {
				issueList = issueService.getListIssueByUserId(issue);
			}
			
			jSONObject.put("issueList", issueList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		return gson.toJson(jSONObject);
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
	
	/**
	 * 언어 설정
	 * @param model
	 * @return
	 */
	@GetMapping(value = "ajax-change-language.do")
	@ResponseBody
	public String ajaxChangeLanguage(HttpServletRequest request, @RequestParam("lang") String lang, Model model) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			log.info("@@ lang = {}", lang);
			if(lang != null && !"".equals(lang) && ("ko".equals(lang) || "en".equals(lang))) {
				request.getSession().setAttribute(SessionKey.LANG.name(), lang);
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 검색 조건
	 * @param issue
	 * @return
	 */
	private String getSearchParameters(Issue issue) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(issue.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(issue.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(issue.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(issue.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(issue.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(issue.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(issue.getOrder_value()));
		return builder.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param issue
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuilder builder = new StringBuilder(100);
		String pageNo = request.getParameter("pageNo");
		builder.append("pageNo=" + pageNo);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		return builder.toString();
	}
}
