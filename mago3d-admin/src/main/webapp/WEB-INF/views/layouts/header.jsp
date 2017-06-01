<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.gaia3d.domain.UserSession"%>
<%@page import="com.gaia3d.domain.CacheManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%
	Map<String, String> haStatusMap = new HashMap<String, String>();
	String basicServerRole = null;
	String activeServerIp = null;
	String standbyStatus = null;
	if(haStatusMap != null && !haStatusMap.isEmpty()) {
		basicServerRole = haStatusMap.get("basicServerRole");
		activeServerIp = haStatusMap.get("activeServerIp");
		standbyStatus = haStatusMap.get("standbyStatus");
	}
%>
<header class="site-header">
	<div class="row">
		<div class="container">
			<h1 class="site-title u-pull-left"><a href="/main/index.do"><img src="/images/ko/common/logo-OTP.png" alt="Gt1000 OTP" /></a></h1>
			<aside class="site-aside-menu u-pull-right">
				<ul>
<%
	if(basicServerRole != null && !"".equals(basicServerRole)) {
%>
					<li>
                        <span class="topactive">VRRP 기본 설정 :</span>
                        <span class="topip"><%=basicServerRole %></span>
					</li>
<%	} %>				
<%
	if(activeServerIp != null && !"".equals(activeServerIp)) {
%>
					<li>
                        <span class="topactive">IP :</span>
                        <span class="topip"><%=activeServerIp %></span>
					</li>
<%	} %>
<%
	if(standbyStatus != null && !"".equals(standbyStatus)) {
%>
					<li>
                        <span class="standby">STANDBY </span>
<%
		if("A".equals(standbyStatus)) {
%>
                        <span class="standby"><img src="/images/ko/icon/standby_alive.png"></span>
<%
		} else if("D".equals(standbyStatus)) {
%>
						<span class="standby"><img src="/images/ko/icon/standby_down.png"></span>	
<%
		} else {
%>
						<span class="standby"><img src="/images/ko/icon/standby_unknown.png"></span>		
					</li>
<%	
		}
	} 
%>
					<li>
						<a href="#">
							<span class="icon-glyph glyph-qmark-circle"></span>
							<span class="icon-text">도움말</span>
						</a>
					</li>
					<li>
<%
	UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
%>
						<a href="/login/logout.do">
							<span class="icon-glyph glyph-out"></span>
							<span class="icon-text">로그아웃</span>
						</a>
<%
	} else {
%>
						<a href="/login/login.do">
							<span class="icon-glyph glyph-on"></span>
							<span class="icon-text">로그인</span>
						</a>
<%
	}
%>					
					</li>
				</ul>
			</aside>
		</div>
	</div>
</header>