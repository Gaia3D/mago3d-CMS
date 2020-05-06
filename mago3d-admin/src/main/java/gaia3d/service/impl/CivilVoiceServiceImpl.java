package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.CivilVoice;
import gaia3d.persistence.CivilVoiceCommentMapper;
import gaia3d.persistence.CivilVoiceMapper;
import gaia3d.service.CivilVoiceService;

/**
 *
 * @author kimhj
 *
 */
@Service
public class CivilVoiceServiceImpl implements CivilVoiceService {

	@Autowired
	private CivilVoiceMapper civilVoiceMapper;

	@Autowired
	private CivilVoiceCommentMapper civilVoiceCommentMapper;


	@Transactional(readOnly = true)
	public List<CivilVoice> getListCivilVoice(CivilVoice civilvoice) {
		return civilVoiceMapper.getListCivilVoice(civilvoice);
	}

	@Transactional(readOnly = true)
	public Long getCivilVoiceTotalCount(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVoiceTotalCount(civilVoice);
	}

	@Transactional(readOnly = true)
	public CivilVoice getCivilVocieById(CivilVoice civilVoice) {
		return civilVoiceMapper.getCivilVocieById(civilVoice);
	}

	@Transactional
	public int insertCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.insertCivilVoice(civilVoice);
	}

	@Transactional
	public int updateCivilVoice(CivilVoice civilVoice) {
		return civilVoiceMapper.updateCivilVoice(civilVoice);
	}

	@Transactional
	public int deleteCivilVoice(CivilVoice civilVoice) {
		civilVoiceCommentMapper.deleteCivilVoiceCommentFromId(civilVoice.getCivilVoiceId());
		return civilVoiceMapper.deleteCivilVoice(civilVoice.getCivilVoiceId());
	}
}
