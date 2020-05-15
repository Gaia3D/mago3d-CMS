<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Layer 그룹 등록 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="layerGroup" modelAttribute="layerGroup" method="post" onsubmit="return false;">
							<table class="input-table scope-row" summary="2D 레이어 그룹 등록 테이블">
							<caption class="hiddenTag">2D 레이어 그룹 등록</caption>
								<col class="col-label l" />
								<col class="col-input" />
								<tr>
									<th class="col-label" scope="row">
										<form:label path="layerGroupName">Layer 그룹명</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="layerGroupName" cssClass="l" maxlength="256" />
										<form:errors path="layerGroupName" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="parentName">상위 그룹</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:hidden path="parent" />
			 							<form:input path="parentName" cssClass="l" readonly="true" />
										<input type="button" id="layerGroupButtion" value="상위 레이어 그룹 선택" />
									</td>
								</tr>
								<tr>
									<th class="col-label l" scope="row">
										<span>사용 여부</span>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input radio-set">
										<form:radiobutton label="사용" path="available" value="true" checked="checked" />
										<form:radiobutton label="미사용" path="available" value="false" />
										<form:errors path="available" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label l" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
									<td class="col-input">
										<form:input path="description" cssClass="xl" />
										<form:errors path="description" cssClass="error" />
									</td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<input type="submit" value="<spring:message code='save'/>" onclick="insertLayerGroup();"/>
									<input type="submit" onClick="formClear(); return false;" value="초기화" />
									<a href="/layer-group/list" class="button">목록</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

	<!-- Dialog -->
	<%@ include file="/WEB-INF/views/layer-group/layer-group-dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	function validate() {
		var number = /^[0-9]+$/;
		if ($("#layerGroupName").val() === null || $("#layerGroupName").val() === "") {
			alert("레이어 그룹명을 입력해 주세요.");
			$("#layerGroupName").focus();
			return false;
		}
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 레이어 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
	}

	// 저장
	var insertLayerGroupFlag = true;
	function insertLayerGroup() {
		if (validate() == false) {
			return false;
		}
		if(insertLayerGroupFlag) {
			insertLayerGroupFlag = false;
			var formData = $("#layerGroup").serialize();
			$.ajax({
				url: "/layer-groups/insert",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["insert"]);
						window.location.reload();
					} else {
						alert(JS_MESSAGE[msg.errorCode]);
						console.log("---- " + msg.message);
					}
					insertLayerGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertLayerGroupFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	var layerGroupDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 Layer Group 찾기
	$( "#layerGroupButtion" ).on( "click", function() {
		layerGroupDialog.dialog( "open" );
		layerGroupDialog.dialog( "option", "title", "레이어 그룹 선택");
	});

	// 다이얼로그에서 선택
	function confirmParent(parent, parentName, parentDepth) {
		if(parentDepth >= 3) {
			alert("레이어 그룹은 3Depth 이상 계층으로 입력할 수 없습니다.");
			return;
		}
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		layerGroupDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${layerGroup.parentName}");
		layerGroupDialog.dialog( "close" );
	});

	function formClear() {

	}

</script>
</body>
</html>