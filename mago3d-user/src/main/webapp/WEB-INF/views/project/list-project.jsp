<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>프로젝트 목록 | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content-wrap">
			<div id="gnb-content" class="clfix">
				<h1 style="padding-left: 20px;">
					<span style="font-size:26px;">프로젝트 목록</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="프로젝트"></i>
					</span>
					<span style="font-size:12px;">프로젝트 > 프로젝트 목록</span>
				</div>
			</div>
			
			<div class="page-content">
				<div class="search-filter">
					<div class="filters">
		   				<form:form id="searchForm" modelAttribute="project" method="post" action="/project/list-project.do" onsubmit="return searchCheck();">
						<div class="input-group row">
							<div class="input-set">
								<label for="search_word"><spring:message code='search.word'/></label>
								<select id="search_word" name="search_word" class="select" style="height: 30px;">
									<option value=""><spring:message code='select'/></option>
				          			<option value="project_name">프로젝트명</option>
								</select>
								<select id="search_option" name="search_option" class="select" style="height: 30px;">
									<option value="0"><spring:message code='search.same'/></option>
									<option value="1"><spring:message code='search.include'/></option>
								</select>
								<form:input path="search_value" type="search" cssClass="m" />
							</div>
							<div class="input-set">
								<label for="start_date"><spring:message code='search.date'/></label>
								<input type="text" class="s date" id="start_date" name="start_date" />
								<span class="delimeter tilde">~</span>
								<input type="text" class="s date" id="end_date" name="end_date" />
							</div>
							<div class="input-set">
								<label for="order_word"><spring:message code='search.order'/></label>
								<select id="order_word" name="order_word" class="select" style="height: 30px;">
									<option value=""> <spring:message code='search.basic'/> </option>
									<option value="project_name"> 프로젝트명 </option>
									<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
								</select>
								<select id="order_value" name="order_value" class="select" style="height: 30px;">
			                		<option value=""> <spring:message code='search.basic'/> </option>
				                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
									<option value="DESC"> <spring:message code='search.descending.order'/> </option>
								</select>
								<select id="list_counter" name="list_counter" class="select" style="height: 30px;">
			                		<option value="10"> <spring:message code='search.ten.count'/> </option>
				                	<option value="50"> <spring:message code='search.fifty.count'/> </option>
									<option value="100"> <spring:message code='search.hundred.count'/> </option>
								</select>
							</div>
							<div class="input-set">
								<input type="submit" value="<spring:message code='search'/>" />
							</div>
						</div>
						</form:form>
					</div>
				</div>
				
				<div class="list">
					<form:form id="listForm" modelAttribute="uploadLog" method="post">
					<div class="list-header">
						<div class="list-desc u-pull-left">
							<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
							<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
						</div>
					</div>
					
					<table class="list-table scope-col">
						<col class="col-number" />
						<col class="col-number" />
						<col class="col-name" />
						<col class="col-name" />
						<col class="col-number" />
						<col class="col-toggle" />
						<col class="col-toggle" />
						<col class="col-toggle" />
						<col class="col-toggle" />
						<col class="col-toggle" />
						<col class="col-number" />
						<col class="col-functions" />
						<col class="col-date" />
						<col class="col-functions" />
						<thead>
							<tr>
								<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
								<th scope="col" class="col-number"><spring:message code='number'/></th>
								<th scope="col" class="col-name">Key</th>
								<th scope="col" class="col-name"><spring:message code='project.name'/></th>
								<th scope="col" class="col-number"><spring:message code='order'/></th>
								<th scope="col" class="col-toggle"><spring:message code='default.value'/></th>
								<th scope="col" class="col-toggle"><spring:message code='code.use.not'/></th>
								<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
								<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
								<th scope="col" class="col-toggle"><spring:message code='height'/></th>
								<th scope="col" class="col-number"><spring:message code='movement.time'/></th>
								<th scope="col" class="col-functions"><spring:message code='data.management'/></th>
								<th scope="col" class="col-date"><spring:message code='search.insert.date'/></th>
								<th scope="col" class="col-functions"><spring:message code='code.modify.delete'/></th>
							</tr>
						</thead>
						<tbody>
	<c:if test="${empty projectList }">
							<tr>
								<td colspan="14" class="col-none"><spring:message code='project.does.not.exist'/></td>
							</tr>
	</c:if>
	<c:if test="${!empty projectList }">
		<c:forEach var="project" items="${projectList}" varStatus="status">
								<tr>
									<td class="col-checkbox">
										<input type="checkbox" id="project_id_${project.project_id}" name="project_id" value="${project.project_id}" />
									</td>
									<td class="col-number">${pagination.rowNumber - status.index}</td>
									<td class="col-name">${project.project_key }</td>
									<td class="col-number">${project.project_name } [ 보기 ]</td>
									<td class="col-number">${project.view_order}</td>
									<td class="col-toggle">${project.default_yn}</td>
									<td class="col-toggle">${project.use_yn}</td>
									<td class="col-toggle">${project.latitude}</td>
									<td class="col-toggle">${project.longitude}</td>
									<td class="col-toggle">${project.height}</td>
									<td class="col-toggle">${project.duration}</td>
									<td class="col-functions"><a href="#" onclick="viewDataList('${project.project_id}', '${project.project_name}'); return false;"><spring:message code='view'/></a></td>
									<td class="col-date">${project.viewInsertDate }</td>
									<td class="col-functions">
										<span class="button-group">
											<a href="/data/modify-project.do?project_id=${project.project_id}" class="image-button button-edit"><spring:message code='modified'/></a>
											<a href="#" onclick="deleteProject('${project.project_id}'); return false;" class="image-button button-delete">
												<spring:message code='delete'/>
											</a>
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
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
</body>
</html>