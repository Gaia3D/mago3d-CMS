package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.CivilVoice;

@Repository
public interface CivilVoiceMapper {

	/**
	 * 시민 참여 목록 조회
	 * @param civilvoice
	 * @return
	 */
	List<CivilVoice> getListCivilVoice(CivilVoice civilVoice);

	/**
	 * 시민 참여 전체 목록 조회
	 * @param civilvoice
	 * @return
	 */
	List<CivilVoice> getListAllCivilVoice(CivilVoice civilVoice);

	/**
	 * 시민 참여 전체 건수 조회
	 * @param civilvoice
	 * @return
	 */
	Long getCivilVoiceTotalCount(CivilVoice civilVoice);

	/**
	 * 시민 참여 한건에 대한 정보 조회
	 * @param civilVoice
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
	 * 댓글 수 수정
	 * @param civilvoice
	 * @return
	 */
	int updateCivilVoiceCommentCount(CivilVoice civilVoice);

	/**
	 * 조회 수 수정
	 * @param civilvoice
	 * @return
	 */
	int updateCivilVoiceViewCount(CivilVoice civilVoice);

	/**
	 * 삭제
	 * @param civilVoiceId
	 * @return
	 */
	int deleteCivilVoice(long civilVoiceId);

	/**
	 * 전체 삭제
	 * @return
	 */
	int deleteAllCivilVoice();
}
