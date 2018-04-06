package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Board;
import com.gaia3d.domain.BoardComment;
import com.gaia3d.persistence.BoardMapper;
import com.gaia3d.service.BoardService;

/**
 * 게시판
 * @author jeongdae
 *
 */
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	/**
	 * 게시물 총 건수
	 * @param board
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getBoardTotalCount(Board board) {
		return boardMapper.getBoardTotalCount(board);
	}
	
	/**
	 * 게시물 목록
	 * @param board
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Board> getListBoard(Board board) {
		return boardMapper.getListBoard(board);
	}
	
	/**
	 * 게시물 Comment 목록
	 * @param board_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<BoardComment> getListBoardComment(Long board_id) {
		return boardMapper.getListBoardComment(board_id);
	}
	
	/**
	 * 게시물 정보
	 * @param board_id
	 * @return
	 */
	@Transactional
	public Board getBoard(Long board_id) {
		Board board = boardMapper.getBoard(board_id);
		boardMapper.updateBoardViewCount(board_id);
		return board;
	}
	
	/**
	 * 게시물 Comment 정보
	 * @param board_comment_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public BoardComment getBoardComment(Long board_comment_id) {
		return boardMapper.getBoardComment(board_comment_id);
	}
	
	/**
	 * 게시물 등록
	 * @param board
	 * @return
	 */
	@Transactional
	public int insertBoard(Board board) {
		boardMapper.insertBoard(board);
		return boardMapper.insertBoardDetail(board);
	}
	
	/**
	 * 게시물 Comment 등록
	 * @param boardComment
	 * @return
	 */
	@Transactional
	public int insertBoardComment(BoardComment boardComment) {
		return boardMapper.insertBoardComment(boardComment);
	}
	
	/**
	 * 게시물 수정
	 * @param board
	 * @return
	 */
	@Transactional
	public int updateBoard(Board board) {
		boardMapper.updateBoard(board);
		return boardMapper.updateBoardDetail(board);
	}
	
	/**
	 * 게시물 Comment 수정
	 * @param boardComment
	 * @return
	 */
	@Transactional
	public int updateBoardComment(BoardComment boardComment) {
		return boardMapper.updateBoardComment(boardComment);
	}
	
	/**
	 * 게시물 삭제
	 * @param board_id
	 * @return
	 */
	@Transactional
	public int deleteBoard(Long board_id) {
		return boardMapper.deleteBoard(board_id);
	}
	
	/**
	 * 게시물 Comment 삭제
	 * @param board_comment_id
	 * @return
	 */
	@Transactional
	public int deleteBoardComment(Long board_comment_id) {
		return boardMapper.deleteBoardComment(board_comment_id);
	}
	
	/**
	 * 게시물 Comment 일괄 삭제
	 * @param board_id
	 * @return
	 */
	@Transactional
	public int deleteBoardCommentByBoardId(Long board_id) {
		return boardMapper.deleteBoardCommentByBoardId(board_id);
	}
}
