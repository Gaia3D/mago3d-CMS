package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.ConverterJob;
import com.gaia3d.domain.DataSharingType;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UploadData;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ConverterService;
import com.gaia3d.service.DataLogService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.IssueService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UploadDataService;
import com.gaia3d.service.UserService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FormatUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * main
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/main/")
public class MainController {
	
	@Autowired
	private ConverterService converterService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private DataService dataService;
	@Autowired
	private DataLogService dataLogService;
	@Autowired
	private UserService userService;
	
	@Autowired
	private UploadDataService uploadDataService;
	
	@Autowired
	private IssueService issueService;
	
	/**
	 * 사용자 메인 페이지에서 Issue 조회
	 * @param model
	 * @return
	 *
	 */	
	@RequestMapping(value = "index.do")
	public String index(HttpServletRequest request, Model model) {
		Policy policy = CacheManager.getPolicy();
		
		String today = DateUtil.getToday(FormatUtil.VIEW_YEAR_MONTH_DAY_TIME);
		String yearMonthDay = today.substring(0, 4) + today.substring(5,7) + today.substring(8,10);
		
		Project project = new Project();
		project.setSharing_type(DataSharingType.PUBLIC.getValue());
		Long publicProjectCount = projectService.getProjectTotalCount(project);
		project.setSharing_type(DataSharingType.PRIVATE.getValue());
		Long privateProjectCount = projectService.getProjectTotalCount(project);
		project.setSharing_type(DataSharingType.SHARING.getValue());
		Long sharingProjectCount = projectService.getProjectTotalCount(project);
		
		model.addAttribute("today", today);
		model.addAttribute("yearMonthDay", today.subSequence(0, 10));
		model.addAttribute("thisYear", yearMonthDay.subSequence(0, 4));
		// 메인 페이지 갱신 속도
		model.addAttribute("widgetInterval", policy.getContent_main_widget_interval());
		
		model.addAttribute("publicProjectCount", publicProjectCount);
		model.addAttribute("privateProjectCount", privateProjectCount);
		model.addAttribute("sharingProjectCount", sharingProjectCount);
		
		return "/main/index";
	}
}
