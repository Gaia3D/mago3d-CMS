<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="breadcrumbs">
	<div class="col-sm-4">
		<div class="page-header float-left">
			<div>
				<h1>${menu.name }</h1>
			</div>
		</div>
	</div>
	<div class="col-sm-8">
		<div class="page-header float-right">
			<div>
				<ol class="breadcrumb text-right">
					<li class="active">
<c:if test="${menu.parent ne 0 and menu.depth ne 1}">							
						<a href="${parentMenu.url }">
							<span class="icon-glyph ${parentMenu.css_class }"></span>
							<span class="icon-text">${parentMenu.name }</span>
						</a>
</c:if>
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
					</li>
				</ol>
			</div>
		</div>
	</div>
</div>
