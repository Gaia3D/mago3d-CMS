<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 변경 요청 이력 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
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
							<form:form id="searchForm" modelAttribute="dataAdjustLog" method="get" action="/data-adjust-log/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색조건</label>
										<select id="searchWord" name="searchWord" class="select" title="검색조건" style="height: 30px;">
											<option value=""><spring:message code='select'/></option>
						          			<option value="data_name">데이터명</option>
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
											<option value="data_name">데이터명</option>
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
								<form:form id="listForm" modelAttribute="dataInfo" method="post">
									<input type="hidden" id="checkIds" name="checkIds" value="" />
									<input type="hidden" id="status" name="status" value="" />
								<div class="list-header row">
									<div class="list-desc u-pull-left">
										<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
										<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
									</div>
								</div>
								<table class="list-table scope-col" summary="데이터 위치 변경 요청 이력 리스트 ">
								<caption class="hiddenTag">데이터 위치 변경 요척 이력</caption>
									<col class="col-checkbox" />
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-name" />
									<col class="col-type" />
									<col class="col-count" />
									<col class="col-count" />
									<col class="col-count" />
									<col class="col-type" />
									<col class="col-functions" />
									<col class="col-date" />
									<thead>
										<tr>
											<th scope="col" class="col-checkbox"><label for="chkAll" class="hiddenTag">전체선택 체크박스</label><input type="checkbox" id="chkAll" name="chkAll" /></th>
											<th scope="col" class="col-number"><spring:message code='number'/></th>
											<th scope="col" class="col-name">그룹명</th>
											<th scope="col" class="col-name">데이터명</th>
											<th scope="col" class="col-type">요청자</th>
											<th scope="col" class="col-count">변경 후 경도</th>
											<th scope="col" class="col-count">변경 후 위도</th>
											<th scope="col" class="col-count">높이</th>
											<th scope="col" class="col-type">상태</th>
											<th scope="col" class="col-functions">결재</th>
											<th scope="col" class="col-date">요청일</th>
										</tr>
									</thead>
									<tbody>
		<c:if test="${empty dataAdjustLogList }">
										<tr>
											<td colspan="11" class="col-none">데이터 변경 요청 이력이 존재하지 않습니다.</td>
										</tr>
		</c:if>
		<c:if test="${!empty dataAdjustLogList }">
			<c:forEach var="dataAdjustLog" items="${dataAdjustLogList}" varStatus="status">

										<tr>
											<td class="col-checkbox">
												<label for="dataAdjustLogId_${dataAdjustLog.dataAdjustLogId}" class="hiddenTag">선택 체크박스</label>
												<input type="checkbox" id="dataAdjustLogId_${dataAdjustLog.dataAdjustLogId}" name="dataAdjustLogId" value="${dataInfoAdjustLog.dataAdjustLogId}" />
											</td>
											<td class="col-number">${pagination.rowNumber - status.index }</td>
											<td class="col-name ellipsis" style="max-width:120px;">
												<a href="#" class="view-group-detail" onclick="detailDataGroup('${dataAdjustLog.dataGroupId }'); return false;">${dataAdjustLog.dataGroupName }</a></td>
											<td class="col-name ellipsis" style="max-width:140px;">
												<a href="#" class="view-group-detail" onclick="detailDataAdjustLog('${dataAdjustLog.dataName}'
															, '${dataAdjustLog.beforeLatitude}', '${dataAdjustLog.latitude}', '${dataAdjustLog.beforeLongitude}', '${dataAdjustLog.longitude}'
															, '${dataAdjustLog.beforeAltitude}', '${dataAdjustLog.altitude}', '${dataAdjustLog.beforeHeading}', '${dataAdjustLog.heading}'
															, '${dataAdjustLog.beforePitch}', '${dataAdjustLog.pitch}', '${dataAdjustLog.beforeRoll}', '${dataAdjustLog.roll}'); return false;">${dataAdjustLog.dataName }</a>
												</td>
											<td class="col-type">${dataAdjustLog.userId }</td>
											<td class="col-count">${dataAdjustLog.longitude}</td>
											<td class="col-count">${dataAdjustLog.latitude}</td>
											<td class="col-count">${dataAdjustLog.altitude}</td>
											<td class="col-type">
												<span class="icon-glyph glyph-on on"></span>
				<c:if test="${dataAdjustLog.status eq 'request'}">
												<span class="icon-text">요청</span>
				</c:if>
				<c:if test="${dataAdjustLog.status eq 'approval'}">
												<span class="icon-text">승인</span>
				</c:if>
				<c:if test="${dataAdjustLog.status eq 'reject'}">
												<span class="icon-text">반려</span>
				</c:if>
				<c:if test="${dataAdjustLog.status eq 'rollback'}">
												<span class="icon-text">원복</span>
				</c:if>
											</td>
											<td class="col-functions">
												<span class="button-group">
				<c:if test="${dataAdjustLog.status eq 'request'}">
												<a href="#" onclick="return warning('approval', '${dataAdjustLog.dataAdjustLogId}');" class="button" >
													승인
												</a>
												<a href="#" onclick="return warning('reject', '${dataAdjustLog.dataAdjustLogId}');" class="button" >
													반려
												</a>
				</c:if>
				<c:if test="${dataAdjustLog.status eq 'complete'}">
												<a href="#" onclick="return warning('rollback', '${dataAdjustLog.dataAdjustLogId}');" class="button" >
													원복
												</a>
				</c:if>
														</span>
											</td>
											<td class="col-date">
												<fmt:parseDate value="${dataAdjustLog.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
												<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
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

