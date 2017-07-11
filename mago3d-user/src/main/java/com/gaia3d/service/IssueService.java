package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.Issue;
import com.gaia3d.domain.IssueComment;
import com.gaia3d.domain.IssueFile;

/**
 * issue
 * @author jeongdae
 *
 */
public interface IssueService {
	
	/**
	 * issue 총 건수
	 * @param issue
	 * @return
	 */
	Long getIssueTotalCount(Issue issue);
	
	/**
	 * issue 목록
	 * @param issue
	 * @return
	 */
	List<Issue> getListIssue(Issue issue);
	
	/**
	 * issue 총 건수
	 * @param issue
	 * @return
	 */
	Long getIssueTotalCountByUserId(Issue issue);
	
	/**
	 * issue 목록
	 * @param issue
	 * @return
	 */
	List<Issue> getListIssueByUserId(Issue issue);
	
	/**
	 * issue Comment 목록
	 * @param issue_id
	 * @return
	 */
	List<IssueComment> getListIssueComment(Long issue_id);
	
	/**
	 * issue 정보
	 * @param issue_id
	 * @return
	 */
	Issue getIssue(Long issue_id);
	
	/**
	 * issue Comment 정보
	 * @param issue_comment_id
	 * @return
	 */
	IssueComment getIssueComment(Long issue_comment_id);
	
	/**
	 * issue 등록
	 * @param issue
	 * @param issueFile
	 * @return
	 */
	Issue insertIssue(Issue issue, IssueFile issueFile);
	
	/**
	 * issue Comment 등록
	 * @param issueComment
	 * @return
	 */
	int insertIssueComment(IssueComment issueComment);
	
	/**
	 * issue 수정
	 * @param issue
	 * @return
	 */
	int updateIssue(Issue issue);
	
	/**
	 * issue Comment 수정
	 * @param issueComment
	 * @return
	 */
	int updateIssueComment(IssueComment issueComment);
	
	/**
	 * issue 삭제
	 * @param issue_id
	 * @return
	 */
	int deleteIssue(Long issue_id);
	
	/**
	 * issue Comment 삭제
	 * @param issue_comment_id
	 * @return
	 */
	int deleteIssueComment(Long issue_comment_id);
	
	/**
	 * issue Comment 일괄 삭제
	 * @param issue_id
	 * @return
	 */
	int deleteIssueCommentByIssueId(Long issue_id);
}
