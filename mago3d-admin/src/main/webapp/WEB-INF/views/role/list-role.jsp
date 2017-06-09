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
						<div class="filters">
							<form:form id="role" modelAttribute="role" method="post" action="/role/list-role.do">
								<div class="input-group row">
									<div class="input-set">
										<label for="role_type">Role 분류</label>
										<select id="role_type" name="role_type" class="select">
											<option value="">전체</option>
											<option value="0">사용자</option>
										</select>
									</div>
									<div class="input-set">
										<label for="use_yn">사용여부</label>
										<select id="use_yn" name="use_yn" class="select">
											<option value="">전체</option>
											<option value="Y">사용</option>
											<option value="N">미사용</option>
										</select>
									</div>
									<div class="input-set">
										<label for="order_word">표시 순서</label>
										<select id="order_word" name="order_word" class="select">
											<option value="">기본</option>
											<option value="role_name">Role 명</option>
											<option value="insert_date">등록일</option>
										</select>
										<select id="order_value" name="order_value" class="select">
											<option value="">기본</option>
											<option value="ASC">오름차순</option>
											<option value="DESC">내림차순</option>
										</select>
									</div>
									<div class="input-set">
										<input type="submit" value="검색" />
									</div>
								</div>
							</form:form>
						</div>
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									전체: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em>건, 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
								</div>
								<div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="/role/input-role.do" class="image-button button-area button-new" title="Role 등록">Role 등록</a>
									</div>
								</div>
							</div>
							<form:form id="listForm" modelAttribute="role" method="post">
								<table class="list-table scope-col">
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-key" />
									<col class="col-type" />
									<col class="col-toggle" />
									<col class="col-desc" />
									<col class="col-date-time" />
									<col class="col-functions" />
									<thead>
										<tr>
											<th scope="col" class="col-number">번호</th>
											<th scope="col" class="col-name">Role 명</th>
											<th scope="col" class="col-key">Role Key</th>
											<th scope="col" class="col-type">Role 유형</th>
											<th scope="col" class="col-toggle">사용여부</th>
											<th scope="col" class="col-desc">설명</th>
											<th scope="col" class="col-date-time">등록일</th>
											<th scope="col" class="col-functions">수정/삭제</th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty roleList }">
										<tr>
											<td colspan="8" class="col-none">Role 이 존재하지 않습니다.</td>
										</tr>
</c:if>
<c:if test="${!empty roleList }">
	<c:forEach var="role" items="${roleList}" varStatus="status">
										<tr>
											<td class="col-number">${roleListSize - status.index }</td>
											<td class="col-name"><a href="/role/detail-role.do?role_id=${role.role_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">${role.role_name }</a></td>
											<td class="col-key">${role.role_key }</td>
											<td class="col-type">${role.viewRoleType }</td>
											<td class="col-toggle">${role.viewUseYn }</td>
											<td class="col-desc">${role.description }</td>
											<td class="col-date-time">${role.viewInsertDate }</td>
											<td class="col-functions">
												<span class="button-group">
													<a href="/role/modify-role.do?role_id=${role.role_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" class="image-button button-edit">수정</a>
													<a href="#" onclick="deleteRole('${role.role_id}');" class="image-button button-delete">삭제</a>
												</span>
											</td>
										</tr>
	</c:forEach>
</c:if>
									</tbody>
								</table>
							</form:form>
						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
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
		$("#role_type").val("${role.role_type}");
		$("#use_yn").val("${role.use_yn}");
		$("#order_word").val("${role.order_word}");
		$("#order_value").val("${role.order_value}");
		
		$( ".select" ).selectmenu();
		initSelect(	new Array("role_type", "use_yn"), new Array("${role.role_type}", "${role.use_yn}"));
	});
	
	var deleteRoleFlag = true;
	function deleteRole(role_id) {
		if(deleteRoleFlag) {
			if(confirm("삭제 하시겠습니까?")) { 
				deleteRoleFlag = false;
				var info = "role_id=" + role_id;		
				$.ajax({
					url: "/role/ajax-delete-role.do",
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
						deleteRoleFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteRoleFlag = true;
					}
				});
			} else {
				deleteRoleFlag = true;
			}
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>