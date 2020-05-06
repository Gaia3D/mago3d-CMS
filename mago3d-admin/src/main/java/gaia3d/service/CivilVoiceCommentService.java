package gaia3d.service;

import java.util.List;

import gaia3d.domain.CivilVoiceComment;

public interface CivilVoiceCommentService {

	/**
	 * 시민 참여 댓글 목록 조회
	 * @param civilVoiceComment
	 * @return
	 */
	List<CivilVoiceComment> getListCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 시민 참여 댓글 전체 건수 조회
	 * @param civilVoiceComment
	 * @return
	 */
	Long getCivilVoiceCommentTotalCount(CivilVoiceComment civilVoiceComment);

	/**
	 * 등록
	 * @param civilvoiceComment
	 * @return
	 */
	int insertCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 수정
	 * @param civilvoiceComment
	 * @return
	 */
	int updateCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 삭제
	 * @param civilVoiceCommentId
	 * @return
	 */
	int deleteCivilVoiceComment(long civilVoiceCommentId);

	/**
	 * 동의 여부 확인
	 * @param civilVoiceComment
	 * @return
	 */
	Boolean alreadyRegistered(CivilVoiceComment civilVoiceComment);
}
