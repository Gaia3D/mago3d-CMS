package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Issue;
import com.gaia3d.domain.IssueComment;
import com.gaia3d.domain.IssueFile;
import com.gaia3d.domain.IssuePeople;

/**
 * 이슈
 * @author jeongdae
 *
 */
@Repository
public interface IssueMapper {
	
	/**
	 * 이슈 총 건수
	 * @param issue
	 * @return
	 */
	Long getIssueTotalCount(Issue issue);
	
	/**
	 * 이슈 목록
	 * @param issue
	 * @return
	 */
	List<Issue> getListIssue(Issue issue);
	
	/**
	 * 이슈 총 건수
	 * @param issue
	 * @return
	 */
	Long getIssueTotalCountByUserId(Issue issue);
	
	/**
	 * 이슈 목록
	 * @param issue
	 * @return
	 */
	List<Issue> getListIssueByUserId(Issue issue);
	
	/**
	 * 이슈 Comment 목록
	 * @param issue_id
	 * @return
	 */
	List<IssueComment> getListIssueComment(Long issue_id);
	
	/**
	 * 이슈 정보
	 * @param issue_id
	 * @return
	 */
	Issue getIssue(Long issue_id);
	
	/**
	 * 이슈 Comment 정보
	 * @param issue_comment_id
	 * @return
	 */
	IssueComment getIssueComment(Long issue_comment_id);
	
	/**
	 * 이슈 등록
	 * @param issue
	 * @return
	 */
	int insertIssue(Issue issue);
	
	/**
	 * 이슈 상세 등록
	 * @param issue
	 */
	int insertIssueDetail(Issue issue);
	
	/**
	 * 이슈 Comment 등록
	 * @param issueComment
	 * @return
	 */
	int insertIssueComment(IssueComment issueComment);
	
	/**
	 * 이슈 파일 등록
	 * @param issueFile
	 */
	int insertIssueFile(IssueFile issueFile);
	
	/**
	 * 이슈 관계자 등록
	 * @param issuePeople
	 */
	int insertIssuePeople(IssuePeople issuePeople);
	
	/**
	 * 이슈 수정
	 * @param issue
	 * @return
	 */
	int updateIssue(Issue issue);
	
	/**
	 * 이슈 상세 수정
	 * @param issue
	 * @return
	 */
	int updateIssueDetail(Issue issue);
	
	/**
	 * 이슈 Comment 수정
	 * @param issueComment
	 * @return
	 */
	int updateIssueComment(IssueComment issueComment);
	
	/**
	 * 이슈 삭제
	 * @param issue_id
	 * @return
	 */
	int deleteIssue(Long issue_id);
	
	/**
	 * 이슈 상세 삭제
	 * @param issue_detail_id
	 * @return
	 */
	int deleteIssueDetail(Long issue_id);
	
	/**
	 * 이슈 Comment 삭제
	 * @param issue_comment_id
	 * @return
	 */
	int deleteIssueComment(Long issue_comment_id);
	
	/**
	 * 이슈 Comment 일괄 삭제
	 * @param issue_id
	 * @return
	 */
	int deleteIssueCommentByIssueId(Long issue_id);
}
