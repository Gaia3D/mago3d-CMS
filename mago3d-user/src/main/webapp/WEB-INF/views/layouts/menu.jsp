<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<ul class="nav">
<c:forEach items="${cacheUserGroupMenuList}" var="userGroupMenu">
  	<li id="${userGroupMenu.htmlId}" class="${userGroupMenu.cssClass}" data-nav="${userGroupMenu.htmlContentId}" title="${userGroupMenu.name}">${userGroupMenu.name}</li>
</c:forEach>
</ul>
	