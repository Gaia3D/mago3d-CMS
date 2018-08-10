<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.gaia3d.domain.UserSession"%>



<div class="content-header">
	<div style="float:left;">
		<div style="padding-left: 20px; padding-top: 10px; ">
			<a href="#" onclick="toggleMenu();">
				<span style="font-size:30px; color: white;">
					<i id="toggleMenuIcon" class="fas fa-angle-double-left"></i>
				</span>
			</a>
		</div>
	</div>
	<div style="float:right; padding-top: 20px; padding-right: 50px; color: #ffffff;">
		<spring:message code='help'/> | 
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>
				<a href="/login/logout.do" style="color: #ffffff;">
					<spring:message code='logout'/>
				</a>
<%
	} else {
%>
				<a href="/login/login.do" style="color: #ffffff;">
					<spring:message code='login'/>
				</a>
<%
	}
%>			
	</div>
</div>