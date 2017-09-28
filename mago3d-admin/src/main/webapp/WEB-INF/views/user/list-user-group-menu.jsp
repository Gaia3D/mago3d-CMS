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
		          	<li class="s_title"><a href="/user/list-user.do"><spring:message code='user.group.user'/></a></li>
		          	<li class="next_img"></li>
			        <li class="s_title"><spring:message code='user.user.list.information'/></li>
		        </ul>
		    </div>
		    
			<div id="main_content">
				<div class="main_content_title">
			    	<ul>
			        	<li><spring:message code='user.group.usergroup'/></li>
			        </ul>
			    </div>
				<div id="list_area">
					<table class="list_table">
						<caption><spring:message code='user.group.usergroup'/></caption>
						<colgroup>
							<col width="20%" />
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><spring:message code='user.group.menu.name'/></th>
								<th scope="col"><spring:message code='user.list.use.not'/></th>
								<th scope="col"><spring:message code='user.list.all.authority'/></th>
								<th scope="col"><spring:message code='user.list.solo.authority'/></th>
		 					</tr>
						</thead>
						<tbody>
		<c:if test="${empty userGroupMenuList }">
							<tr>
								<td colspan="4"><spring:message code='user.list.menu.not.authority'/></td>
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
				<c:if test="${userGroupMenu.all_yn == 'Y'}">O</c:if>
				<c:if test="${null eq userGroupMenu.all_yn || userGroupMenu.all_yn == 'N'}">X</c:if>
								</td>
								<td style="padding-left:20px; text-align: left;">
									읽기(
				<c:if test="${userGroupMenu.read_yn == 'Y'}">O</c:if>
				<c:if test="${null eq userGroupMenu.read_yn || userGroupMenu.read_yn == 'N'}">X</c:if>
									) &nbsp;&nbsp;&nbsp;
									쓰기(
				<c:if test="${userGroupMenu.write_yn == 'Y'}">O</c:if>
				<c:if test="${null eq userGroupMenu.write_yn || userGroupMenu.write_yn == 'N'}">X</c:if>
									) &nbsp;&nbsp;&nbsp;
									수정(
				<c:if test="${userGroupMenu.update_yn == 'Y'}">O</c:if>
				<c:if test="${null eq userGroupMenu.update_yn || userGroupMenu.update_yn == 'N'}">X</c:if>
									) &nbsp;&nbsp;&nbsp;
									삭제(
				<c:if test="${userGroupMenu.delete_yn == 'Y'}">O</c:if>
				<c:if test="${null eq userGroupMenu.delete_yn || userGroupMenu.delete_yn == 'N'}">X</c:if>
									)
								</td>
							</tr>
			</c:forEach>
		</c:if>
							<tr style="line-height: 40px;">
					  			<td colspan="4" style="text-align: center;">
					  				<a href="/user/modify-user-group-menu.do?user_group_id=${userGroup.user_group_id }" class="buttonPro purple">메뉴권한 수정</a>
					  				<a href="/user/list-user-group.do" class="buttonPro purple"><spring:message code='user.list.group.list'/></a>
					  			</td>
					  		</tr>
						</tbody>
					</table>
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

	function toggleMenu(menu_id) {
		$(".toggle_menu_" + menu_id).toggle();
	}
</script>
</body>
</html>