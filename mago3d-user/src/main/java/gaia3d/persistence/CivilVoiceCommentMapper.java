package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.CivilVoiceComment;

@Repository
public interface CivilVoiceCommentMapper {

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
	 * @param civilVoiceComment
	 * @return
	 */
	int insertCivilVoiceComment(CivilVoiceComment civilVoiceComment);

	/**
	 * 수정
	 * @param civilVoiceComment
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
	 * 삭제
	 * @param civilVoiceId
	 * @return
	 */
	int deleteCivilVoiceCommentFromId(long civilVoiceId);

	/**
	 * 동의 여부 확인
	 * @param civilVoiceComment
	 * @return
	 */
	Boolean alreadyRegistered(CivilVoiceComment civilVoiceComment);
}
