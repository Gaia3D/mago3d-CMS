<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 목록 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/json-viewer/json-viewer.css?cacheVersion=${contentCacheVersion}" />
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
							<form:form id="searchForm" modelAttribute="dataInfo" method="get" action="/data/list" onsubmit="return searchCheck();">
								<div class="input-group row">
									<div class="input-set">
										<label for="searchWord" class="hiddenTag">검색유형</label>
										<select id="searchWord" name="searchWord" class="selectBoxClass" title="검색유형">
											<option value=""><spring:message code='select'/></option>
						          			<option value="data_name">데이터 명</option>
						          			<option value="data_group_name">데이터 그룹명</option>
										</select>
										<label for="searchOption" class="hiddenTag">검색옵션</label>
										<form:select path="searchOption" class="select" style="height: 30px;">
											<form:option value="0"><spring:message code='search.same'/></form:option>
											<form:option value="1"><spring:message code='search.include'/></form:option>
										</form:select>
										<label for="searchValue"><spring:message code='search.word'/></label>
										<form:input path="searchValue" type="search" cssClass="m" cssStyle="float: right;" />
									</div>
									<div class="input-set">
										<label for="startDate"><spring:message code='search.date'/></label>
										<input type="text" class="s date" id="startDate" name="startDate" title="시작일" autocomplete="off" />
										<span class="delimeter tilde">~</span>
										<label for="endDate" class="hiddenTag">종료일</label>
										<input type="text" class="s date" id="endDate" name="endDate" title="종료일" autocomplete="off" />
									</div>
									<div class="input-set">
										<label for="orderWord"><spring:message code='search.order'/></label>
										<select id="orderWord" name="orderWord" class="selectBoxClass" title="표시기준">
											<option value=""> <spring:message code='search.basic'/> </option>
											<option value="data_name">데이터 명</option>
						          			<option value="data_group_name">데이터 그룹명</option>
											<option value="insert_date"> <spring:message code='search.insert.date'/> </option>
										</select>
										<label for="orderValue" class="hiddenTag">정렬기준</label>
										<select id="orderValue" name="orderValue" class="selectBoxClass" title="정렬기준">
					                		<option value=""> <spring:message code='search.basic'/> </option>
						                	<option value="ASC"> <spring:message code='search.ascending'/> </option>
											<option value="DESC"> <spring:message code='search.descending.order'/> </option>
										</select>
										<label for="listCounter" class="hiddenTag">리스트건수</label>
										<form:select path="listCounter" class="select" style="height: 30px;" title="리스트건수">
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
								<label for="checkIds" class="hiddenTag"></label>
								<input type="hidden" id="checkIds" name="checkIds" value="" />
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<spring:message code='all.d'/> <em><fmt:formatNumber value="${pagination.totalCount}" type="number"/></em><spring:message code='search.what.count'/>
									<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> <spring:message code='search.page'/>
								</div>
								<div class="list-functions u-pull-right">
									<div class="button-group">
										<a href="#" onclick="uploadDataFile(); return false;" class="button">데이터 일괄 업로딩</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col" summary="데이터 리스트 트리">
							<caption class="hiddenTag">데이터 목록</caption>
								<col class="col-checkbox" />
								<col class="col-number" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<thead>
									<tr>
										<th scope="col" class="col-checkbox"><label for="chkAll" class="hiddenTag">전체선택 체크박스</label><input type="checkbox" id="chkAll" name="chkAll" /></th>
										<th scope="col" class="col-number"><spring:message code='number'/></th>
										<th scope="col" class="col-name">그룹명</th>
										<th scope="col" class="col-name">데이터명</th>
										<th scope="col" class="col-name">아이디</th>
										<th scope="col" class="col-name">데이터타입</th>
										<th scope="col" class="col-name">공유유형</th>
										<th scope="col" class="col-name">상태</th>
										<th scope="col" class="col-name">지도</th>
										<th scope="col" class="col-name">메타정보</th>
										<th scope="col" class="col-name">속성</th>
										<th scope="col" class="col-name">오브젝트 속성</th>
										<th scope="col" class="col-name">삭제</th>
										<th scope="col" class="col-date">등록일</th>
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
											<label for="dataId_${dataInfo.dataId}" class="hiddenTag">선택 체크박스</label>
											<input type="checkbox" id="dataId_${dataInfo.dataId}" name="dataId" value="${dataInfo.dataId}" />
										</td>
										<td class="col-number">${pagination.rowNumber - status.index }</td>
										<td class="col-name ellipsis" style="max-width:200px;">
											<a href="#" class="view-group-detail" onclick="detailDataGroup('${dataInfo.dataGroupId }'); return false;">${dataInfo.dataGroupName }</a></td>
										<td class="col-name">
											<a href="/data/modify?dataId=${dataInfo.dataId }&amp;pageNo=${pagination.pageNo }${pagination.searchParameters}">
											${dataInfo.dataName }</a>
										</td>
										<td class="col-name">${dataInfo.userId }</td>
										<td class="col-name">${dataInfo.dataType }</td>
										<td class="col-type">
			<c:if test="${dataInfo.sharing eq 'common'}">공통</c:if>
			<c:if test="${dataInfo.sharing eq 'public'}">공개</c:if>
			<c:if test="${dataInfo.sharing eq 'private'}">개인</c:if>
			<c:if test="${dataInfo.sharing eq 'group'}">그룹</c:if>
										</td>
										<td class="col-type">
			<c:if test="${dataInfo.status eq 'processing' }">
											변환중
			</c:if>
			<c:if test="${dataInfo.status eq 'use' }">
											사용중
			</c:if>
			<c:if test="${dataInfo.status eq 'unused' }">
											사용중지
			</c:if>
			<c:if test="${dataInfo.status eq 'delete' }">
											삭제
			</c:if>
							</td>
										<td class="col-type">
											<a href="#" onclick="viewDataInfo('${dataInfo.dataId}'); return false;">보기</a>
										</td>
										<td class="col-type">
											<a href="#" onclick="detailMetainfo('${dataInfo.dataId }'); return false;">보기</a>
										</td>
										<td class="col-functions">
			<c:if test="${dataInfo.attributeExist eq 'true' }">
												<a href="#" onclick="detailDataAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">보기</a>&nbsp;&nbsp;
			</c:if>
												<a href="#" onclick="uploadDataAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">
													<spring:message code='modified'/></a>
										</td>
										<td class="col-functions">
			<c:if test="${dataInfo.objectAttributeExist eq 'true' }">
												<a href="#" onclick="detailDataObjectAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">보기</a>&nbsp;&nbsp;
			</c:if>
												<a href="#" onclick="uploadDataObjectAttribute('${dataInfo.dataId }', '${dataInfo.dataName }'); return false;">
													<spring:message code='modified'/></a>
										</td>
										<td class="col-functions">
											<a href="/data/delete?dataId=${dataInfo.dataId }" onclick="return deleteWarning();"
												class="image-button button-delete"><spring:message code='delete'/></a>
										</td>
										<td class="col-type">
											<fmt:parseDate value="${dataInfo.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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
