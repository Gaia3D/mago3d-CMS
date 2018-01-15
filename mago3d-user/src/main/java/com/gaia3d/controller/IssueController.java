package com.gaia3d.controller;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gaia3d.config.PropertiesConfig;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.Issue;
import com.gaia3d.domain.IssueComment;
import com.gaia3d.domain.IssueFile;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.IssueService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.StringUtil;
import com.gaia3d.util.WebUtil;
import com.gaia3d.validator.IssueValidator;

import lombok.extern.slf4j.Slf4j;

/**
 * issue
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/issue/")
public class IssueController {
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	@Resource(name="issueValidator")
	private IssueValidator issueValidator;
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private IssueService issueService;
	
	/**
	 * issue 목록
	 * @param request
	 * @param issue
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-issue.do")
	public String listIssue(HttpServletRequest request, Issue issue, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
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
		long totalCount = issueService.getIssueTotalCount(issue);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(issue), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		issue.setOffset(pagination.getOffset());
		issue.setLimit(pagination.getPageRows());
		List<Issue> issueList = new ArrayList<Issue>();
		if(totalCount > 0l) {
			issueList = issueService.getListIssue(issue);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("issueList", issueList);
		return "/issue/list-issue";
	}
	
	/**
	 * 공간 정보를 이용한 현재 위치 근처의 이슈
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-list-issue-by-geo.do")
	@ResponseBody
	public Map<String, Object> ajaxListIssueByGeo(HttpServletRequest request, Project project) {
		
		log.info("@@ project = {}", project);
		
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			Issue issue = new Issue();
//			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//			if(userSession == null) {
//				issue.setUser_id("guest");
//				issue.setUser_name("guest");
//			} else {
//				issue.setUser_id(userSession.getUser_id());
//				issue.setUser_name(userSession.getUser_name());
//			}
			project.setLocation("SRID=4326;POINT(" + project.getLongitude() + " " + project.getLatitude() + ")");
			Project nearProject = projectService.getProjectByGeo(project);
			
			if(StringUtil.isNotEmpty(issue.getStart_date())) {
				issue.setStart_date(issue.getStart_date().substring(0, 8) + DateUtil.START_TIME);
			}
			if(StringUtil.isNotEmpty(issue.getEnd_date())) {
				issue.setEnd_date(issue.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
			}
						
			issue.setProject_id(nearProject.getProject_id());
			issue.setOffset(0l);
			issue.setLimit(100l);
			List<Issue> issueList = issueService.getListIssue(issue);
			
			jSONObject.put("issueList", issueList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * TODO 현재는 사용하지 않음
	 * issue 쓰기 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "input-issue.do")
	public String inputIssue(Model model) {
		
		Project project = new Project();
		project.setUse_yn(Project.IN_USE);
		List<Project> projectList = projectService.getListProject(project);
		@SuppressWarnings("unchecked")
		List<CommonCode> issuePriorityList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_PRIORITY);
		@SuppressWarnings("unchecked")
		List<CommonCode> issueTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_TYPE);
		
		Issue issue = new Issue();
		model.addAttribute(issue);
		model.addAttribute("projectList", projectList);
		model.addAttribute("issuePriorityList", issuePriorityList);
		model.addAttribute("issueTypeList", issueTypeList);
		
		return "/issue/input-issue";
	}
	
	/**
	 * TODO 현재는 사용하지 않음
	 * issue 등록
	 * @param issue
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@PostMapping(value = "insert-issue.do")
	public String insertIssue(MultipartHttpServletRequest request, Issue issue, BindingResult bindingResult, Model model) {
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		
		Project project = new Project();
		project.setUse_yn(Project.IN_USE);
		
		MultipartFile multipartFile = request.getFile("file_name");
		IssueFile issueFile = new IssueFile();
		if(multipartFile != null && multipartFile.getSize() != 0l) {
			FileInfo fileInfo = FileUtil.upload(multipartFile, FileUtil.ISSUE_FILE_UPLOAD, propertiesConfig.getExcelDataUploadDir());
			if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
				bindingResult.rejectValue("file_name", fileInfo.getError_code());
				
				List<Project> projectList = projectService.getListProject(project);
				@SuppressWarnings("unchecked")
				List<CommonCode> issuePriorityList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_PRIORITY);
				@SuppressWarnings("unchecked")
				List<CommonCode> issueTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_TYPE);
				
				model.addAttribute(issue);
				model.addAttribute("projectList", projectList);
				model.addAttribute("issuePriorityList", issuePriorityList);
				model.addAttribute("issueTypeList", issueTypeList);
				
				return "/issue/input-issue";
			}
			
			issueFile.setFile_name(fileInfo.getFile_name());
			issueFile.setFile_real_name(fileInfo.getFile_real_name());
			issueFile.setFile_path(fileInfo.getFile_path());
			issueFile.setFile_size(fileInfo.getFile_size());
			issueFile.setFile_ext(fileInfo.getFile_ext());
		}
		
		
		issue.setUser_id(userSession.getUser_id());
		issue.setUser_name(userSession.getUser_name());
		
		issue.setMethod_mode("insert");
		String errorcode = issue.validate();
		if(errorcode != null) {
			log.info("validate error 발생: {} ", errorcode);
			if("title.invalid".equals(errorcode)) {
				bindingResult.rejectValue("title", errorcode);
			} else if("contents.invalid".equals(errorcode)) {
				bindingResult.rejectValue("contents", errorcode);
			}
			
			List<Project> projectList = projectService.getListProject(project);
			@SuppressWarnings("unchecked")
			List<CommonCode> issuePriorityList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_PRIORITY);
			@SuppressWarnings("unchecked")
			List<CommonCode> issueTypeList = (List<CommonCode>)CacheManager.getCommonCode(CommonCode.ISSUE_TYPE);
			
			model.addAttribute(issue);
			model.addAttribute("projectList", projectList);
			model.addAttribute("issuePriorityList", issuePriorityList);
			model.addAttribute("issueTypeList", issueTypeList);
			
			return "/issue/input-issue";
		}
		
		// TODO 날짜를 더해서 넣어야 한다 공백 처리 해서
		String client_ip = WebUtil.getClientIp(request);
		issue.setClient_ip(client_ip);
		issue.setLocation("POINT(" + issue.getLongitude() + " " + issue.getLatitude() + ")");
		log.info("@@@ issue = {}", issue);
		
		issueService.insertIssue(issue, issueFile);
		
		return "redirect:/issue/result-issue.do?issue_id=" + issue.getIssue_id() + "&method_mode=insert";
	}
	
	/**
	 * TODO F5 멱등 때문에 ajax 말고 submit 방식을 사용해야 함
	 * issue 등록
	 * @param issue
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-issue.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertIssue(HttpServletRequest request, Issue issue) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
		
			// TODO 현재 버전에서는 파일 첨부가 없어서 임시로 주석 처리 해 둔거 같음
//			MultipartFile multipartFile = request.getFile("file_name");
			IssueFile issueFile = new IssueFile();
//			if(multipartFile != null && multipartFile.getSize() != 0l) {
//				FileInfo fileInfo = FileUtil.upload(multipartFile, FileUtil.ISSUE_DATA_UPLOAD, propertiesConfig.getExcelDataUploadDir());
//				if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
//					jSONObject.put("result", fileInfo.getError_code());
//					return gson.toJson(jSONObject);
//				}
//				
//				issueFile.setFile_name(fileInfo.getFile_name());
//				issueFile.setFile_real_name(fileInfo.getFile_real_name());
//				issueFile.setFile_path(fileInfo.getFile_path());
//				issueFile.setFile_size(fileInfo.getFile_size());
//				issueFile.setFile_ext(fileInfo.getFile_ext());
//			}
//			
//			Issue issue = new Issue();
//			issue.setProject_id(Long.valueOf((String)request.getParameter("project_id")));
			if(userSession == null) {
				issue.setUser_id("guest");
				issue.setUser_name("guest");
			} else {
				issue.setUser_id(userSession.getUser_id());
				issue.setUser_name(userSession.getUser_name());
			}
			
			issue.setProject_id(Long.valueOf((String)request.getParameter("project_id")));
			issue.setPriority((String)request.getParameter("priority"));
			issue.setIssue_type((String)request.getParameter("issue_type"));
			issue.setData_key((String)request.getParameter("data_key"));
			issue.setLatitude(new BigDecimal((String)request.getParameter("latitude")));
			issue.setLongitude(new BigDecimal((String)request.getParameter("longitude")));
			issue.setTitle((String)request.getParameter("title"));
			issue.setDue_date((String)request.getParameter("due_to"));
			issue.setAssignee((String)request.getParameter("assignee"));
			issue.setReporter((String)request.getParameter("reporter"));
			issue.setContents((String)request.getParameter("contents"));
			
			issue.setMethod_mode("insert");
			String errorcode = issue.validate();
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				log.info("validate error 발생: {} ", jSONObject.toString());
				return jSONObject;
			}
			
			if(issue.getDue_day() != null && !"".equals(issue.getDue_day())
					&& issue.getDue_hour() != null && !"".equals(issue.getDue_hour())) {
				issue.setDue_date(issue.getDue_day().replaceAll("-", "") + issue.getDue_hour());
			}
			String client_ip = WebUtil.getClientIp(request);
			issue.setClient_ip(client_ip);
			issue.setLocation("POINT(" + issue.getLongitude() + " " + issue.getLatitude() + ")");
			log.info("@@@ before issue = {}", issue);
			
			issueService.insertIssue(issue, issueFile);
			
			jSONObject.put("issue", issue);
			log.info("@@@ after issue = {}", issue);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * issue 보기
	 * @param issue_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "detail-issue.do")
	public String detailIssue(@RequestParam("issue_id") String issue_id, HttpServletRequest request, Model model) {
		
		String listParameters = getListParameters(request);
		
		Issue issue =  issueService.getIssue(Long.valueOf(issue_id));		
		List<IssueComment> issueCommentList = issueService.getListIssueComment(issue.getIssue_id());
		
		model.addAttribute("listParameters", listParameters);
		model.addAttribute(issue);
		model.addAttribute(issueCommentList);
		
		return "/issue/detail-issue";
	}
	
	/**
	 * issue 수정 화면
	 * @param issue_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-issue.do")
	public String modifyIssue(HttpServletRequest request, @RequestParam("issue_id") String issue_id, Model model) {
		String listParameters = getListParameters(request);
		
		Issue issue =  issueService.getIssue(Long.valueOf(issue_id));
		List<IssueComment> issueCommentList = issueService.getListIssueComment(issue.getIssue_id());
		
		model.addAttribute("listParameters", listParameters);
		model.addAttribute(issue);
		model.addAttribute(issueCommentList);
		
		return "/issue/modify-issue";
	}
	
	/**
	 * issue 수정
	 * @param issue
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-update-issue.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateIssue(Issue issue) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			log.info("@@ issue = {}", issue);
			issue.setMethod_mode("update");
			
			String errorcode = issue.validate();
			log.info("@@@@@@@@@@@@ errorcode = {}", errorcode);
			if(errorcode != null) {
				result = errorcode;
				jSONObject.put("result", result);
				return jSONObject;
			}			
			issueService.updateIssue(issue);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		
		return jSONObject;
	}
	
	/**
	 * issue 삭제
	 * @param issue_id
	 * @param model
	 * @return
	 */
	@GetMapping(value = "delete-issue.do")
	public String deleteIssue(@RequestParam("issue_id") String issue_id, Model model) {
		
		issueService.deleteIssue(Long.valueOf(issue_id));
		
		return "redirect:/issue/list-issue.do";
	}
	
	/**
	 * issue 등록, 수정, 삭제 처리 결과 페이지
	 * @param request
	 * @param method_mode
	 * @param model
	 * @return
	 */
	@GetMapping(value = "result-issue.do")
	public String resultIssue(HttpServletRequest request, @RequestParam("method_mode") String method_mode, Model model) {
		
		if("insert".equals(method_mode) || "update".equals(method_mode)) {
			String issue_id = request.getParameter("issue_id");
			if(issue_id == null || "".equals(issue_id)) {
				log.error("@@ Invalid issue_id. issue_id = {}", issue_id);
				return "redirect:/issue/list-issue.do";
			}
			Issue issue =  issueService.getIssue(Long.valueOf(issue_id));
			model.addAttribute(issue);
		}
		model.addAttribute("method_mode", method_mode);
		
		return "/issue/result-issue";
	}
	
	/**
	 * issue 댓글(Comment) 등록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-issue-comment.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertIssueComment(HttpServletRequest request, Issue issue) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			
			log.info("@@ issue = {} ", issue);
			if(issue.getIssue_id() == null || issue.getIssue_id().longValue() <= 0l) {
				result = "issuecomment.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			if(issue.getComment() == null || "".equals(issue.getComment())) {
				result = "issuecomment.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			IssueComment issueComment = new IssueComment();
			issueComment.setIssue_id(issue.getIssue_id());
			issueComment.setUser_id(userSession.getUser_id());
			issueComment.setComment(issue.getComment());
			
			String client_ip = WebUtil.getClientIp(request);
			issueComment.setClient_ip(client_ip);			
			issueService.insertIssueComment(issueComment);
			
			List<IssueComment> issueCommentList = issueService.getListIssueComment(issue.getIssue_id());
			jSONObject.put("issueCommentList", issueCommentList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		return jSONObject;
	}
	
	/**
	 * issue 댓글(Comment) 삭제
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-issue-comment.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteIssueComment(HttpServletRequest request, Long issue_comment_id) {
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		try {
			log.info("@@ issue_comment_id = {} ", issue_comment_id);
			if(issue_comment_id == null || issue_comment_id.longValue() <= 0l) {
				result = "issuecomment.invalid";
				jSONObject.put("result", result);
				return jSONObject;
			}
			
			IssueComment issueComment = issueService.getIssueComment(issue_comment_id);
			issueService.deleteIssueComment(issue_comment_id);
			List<IssueComment> issueCommentList = issueService.getListIssueComment(issueComment.getIssue_id());
			jSONObject.put("issueCommentList", issueCommentList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		jSONObject.put("result", result);
		return jSONObject;
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
