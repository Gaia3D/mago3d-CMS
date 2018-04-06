package com.gaia3d.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.Board;
import com.gaia3d.domain.BoardComment;
import com.gaia3d.domain.Pagination;
import com.gaia3d.domain.UserSession;
import com.gaia3d.service.BoardService;
import com.gaia3d.util.DateUtil;
import com.gaia3d.util.StringUtil;
import com.gaia3d.util.WebUtil;
import com.gaia3d.validator.BoardValidator;
import lombok.extern.slf4j.Slf4j;

/**
 * 게시판
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/board/")
public class BoardController {
	
	@Resource(name="boardValidator")
	private BoardValidator boardValidator;
	
	@Autowired
	private BoardService boardService;
	
	/**
	 * 게시판 목록
	 * @param request
	 * @param board
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-board.do")
	public String listBoard(HttpServletRequest request, Board board, @RequestParam(defaultValue="1") String pageNo, Model model) {
		
		log.info("@@ board = {}", board);
		if(StringUtil.isNotEmpty(board.getStart_date())) {
			board.setStart_date(board.getStart_date().substring(0, 8) + DateUtil.START_TIME);
		}
		if(StringUtil.isNotEmpty(board.getEnd_date())) {
			board.setEnd_date(board.getEnd_date().substring(0, 8) + DateUtil.END_TIME);
		}
		long totalCount = boardService.getBoardTotalCount(board);
		
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(board), totalCount, Long.valueOf(pageNo).longValue());
		log.info("@@ pagination = {}", pagination);
		
		board.setOffset(pagination.getOffset());
		board.setLimit(pagination.getPageRows());
		List<Board> boardList = new ArrayList<Board>();
		if(totalCount > 0l) {
			boardList = boardService.getListBoard(board);
		}
		
		model.addAttribute(pagination);
		model.addAttribute("boardList", boardList);
		return "/board/list-board";
	}
	
	/**
	 * 게시판 글쓰기 화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "input-board.do", method = RequestMethod.GET)
	public String inputBoard(Model model) {
		
		Board board = new Board();
		model.addAttribute(board);
		return "/board/input-board";
	}
	
	/**
	 * 게시판 글등록
	 * @param board
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-board.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxInsertBoard(HttpServletRequest request, Board board) {
		
		log.info("@@@ board = {}", board);
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			board.setMethod_mode("insert");
			String errorcode = board.validate();
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {}", errorcode);
				return map;
			}
			
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			// TODO 날짜를 더해서 넣어야 한다 공백 처리 해서
			board.setUser_id(userSession.getUser_id());
			board.setUser_name(userSession.getUser_name());
			String client_ip = WebUtil.getClientIp(request);
			board.setClient_ip(client_ip);
			log.info("@@@ board = {}", board);
			boardService.insertBoard(board);
			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 게시판 글 보기
	 * @param board_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail-board.do", method = RequestMethod.GET)
	public String detailBoard(@RequestParam("board_id") String board_id, HttpServletRequest request, Model model) {
		
		String listParameters = getListParameters(request);
		
		Board board =  boardService.getBoard(Long.valueOf(board_id));		
		List<BoardComment> boardCommentList = boardService.getListBoardComment(board.getBoard_id());
		
		model.addAttribute("listParameters", listParameters);
		model.addAttribute(board);
		model.addAttribute(boardCommentList);
		
		return "/board/detail-board";
	}
	
	/**
	 * 게시판 글 수정 화면
	 * @param board_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "modify-board.do", method = RequestMethod.GET)
	public String modifyBoard(HttpServletRequest request, @RequestParam("board_id") String board_id, Model model) {
		String listParameters = getListParameters(request);
		
		Board board =  boardService.getBoard(Long.valueOf(board_id));
		List<BoardComment> boardCommentList = boardService.getListBoardComment(board.getBoard_id());
		
		model.addAttribute("listParameters", listParameters);
		model.addAttribute(board);
		model.addAttribute(boardCommentList);
		
		return "/board/modify-board";
	}
	
	/**
	 * 게시판 글 수정
	 * @param board
	 * @param bindingResult
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-update-board.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxUpdateBoard(Board board) {
		
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ board = {}", board);
			board.setMethod_mode("update");
			
			String errorcode = board.validate();
			log.info("@@@@@@@@@@@@ errorcode = {}", errorcode);
			if(errorcode != null) {
				result = errorcode;
				map.put("result", result);
				log.info("validate error 발생: {}", errorcode);
				return map;
			}			
			boardService.updateBoard(board);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 게시물 삭제
	 * @param board_id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "delete-board.do", method = RequestMethod.GET)
	public String deleteBoard(@RequestParam("board_id") String board_id, Model model) {
		
		boardService.deleteBoard(Long.valueOf(board_id));
		
		return "redirect:/board/list-board.do";
	}
	
	/**
	 * 게시물 등록, 수정, 삭제 처리 결과 페이지
	 * @param request
	 * @param method_mode
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "result-board.do", method = RequestMethod.GET)
	public String resultBoard(HttpServletRequest request, @RequestParam("method_mode") String method_mode, Model model) {
		
		if("insert".equals(method_mode) || "update".equals(method_mode)) {
			String board_id = request.getParameter("board_id");
			if(board_id == null || "".equals(board_id)) {
				log.error("@@ Invalid board_id. board_id = {}", board_id);
				return "redirect:/board/list-board.do";
			}
			Board board =  boardService.getBoard(Long.valueOf(board_id));
			model.addAttribute(board);
		}
		model.addAttribute("method_mode", method_mode);
		
		return "/board/result-board";
	}
	
	/**
	 * 게시물 댓글(Comment) 등록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-board-comment.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxInsertBoardComment(HttpServletRequest request, Board board) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
			
			log.info("@@ board = {} ", board);
			if(board.getBoard_id() == null || board.getBoard_id().longValue() <= 0l) {
				result = "board.id.invalid";
				map.put("result", result);
				log.info("validate error 발생: {}", "board.id.invalid");
				return map;
			}
			if(board.getComment() == null || "".equals(board.getComment())) {
				result = "board.comment.invalid";
				map.put("result", result);
				log.info("validate error 발생: {}", "board.comment.invalid");
				return map;
			}
			
			BoardComment boardComment = new BoardComment();
			boardComment.setBoard_id(board.getBoard_id());
			boardComment.setUser_id(userSession.getUser_id());
			boardComment.setComment(board.getComment());
			
			String client_ip = WebUtil.getClientIp(request);
			boardComment.setClient_ip(client_ip);			
			boardService.insertBoardComment(boardComment);
			
			List<BoardComment> boardCommentList = boardService.getListBoardComment(board.getBoard_id());
			map.put("boardCommentList", boardCommentList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 게시물 댓글(Comment) 삭제
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "ajax-delete-board-comment.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> ajaxDeleteBoardComment(HttpServletRequest request, Long board_comment_id) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		try {
			log.info("@@ board_comment_id = {} ", board_comment_id);
			if(board_comment_id == null || board_comment_id.longValue() <= 0l) {
				result = "board.comment.id.invalid";
				map.put("result", result);
				log.info("validate error 발생: {}", "board.comment.id.invalid");
				return map;
			}
			
			BoardComment boardComment = boardService.getBoardComment(board_comment_id);
			boardService.deleteBoardComment(board_comment_id);
			List<BoardComment> boardCommentList = boardService.getListBoardComment(boardComment.getBoard_id());
			map.put("boardCommentList", boardCommentList);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		return map;
	}
	
	/**
	 * 검색 조건
	 * @param board
	 * @return
	 */
	private String getSearchParameters(Board board) {
		StringBuilder builder = new StringBuilder(100);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(board.getSearch_word()));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(board.getSearch_option()));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(board.getSearch_value()), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("use_yn=" + StringUtil.getDefaultValue(board.getUse_yn()));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(board.getStart_date()));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(board.getEnd_date()));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(board.getOrder_word()));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(board.getOrder_value()));
		return builder.toString();
	}
	
	/**
	 * 목록 페이지 이동 검색 조건
	 * @param board
	 * @return
	 */
	private String getListParameters(HttpServletRequest request) {
		StringBuilder builder = new StringBuilder(100);
		String pageNo = request.getParameter("pageNo");
		builder.append("pageNo=" + pageNo);
		builder.append("&");
		builder.append("search_word=" + StringUtil.getDefaultValue(request.getParameter("search_word")));
		builder.append("&");
		builder.append("search_option=" + StringUtil.getDefaultValue(request.getParameter("search_option")));
		builder.append("&");
		try {
			builder.append("search_value=" + URLEncoder.encode(StringUtil.getDefaultValue(request.getParameter("search_value")), "UTF-8"));
		} catch(Exception e) {
			e.printStackTrace();
			builder.append("search_value=");
		}
		builder.append("&");
		builder.append("use_yn=" + StringUtil.getDefaultValue(request.getParameter("use_yn")));
		builder.append("&");
		builder.append("start_date=" + StringUtil.getDefaultValue(request.getParameter("start_date")));
		builder.append("&");
		builder.append("end_date=" + StringUtil.getDefaultValue(request.getParameter("end_date")));
		builder.append("&");
		builder.append("order_word=" + StringUtil.getDefaultValue(request.getParameter("order_word")));
		builder.append("&");
		builder.append("order_value=" + StringUtil.getDefaultValue(request.getParameter("order_value")));
		return builder.toString();
	}
}
