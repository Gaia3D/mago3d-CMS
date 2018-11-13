<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.gaia3d.domain.UserSession"%>

<header>
	<div id="header-logo">
		<span style="padding-left: 15px; font-size:38px; color: #573592;">
			<i class="fas fa-home"></i>
		</span>
	</div>
	<div id="header-logo-label">
		<a href="/main/index.do" style="text-decoration: none; font-weight: bold;">mago3D</a>
	</div>
	<div id="header-content">
		<div class="header-content-left">
			<div style="padding-left: 20px; padding-top: 12px; ">
				<a href="#" onclick="toggleMenu();">
					<span style="font-size:30px;">
						<i id="toggleMenuIcon" class="fas fa-angle-double-left"></i>
					</span>
				</a>
				<span style="font-size:30px;">
					<i class="fas fa-arrow-alt-circle-down"></i>
				</span>
			</div>
		</div>
		<div class="header-content-center">
			&nbsp;
		</div>
		<div class="header-content-right">
			<ul style="list-style: none;">
				<li style="float: left;">
					<a href="#" style="text-decoration: none; font-size:14px; font-weight: bold; ">
						<span style="color: Mediumslateblue;">
						  <i class="fas fa-times-circle"></i>
						</span>
						<span class="icon-text"> 0 </span>
					</a>
				</li>
				<li style="float: left; padding-left: 10px;">
					<a href="#" style="text-decoration: none; font-size:14px; font-weight: bold; ">
						<span style="color: Tomato;">
						  <i class="fas fa-bell"></i>
						</span>
						<span class="icon-text"> 0 </span>
					</a>
				</li>
				<li style="float: left; padding-left: 20px;">
					<a href="#" style="text-decoration: none; font-size:14px; font-weight: bold; ">
						<span class="icon-glyph glyph-qmark-circle"></span>
						<span class="icon-text"><spring:message code='help'/></span>
					</a>
				</li>
				<li style="float: left; padding-left: 20px;">
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>
					<a href="/login/logout.do" style="text-decoration: none; font-size:14px; font-weight: bold; ">
						<span class="icon-glyph glyph-out"></span>
						<span class="icon-text"><spring:message code='logout'/></span>
					</a>
<%
	} else {
%>
					<a href="/login/login.do" style="text-decoration: none; font-size:14px; font-weight: bold; ">
						<span class="icon-glyph glyph-on"></span>
						<span class="icon-text"><spring:message code='login'/></span>
					</a>
<%
	}
%>					
				</li>
			</ul>
		</div>
	</div>
</header>
