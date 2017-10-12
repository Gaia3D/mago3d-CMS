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
									<spring:message code='all'/> <em>${commonCodeListSize}</em><spring:message code='user.group.all.count.key'/>
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-number" />
								<col class="col-type" />
								<col class="col-id" />
								<col class="col-name" />
								<!-- <col class="col-name" /> -->
								<col class="col-name" />
								<col class="col-toggle" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-desc" />
								<col class="col-date-time" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-type"><spring:message code='code.list'/></th>
										<th scope="col" class="col-id"><spring:message code='code.key'/></th>
										<th scope="col" class="col-name"><spring:message code='code.name'/></th>
										<!-- <th scope="col" class="col-name">코드명(영어)</th> -->
										<th scope="col" class="col-name"><spring:message code='code.result'/></th>
										<th scope="col" class="col-toggle"><spring:message code='code.use.not'/></th>
										<th scope="col" class="col-number"><spring:message code='code.order'/></th>
										<th scope="col" class="col-name">Css</th>
										<th scope="col" class="col-name">Image</th>
										<th scope="col" class="col-desc"><spring:message code='description'/></th>
										<th scope="col" class="col-desc"><spring:message code='code.insert.date'/></th>
										<th scope="col" class="col-functions"><spring:message code='code.modify.delete'/></th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty commonCodeList }">
									<tr>
										<td colspan="12" class="col-none">공통 코드 목록이 존재하지 않습니다.
										</td>
									</tr>
</c:if>
<c:if test="${!empty commonCodeList }">
	<c:forEach var="commonCode" items="${commonCodeList}" varStatus="status">
									<tr>
										<td class="col-number">${commonCodeListSize - status.index}</td>
										<td class="col-type">${commonCode.code_type}</td>
										<td class="col-id">${commonCode.code_key}</td>
										<td class="col-name">${commonCode.code_name}</td>
										<%-- <td class="col-name">${commonCode.code_name_en}</td> --%>
										<td class="col-name">${commonCode.code_value}</td>
										<td class="col-toggle">${commonCode.viewUseYn}</td>
										<td class="col-toggle">${commonCode.view_order}</td>
										<td class="col-name">${commonCode.css_class}</td>
										<td class="col-name">${commonCode.image}</td>
										<td class="col-desc">${commonCode.description}</td>
										<td class="col-date-time">${commonCode.viewInsertDate}</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="/code/modify-code.do?code_key=${commonCode.code_key}" class="image-button button-edit">수정</a>
												<a href="#" onclick="deleteCode('${commonCode.code_key}');" class="image-button button-delete">삭제</a>
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
	var deleteCodeFlag = true;
	function deleteCode(code_key) {
		if(deleteCodeFlag) {
			if(confirm(JS_MESSAGE["delete.confirm"])) { 
				deleteCodeFlag = false;
				var info = "code_key=" + code_key;		
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