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
	 * 최근 이슈 목록
	 * @return
	 */
	List<Issue> getListRecentIssue();
}