<%@ include file="/WEB-INF/views/data/group-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data-adjust-log/data-adjust-log-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var searchWord = "${dataAdjustLog.searchWord}";
		var searchOption = "${dataAdjustLog.searchOption}";
		var orderWord = "${dataAdjustLog.orderWord}";
		var orderValue = "${dataAdjustLog.orderValue}";
		var listCounter = "${dataAdjustLog.listCounter}";

		if(searchWord != "") $("#searchWord").val("${dataAdjustLog.searchWord}");
		if(searchOption != "") $("#searchOption").val("${dataAdjustLog.searchOption}");
		if(orderWord != "") $("#orderWord").val("${dataAdjustLog.orderWord}");
		if(orderValue != "") $("#orderValue").val("${dataAdjustLog.orderValue}");
		if(listCounter != "") $("#listCounter").val("${dataAdjustLog.listCounter}");

		initDatePicker();
		initCalendar(new Array("startDate", "endDate"), new Array("${dataAdjustLog.startDate}", "${dataAdjustLog.endDate}"));
	});

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=dataAdjustLogId]").prop("checked", this.checked);
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

	var dataGroupDialog = $( ".dataGroupDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 530,
		modal: true,
		resizable: false
	});

	// 데이터 그룹 정보
	function detailDataGroup(dataGroupId) {
		dataGroupDialog.dialog( "open" );
		viewDataGroup(dataGroupId);
	}

	// project 정보
	function viewDataGroup(dataGroupId) {
		$.ajax({
			url: "/data-groups/" + dataGroupId,
			//data: { dataGroupId : dataGroupId },
			type: "GET",
			dataType: "json",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			success: function(msg){
				if(msg.statusCode <= 200) {
					drawDataGroup(msg.dataGroup);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error){
		        alert(JS_MESSAGE["ajax.error.message"]);
		        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}

	// 프로젝트 정보
	function drawDataGroup(dataGroup) {
		$("#dataGroupNameInfo").html(dataGroup.dataGroupName);
		$("#dataGroupKeyInfo").html(dataGroup.dataGroupKey);
		$("#dataGroupTargetInfo").html(dataGroup.dataGroupTarget);
		$("#sharingInfo").html(dataGroup.sharing);
		$("#userIdInfo").html(dataGroup.userId);
		$("#basicInfo").html(dataGroup.basic);
		$("#availableInfo").html(dataGroup.available);
		$("#locationInfo").html(dataGroup.longitude + " / " + dataGroup.latitude);
		$("#dataCountInfo").html(dataGroup.dataCount);
		$("#metainfoInfo").html(dataGroup.metainfo);
		$("#descriptionInfo").html(dataGroup.description);
	}

	// data info change request log
	var dataInfoAdjustLogDialog = $( ".dataInfoAdjustLogDialog" ).dialog({
	    autoOpen: false,
	    width: 500,
	    height: 380,
	    modal: true,
	    resizable: false
	});
	function detailDataAdjustLog(dataName, beforeLatitude, latitude, beforeLongitude, longitude, beforeAltitude, altitude, beforeHeading, heading, beforePitch, pitch, beforeRoll, roll) {
		$("#beforeLatitude").html(beforeLatitude);
		$("#afterLatitude").html(latitude);
		$("#beforeLongitude").html(beforeLongitude);
		$("#afterLongitude").html(longitude);
		$("#beforeAltitude").html(beforeAltitude);
		$("#afterAltitude").html(altitude);
		$("#beforeHeading").html(beforeHeading);
		$("#afterHeading").html(heading);
		$("#beforePitch").html(beforePitch);
		$("#afterPitch").html(pitch);
		$("#beforeRoll").html(beforeRoll);
		$("#afterRoll").html(roll);

		dataInfoAdjustLogDialog.dialog({title: dataName + " Change Request Log"}).dialog( "open" );
	}

	var warningFlag = true;
	function warning(status, dataAdjustLogId) {
		if(confirm("계속 진행 하시겠습니까?")) {
			if(warningFlag) {
				warningFlag = false;
				$('#status').val(status);
				var formData = $("#listForm").serialize();
				$.ajax({
					url: "/data-adjust-logs/status/" + dataAdjustLogId,
					type: "POST",
					data: formData,
					dataType: "json",
					headers: {"X-Requested-With": "XMLHttpRequest"},
					success: function(msg){
						if(msg.statusCode <= 200) {
							alert(JS_MESSAGE["update"]);
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.errorCode]);
							console.log("---- " + msg.message);
						}
						warningFlag = true;
					},
					error:function(request, status, error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				        warningFlag = true;
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
