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
									<spring:message code='role.total' var='total'/>
									<spring:message code='role.user' var='user'/>
										<label for="role_type"><spring:message code='role.class'/></label>
										<select id="role_type" name="role_type" class="select">
											<option value="">${total}</option>
											<option value="0">${user}</option>
										</select>
									</div>
									<div class="input-set">
									<spring:message code='use' var='use'/>
									<spring:message code='not.use' var='notUse'/>
										<label for="use_yn"><spring:message code='role.use.not'/></label>
										<select id="use_yn" name="use_yn" class="select">
											<option value="">${total}</option>
											<option value="Y">${use}</option>
											<option value="N">${notUse}</option>
										</select>
									</div>
									<spring:message code='role.basic' var='basic'/>
									<spring:message code='role.name' var='name'/>
									<spring:message code='role.insert.date' var='date'/>
									<spring:message code='role.up.order' var='upOrder'/>
									<spring:message code='role.down.order' var='downOrder'/>
									<div class="input-set">
										<label for="order_word"><spring:message code='role.order'/></label>
										<select id="order_word" name="order_word" class="select">
											<option value="">${basic}</option>
											<option value="role_name">${name}</option>
											<option value="insert_date">${date}</option>
										</select>
										<select id="order_value" name="order_value" class="select">
											<option value="">${basic}</option>
											<option value="ASC">${upOrder}</option>
											<option value="DESC">${downOrder }</option>
										</select>
									</div>
									<div class="input-set">
										<input type="submit" value="<spring:message code='search'/>" />
									</div>
								</div>
							</form:form>
						</div>
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='role.total'/>: <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='role.few'/> 
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='role.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="/role/input-role.do" class="image-button button-area button-new" title="<spring:message code='role.insert'/>"><spring:message code='role.insert'/></a>
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
											<th scope="col" class="col-number"><spring:message code='role.number'/></th>
											<th scope="col" class="col-name"><spring:message code='role.name'/></th>
											<th scope="col" class="col-key">Role Key</th>
											<th scope="col" class="col-type"><spring:message code='role.type'/></th>
											<th scope="col" class="col-toggle"><spring:message code='role.use.not'/></th>
											<th scope="col" class="col-desc"><spring:message code='description'/></th>
											<th scope="col" class="col-date-time"><spring:message code='role.insert.date'/></th>
											<th scope="col" class="col-functions"><spring:message code='role.modify.or.delete'/></th>
										</tr>
									</thead>
									<tbody>
<c:if test="${empty roleList }">
										<tr>
											<td colspan="8" class="col-none"><spring:message code='role.exist'/></td>
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
													<a href="#" onclick="deleteRole('${role.role_id}');" class="image-button button-delete"><spring:message code='delete'/></a>
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
			if(confirm(JS_MESSAGE["delete.confirm"])) { 
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