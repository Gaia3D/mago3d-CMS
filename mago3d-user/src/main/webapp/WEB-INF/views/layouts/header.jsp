<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.gaia3d.domain.UserSession"%>

<header id="header" class="header">
	<div class="header-menu">
		<div class="col-sm-7">
			<!-- Left Panel Show/Hide Toggle -->
			<a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
			<div class="header-left">
				<i style="padding-left: 20px;" class="fa fa-bell"> 0 </i>
                   <i style="padding-left: 20px;" class="ti-email"> 0 </i>
			</div>
			</div>

           <div class="col-sm-5">
               <div class="float-right">
				<a href="#">
					<span class="icon-glyph glyph-qmark-circle"></span>
					<span class="icon-text"><spring:message code='help'/></span>
				</a>
				<span style="width: 20px;">&nbsp;&nbsp;</span>
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>
				<a href="/login/logout.do">
					<span class="icon-glyph glyph-out"></span>
					<span class="icon-text"><spring:message code='logout'/></span>
				</a>
<%
	} else {
%>
				<a href="/login/login.do">
					<span class="icon-glyph glyph-on"></span>
					<span class="icon-text"><spring:message code='login'/></span>
				</a>
<%
	}
%>			
			</div>
		</div>
	</div>

</header>
