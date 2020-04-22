<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 그룹 메뉴 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
    <style type="text/css">
    	.title {
			font-size: 15px;
			font-weight: bold;
			color: black;
    	}
    </style>
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
							<form:form id="userGroupMenu" modelAttribute="userGroupMenu" method="post" onsubmit="return false;">
								<input type="hidden" id="allYn" name="allYn" value="" />
								<input type="hidden" id="readYn" name="readYn" value="" />
								<input type="hidden" id="writeYn" name="writeYn" value="" />
								<input type="hidden" id="updateYn" name="updateYn" value="" />
								<input type="hidden" id="deleteYn" name="deleteYn" value="" />
								<div class="">
							    	<div style="float: left; padding: 5px; width: 100%;">
										<div style="float: left; width: 50%; ">
											사용자 그룹명: <span class="title">${userGroup.userGroupName }</span>
										</div>
									</div>
									<table class="list-table scope-col">
										<thead>
											<tr>
												<th scope="col">메뉴명</th>
												<th scope="col">전체 권한 (
													<input type="checkbox" id="menuGrantAll" name="menuGrantAll" value="Y" onclick="checkMenuGrantAll();" />
													<label for="menuGrantAll">일괄 부여</label> )
												</th>
												<th scope="col">개별 권한</th>
												<th scope="col">메뉴 타입</th>
												<th scope="col">URL</th>
												<th scope="col">HTML ID</th>
											</tr>
										</thead>
										<c:if test="${empty menuList }">
											<tr>
												<td colspan="6" class="col-none">메뉴가 존재하지 않습니다.</td>
											</tr>
										</c:if>
										<c:if test="${!empty menuList }">
											<c:forEach var="menu" items="${menuList}" varStatus="status">
												<c:set var="rootMenuClass" value="" />
												<c:if test="${menu.depth == 0 }">
													<c:set var="menuPadding" value="15px;" />
													<c:set var="toggleClass" value="background: #ededed;" />
													<c:set var="toggleLink" value="" />
												</c:if>
												<c:if test="${menu.depth == 1 }">
													<c:set var="menuPadding" value="15px;" />
													<c:set var="toggleClass" value="" />
													<c:set var="toggleLink" value="+" />
												</c:if>
												<c:if test="${menu.depth == 2 }">
													<c:set var="menuPadding" value="45px;" />
													<c:set var="toggleClass" value="" />
													<c:set var="toggleLink" value="" />
												</c:if>
												<tr style="${toggleClass}">
													<td class="col-name" style="text-align: left; padding-left:${menuPadding};">
														${toggleLink } ${menu.name }
													</td>

													<td style="text-align: center;">
														<c:if test="${menu.depth > 0 }">
															<input type="checkbox" id="menuAllYn${menu.menuId }" name="menuAllYn" value="${menu.menuId }_${menu.allYn }"
																class="all_yn" onclick="checkAllYn('${menu.menuId }');" />
															<label for="menuAllYn${menu.menuId }">권한 있음</label>&nbsp;&nbsp;
														</c:if>
													</td>
													<td style="padding-left:20px; text-align: left;">
														<c:if test="${menu.depth > 0 }">
														<input type="checkbox" id="menuReadYn${menu.menuId }" name="menuReadYn" value="${menu.menuId }_${menu.readYn }"
																onclick="checkReadYn('${menu.menuId }');" />
															<label for="menuReadYn${menu.menuId }">읽기</label>&nbsp;&nbsp;
															<input type="checkbox" id="menuWriteYn${menu.menuId }" name="menuWriteYn" value="${menu.menuId }_${menu.writeYn }"
																onclick="checkWriteYn('${menu.menuId }');" />
															<label for="menuWriteYn${menu.menuId }">쓰기</label>&nbsp;&nbsp;
															<input type="checkbox" id="menuUpdateYn${menu.menuId }" name="menuUpdateYn" value="${menu.menuId }_${menu.updateYn }"
																onclick="checkUpdateYn('${menu.menuId }');" />
															<label for="menuUpdateYn${menu.menuId }">수정</label>&nbsp;&nbsp;
															<input type="checkbox" id="menuDeleteYn${menu.menuId }" name="menuDeleteYn" value="${menu.menuId }_${menu.deleteYn }"
																onclick="checkDeleteYn('${menu.menuId }');" />
															<label for="menuDeleteYn${menu.menuId }">삭제</label>&nbsp;&nbsp;
														</c:if>
													</td>
													<td class="col-name">
														<c:if test="${menu.menuType eq '0' }">URL</c:if>
														<c:if test="${menu.menuType eq '1' }">HTML ID</c:if>
													</td>
													<td class="col-name" style="text-align: left;">${menu.url }</td>
													<td class="col-name" style="text-align: left;">${menu.htmlId }</td>
												</tr>
											</c:forEach>
										</c:if>
									</table>
								</div>
								<div class="button-group">
									<div class="center-buttons">
										<input type="submit" value="<spring:message code='save'/>" onclick="update();"/>
										<a href="/user-group/list" class="button">목록</a>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#allYn").val(null);
		$("#readYn").val(null);
		$("#writeYn").val(null);
		$("#updateYn").val(null);
		$("#deleteYn").val(null);
		var userGroupMenuJson = JSON.parse('${userGroupMenuJson}');
		for(var i=0; i<userGroupMenuJson.length; i++) {
			var userGroupMenu = userGroupMenuJson[i];
			var menuId = userGroupMenu.menuId;

			if(userGroupMenu.allYn === "Y") {
				$("input:checkbox[id='menuAllYn" + menuId + "']").prop("checked", true);
				checkAllYn(menuId);
			}
			if(userGroupMenu.readYn === "Y") {
				$("input:checkbox[id='menuReadYn" + menuId + "']").prop("checked", true);
				checkReadYn(menuId);
			}
			if(userGroupMenu.writeYn === "Y") {
				$("input:checkbox[id='menuWriteYn" + menuId + "']").prop("checked", true);
				checkWriteYn(menuId);
			}
			if(userGroupMenu.updateYn === "Y") {
				$("input:checkbox[id='menuUpdateYn" + menuId + "']").prop("checked", true);
				checkUpdateYn(menuId);
			}
			if(userGroupMenu.deleteYn === "Y") {
				$("input:checkbox[id='menuDeleteYn" + menuId + "']").prop("checked", true);
				checkDeleteYn(menuId);
			}
		}
	});

	// 전체 권한 일괄 부여
	function checkMenuGrantAll() {
		var value = "";
		if($("input:checkbox[id=menuGrantAll]").is(":checked") == true ) {
			$("input:checkbox[name=menuAllYn]").each(function() {
				this.checked = true;
				var checkValue = $(this).val();
				var values = checkValue.split("_");
				$(this).val(values[0] + "_Y");
			});
		} else {
			$("input:checkbox[name=menuAllYn]").each(function() {
				this.checked = false;
				var checkValue = $(this).val();
				var values = checkValue.split("_");
				$(this).val(values[0] + "_N");
			});
		}
	}

	// 전체 권한 개별 클릭
	function checkAllYn(menuId) {
		if($("input:checkbox[id=menuAllYn" + menuId + "]").is(":checked") == true ) {
			$("input:checkbox[id=menuAllYn" + menuId + "]").val(menuId + "_Y");
		} else {
			$("input:checkbox[id=menuAllYn" + menuId + "]").val(menuId + "_N");
		}
	}

	// 읽기 권한
	function checkReadYn(menuId) {
		if($("input:checkbox[id=menuReadYn" + menuId + "]").is(":checked") == true ) {
			$("input:checkbox[id=menuReadYn" + menuId + "]").val(menuId + "_Y");
		} else {
			$("input:checkbox[id=menuReadYn" + menuId + "]").val(menuId + "_N");
		}
	}

	// 쓰기 권한
	function checkWriteYn(menuId) {
		if($("input:checkbox[id=menuWriteYn" + menuId + "]").is(":checked") == true ) {
			$("input:checkbox[id=menuWriteYn" + menuId + "]").val(menuId + "_Y");
		} else {
			$("input:checkbox[id=menuWriteYn" + menuId + "]").val(menuId + "_N");
		}
	}

	// 수정 권한
	function checkUpdateYn(menuId) {
		if($("input:checkbox[id=menuUpdateYn" + menuId + "]").is(":checked") == true ) {
			$("input:checkbox[id=menuUpdateYn" + menuId + "]").val(menuId + "_Y");
		} else {
			$("input:checkbox[id=menuUpdateYn" + menuId + "]").val(menuId + "_N");
		}
	}

	// 삭제 권한
	function checkDeleteYn(menuId) {
		if($("input:checkbox[id=menuDeleteYn" + menuId + "]").is(":checked") == true ) {
			$("input:checkbox[id=menuDeleteYn" + menuId + "]").val(menuId + "_Y");
		} else {
			$("input:checkbox[id=menuDeleteYn" + menuId + "]").val(menuId + "_N");
		}
	}

	function check() {
		var allYn = $("#allYn").val();
		var readYn = $("#readYn").val();
		var writeYn = $("#writeYn").val();
		var updateYn = $("#updateYn").val();
		var deleteYn = $("#deleteYn").val();

		$("input:checkbox[name=menuAllYn]").each(function() {
			var checkValue = $(this).val();
			if(allYn == null || allYn == "") {
				allYn = checkValue;
			} else {
				allYn = allYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menuReadYn]").each(function() {
			var checkValue = $(this).val();
			if(readYn == null || readYn == "") {
				readYn = checkValue;
			} else {
				readYn = readYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menuWriteYn]").each(function() {
			var checkValue = $(this).val();
			if(writeYn == null || writeYn == "") {
				writeYn = checkValue;
			} else {
				writeYn = writeYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menuUpdateYn]").each(function() {
			var checkValue = $(this).val();
			if(updateYn == null || updateYn == "") {
				updateYn = checkValue;
			} else {
				updateYn = updateYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menuDeleteYn]").each(function() {
			var checkValue = $(this).val();
			if(deleteYn == null || deleteYn == "") {
				deleteYn = checkValue;
			} else {
				deleteYn = deleteYn + "," + checkValue;
			}
		});

		$("#allYn").val(allYn);
		$("#readYn").val(readYn);
		$("#writeYn").val(writeYn);
		$("#updateYn").val(updateYn);
		$("#deleteYn").val(deleteYn);
	}

	var updateUserGroupMenuFlag = true;
	function update() {
		if(updateUserGroupMenuFlag) {
			updateUserGroupMenuFlag = false;

			check();

			$.ajax({
				url: "/user-groups/menu",
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
				data: $("#userGroupMenu").serialize()+ "&userGroupId=${userGroup.userGroupId}",
				dataType: "json",
				success: function(msg) {
					if(msg.statusCode <= 200) {
    					alert(JS_MESSAGE["update"]);
    					window.location.reload();
    					updateUserGroupMenuFlag = true;
    				} else {
						alert(JS_MESSAGE[msg.errorCode]);
    					console.log("---- " + msg.message);
    					updateUserGroupMenuFlag = true;
    				}
				},
		        error: function(request, status, error) {
		        	alert(JS_MESSAGE["ajax.error.message"]);
		        	updateUserGroupMenuFlag = true;
		        }
			});
		} else {
			alert("진행 중입니다.");
			return;
		}
	}
</script>
</body>
</html>