package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.CivilVoice;
import gaia3d.domain.CivilVoiceComment;
import gaia3d.persistence.CivilVoiceCommentMapper;
import gaia3d.persistence.CivilVoiceMapper;
import gaia3d.service.CivilVoiceCommentService;

@Service
public class CivilVoiceCommentServiceImpl implements CivilVoiceCommentService {

	@Autowired
	private CivilVoiceMapper civilVoiceMapper;

	@Autowired
	private CivilVoiceCommentMapper civilVoiceCommentMapper;


	@Transactional(readOnly=true)
	public List<CivilVoiceComment> getListCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.getListCivilVoiceComment(civilVoiceComment);
	}

	@Transactional(readOnly=true)
	public Long getCivilVoiceCommentTotalCount(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.getCivilVoiceCommentTotalCount(civilVoiceComment);
	}

	@Transactional
	public int insertCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		CivilVoice civilVoice = new CivilVoice();
		civilVoice.setCivilVoiceId(civilVoiceComment.getCivilVoiceId());
		civilVoiceMapper.updateCivilVoiceCommentCount(civilVoice);

		return civilVoiceCommentMapper.insertCivilVoiceComment(civilVoiceComment);
	}

	@Transactional
	public int updateCivilVoiceComment(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.updateCivilVoiceComment(civilVoiceComment);
	}

	@Transactional
	public int deleteCivilVoiceComment(long civilVoiceCommentId) {
		return civilVoiceCommentMapper.deleteCivilVoiceComment(civilVoiceCommentId);
	}

	@Transactional(readOnly=true)
	public Boolean alreadyRegistered(CivilVoiceComment civilVoiceComment) {
		return civilVoiceCommentMapper.alreadyRegistered(civilVoiceComment);
	}
}
