package gaia3d.controller.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.issue.Issue;
import gaia3d.domain.user.UserSession;
import gaia3d.service.IssueService;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.WebUtils;
import lombok.extern.slf4j.Slf4j;

/**
 * 이슈
 * @author jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/issues")
public class IssueRestController {
	private static final long PAGE_ROWS = 5L;
	private static final long PAGE_LIST_COUNT = 5L;
	@Autowired
	private IssueService issueService;
	
	/**
	 * 이슈 정보
	 * @param request
	 * @param issueId
	 * @return
	 */
	@GetMapping(value = "/{issueId:[0-9]+}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long issueId) {
		log.info("@@ issueId = {}", issueId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		Issue issue = issueService.getIssue(issueId);
		int statusCode = HttpStatus.OK.value();
		
		result.put("issue", issue);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 이슈 등록
	 * @param request
	 * @param issue
	 * @param errors
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid Issue issue, Errors errors) {
		log.info("@@ issue = {}", issue);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(errors.hasErrors()) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "validation.error");
			result.put("message", errors.getAllErrors().get(0).getDefaultMessage());
			return result;
        }

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		issue.setLocation("POINT(" + issue.getLongitude() + " " + issue.getLatitude() + ")");
		issue.setUserId(userSession.getUserId());
		issue.setClientIp(WebUtils.getClientIp(request));
		issue = issueService.insertIssue(issue);
		int statusCode = HttpStatus.OK.value();
		
		result.put("issueId", issue.getIssueId());
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 이슈 목록 조회
	 * @param request
	 * @param issue
	 * @param pageNo
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, Issue issue, @RequestParam(defaultValue="1") String pageNo) {
		
		issue.setSearchWord(SQLInjectSupport.replaceSqlInection(issue.getSearchWord()));
		issue.setOrderWord(SQLInjectSupport.replaceSqlInection(issue.getOrderWord()));
		log.info("@@@@@@@@ issue = {}", issue);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		long rows = issue.getLimit() != null ? issue.getLimit() : PAGE_ROWS; 
		long totalCount = issueService.getIssueTotalCount(issue);
		Pagination pagination = new Pagination(	request.getRequestURI(),
												getSearchParameters(PageType.LIST, issue),
												totalCount,
												Long.parseLong(pageNo),
												rows,
												PAGE_LIST_COUNT);
		log.info("@@ pagination = {}", pagination);

		issue.setOffset(pagination.getOffset());
		issue.setLimit(pagination.getPageRows());
		List<Issue> issueList = new ArrayList<>();
		if(totalCount > 0L) {
			issueList = issueService.getListIssue(issue);
		}

		int statusCode = HttpStatus.OK.value();
		
		result.put("totalCount", totalCount);
		result.put("pagination", pagination);
		result.put("issueList", issueList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 검색 조건
	 * @param pageType
	 * @param issue
	 * @return
	 */
	private String getSearchParameters(PageType pageType, Issue issue) {
		StringBuilder builder = new StringBuilder(issue.getParameters());
//		buffer.append("&");
//		try {
//			buffer.append("dataName=" + URLEncoder.encode(getDefaultValue(dataInfo.getDataName()), "UTF-8"));
//		} catch(Exception e) {
//			buffer.append("dataName=");
//		}
		
		builder.append("&location=").append(issue.getLocation());
		return builder.toString();
	}
}