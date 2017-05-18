<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="page-header row">
	<h2 class="page-title u-pull-left">
<c:if test="${menu.alias_name ==null || menu.alias_name ==''}">	
		${menu.name }
</c:if>
<c:if test="${menu.alias_name !=null && menu.alias_name !=''}">	
		${menu.alias_name }
</c:if>
	</h2>
	<div class="breadcrumbs u-pull-right">
		<a href="${parentMenu.url }">
			<span class="icon-glyph ${parentMenu.css_class }"></span>
			<span class="icon-text">${parentMenu.name }</span>
		</a>
<c:if test="${menu.alias_name ==null || menu.alias_name ==''}">	
		<span class="delimeter">&gt;</span>
		<span class="icon-text">${menu.name }</span>
</c:if>
<c:if test="${menu.alias_name !=null && menu.alias_name !=''}">	
		<span class="delimeter">&gt;</span>
		<a href="${menu.url }">
			<span class="icon-text">${menu.name }</span>
		</a>
		<span class="delimeter">&gt;</span>
		<span class="icon-text">${menu.alias_name }</span>
</c:if>		
	</div>
</div>
