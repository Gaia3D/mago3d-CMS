package gaia3d.service;

import java.util.List;

import gaia3d.domain.issue.Issue;

/**
 * issue
 * @author jeongdae
 *
 */
public interface IssueService {
	
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
	 * 이슈 정보
	 * @param issueId
	 * @return
	 */
	Issue getIssue(Long issueId);
	
	/**
	 * 이슈 등록
	 * @param issue
	 * @return
	 */
	Issue insertIssue(Issue issue);
	
	/**
	 * 이슈 수정
	 * @param issue
	 * @return
	 */
	int updateIssue(Issue issue);
	
	/**
	 * 이슈 삭제
	 * @param issueId
	 * @return
	 */
	int deleteIssue(Long issueId);
}
