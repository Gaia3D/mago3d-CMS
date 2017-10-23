<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/ko/font/font.css" />
	<link rel="stylesheet" href="/images/ko/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/ko/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/ko/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/ko/style.css" />
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="board" modelAttribute="board" method="post" onsubmit="return false;">
							<form:hidden path="board_id"/>			
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									아이디
								</th>
								<td class="col-input">
									${board.user_id }
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									작성자
								</th>
								<td class="col-input">
									${board.user_name }
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="title">제목</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="title" cssClass="xl" />
									<form:errors path="title" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="contents">내용</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:textarea path="contents" />
									<form:errors path="contents" cssClass="error" />
								</td>
							</tr>
							
							<tr>
								<th class="col-label" scope="row">
									<span>사용유무</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input radio-set">
									<input type="radio" id="use_y" name="use_yn" value="Y" />
									<label for="use_y">사용</label>
									<input type="radio" id="use_n" name="use_yn" value="N" />
									<label for="use_n">사용안함</label>
								</td>
							</tr>
							
							<tr>
								<th class="col-label" scope="row"><form:label path="start_date">게시기간</form:label></th>
								<td class="col-input radio-set">
								<form:hidden path="start_date" />
								<form:hidden path="end_date" />
									<input type="text" id="start_day" name="start_day" class="s date" placeholder="날짜" />
									<input type="text" id="start_hour" name="start_hour" class="s" placeholder="시간" maxlength="2" />
									<span class="delimeter">:</span>
									<input type="text" id="start_minute" name="" class="s" placeholder="분" maxlength="2" />
									<span class="delimeter tilde">~</span>
									<input type="text" id="end_day" name="end_day" class="s date" placeholder="날짜" />
									<input type="text" id="end_hour" name="end_hour" class="s" placeholder="시간" maxlength="2" />
									<span class="delimeter">:</span>
									<input type="text" id="end_minute" name="end_minute" class="s" placeholder="분" maxlength="2" />
								</td>
							</tr>
						</table>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="수정" onclick="updateBoard();" />
								<a href="/board/list-board.do?pageNo=${pagination.pageNo }" class="button">목록</a>
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
						
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/ko/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/ko/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/ko/common.js"></script>
<script type="text/javascript" src="/js/ko/message.js"></script>
<script type="text/javascript" src="/js/consoleLog.js"></script>
<script type="text/javascript" src="/js/ko/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		$( ".select" ).selectmenu();
		
		$("[name=use_yn]").filter("[value='${board.use_yn}']").prop("checked",true);
		
		var start_date = "${board.start_date}";
		var end_date = "${board.end_date}";
		if(start_date != null && start_date != "") {
			$("#start_day").val(start_date.substr(0,4) + start_date.substr(5,2) + start_date.substr(8,2));
			$("#start_hour").val(start_date.substr(11,2));
			$("#start_minute").val(start_date.substr(14,2));
		}
		if(end_date != null && end_date != "") {
			$("#end_day").val(end_date.substr(0,4) + end_date.substr(5,2) + end_date.substr(8,2));
			$("#end_hour").val(end_date.substr(11,2));
			$("#end_minute").val(end_date.substr(14,2));
		}
	});
	
	function check() {
		if ($("#title").val() == "") {
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return false;
		}
		if ($("#contents").val() == "") {
			alert("내용을 입력하여 주십시오.");
			$("#contents").focus();
			return false;
		}
		if ($("#start_hour").val() > 23) {
			alert("게시 시작시간을 올바르게 설정하여 주십시오.");
			$("#start_hour").focus();
			return false;
		}
		if ($("#start_minute").val() > 59) {
			alert("게시 시작시간을 올바르게 설정하여 주십시오.");
			$("#start_minute").focus();
			return false;
		}
		if ($("#end_hour").val() > 23) {
			alert("게시 종료시간을 올바르게 설정하여 주십시오.");
			$("#end_hour").focus();
			return false;
		}
		if ($("#end_minute").val() > 59) {
			alert("게시 종료시간을 올바르게 설정하여 주십시오.");
			$("#end_minute").focus();
			return false;
		}
		
		if($("#start_day").val() != null && $("#start_day").val() != "") {
			if($("#start_hour").val() == null || $("#start_hour").val() == "") {
				alert("게시 시작 시간을 올바르게 설정하여 주십시오.");
				$("#start_hour").focus();
				return false;
			}
			if($("#start_minute").val() == null || $("#start_minute").val() == "") {
				alert("게시 시작 시간 분을 올바르게 설정하여 주십시오.");
				$("#start_minute").focus();
				return false;
			}
			if($("#end_hour").val() == null || $("#end_hour").val() == "") {
				alert("게시 종료 시간을 올바르게 설정하여 주십시오.");
				$("#end_hour").focus();
				return false;
			}
			if($("#end_minute").val() == null || $("#end_minute").val() == "") {
				alert("게시 종료 시간 분을 올바르게 설정하여 주십시오.");
				$("#end_minute").focus();
				return false;
			}
			
			$("#start_date").val($("#start_day").val() + $("#start_hour").val() + $("#start_minute").val() + "00");
			$("#end_date").val($("#end_day").val() +  + $("#end_hour").val() + $("#end_minute").val() + "59");
		}
	}
	
	// 저장
	var updateBoardFlag = true;
	function updateBoard() {
		if (check() == false) {
			return false;
		}
		if(updateBoardFlag) {
			updateBoardFlag = false;
			var info = $("#board").serialize();		
			$.ajax({
				url: "/board/ajax-update-board.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateBoardFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateBoardFlag = true;
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
		alert("개발중 입니다... template 도 수정해야 합니다.");
	}
	
	// 삭제
	var deleteBoardCommentFlag = true;
	function deleteBoardComment(board_comment_id) {
		alert("개발중 입니다.... template 을 고쳐야 합니다.");
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
							// TODO 여기에 댓글 목록을 reload 하는 처리가 들어가야 함. 이건 나중에 디자인 되면 하자.
							$("#comment_list").empty();
							var html = commentTemplate.render(msg.boardCommentList);
							$("#comment_list").html(html);
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