<%@ include file="/WEB-INF/views/data/data-file-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-metainfo-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-object-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-attribute-file-dialog.jsp" %>
<%@ include file="/WEB-INF/views/data/data-object-attribute-file-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.form.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/handlebars-4.1.2/handlebars.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/json-viewer/json-viewer.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/handlebarsHelper.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var searchWord = "${dataInfo.searchWord}";
		var searchOption = "${dataInfo.searchOption}";
		var orderWord = "${dataInfo.orderWord}";
		var orderValue = "${dataInfo.orderValue}";
		var listCounter = "${dataInfo.listCounter}";

		if(searchWord != "") $("#searchWord").val("${dataInfo.searchWord}");
		if(searchOption != "") $("#searchOption").val("${dataInfo.searchOption}");
		if(orderWord != "") $("#orderWord").val("${dataInfo.orderWord}");
		if(orderValue != "") $("#orderValue").val("${dataInfo.orderValue}");
		if(listCounter != "") $("#listCounter").val("${dataInfo.listCounter}");

		initDatePicker();
		initCalendar(new Array("startDate", "endDate"), new Array("${dataInfo.startDate}", "${dataInfo.endDate}"));
	});

	// 전체 선택
	$("#chkAll").click(function() {
		$(":checkbox[name=dataId]").prop("checked", this.checked);
	});

	// 데이터 그룹 정보
	function detailDataGroup(dataGroupId) {
		dataGroupDialog.dialog( "open" );

		$.ajax({
			url: "/data-groups/" + dataGroupId,
			//data: { "dataGroupId" : dataGroupId },
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					var sharing = msg.dataGroup.sharing;
					if(sharing == "common") {
						sharing = "공통";
					} else if(sharing == "public") {
						sharing = "공개";
					} else if(sharing == "private") {
						sharing = "비공개";
					} else if(sharing == "group") {
						sharing = "그룹";
					}

					$("#dataGroupNameInfo").html(msg.dataGroup.dataGroupName);
					$("#dataGroupKeyInfo").html(msg.dataGroup.dataGroupKey);
					$("#dataGroupTargetInfo").html(msg.dataGroup.dataGroupTarget);
					$("#sharingInfo").html(sharing);
					$("#userIdInfo").html(msg.dataGroup.userId);
					$("#basicInfo").html(msg.dataGroup.basic ? '기본' : '선택');
					$("#availableInfo").html(msg.dataGroup.available ? '사용' : '미사용');
					$("#locationInfo").html(msg.dataGroup.longitude + " / " + msg.dataGroup.latitude);
					$("#dataCountInfo").html(msg.dataGroup.dataCount);
					$("#metainfoInfo").html(msg.dataGroup.metainfo);
					$("#descriptionInfo").html(msg.dataGroup.description);

				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 메타 정보
	function detailMetainfo(dataId) {
		dataMetainfoDialog.dialog( "open" );

		$.ajax({
			url: "/datas/" + dataId,
			//data: { dataId : dataId },
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					$("#dataMetainfo").html(msg.dataInfo.metainfo);
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 데이터 속성
	function detailDataAttribute(dataId, dataName) {
		dataAttributeDialog.dialog( "open" );
		$("#dataNameForAttribute").html(dataName);

		$.ajax({
			url: "/datas/attributes/" + dataId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataAttribute !== null) {
						//$("#dataAttributeForOrigin").html(msg.dataAttribute.attributes);
						$("#dataAttributeViewer").html("");
						var jsonViewer = new JSONViewer();
						document.querySelector("#dataAttributeViewer").appendChild(jsonViewer.getContainer());
						jsonViewer.showJSON(JSON.parse(msg.dataAttribute.attributes), -1, -1);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	// Data 일괄 등록
	function uploadDataFile() {
		uploadDataFileDialog.dialog( "open" );
		$("#dataFileName").val("");
 		$("#dataFileUploadLog > tbody:last").html("");
	}
	
	// Data 일괄 등록 닫기
	function popClose() {
		uploadDataFileDialog.dialog( "close" );
		location.reload();
	}
	
	// 일괄등록(파일)
	var dataFileUploadFlag = true;
	function uploadDataFileSave() {
		var fileName = $("#dataFileName").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#dataFileName").focus();
			return false;
		}
		
		if( fileName.lastIndexOf("xlsx") <=0 
				&& fileName.lastIndexOf("xls") <=0
				&& fileName.lastIndexOf("json") <=0 
				&& fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#dataFileName").focus();
			return false;
		}
		
		if(dataFileUploadFlag) {
			dataFileUploadFlag = false;
			$("#dataFileInfo").ajaxSubmit({
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						if(msg.parseErrorCount != 0 || msg.insertErrorCount != 0) {
							$("#dataFileName").val("");
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						
						var source = $("#templateDataFileUploadLog").html();
						var template = Handlebars.compile(source);
						var dataFileUploadHtml = template(msg);
						
						$("#dataFileUploadLog").html("");
		                $("#dataFileUploadLog").append(dataFileUploadHtml);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
	    			}
					dataFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// 데이터 속성 수정
	function uploadDataAttribute(dataId, dataName) {
		uploadDataAttributeDialog.dialog( "open" );
		$("#attributeFileName").val("");
		$("#dataAttributeUploadLog").html("");
		$("#attributeFileDataId").val(dataId);
		$("#attributeDataName").html(dataName);
	}

	// 데이터 속성 파일 upload
	var dataAttributeFileUploadFlag = true;
	function dataAttributeFileUpload() {
		var fileName = $("#attributeFileName").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#attributeFileName").focus();
			return false;
		}
		if( fileName.lastIndexOf("json") <=0 && fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#fileName").focus();
			return false;
		}

		if(dataAttributeFileUploadFlag) {
			dataAttributeFileUploadFlag = false;
			$("#dataAttributeInfo").ajaxSubmit({
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						if(msg.parseErrorCount != 0 || msg.insertErrorCount != 0) {
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						
						var source = $("#templateDataAttributeUploadLog").html();
						var template = Handlebars.compile(source);
						var dataAttributeUploadHtml = template(msg);
						
						$("#dataAttributeUploadLog").html("");
		                $("#dataAttributeUploadLog").append(dataAttributeUploadHtml);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
	    			}
					dataAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 데이터 Object 속성
	function detailDataObjectAttribute(dataId, dataName) {
		dataObjectAttributeDialog.dialog( "open" );
		$("#dataNameForObjectAttribute").html(dataName);

		$.ajax({
			url: "/datas/object/attributes/" + dataId,
			type: "GET",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.dataObjectAttribute !== null) {
						//$("#dataObjectAttributeForOrigin").html(msg.dataObjectAttribute.attributes);
						$("#dataObjectAttributeViewer").html("");
						var jsonViewer = new JSONViewer();
						document.querySelector("#dataObjectAttributeViewer").appendChild(jsonViewer.getContainer());
						jsonViewer.showJSON(JSON.parse(msg.dataObjectAttribute.attributes), -1, -1);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
				}
			},
			error:function(request,status,error){
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// Data Object Attribute 파일 수정
	function uploadDataObjectAttribute(dataId, dataName) {
		uploadDataObjectAttributeDialog.dialog( "open" );
		$("#objectAttributeFileName").val("");
		$("#dataObjectAttributeUploadLog").html("");
		$("#objectAttributeFileDataId").val(dataId);
		$("#objectAttributeDataName").html(dataName);
	}

	// Data Object 속성 파일 upload
	var dataObjectAttributeFileUploadFlag = true;
	function dataObjectAttributeFileUpload() {
		var fileName = $("#objectAttributeFileName").val();
		if(fileName === "") {
			alert(JS_MESSAGE["file.name.empty"]);
			$("#object_attribute_file_name").focus();
			return false;
		}

		if( fileName.lastIndexOf("json") <=0 && fileName.lastIndexOf("txt") <=0 ) {
			alert(JS_MESSAGE["file.ext.invalid"]);
			$("#file_name").focus();
			return false;
		}

		if(dataObjectAttributeFileUploadFlag) {
			dataObjectAttributeFileUploadFlag = false;
			$("#dataObjectAttributeInfo").ajaxSubmit({
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				dataType: "json",
				success: function(msg){
					if(msg.statusCode <= 200) {
						if(msg.parseErrorCount != 0 || msg.insertErrorCount != 0) {	
							alert(JS_MESSAGE["error.exist.in.processing"]);
						} else {
							alert(JS_MESSAGE["update"]);
						}
						
						var source = $("#templateDataObjectAttributeUploadLog").html();
						var template = Handlebars.compile(source);
						var dataObjectAttributeUploadHtml = template(msg);
						
						$("#dataObjectAttributeUploadLog").html("");
		                $("#dataObjectAttributeUploadLog").append(dataObjectAttributeUploadHtml);
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
	    			}
					dataObjectAttributeFileUploadFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
					dataObjectAttributeFileUploadFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

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

	// 데이터 그룹 정보
	var dataGroupDialog = $( ".dataGroupDialog" ).dialog({
		autoOpen: false,
		width: 800,
		height: 550,
		modal: true,
		resizable: false
	});
	// 데이터 metainfo 다이얼 로그
	var dataMetainfoDialog = $( ".dataMetainfoDialog" ).dialog({
		autoOpen: false,
		width: 500,
		height: 255,
		modal: true,
		resizable: false
	});
	// 데이터 속성 다이얼 로그
	var dataAttributeDialog = $( ".dataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 800,
		height: 550,
		modal: true,
		resizable: false
	});
	// 데이터 Object 속성 다이얼 로그
	var dataObjectAttributeDialog = $( ".dataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 800,
		height: 550,
		modal: true,
		resizable: false
	});
	
	// 데이터 일괄 등록 다이얼 로그
	var uploadDataFileDialog = $( ".uploadDataFileDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	
	// 데이터 속성 하나 등록 다이얼 로그
	var uploadDataAttributeDialog = $( ".uploadDataAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	// 데이터 Object 속성 하나 등록
	var uploadDataObjectAttributeDialog = $( ".uploadDataObjectAttributeDialog" ).dialog({
		autoOpen: false,
		width: 600,
		height: 445,
		modal: true,
		resizable: false,
		close: function() { location.reload(); }
	});
	
	// 지도에서 찾기 -- common.js, openFindDataPoint
	function viewDataInfo(dataId) {
		openFindDataPoint(dataId, "list");
	}
</script>
</body>
</html>
