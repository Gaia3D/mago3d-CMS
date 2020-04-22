<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mago3d.domain.Key"%>
<%@page import="mago3d.domain.UserSession"%>
<%@page import="mago3d.domain.CacheManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<header>
	<h1>국가 디지털트윈 플랫폼 시범 서비스</h1>

	<div class="gnb">
		<%
			UserSession userSession = (UserSession) request.getSession().getAttribute(Key.USER_SESSION.name());
		if (userSession != null && userSession.getUserId() != null && !"".equals(userSession.getUserId())) {
		%>

		<ul>
			<li class="user"><span><%=userSession.getUserName()%> 님</span>
				<!-- <button type="button" class="magoSet" id="magoHelp">API도움말</button> -->
				<a href="/guide/help" title="API도움말" onclick="goMagoAPIGuide(this.href);return false;">API도움말</a>
				<a href="/sign/signout" title="Sign out">Sign out</a></li>
		</ul>

		<%
			} else {
				
		%>
		<ul>
			<li>
				<!-- <button type="button" class="magoSet" id="magoHelp">API도움말</button> -->
				<a href="#" title="API도움말" onclick="goMagoAPIGuide();return false;">API도움말</a>
			</li>
			<li class="user"><a href="/sign/signin">Sign in</a></li>
		</ul>
		<%
			}
		%>

	</div>


</header>