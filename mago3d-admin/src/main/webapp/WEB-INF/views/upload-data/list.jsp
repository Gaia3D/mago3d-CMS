<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>업로딩 데이터 목록 | NDTP</title>
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
							<form:form id="searchForm" modelAttribute="uploadData" method="get" action="/upload-data/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색조건</label>
										<select id="searchWord" name="searchWord" title="검색조건" class="selectBoxClass">
											<option value=""><spring:message code='select'/></option>
		          							<option value="data_name">데이터명</option>
										</select>
										<label for="searchOption" class="hiddenTag">검색옵션</label>
										<form:select path="searchOption" title="검색옵션" class="select" style="height: 30px;">
											<form:option value="0"><spring:message code='search.same'/></form:option>
											<form:option value="1"><spring:message code='search.include'/></form:option>
										</form:select>
										<label for="searchValue"><spring:message code='search.word'/></label>
										<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
									</div>
									<div class="input-set">
										<label for="startDate"><spring:message code='search.date'/></label>
										<input type="text" id="startDate" name="startDate" class="s date" title="시작일" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" id="endDate" name="endDate" class="s date" title="종료일" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" class="selectBoxClass">
											<option value=""> <spring:message code='search.basic'/> </option>
											<option value="data_name">데이터명</option>
											<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" title="정렬기준" class="selectBoxClass">
					                		<option value=""> <spring:message code='search.basic'/> </option>
						                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
											<option value="DESC"> <spring:message code='search.descending.order'/> </option>
										</select>
										<label for="listCounter" class="hiddenTag">리스트 건수</label>
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
							<form:form id="listForm" modelAttribute="uploadData" method="post">
								<input type="hidden" id="checkIds" name="checkIds" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<div style="padding-bottom: 3px;" class="button-group">
										<a href="#" onclick="converterFiles(); return false;" class="button" title="F4D 일괄 변환">F4D 일괄 변환</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col" summary="업로드 목록 테이블">
							<caption class="hiddenTag">업로드 목록</caption>
								<col class="col-checkbox" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-number" />
								<col class="col-number" />
								<col class="col-number" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-checkbox"><label for="chkAll" class="hiddenTag">전체선택 체크박스</label><input type="checkbox" id="chkAll" name="chkAll" /></th>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-name">그룹명</th>
										<th scope="col" class="col-name">공유 유형</th>
										<th scope="col" class="col-name">데이터 타입</th>
										<th scope="col" class="col-name">데이터명</th>
										<th scope="col" class="col-name">3D파일/전체파일</th>
										<th scope="col" class="col-name">Converter 횟수</th>
										<th scope="col" class="col-functions">Converter</th>
										<th scope="col" class="col-functions">삭제</th>
										<th scope="col" class="col-date">등록일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty uploadDataList }">
									<tr>
										<td colspan="11" class="col-none">파일 업로딩 이력이 존재하지 않습니다.</td>
									</tr>
