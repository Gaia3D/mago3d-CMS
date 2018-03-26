<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="page-header row">
	<h2 class="page-title u-pull-left">
		${menu.name }
	</h2>
	<div class="breadcrumbs u-pull-right">
		<a href="${parentMenu.url }">
			<span class="icon-glyph ${parentMenu.css_class }"></span>
			<span class="icon-text">${parentMenu.name }</span>
		</a>
<c:if test="${menu.display_yn =='Y'}">	
		<span class="delimeter">&gt;</span>
		<span class="icon-text">${menu.name }</span>
</c:if>
<c:if test="${menu.display_yn !='Y'}">	
		<span class="delimeter">&gt;</span>
		<a href="${menu.url_alias }">
			<span class="icon-text">${menu.alias_name }</span>
		</a>
		<span class="delimeter">&gt;</span>
		<span class="icon-text">${menu.name }</span>
</c:if>		
	</div>
</div>
