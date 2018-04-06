package com.gaia3d.persistence;

import java.util.List;

import com.gaia3d.domain.Board;
import com.gaia3d.domain.BoardComment;

import org.springframework.stereotype.Repository;


/**
 * 게시판
 * @author jeongdae
 *
 */
@Repository
public interface BoardMapper {
	
	/**
	 * 게시물 총 건수
	 * @param board
	 * @return
	 */
	Long getBoardTotalCount(Board board);
	
	/**
	 * 게시물 목록
	 * @param board
	 * @return
	 */
	List<Board> getListBoard(Board board);
	
	/**
	 * 게시물 Comment 목록
	 * @param board_id
	 * @return
	 */
	List<BoardComment> getListBoardComment(Long board_id);
	
	/**
	 * 게시물 정보
	 * @param board_id
	 * @return
	 */
	Board getBoard(Long board_id);
	
	/**
	 * 게시물 Comment 정보
	 * @param board_comment_id
	 * @return
	 */
	BoardComment getBoardComment(Long board_comment_id);
	
	/**
	 * 게시물 등록
	 * @param board
	 * @return
	 */
	int insertBoard(Board board);
	
	/**
	 * 게시물 상세 등록
	 * @param board
	 */
	int insertBoardDetail(Board board);
	
	/**
	 * 게시물 Comment 등록
	 * @param boardComment
	 * @return
	 */
	int insertBoardComment(BoardComment boardComment);
	
	/**
	 * 게시물 수정
	 * @param board
	 * @return
	 */
	int updateBoard(Board board);
	
	/**
	 * 게시물 조회 건수를 +1
	 * @param board_id
	 */
	void updateBoardViewCount(Long board_id);
	
	/**
	 * 게시물 상세 수정
	 * @param board
	 * @return
	 */
	int updateBoardDetail(Board board);
	
	/**
	 * 게시물 Comment 수정
	 * @param boardComment
	 * @return
	 */
	int updateBoardComment(BoardComment boardComment);
	
	/**
	 * 게시물 삭제
	 * @param board_id
	 * @return
	 */
	int deleteBoard(Long board_id);
	
	/**
	 * 게시물 상세 삭제
	 * @param board_id
	 * @return
	 */
	int deleteBoardDetail(Long board_id);
	
	/**
	 * 게시물 Comment 삭제
	 * @param board_comment_id
	 * @return
	 */
	int deleteBoardComment(Long board_comment_id);
	
	/**
	 * 게시물 Comment 일괄 삭제
	 * @param board_id
	 * @return
	 */
	int deleteBoardCommentByBoardId(Long board_id);
}
