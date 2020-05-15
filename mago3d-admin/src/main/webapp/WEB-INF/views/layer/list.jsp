<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 목록 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
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
							<form:form id="layer" modelAttribute="layer" method="get" action="/layer/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색유형</label>
										<select id="searchWord" name="searchWord" class="select" title="검색유형" style="height: 30px;">
											<option value=""><spring:message code='select'/></option>
											<option value="layer_name">레이어 명</option>
											<option value="layer_key">레이어 Key</option>
											<option value="layer_group_name">레이어 그룹명</option>
										</select>
										<label for="searchOption" class="hiddenTag">검색옵션</label>
										<form:select path="searchOption" class="select" title="검색옵션" style="height: 30px;">
											<form:option value="0"><spring:message code='search.same'/></form:option>
											<form:option value="1"><spring:message code='search.include'/></form:option>
										</form:select>
										<label for="searchValue"><spring:message code='search.word'/></label>
										<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
									</div>
									<div class="input-set">
										<label for="startDate"><spring:message code='search.date'/></label>
										<input type="text" class="s date" id="startDate" name="startDate" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" class="s date" id="endDate" name="endDate" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" class="select" style="height: 30px;">
											<option value=""> <spring:message code='search.basic'/> </option>
											<option value="layer_name">레이어 명</option>
											<option value="layer_key">레이어 Key</option>
											<option value="layer_group_name">레이어 그룹명</option>
											<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" class="select" title="정렬기준" style="height: 30px;">
					                		<option value=""> <spring:message code='search.basic'/> </option>
						                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
											<option value="DESC"> <spring:message code='search.descending.order'/> </option>
										</select>
										<label for="listCounter" class="hiddenTag">리스트건수</label>
										<form:select path="listCounter" class="select" title="리스트건수" style="height: 30px;">
					                		<form:option value="10"><spring:message code='search.ten.count'/></form:option>
						                	<form:option value="50"><spring:message code='search.fifty.count'/></form:option>
											<form:option value="100"><spring:message code='search.hundred.count'/></form:option>
										</form:select>
									</div>
									<div class="input-set">
										<input type="submit" value="<spring:message code='search'/>" />
									</div>
								</div>
							</form:form>
						</div>
						<div class="list">
							<form:form id="listForm" modelAttribute="layer" method="post">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/>
									<spring:message code='search.page'/>
								</div>
							</div>
							<table class="list-table scope-col" summary="2D 레이어 목록 테이블">
							<caption class="hiddenTag">2D 레이어 목록</caption>
								<col class="col-name" />
								<col class="col-id" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-date" />
								<thead>
									<tr>
										<th scope="col">Layer 명</th>
					                    <th scope="col">Layer Key</th>
					                    <th scope="col">표시순서(Z-Index)</th>
					                    <th scope="col">사용 여부</th>
					                    <th scope="col">지도</th>
					                    <th scope="col">편집</th>
					                    <th scope="col">최종 수정일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty layerList }">
									<tr>
										<td colspan="7" class="col-none">Layer 가 존재하지 않습니다.</td>
									</tr>
</c:if>
<c:if test="${!empty layerList }">
	<c:forEach var="layer" items="${layerList}" varStatus="status">
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
										<td class="col-key">
                        					${layer.layerName }
										</td>
					                    <td class="col-key" style="text-align: left;" nowrap="nowrap">${layer.layerKey }</td>
                    					<td class="col-key" nowrap="nowrap">${layer.viewZIndex }</td>
					                    <td class="col-type">
        <c:if test="${layer.available eq 'true' }">
                        					사용
        </c:if>
        <c:if test="${layer.available eq 'false' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-type">
                        					<a href="#" onclick="viewLayer('${layer.layerId}', '${layer.layerName}'); return false;" class="linkButton">보기</a>
					                    </td>
					                    <td class="col-type">
											<a href="/layer/modify?layerId=${layer.layerId}" class="image-button button-edit"><spring:message code='modified'/></a>&nbsp;&nbsp;
					                    	<a href="#" onclick="deleteLayer('${layer.layerId}'); return false;" class="image-button button-delete"><spring:message code='delete'/></a>
					                    </td>
					                    <td class="col-date">
					                    	<fmt:parseDate value="${layer.updateDate}" var="viewUpdateDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewUpdateDate}" pattern="yyyy-MM-dd HH:mm"/>
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

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
$(document).ready(function() {
	initDatePicker();

	$("#searchWord").val("${layer.searchWord}");
	$("#searchValue").val("${layer.searchValue}");
	$("#orderWord").val("${layer.orderWord}");
	$("#orderValue").val("${layer.orderValue}");

	initCalendar(new Array("startDate", "endDate"), new Array("${layer.startDate}", "${layer.endDate}"));
});

function searchCheck() {
	if($("#searchOption").val() == "1") {
		if(confirm(JS_MESSAGE["search.option.warning"])) {
			// go
		} else {
			return false;
		}
	}

	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	if(startDate != null && startDate != "" && endDate != null && endDate != "") {
		if(parseInt(startDate) > parseInt(endDate)) {
			alert(JS_MESSAGE["search.date.warning"]);
			$("#startDate").focus();
			return false;
		}
	}
	return true;
}

var deleteLayerFlag = true;
function deleteLayer(layerId) {
	if(deleteLayerFlag) {
		if(confirm(JS_MESSAGE["delete.confirm"])) {
			deleteLayerFlag = false;
			$.ajax({
				url: "/layer/delete/" + layerId,
				type: "DELETE",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg) {
					alert(JS_MESSAGE["delete"]);
					location.reload();
				},
		        error: function(request, status, error) {
		        	// alert message, 세션이 없는 경우 로그인 페이지로 이동 - common.js
		        	ajaxErrorHandler(request);
		        	deleteLayerFlag = true;
		        }
			});
		} else {
			deleteLayerFlag = true;
		}
	} else {
		alert(JS_MESSAGE["button.dobule.click"]);
		return;
	}
}
// 지도 보기
function viewLayer(layerId, layerName) {
    var url = "/layer/" + layerId + "/map";
    var width = 800;
    var height = 700;

    var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
            + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
    popWin.document.title = layerName;
}
</script>
</body>
</html>