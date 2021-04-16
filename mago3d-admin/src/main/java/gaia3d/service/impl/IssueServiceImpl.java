package gaia3d.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.issue.Issue;
import gaia3d.persistence.IssueMapper;
import gaia3d.service.IssueService;
import lombok.RequiredArgsConstructor;

/**
 * issue
 * @author jeongdae
 *
 */
@RequiredArgsConstructor
@Service
public class IssueServiceImpl implements IssueService {

	private final IssueMapper issueMapper;

	/**
	 * 최근 이슈 목록
	 * @return
	 */

	@Transactional(readOnly=true)
	public List<Issue> getListRecentIssue() {
		return issueMapper.getListRecentIssue();
	}
}