</c:if>
<c:if test="${!empty uploadDataList }">
	<c:forEach var="uploadData" items="${uploadDataList}" varStatus="status">

									<tr>
										<td class="col-checkbox">
											<label for="uploadDataId_${uploadData.uploadDataId}" class="hiddenTag">선택 체크박스</label>
											<input type="checkbox" id="uploadDataId_${uploadData.uploadDataId}" name="uploadDataId" value="${uploadData.uploadDataId}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index }</td>
										<td class="col-name ellipsis" style="max-width:150px;">${uploadData.dataGroupName }</td>
										<td class="col-type">
											<c:if test="${uploadData.sharing eq 'common' }">
												공통
											</c:if>
											<c:if test="${uploadData.sharing eq 'public' }">
												공개
											</c:if>
											<c:if test="${uploadData.sharing eq 'private' }">
												개인
											</c:if>
											<c:if test="${uploadData.sharing eq 'group' }">
												공유
											</c:if>
										</td>
										<td class="col-type">${uploadData.dataType }</td>
										<td class="col-name">
											<a href="/upload-data/modify?uploadDataId=${uploadData.uploadDataId }">
													${uploadData.dataName }
											</a>
										</td>
										<td class="col-count">
											<span style="color:blue; font-weight: bold;">
											<fmt:formatNumber value="${uploadData.converterTargetCount}" type="number"/>
											</span> /
											<fmt:formatNumber value="${uploadData.fileCount}" type="number"/> 개
										</td>
										<td class="col-count"><fmt:formatNumber value="${uploadData.converterCount}" type="number"/> 건</td>
										<td class="col-functions">
											<span class="button-group">
												<a href="#" onclick="converterFile('${uploadData.uploadDataId}', '${uploadData.dataName}', '${uploadData.dataType}'); return false;"
												   class="button" style="text-decoration: none;">
													F4D 변환
												</a>
											</span>
												</td>
												<td class="col-functions">
											<span class="button-group">
												<a href="#" onclick="deleteUploadData('${uploadData.uploadDataId }'); return false;"
												   class="image-button button-delete"><spring:message code='delete'/></a>
											</span>
										</td>
										<td class="col-type">
											<fmt:parseDate value="${uploadData.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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
	<%@ include file="/WEB-INF/views/upload-data/converter-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var searchWord = "${uploadData.searchWord}";
		var searchOption = "${uploadData.searchOption}";
		var orderWord = "${uploadData.orderWord}";
		var orderValue = "${uploadData.orderValue}";
		var listCounter = "${uploadData.listCounter}";

		if(searchWord != "") $("#searchWord").val("${uploadData.searchWord}");
		if(searchOption != "") $("#searchOption").val("${uploadData.searchOption}");
		if(orderWord != "") $("#orderWord").val("${uploadData.orderWord}");
		if(orderValue != "") $("#orderValue").val("${uploadData.orderValue}");
		if(listCounter != "") $("#listCounter").val("${uploadData.listCounter}");

		initDatePicker();
		initCalendar(new Array("startDate", "endDate"), new Array("${uploadData.startDate}", "${uploadData.endDate}"));
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

	//전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=uploadDataId]").prop("checked", this.checked);
	});

	var dialogConverterJob = $( ".dialogConverterJob" ).dialog({
		autoOpen: false,
		/* height: 315, */
		width: 600,
		modal: true,
		resizable: false,
		close: function() {
			$("#converterCheckIds").val("");
			$("#title").val("");
			//location.reload();
		}
	});

	// F4D Converter Button Click
	function converterFile(uploadDataId, dataName, dataType) {
		$("#dataType").val(dataType);
		$("#converterCheckIds").val(uploadDataId + ",");
		$("#title").val(dataName);
		// 여기서 확장자가 las면 template 을 포인트 클라우트 클릭하게
		if(dataType === "las") {
			$("#converterTemplate").val("point-cloud");
		} else {
			$("#converterTemplate").val("basic");
		}
		
		dialogConverterJob.dialog( "open" );
	}

	// All F4D Converter Button Click
	function converterFiles() {
		var checkedValue = "";
		$("input:checkbox[name=uploadDataId]:checked").each(function(index) {
			checkedValue += $(this).val() + ",";
		});
		if(checkedValue === "") {
			alert("파일을 선택해 주십시오.");
			return;
		}
		$("#dataType").val("");
		$("#converterCheckIds").val(checkedValue);

		dialogConverterJob.dialog( "open" );
	}

	// F4D Converter 일괄 변환
	var saveConverterJobFlag = true;
	function saveConverterJob() {
		if($("#title").val() === null || $("#title").val() === "") {
			alert("제목을 입력하여 주십시오.");
			$("#title").focus();
			return false;
		}
		
		if($("#dataType").val() === "las") {
			// 여기서 확장자가 las면 template 을 포인트 클라우트 클릭하게
			if($("#converterTemplate").val() != "point-cloud") {
				alert("LAS 데이터의 경우 변환 템플릿을 Point Cloud 로 선택하여 주십시오.");
				$("#converterTemplate").focus();
				return false;
			}
		}
		
		if(saveConverterJobFlag) {
			saveConverterJobFlag = false;
			var formData =$("#converterJobForm").serialize();
			$.ajax({
				url: "/converters",
				type: "POST",
				data: formData,
				dataType: "json",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
					}

					$("#converterCheckIds").val("");
					$("#title").val("");
					$(":checkbox[name=uploadDataId]").prop("checked", false);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dialogConverterJob.dialog( "close" );
					saveConverterJobFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	var deleteUploadDataFlag = true;
	function deleteUploadData(uploadDataId) {
		if(confirm(JS_MESSAGE["delete.confirm"])) {
			if(deleteUploadDataFlag) {
				deleteUploadDataFlag = false;
				$.ajax({
					url: "/upload-datas/" + uploadDataId,
					type: "DELETE",
					//data: formData,
					dataType: "json",
					headers: {"X-Requested-With": "XMLHttpRequest"},
					success: function(msg){
						if(msg.statusCode <= 200) {
							alert(JS_MESSAGE["delete"]);
							location.reload();
						} else {
							alert(JS_MESSAGE[msg.errorCode]);
						}
						deleteDatasFlag = true;
					},
					error:function(request,status,error){
				        alert(JS_MESSAGE["ajax.error.message"]);
				        deleteDatasFlag = true;
					}
				});
			} else {
				alert(JS_MESSAGE["button.dobule.click"]);
				return;
			}
		}
	}

	$('#yAxisUp').change(function() {
		var desc = $(this).siblings('span');
		var value = $(this).val();
		if (value === 'Y') {
			desc.text('Y축이 건물의 천장을 향하는 경우');
		} else if (value === 'N') {
			desc.text('Z축이 건물의 천장을 향하는 경우');
		}
	});
</script>
</body>
</html>
