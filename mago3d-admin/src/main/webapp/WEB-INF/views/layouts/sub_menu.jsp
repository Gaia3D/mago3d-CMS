<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="local-navigation">
	<div class="nav-header">
		<h2 class="nav-title">
			<span class="ko">${parentMenu.name }</span>
			<span class="en">${parentMenu.name_en }</span>
		</h2>
	</div>
	
	<ul>
<c:forEach var="userGroupMenu" items="${cacheUserGroupMenuList }" varStatus="status">
	<c:if test="${userGroupMenu.depth eq 2 and userGroupMenu.display_yn eq 'Y' and userGroupMenu.parent eq parentMenu.menu_id }">
		<c:if test="${userGroupMenu.menu_id eq clickMenuId }">
		<li class="current-page"><a href="${userGroupMenu.url }">${userGroupMenu.name }</a></li>
		</c:if>
		<c:if test="${userGroupMenu.menu_id ne clickMenuId }">
		<li><a href="${userGroupMenu.url }">${userGroupMenu.name }</a></li>
		</c:if>
	</c:if>
</c:forEach>
	</ul>
</div>