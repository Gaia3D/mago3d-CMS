package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.issue.Issue;

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
	int insertIssue(Issue issue);
	
	/**
	 * 이슈 상세 등록
	 * @param issue
	 */
	int insertIssueDetail(Issue issue);
	
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
	 * 이슈 삭제
	 * @param issueId
	 * @return
	 */
	int deleteIssue(Long issueId);
	
	/**
	 * 이슈 상세 삭제
	 * @param issueId
	 * @return
	 */
	int deleteIssueDetail(Long issueId);
}
