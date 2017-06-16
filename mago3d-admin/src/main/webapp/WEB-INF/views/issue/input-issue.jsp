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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<form:form id="issue" action="/issue/insert-issue.do" modelAttribute="issue" method="post" enctype="multipart/form-data" onsubmit="return check();">			
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									<form:label path="data_group_id">데이터 그룹</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:select path="data_group_id" cssClass="select">
<c:forEach var="dataGroup" items="${dataGroupList}">
										<option value="${dataGroup.data_group_id}">${dataGroup.data_group_name}</option>
</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="issue_type">Issue Type</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
										<option value="${commonCode.code_value}">${commonCode.code_value}</option>
</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="data_key">Data Key</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="data_key" cssClass="l" />
									<form:errors path="data_key" cssClass="error" />
									<form:hidden path="latitude"/>
									<form:hidden path="longitude"/>
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
									<form:label path="priority">Issue Type</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
										<option value="${commonCode.code_value}">${commonCode.code_value}</option>
</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><form:label path="due_date">마감일</form:label></th>
								<td class="col-input radio-set">
								<form:hidden path="start_date" />
									<input type="text" id="start_day" name="start_day" class="s date" placeholder="날짜" />
									<input type="text" id="start_hour" name="start_hour" class="s" placeholder="시간" maxlength="2" />
									<span class="delimeter">:</span>
									<input type="text" id="start_minute" name="start_minute" class="s" placeholder="분" maxlength="2" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="assignee">Assignee</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="assignee" cssClass="l" placeholder="대리자" />
									<form:errors path="assignee" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="reporter">reporter</form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:input path="reporter" cssClass="l" placeholder="보고 해야 하는 사람" />
									<form:errors path="reporter" cssClass="error" />
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
									첨부 파일
								</th>
								<td class="col-input">
									<input type="file" id="file_name" name="file_name" class="col-data" />
									<form:errors path="file_name" cssClass="error" />
								</td>
							</tr>
						</table>
						<div class="button-group">
							<div id="insertIssueLink" class="center-buttons">
								<input type="submit" value="저장"/>
								<a href="/issue/list-issue.do" class="button">목록</a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initJqueryCalendar();
		$( ".select" ).selectmenu();
		
		$("[name=use_yn]").filter("[value='Y']").prop("checked",true);
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
	}
	
/* 	// 저장
	var insertIssueFlag = true;
	function insertIssue() {
		if (check() == false) {
			return false;
		}
		if(insertIssueFlag) {
			insertIssueFlag = false;
			$("#issue").ajaxSubmit({
				type: "POST",
//				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					alert(msg + "1");
					if(msg.result == "success") {
						alert(msg + "2");
						alert(JS_MESSAGE["insert"]);
						location.href="/issue/list-issue.do";
					} else {
						alert(msg + "3");
						alert(JS_MESSAGE[msg.result]);
					}
					insertIssueFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertIssueFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}	
	} */
</script>
</body>
</html>