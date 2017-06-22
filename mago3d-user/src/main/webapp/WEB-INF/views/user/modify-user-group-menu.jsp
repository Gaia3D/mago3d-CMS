<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link type="text/css" rel="stylesheet" href="/css/${lang}/layout.css" />
	<link type="text/css" rel="stylesheet" href="/css/${lang}/common.css" />
	<link type="text/css" rel="stylesheet" href="/css/${lang}/admin.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
</head>
<body>
<div id="wrapper">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="contents">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content">
			<div id="location">
				<ul>
					<li style="margin-right:12px;"><img src="/images/btn_menu_hiding.gif" /></li>
		          	<li class="s_title"><a href="/user/list-user.do">사용자</a></li>
		          	<li class="next_img"></li>
			        <li class="s_title">${userGroup.name } 메뉴 권한 수정</li>
		        </ul>
		    </div>
		    
			<div id="main_content">
				<div class="main_content_title">
			    	<ul>
			        	<li>사용자 그룹</li>
			        </ul>
			    </div>
				<div id="list_area">
					<form:form id="userGroup" modelAttribute="userGroup" method="post" action="/user/update-user-group-menu.do" onsubmit="return check();">
						<input type="hidden" id="user_group_id" name="user_group_id" value="${userGroup.user_group_id }" />
						<input type="hidden" id="all_yn" name="all_yn" value="" />
						<input type="hidden" id="read_yn" name="read_yn" value="" />
						<input type="hidden" id="write_yn" name="write_yn" value="" />
						<input type="hidden" id="update_yn" name="update_yn" value="" />
						<input type="hidden" id="delete_yn" name="delete_yn" value="" />
					<table class="list_table">
						<caption>사용자 그룹</caption>
						<colgroup>
							<col width="20%" />
							<col width="10%" />
							<col width="20%" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">메뉴명</th>
								<th scope="col">사용유무</th>
								<th scope="col">전체 권한 (
									<input type="checkbox" id="menu_grant_all" name="menu_grant_all" value="Y" onclick="checkMenuGrantAll();" />
									<label for="menu_grant_all">일괄 부여</label>
								</th>
								<th scope="col">개별 권한</th>
		 					</tr>
						</thead>
						<tbody>
		<c:if test="${empty userGroupMenuList }">
							<tr>
								<td colspan="4">사용자 그룹 메뉴 권한 목록이 존재하지 않습니다.</td>
							</tr>
		</c:if>
		<c:if test="${!empty userGroupMenuList }">
			<c:forEach var="userGroupMenu" items="${userGroupMenuList}" varStatus="status">
				<c:if test="${userGroupMenu.depth == 1 }"> 
					<c:set var="menuPadding" value="15px;" />
					<c:set var="toggleClass" value="" />
					<c:set var="toggleLink" value="+" />
				</c:if>
				<c:if test="${userGroupMenu.depth == 2 }"> 
					<c:set var="menuPadding" value="45px;" />
					<c:set var="toggleMenuParent" value="toggle_menu_${userGroupMenu.parent}" />
					<c:set var="toggleClass" value="toggle_menu ${toggleMenuParent}" />
					<c:set var="toggleLink" value="" />
				</c:if>
				<c:if test="${userGroupMenu.depth == 3 }"> 
					<c:set var="menuPadding" value="70px;" />
					<c:set var="toggleClass" value="toggle_menu ${toggleMenuParent}" />
					<c:set var="toggleLink" value="" />
				</c:if>
							<tr class="${toggleClass }">
			<c:if test="${userGroupMenu.depth == 1 }">
								<td style="padding-left:${menuPadding}; text-align: left;">
									<a href="#" onclick="toggleMenu('${userGroupMenu.menu_id}')">${toggleLink }</a> ${userGroupMenu.name }
								</td>
			</c:if>
			<c:if test="${userGroupMenu.depth > 1 }">
								<td style="padding-left:${menuPadding}; text-align: left;">
									${toggleLink } ${userGroupMenu.name }
								</td>
			</c:if>
								<td style="text-align: center;">${userGroupMenu.viewUseYn }</td>
								<td style="text-align: center;">
									<input type="checkbox" id="menu_all_yn_${userGroupMenu.menu_id }" name="menu_all_yn" value="${userGroupMenu.menu_id }_${userGroupMenu.all_yn }" 
										${userGroupMenu.checkedAllYn } class="all_yn" onclick="checkAllYn('${userGroupMenu.menu_id }');" />
									<label for="menu_all_yn_${userGroupMenu.menu_id }">권한 있음</label>&nbsp;&nbsp;
								</td>
								<td style="padding-left:20px; text-align: left;">
									<input type="checkbox" id="menu_read_yn_${userGroupMenu.menu_id }" name="menu_read_yn" value="${userGroupMenu.read_yn }" ${userGroupMenu.checkedReadYn } 
										onclick="checkReadYn('${userGroupMenu.menu_id }');" />
									<label for="menu_read_yn_${userGroupMenu.menu_id }">읽기</label>&nbsp;&nbsp;
									<input type="checkbox" id="menu_write_yn_${userGroupMenu.menu_id }" name="menu_write_yn" value="${userGroupMenu.write_yn }" ${userGroupMenu.checkedWriteYn } 
										onclick="checkWriteYn('${userGroupMenu.menu_id }');" />
									<label for="menu_write_yn_${userGroupMenu.menu_id }">쓰기</label>&nbsp;&nbsp;
									<input type="checkbox" id="menu_update_yn_${userGroupMenu.menu_id }" name="menu_update_yn" value="${userGroupMenu.update_yn }" ${userGroupMenu.checkedUpdateYn } 
										onclick="checkUpdateYn('${userGroupMenu.menu_id }');" />
									<label for="menu_update_yn_${userGroupMenu.menu_id }">수정</label>&nbsp;&nbsp;
									<input type="checkbox" id="menu_delete_yn_${userGroupMenu.menu_id }" name="menu_delete_yn" value="${userGroupMenu.delete_yn }" ${userGroupMenu.checkedDeleteYn } 
										onclick="checkDeleteYn('${userGroupMenu.menu_id }');" />
									<label for="menu_delete_yn_${userGroupMenu.menu_id }">삭제</label>&nbsp;&nbsp;
								</td>
							</tr>
			</c:forEach>
		</c:if>
							<tr style="line-height: 40px;">
					  			<td colspan="4" style="text-align: center;">
					  				<input type="submit" value="저장" class="buttonPro purple" />
					  				<a href="/user/list-user-group.do" class="buttonPro purple">그룹 목록</a>
					  			</td>
					  		</tr>
						</tbody>
					</table>
					</form:form>
				</div>				
			</div>
			<!-- main content 종료 -->
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$(".toggle_menu").toggle();
	});

	// 메뉴명 Toggle
	function toggleMenu(menu_id) {
		$(".toggle_menu_" + menu_id).toggle();
	}
	
	// 전체 권한 일괄 부여
	function checkMenuGrantAll() {
		var value = "";
		if($("input:checkbox[id=menu_grant_all]").is(":checked") == true ) {
			$("input:checkbox[name=menu_all_yn]").each(function() {
				this.checked = true;
				var checkValue = $(this).val();
				var values = checkValue.split("_");
				$(this).val(values[0] + "_Y");
			})
		} else {
			$("input:checkbox[name=menu_all_yn]").each(function() {
				this.checked = false;
				var checkValue = $(this).val();
				var values = checkValue.split("_");
				$(this).val(values[0] + "_N");
			})
		}
	}
	
	// 전체 권한 개별 클릭
	function checkAllYn(menu_id) {
		if($("input:checkbox[id=menu_all_yn_" + menu_id + "]").is(":checked") == true ) {
			$("input:checkbox[id=menu_all_yn_" + menu_id + "]").val(menu_id + "_Y");
		} else {
			$("input:checkbox[id=menu_all_yn_" + menu_id + "]").val(menu_id + "_N");
		}
	}
	
	// 읽기 권한
	function checkReadYn(menu_id) {
		if($("input:checkbox[id=menu_read_yn_" + menu_id + "]").is(":checked") == true ) {
			$("input:checkbox[id=menu_read_yn_" + menu_id + "]").val("Y");
		} else {
			$("input:checkbox[id=menu_read_yn_" + menu_id + "]").val("N");
		}
	}
	// 쓰기 권한
	function checkWriteYn(menu_id) {
		if($("input:checkbox[id=menu_write_yn_" + menu_id + "]").is(":checked") == true ) {
			$("input:checkbox[id=menu_write_yn_" + menu_id + "]").val("Y");
		} else {
			$("input:checkbox[id=menu_write_yn_" + menu_id + "]").val("N");
		}
	}
	// 수정 권한
	function checkUpdateYn(menu_id) {
		if($("input:checkbox[id=menu_update_yn_" + menu_id + "]").is(":checked") == true ) {
			$("input:checkbox[id=menu_update_yn_" + menu_id + "]").val("Y");
		} else {
			$("input:checkbox[id=menu_update_yn_" + menu_id + "]").val("N");
		}
	}
	// 삭제 권한
	function checkDeleteYn(menu_id) {
		if($("input:checkbox[id=menu_delete_yn_" + menu_id + "]").is(":checked") == true ) {
			$("input:checkbox[id=menu_delete_yn_" + menu_id + "]").val("Y");
		} else {
			$("input:checkbox[id=menu_delete_yn_" + menu_id + "]").val("N");
		}
	}
	
	function check() {
		var allYn = $("#all_yn").val();
		var readYn = $("#read_yn").val();
		var writeYn = $("#write_yn").val();
		var updateYn = $("#update_yn").val();
		var deleteYn = $("#delete_yn").val();
		
		$("input:checkbox[name=menu_all_yn]").each(function() {
			var checkValue = $(this).val();
			if(allYn == null || allYn == "") {
				allYn = checkValue;	
			} else {
				allYn = allYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menu_read_yn]").each(function() {
			var checkValue = $(this).val();
			if(readYn == null || readYn == "") {
				readYn = checkValue;	
			} else {
				readYn = readYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menu_write_yn]").each(function() {
			var checkValue = $(this).val();
			if(writeYn == null || writeYn == "") {
				writeYn = checkValue;	
			} else {
				writeYn = writeYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menu_update_yn]").each(function() {
			var checkValue = $(this).val();
			if(updateYn == null || updateYn == "") {
				updateYn = checkValue;	
			} else {
				updateYn = updateYn + "," + checkValue;
			}
		});
		$("input:checkbox[name=menu_delete_yn]").each(function() {
			var checkValue = $(this).val();
			if(deleteYn == null || deleteYn == "") {
				deleteYn = checkValue;	
			} else {
				deleteYn = deleteYn + "," + checkValue;
			}
		});
		
		$("#all_yn").val(allYn);
		$("#read_yn").val(readYn);
		$("#write_yn").val(writeYn);
		$("#update_yn").val(updateYn);
		$("#delete_yn").val(deleteYn);
	}
</script>
</body>
</html>