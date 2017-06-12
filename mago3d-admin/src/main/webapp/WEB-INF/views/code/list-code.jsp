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
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em>${commonCodeListSize}</em>건
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-id" />
								<col class="col-name" />
								<!-- <col class="col-name" /> -->
								<col class="col-name" />
								<col class="col-type" />
								<col class="col-toggle" />
								<col class="col-number" />
								<col class="col-desc" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number">번호</th>
										<th scope="col" class="col-id">코드키</th>
										<th scope="col" class="col-name">코드명</th>
										<!-- <th scope="col" class="col-name">코드명(영어)</th> -->
										<th scope="col" class="col-name">코드값</th>
										<th scope="col" class="col-type">코드분류</th>
										<th scope="col" class="col-toggle">사용유무</th>
										<th scope="col" class="col-number">표시순서</th>
										<th scope="col" class="col-desc">설명</th>
										<th scope="col" class="col-desc">등록일</th>
										<th scope="col" class="col-functions">수정/삭제</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty commonCodeList }">
									<tr>
										<td colspan="10" class="col-none">공통 코드 목록이 존재하지 않습니다.
										</td>
									</tr>
</c:if>
<c:if test="${!empty commonCodeList }">
	<c:forEach var="commonCode" items="${commonCodeList}" varStatus="status">
									<tr>
										<td class="col-number">${commonCodeListSize - status.index}</td>
										<td class="col-id">${commonCode.code_key}</td>
										<td class="col-name">${commonCode.code_name}</td>
										<%-- <td class="col-name">${commonCode.code_name_en}</td> --%>
										<td class="col-name">${commonCode.code_value}</td>
										<td class="col-type">${commonCode.code_type}</td>
										<td class="col-toggle">${commonCode.viewUseYn}</td>
										<td class="col-toggle">${commonCode.view_order}</td>
										<td class="col-desc">${commonCode.description}</td>
										<td class="col-date-time">${commonCode.viewInsertDate}</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="/code/modify-code.do?code_key=${commonCode.code_key }&view_order=${commonCode.view_order}" class="image-button button-edit">수정</a>
												<a href="#" onclick="deleteCode('${commonCode.code_key}', '${commonCode.view_order}');" class="image-button button-delete">삭제</a>
											</span>
										</td>
									</tr>
	</c:forEach>
</c:if>
								</tbody>
							</table>
						</div>
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
	function check() {
		if ($("#code_name").val() == "") {
			alert("코드명을 입력하여 주십시오.");
			$("#code_name").focus();
			return false;
		}
	}
	
	// 수정
	var updateCodeFlag = true;
	function updateCode() {
		if (check() == false) {
			return false;
		}
		if(updateCodeFlag) {
			updateCodeFlag = false;
			var info = $("#commonCode").serialize();		
			$.ajax({
				url: "/code/ajax-update-code.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateCodeFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateCodeFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	var deleteCodeFlag = true;
	function deleteCode(code_key, view_order) {
		if(deleteCodeFlag) {
			if(confirm("삭제 하시겠습니까?")) { 
				deleteCodeFlag = false;
				var info = "code_key=" + code_key + "&view_order=" + view_order;		
				$.ajax({
					url: "/code/ajax-delete-code.do",
					type: "POST",
					data: info,
					cache: false,
					dataType: "json",
					success: function(msg){
						if(msg.result == "success") {
							alert(JS_MESSAGE["delete"]);
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.result]);
						}
						deleteCodeFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteCodeFlag = true;
					}
				});
			} else {
				 deleteCodeFlag = true;
			}
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>