<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>시민참여 등록 | mago3D</title>
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
						<div class="input-header row">
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="civilVoice" modelAttribute="civilVoice" method="post" onsubmit="return false;">
							<table class="input-table scope-row" summary="시민 참여 등록 테이블">
							<caption class="hiddenTag">시민  참여 등록</caption>
								<col class="col-label l" />
								<col class="col-input" />
								<tr>
									<th class="col-label" scope="row">
										<form:label path="title">제목</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="title" cssClass="l" />
										<form:errors path="title" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="longitude">위치</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="longitude" cssClass="m" />
										<form:label path="latitude" class="hiddenTag">위치(latitude)</form:label>
										<form:input path="latitude" cssClass="m" />
										<input type="button" id="mapButtion" value="위치 지정" />
										<form:errors path="longitude" cssClass="error" />
										<form:errors path="latitude" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="contents">내용</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:textarea path="contents" cols="10" rows="10"></form:textarea>
										<form:errors path="contents" cssClass="error" />
									</td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<input type="submit" value="<spring:message code='save'/>" onclick="insertCivilCVoice();"/>
									<a href="/civil-voice/list" class="button">목록</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

	<%@ include file="/WEB-INF/views/data-group/parent-data-group-dialog.jsp" %>

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
		if (!$("#title").val()) {
			alert("제목을 입력해 주세요.");
			$("#title").focus();
			return false;
		}
		if(!$('[name=longitude]').val() || !$('[name=latitude]').val()) {
			alert("위치를 지정하여 주십시오.");
			$('[name=longitude]').focus();
			return false;
		}
		if(!$("#contents").val()) {
			alert("내용을 입력해 주세요.");
			$("#contents").focus();
			return false;
		}
		return true;
	}

	// 저장
	var insertCivilCVoiceFlag = true;
	function insertCivilCVoice() {
		if (!validate()) {
			return false;
		}
		if(insertCivilCVoiceFlag) {
			insertCivilCVoiceFlag = false;
			var formData = $("#civilVoice").serialize();
			$.ajax({
				url: "/civil-voices",
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
					insertCivilCVoiceFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertCivilCVoiceFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/map/find-point";
		var width = 800;
		var height = 700;

		var popupX = (window.screen.width / 2) - (width / 2);
		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (height / 2);

	    var popWin = window.open(url, "","toolbar=no,width=" + width + ",height=" + height + ",top=" + popupY + ",left="+popupX
	            + ",directories=no,status=yes,scrollbars=no,menubar=no,location=no");
	    //popWin.document.title = layerName;
	});

</script>
</body>
</html>