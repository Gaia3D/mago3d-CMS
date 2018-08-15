<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<script type="text/javascript" src="/js/cloud.js"></script>
</head>
<body>

<div class="default-layout">
	<!-- 왼쪽 메뉴 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<!-- 왼쪽 메뉴 -->
	
	<!--  컨텐츠 -->
	<div class="content-layout">
		<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
		<div>
			<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
			<div class="content-detail">
				
				
				<!-- Start content by page -->
				<div class="page-content">
					<div class="filters">
	    				<form:form id="searchForm" modelAttribute="dataInfo" method="post" action="/data/list-data.do" onsubmit="return searchCheck();">
						<div class="input-group row">
							<div class="input-set">
								<label for="project_id"><spring:message code='project.name'/></label>
								<form:select path="project_id" cssClass="select">
									<option value="0"><spring:message code='all'/></option>
<c:forEach var="project" items="${projectList}">
									<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
								</form:select>
							</div>
							<div class="input-set">
								<label for="search_word"><spring:message code='search.word'/></label>
								<select id="search_word" name="search_word" class="select">
									<option value=""><spring:message code='select'/></option>
				          			<option value="data_name"><spring:message code='data.name'/></option>
								</select>
								<select id="search_option" name="search_option" class="select">
									<option value="0"><spring:message code='search.same'/></option>
									<option value="1"><spring:message code='search.include'/></option>
								</select>
								<form:input path="search_value" type="search" cssClass="m" />
							</div>
							<div class="input-set">
								<label for="status"><spring:message code='search.status'/></label>
								<select id="status" name="status" class="select">
									<option value=""> <spring:message code='all'/> </option>
									<option value="0"> <spring:message code='search.in.use'/>  </option>
									<option value="1"> <spring:message code='search.stop.use'/> </option>
									<option value="2"> <spring:message code='search.etc'/> </option>
								</select>
							</div>
							<div class="input-set">
								<label for="start_date"><spring:message code='search.date'/></label>
								<input type="text" class="s date" id="start_date" name="start_date" />
								<span class="delimeter tilde">~</span>
								<input type="text" class="s date" id="end_date" name="end_date" />
							</div>
							<div class="input-set">
								<label for="order_word"><spring:message code='search.order'/></label>
								<select id="order_word" name="order_word" class="select">
									<option value=""> <spring:message code='search.basic'/> </option>
				                	<option value="data_name"> <spring:message code='data.name'/> </option>
									<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
								</select>
								<select id="order_value" name="order_value" class="select">
			                		<option value=""> <spring:message code='search.basic'/> </option>
				                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
									<option value="DESC"> <spring:message code='search.descending.order'/> </option>
								</select>
								<select id="list_counter" name="list_counter" class="select">
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
					<div class="list">
						<form:form id="listForm" modelAttribute="dataInfo" method="post">
							<input type="hidden" id="check_ids" name="check_ids" value="" />
						<div class="list-header row">
							<div class="list-desc u-pull-left">
								<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/> 
								<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
							</div>
							<div class="list-functions u-pull-right">
								<div class="button-group">
									<a href="#" onclick="updateDataStatus('DATA', 'LOCK'); return false;" class="button"><spring:message code='data.lock'/></a>
									<a href="#" onclick="updateDataStatus('DATA', 'UNLOCK'); return false;" class="button"><spring:message code='data.lock.release'/></a>
									<a href="#" onclick="deleteDatas(); return false;" class="button"><spring:message code='data.all.delete'/></a>
									<a href="#" onclick="uploadDataFile(); return false;" class="button"><spring:message code='data.all.insert'/></a>
									<a href="#" onclick="uploadProjectDataAttribute(); return false;" class="button"><spring:message code='data.attribute.insert'/></a>
									<a href="#" onclick="uploadProjectDataObjectAttribute(); return false;" class="button"><spring:message code='data.object.attribute.insert'/></a>
								</div>
							</div>
						</div>
						<table class="list-table scope-col">
								<col class="col-checkbox" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-id" />
								<col class="col-name" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-date" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-name"><spring:message code='project.name'/></th>
										<th scope="col" class="col-id"><spring:message code='data.key'/></th>
										<th scope="col" class="col-name"><spring:message code='data.name'/></th>
										<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
										<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
										<th scope="col" class="col-toggle"><spring:message code='height'/></th>
										<th scope="col" class="col-toggle"><spring:message code='status'/></th>
										<th scope="col" class="col-name"><spring:message code='data.control.properties'/></th>
										<th scope="col" class="col-name"><spring:message code='data.origin.properties'/></th>
										<th scope="col" class="col-name"><spring:message code='data.object.properties'/></th>
										<th scope="col" class="col-date"><spring:message code='data.insert.date'/></th>
										<th scope="col" class="col-functions"><spring:message code='modified.and.insert'/></th>
									</tr>
								</thead>
								<tbody>
	<c:if test="${empty dataList }">
									<tr>
										<td colspan="14" class="col-none"><spring:message code='data.does.not.exist'/></td>
									</tr>
	</c:if>
	<c:if test="${!empty dataList }">
	<c:forEach var="dataInfo" items="${dataList}" varStatus="status">
									<tr>
										<td class="col-checkbox">
											<input type="checkbox" id="data_id_${dataInfo.data_id}" name="data_id" value="${dataInfo.data_id}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index }</td>
										<td class="col-name">
											<a href="#" class="view-group-detail" onclick="detailProject('${dataInfo.project_id }'); return false;">${dataInfo.project_name }</a></td>
										<td class="col-id">${dataInfo.data_key }</td>
										<td class="col-name"><a href="/data/detail-data.do?data_id=${dataInfo.data_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">${dataInfo.data_name }</a></td>
										<td class="col-toggle">${dataInfo.latitude}</td>
										<td class="col-toggle">${dataInfo.longitude}</td>
										<td class="col-toggle">${dataInfo.height}</td>
										<td class="col-toggle">
	<c:if test="${dataInfo.status eq '0'}">
											<span class="icon-glyph glyph-on on"></span>
											<span class="icon-text"><spring:message code='data.status.use'/></span>
	</c:if>
	<c:if test="${dataInfo.status ne '0'}">
											<span class="icon-glyph glyph-off off"></span>
											<span class="icon-text"><spring:message code='data.status.unused'/></span>
	</c:if>
											
										</td>
										<td class="col-name" style="text-align: center;">
											<a href="#" onclick="detailDataControlAttribute('${dataInfo.data_id }'); return false;"><spring:message code='view'/></a>
										</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="#" onclick="detailDataAttribute('${dataInfo.data_id }', '${dataInfo.data_name }'); return false;"><spring:message code='view'/></a>
												<a href="#" class="image-button button-edit" 
													onclick="uploadDataAttribute('${dataInfo.data_id }', '${dataInfo.data_name }'); return false;">
													<spring:message code='modified'/></a>
											</span>
										</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="#" class="image-button button-edit" 
													onclick="uploadDataObjectAttribute('${dataInfo.data_id }', '${dataInfo.data_name }'); return false;">
													<spring:message code='modified'/></a>
											</span>
										</td>
										<td class="col-date">${dataInfo.viewInsertDate }</td>
										<td class="col-functions">
											<span class="button-group">
	<c:if test="${dataInfo.parent eq '0' and dataInfo.depth eq '1'}">
												[ 불가 ]
	</c:if>
	<c:if test="${dataInfo.parent ne '0' and dataInfo.depth ne '1'}">
												<a href="/data/modify-data.do?data_id=${dataInfo.data_id }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}" 
													class="image-button button-edit"><spring:message code='modified'/></a>
												<a href="/data/delete-data.do?data_id=${dataInfo.data_id }" onclick="return deleteWarning();" 
													class="image-button button-delete"><spring:message code='delete'/></a>
	</c:if>
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
					<!-- End content by page -->
				</div>
				
			</div>	
			<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		</div>
	</div>
	<!--  컨텐츠 -->
</div>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	
	//전체 선택 
	$("#chk_all").click(function() {
		$(":checkbox[name=project_id]").prop("checked", this.checked);
	});
	
</script>
</body>
</html>
