package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Issue;
import com.gaia3d.domain.IssueComment;
import com.gaia3d.persistence.IssueMapper;
import com.gaia3d.service.IssueService;

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
	 * issue Comment 목록
	 * @param issue_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<IssueComment> getListIssueComment(Long issue_id) {
		return issueMapper.getListIssueComment(issue_id);
	}
	
	/**
	 * issue 정보
	 * @param issue_id
	 * @return
	 */
	@Transactional
	public Issue getIssue(Long issue_id) {
		Issue issue = issueMapper.getIssue(issue_id);
		issueMapper.updateIssueViewCount(issue_id);
		return issue;
	}
	
	/**
	 * issue Comment 정보
	 * @param issue_comment_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public IssueComment getIssueComment(Long issue_comment_id) {
		return issueMapper.getIssueComment(issue_comment_id);
	}
	
	/**
	 * issue 등록
	 * @param issue
	 * @return
	 */
	@Transactional
	public int insertIssue(Issue issue) {
		issueMapper.insertIssue(issue);
		return issueMapper.insertIssueDetail(issue);
	}
	
	/**
	 * issue Comment 등록
	 * @param issueComment
	 * @return
	 */
	@Transactional
	public int insertIssueComment(IssueComment issueComment) {
		return issueMapper.insertIssueComment(issueComment);
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
	 * issue Comment 수정
	 * @param issueComment
	 * @return
	 */
	@Transactional
	public int updateIssueComment(IssueComment issueComment) {
		return issueMapper.updateIssueComment(issueComment);
	}
	
	/**
	 * issue 삭제
	 * @param issue_id
	 * @return
	 */
	@Transactional
	public int deleteIssue(Long issue_id) {
		return issueMapper.deleteIssue(issue_id);
	}
	
	/**
	 * issue Comment 삭제
	 * @param issue_comment_id
	 * @return
	 */
	@Transactional
	public int deleteIssueComment(Long issue_comment_id) {
		return issueMapper.deleteIssueComment(issue_comment_id);
	}
	
	/**
	 * issue Comment 일괄 삭제
	 * @param issue_id
	 * @return
	 */
	@Transactional
	public int deleteIssueCommentByIssueId(Long issue_id) {
		return issueMapper.deleteIssueCommentByIssueId(issue_id);
	}
}
