package mago3d.service;

import java.util.List;

import mago3d.domain.CivilVoice;

public interface CivilVoiceService {

	/**
	 * 시민 참여 목록 조회
	 * @param civilvoice
	 * @return
	 */
	List<CivilVoice> getListCivilVoice(CivilVoice civilVoice);

	/**
	 * 시민 참여 전체 건수 조회
	 * @param civilvoice
	 * @return
	 */
	Long getCivilVoiceTotalCount(CivilVoice civilVoice);

	/**
	 * 시민 참여 한건에 대한 정보 조회
	 * @return
	 */
	CivilVoice getCivilVocieById(CivilVoice civilVoice);

	/**
	 * 등록
	 * @param civilvoice
	 * @return
	 */
	int insertCivilVoice(CivilVoice civilVoice);

	/**
	 * 수정
	 * @param civilvoice
	 * @return
	 */
	int updateCivilVoice(CivilVoice civilVoice);

	/**
	 * 삭제
	 * @param civilvoice
	 * @return
	 */
	int deleteCivilVoice(CivilVoice civilVoice);

}
