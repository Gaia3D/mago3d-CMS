package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.config.CacheConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.IssueService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 메인
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/main/")
public class MainController {
	
	@Autowired
	private IssueService issueService;
	
	/**
	 * 사용자 메인 페이지에서 Issue 조회
	 * @param model
	 * @return
	 *
	 */	
	@RequestMapping(value = "index.do")
	public String listMonitoringLog(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		Issue issue = new Issue();
		issue.setUser_id(userSession.getUser_id());
		log.info("@@ issue = {}", issue);
				
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY);
		if(StringUtil.isEmpty(issue.getStart_date())) {
			issue.setStart_date(today.substring(0,4) + DateUtil.START_DAY_TIME);
		} else {
			issue.setStart_date(issue.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isEmpty(issue.getEnd_date())) {
			issue.setEnd_date(today + DateUtil.END_TIME);
		} else {
			issue.setEnd_date(issue.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
							
		long totalCount = issueService.getIssueTotalCountByUserId(issue);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(issue), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		issue.setOffset(pagination.getOffset());
		issue.setLimit(pagination.getPageRows());
			
		List<Issue> issueList = new ArrayList<Issue>();
		if(totalCount > 0l) {
			issueList = issueService.getListIssueByUserId(issue);
		}
		
		//Policy policy = CacheManager.getPolicy();
		
		model.addAttribute(pagination);
		model.addAttribute("issueList", issueList);
		return "/main/index";
	}
	
	private String getSearchParameters(Issue issue) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(issue.getSearch_word()));
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
		return builder.toString();
	}
}
