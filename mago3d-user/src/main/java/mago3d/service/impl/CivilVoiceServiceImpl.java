package mago3d.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mago3d.domain.CivilVoice;
import mago3d.persistence.CivilVoiceCommentMapper;
import mago3d.persistence.CivilVoiceMapper;
import mago3d.service.CivilVoiceService;

@Service
public class CivilVoiceServiceImpl implements CivilVoiceService {
	private final CivilVoiceMapper civilVoiceMapper;
	private final CivilVoiceCommentMapper civilVoiceCommentMapper;

	public CivilVoiceServiceImpl(CivilVoiceMapper civilVoiceMapper, CivilVoiceCommentMapper civilVoiceCommentMapper) {
		this.civilVoiceMapper = civilVoiceMapper;
		this.civilVoiceCommentMapper = civilVoiceCommentMapper;
	}

	@Transactional(readOnly = true)
	public List<CivilVoice> getListCivilVoice(CivilVoice civilvoice) {
		return civilVoiceMapper.getListCivilVoice(civilvoice);
	}

	@Transactional(readOnly = true)
	public List<CivilVoice> getListAllCivilVoice(CivilVoice civilvoice) {
		return civilVoiceMapper.getListAllCivilVoice(civilvoice);
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
	public CivilVoice insertCivilVoice(CivilVoice civilVoice) {
		civilVoiceMapper.insertCivilVoice(civilVoice);
		
		return civilVoice;
	}

	@Transactional
	public CivilVoice updateCivilVoice(CivilVoice civilVoice) {
		civilVoiceMapper.updateCivilVoice(civilVoice);
		return civilVoice;
	}

	@Transactional
	public int updateCivilVoiceViewCount(CivilVoice civilVoice) {
		return civilVoiceMapper.updateCivilVoiceViewCount(civilVoice);
	}

	@Transactional
	public int deleteCivilVoice(CivilVoice civilVoice) {
		civilVoiceCommentMapper.deleteCivilVoiceCommentFromId(civilVoice.getCivilVoiceId());
		return civilVoiceMapper.deleteCivilVoice(civilVoice.getCivilVoiceId());
	}

}
