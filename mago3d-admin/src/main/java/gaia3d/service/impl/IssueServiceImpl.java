package gaia3d.service.impl;

import java.util.List;

import gaia3d.domain.Issue;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.Issue;
import gaia3d.persistence.IssueMapper;
import gaia3d.service.IssueService;

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
