<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 그룹 등록 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
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
						<form:form id="userGroup" modelAttribute="userGroup" method="post" onsubmit="return false;">
							<table class="input-table scope-row" summary="사용자  그룹 등록 테이블">
							<caption class="hiddenTag">사용자 그룹 등록</caption>
								<col class="col-label" />
								<col class="col-input" />
								<tr>
									<th class="col-label" scope="row">
										<form:label path="userGroupName"><spring:message code='user.group.name'/></form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:input path="userGroupName" cssClass="l" maxlength="100" />
										<form:errors path="userGroupName" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label" scope="row">
										<form:label path="userGroupKey">사용자 그룹 Key</form:label>
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input">
										<form:hidden path="duplicationValue"/>
										<form:input path="userGroupKey" cssClass="l" />
				  						<input type="button" id="userGroupDuplicationButton" value="<spring:message code='overlap.check'/>" />
										<form:errors path="userGroupKey" cssClass="error" />
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
										<input type="button" id="userGroupButtion" value="상위 사용자 그룹 선택" />
									</td>
								</tr>
				                <tr>
									<th class="col-label m" scope="row">
										기본 여부
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input radio-set">
										<form:radiobutton label="기본" path="basic" value="true" />
										<form:radiobutton label="선택" path="basic" value="false" checked="checked" />
										<form:errors path="basic" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row">
										사용 여부
										<span class="icon-glyph glyph-emark-dot color-warning"></span>
									</th>
									<td class="col-input radio-set">
										<form:radiobutton label="사용" path="available" value="true" checked="checked" />
										<form:radiobutton label="미사용" path="available" value="false" />
										<form:errors path="available" cssClass="error" />
									</td>
								</tr>
								<tr>
									<th class="col-label m" scope="row"><form:label path="description"><spring:message code='description'/></form:label></th>
									<td class="col-input"><form:input path="description" cssClass="xl" /></td>
								</tr>
							</table>
							<div class="button-group">
								<div class="center-buttons">
									<input type="submit" value="<spring:message code='save'/>" onclick="insertUserGroup();"/>
									<input type="submit" onClick="formClear(); return false;" value="초기화" />
									<a href="/user-group/list" class="button">목록</a>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	<%@ include file="/WEB-INF/views/user-group/dialog.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});

	function validate() {
		var number = /^[0-9]+$/;
		var exceptKorean = /^[a-zA-Z0-9]*$/;
		if ($("#userGroupName").val() === null || $("#userGroupName").val() === "") {
			alert("사용자 그룹명을 입력해 주세요.");
			$("#userGroupName").focus();
			return false;
		}
		if ($("#userGroupKey").val() === null || $("#userGroupKey").val() === "") {
			alert("사용자 그룹 Key(한글불가)을 입력해 주세요.");
			$("#userGroupKey").focus();
			return false;
		}
		if (!exceptKorean.test($("#userGroupKey").val())) {
			alert("사용자 그룹Key는 한글을 입력할 수 없습니다.");
			$("#userGroupKey").val("");
			$("#userGroupKey").focus();
			return false;
		}
		if($("#duplicationValue").val() == null || $("#duplicationValue").val() == "") {
			alert(JS_MESSAGE["group.key.duplication.check"]);
			return false;
		} else if($("#duplicationValue").val() == "1") {
			alert(JS_MESSAGE["group.key.duplication"]);
			return false;
		}
		if($("#parent").val() === null || $("#parent").val() === "" || !number.test($("#parent").val())) {
			alert("상위 사용자 그룹을 선택해 주세요.");
			$("#parent").focus();
			return false;
		}
	}

	// 입력값이 변경되면 중복체크, 영문+숫자
	$("#userGroupKey").on("keyup", function(event) {
		$("#duplicationValue").val(null);
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputValue = $(this).val();
			$(this).val(inputValue.replace(/[^a-z0-9]/gi,''));
		}
	});

	// 그룹Key 중복 확인
 	$("#userGroupDuplicationButton").on("click", function() {
		var userGroupKey = $("#userGroupKey").val();
		if (userGroupKey == "") {
			alert(JS_MESSAGE["group.key.empty"]);
			$("#userGroupKey").focus();
			return false;
		}
		$.ajax({
			url: "/user-groups/duplication",
			type: "GET",
			data: {"userGroupKey": userGroupKey},
			headers: {"X-Requested-With": "XMLHttpRequest"},
			dataType: "json",
			success: function(msg){
				if(msg.statusCode <= 200) {
					if(msg.duplication == true) {
						alert(JS_MESSAGE["group.key.duplication"]);
						$("#userGroupKey").focus();
						return false;
					} else {
						alert(JS_MESSAGE["group.key.enable"]);
						$("#duplicationValue").val(msg.duplication);
					}
				} else {
					alert(JS_MESSAGE[msg.errorCode]);
					console.log("---- " + msg.message);
				}
			},
			error:function(request, status, error) {
				//alert(JS_MESSAGE["ajax.error.message"]);
				alert(" code : " + request.status + "\n" + ", message : " + request.responseText + "\n" + ", error : " + error);
    		}
		});
	});

	// 저장
	var insertUserGroupFlag = true;
	function insertUserGroup() {
		if (validate() == false) {
			return false;
		}
		if(insertUserGroupFlag) {
			insertUserGroupFlag = false;
			var formData = $("#userGroup").serialize();
			$.ajax({
				url: "/user-groups/insert",
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
					insertUserGroupFlag = true;
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        insertUserGroupFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}

	var userGroupDialog = $("#userGroupListDialog").dialog({
		autoOpen: false,
		height: 600,
		width: 1200,
		modal: true,
		overflow : "auto",
		resizable: false
	});

	// 상위 User Group 찾기
	$( "#userGroupButtion" ).on( "click", function() {
		userGroupDialog.dialog( "open" );
		userGroupDialog.dialog( "option", "title", "사용자 그룹 선택");
	});

	// 상위 Node
	function confirmParent(parent, parentName) {
		$("#parent").val(parent);
		$("#parentName").val(parentName);
		userGroupDialog.dialog( "close" );
	}

	$( "#rootParentSelect" ).on( "click", function() {
		$("#parent").val(0);
		$("#parentName").val("${userGroup.parentName}");
		userGroupDialog.dialog( "close" );
	});

	// 지도에서 찾기
	$( "#mapButtion" ).on( "click", function() {
		var url = "/user/location-map";
		var width = 800;
		var height = 700;

        var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
                + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
        //popWin.document.title = layerName;
	});

	// 초기화
	function formClear() {
		$("#userGroupName").val("");
		$("#userGroupKey").val("");
		$("#parent").val(0);
		$("#parentName").val("${userGroup.parentName}");
		$("input:radio[name='basic']:radio[value='false']").prop('checked',true);
		$("input:radio[name='available']:radio[value='true']").prop('checked', true);
		$("#description").val("");
	};

</script>
</body>
</html>