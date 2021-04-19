package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.issue.Issue;
import gaia3d.persistence.IssueMapper;
import gaia3d.service.IssueService;

/**
 * issue
 * @author jeongdae
 *
 */
@Service
public class IssueServiceImpl implements IssueService {

	@Autowired
	private IssueMapper issueMapper;

	/**
	 * issue 총 건수
	 * @param issue
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getIssueTotalCount(Issue issue) {
		return issueMapper.getIssueTotalCount(issue);
	}
	
	/**
	 * issue 목록
	 * @param issue
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Issue> getListIssue(Issue issue) {
		return issueMapper.getListIssue(issue);
	}
	
	/**
	 * issue 총 건수
	 * @param issue
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getIssueTotalCountByUserId(Issue issue) {
		return issueMapper.getIssueTotalCountByUserId(issue);
	}
	
	/**
	 * issue 목록
	 * @param issue
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Issue> getListIssueByUserId(Issue issue) {
		return issueMapper.getListIssueByUserId(issue);
	}
	
	/**
	 * issue 정보
	 * @param issueId
	 * @return
	 */
	@Transactional
	public Issue getIssue(Long issueId) {
		return issueMapper.getIssue(issueId);
	}
	
	/**
	 * issue 등록
	 * @param issue
	 * @param issueFile
	 * @return
	 */
	@Transactional
	public Issue insertIssue(Issue issue) {
		issueMapper.insertIssue(issue);
		issueMapper.insertIssueDetail(issue);
		
		return issue;
//		// TODO 리팩토링이 필요함
//		String assigneValue = issue.getAssignee();
//		if(assigneValue != null && !"".equals(assigneValue)) {
//			String[] assigneArray = assigneValue.split(",");
//			for(String assigne : assigneArray) {
//				IssuePeople issuePeople = new IssuePeople();
//				issuePeople.setIssue_id(issue.getIssue_id());
//				issuePeople.setRole_type(IssuePeople.ASSIGNEE);
//				issuePeople.setUser_id(assigne);
//				
//				issueMapper.insertIssuePeople(issuePeople);
//			}
//		}
//		String reporterValue = issue.getReporter();
//		if(reporterValue != null && !"".equals(reporterValue)) {
//			String[] reporterArray = reporterValue.split(",");
//			for(String reporter : reporterArray) {
//				IssuePeople issuePeople = new IssuePeople();
//				issuePeople.setIssue_id(issue.getIssue_id());
//				issuePeople.setRole_type(IssuePeople.REPORTER);
//				issuePeople.setUser_id(reporter);
//				
//				issueMapper.insertIssuePeople(issuePeople);
//			}
//		}
		
	}
	
	/**
	 * issue 수정
	 * @param issue
	 * @return
	 */
	@Transactional
	public int updateIssue(Issue issue) {
		issueMapper.updateIssue(issue);
		return issueMapper.updateIssueDetail(issue);
	}
	
	/**
	 * issue 삭제
	 * @param issueId
	 * @return
	 */
	@Transactional
	public int deleteIssue(Long issueId) {
		issueMapper.deleteIssue(issueId);
		return issueMapper.deleteIssueDetail(issueId);
	}
}
