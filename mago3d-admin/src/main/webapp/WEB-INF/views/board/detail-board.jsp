<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="inner-header row">
							<div class="content-title u-pull-left">게시물 상세 내용</div>
						</div>
						<table class="inner-table scope-row">
							<col class="col-label" />
							<col class="col-data" />
							<col class="col-label" />
							<col class="col-data" />
							<tr>
								<th scope="row" class="col-label">아이디</th>
								<td class="col-data">${board.user_id}</td>
								<th scope="row" class="col-label">이름</th>
								<td class="col-data">${board.user_name}</td>
							</tr>
							<tr>
								<th scope="row" class="col-label">게시기간</th>
								<td class="col-data">${board.viewStartDate} ~ ${board.viewEndDate}</td>
								<th scope="row" class="col-label">등록일</th>
								<td class="col-data">${board.viewRegisterDate}</td>
							</tr>
							<tr>
								<th scope="row" class="col-label">제목</th>
								<td class="col-data">${board.title}</td>
								<th scope="row" class="col-label">사용여부</th>
								<td class="col-data">${board.viewUseYn}</td>
							</tr>
							<tr>
								<th scope="row" class="col-label">내용</th>
								<td class="col-data" colspan="3">${board.viewContents}</td>
							</tr>	
						</table>	
						<div class="button-group">
							<div class="center-buttons">
								<a href="/board/list-board.do?${listParameters}" class="button">목록</a>	
							</div>
						</div>
						
<c:if test="${!empty boardCommentList }">
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									답글
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-title" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-name">이름</th>
										<th scope="col" class="col-title">제목</th>
										<th scope="col" class="col-date-time">등록일</th>
										<th scope="col" class="col-functions">수정 / 삭제</th>
									</tr>
								</thead>
								<tbody>
	<c:forEach var="boardComment" items="${boardCommentList}" varStatus="status">							
									<tr>
										<td class="col-number">${status.index + 1}</td>
										<td class="col-name">${boardComment.user_name }</td>
										<td class="col-title">
											${boardComment.viewComment}
										</td>
										<td class="col-date-time">${boardComment.viewRegisterDate }</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="#" onclick="modifyBoardComment('${boardComment.board_comment_id}');" class="image-button button-edit">수정</a>
					  							<a href="#" onclick="deleteBoardComment('${boardComment.board_comment_id}');" class="image-button button-delete">삭제</a>
											</span>	
										</td>
									</tr>
	</c:forEach>								
								</tbody>
							</table>
						</div>
</c:if>							
						
						
						
						<div class="input-header row">
							<div class="content-title">댓글</div>
						</div>
						<form:form id="board" modelAttribute="board" method="post">
							<form:hidden path="board_id"/>
						<table class="input-table scope-row">
							<col class="col-input" />
							<col class="col-input" />
							<tr>
								<td class="col-input"><form:textarea path="comment" class="reply" /></td>
								<td class="col-input col-submit"><a href="#" onclick="insertBoardComment();">댓글등록</a></td>
							</tr>
						</table>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript" src="/externlib/${lang}/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/spinner/raphael.js"></script>
<script type="text/javascript">
	$( ".select" ).selectmenu();

	//저장
	var insertBoardCommentFlag = true;
	function insertBoardComment() {
		if($("#comment").val() == "") {
			alert("댓글을 입력하여 주십시오.");
			return false;
		}
		if(insertBoardCommentFlag) {
			insertBoardCommentFlag = false;
			var info = "board_id=${board.board_id}&comment=" + encodeURIComponent($("#comment").val());
			$.ajax({
				url: "/board/ajax-insert-board-comment.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["insert"]);
						/* // TODO 여기에 댓글 목록을 reload 하는 처리가 들어가야 함. 이건 나중에 디자인 되면 하자.
						$("#comment_list").empty();
						var html = commentTemplate.render(msg.boardCommentList);
						$("#comment_list").html(html);
						
						$("#comment").val(""); */
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					insertBoardCommentFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        //alert('code:' + request.status + '\n' + 'message:' + request.responseText + '\n' + 'error:' + error);
			        insertBoardCommentFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 수정
	var modifyBoardCommentFlag = true;
	function modifyBoardComment(board_comment_id) {
		alert("개발중 입니다....");
	}
	
	// 저장
	var deleteBoardCommentFlag = true;
	function deleteBoardComment(board_comment_id) {
		if(JS_MESSAGE["delete.confirm"]) {
			if(deleteBoardCommentFlag) {
				deleteBoardCommentFlag = false;
				var info = "board_comment_id=" + board_comment_id;
				$.ajax({
					url: "/board/ajax-delete-board-comment.do",
					type: "POST",
					data: info,
					cache: false,
					async:false,
					dataType: "json",
					success: function(msg){
						if(msg.result == "success") {
							alert(JS_MESSAGE["delete"]);
							/* // TODO 여기에 댓글 목록을 reload 하는 처리가 들어가야 함. 이건 나중에 디자인 되면 하자.
							$("#comment_list").empty();
							var html = commentTemplate.render(msg.boardCommentList);
							$("#comment_list").html(html); */
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.result]);
						}
						deleteBoardCommentFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteBoardCommentFlag = true;
					}
				});
			} else {
				alert(JS_MESSAGE["button.dobule.click"]);
				return;
			}
		}
	}
</script>
</body>
</html>