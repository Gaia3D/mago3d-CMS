<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.gaia3d.domain.SessionKey"%>
<%
	String accessibility = "ko-KR";
	
	String lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
	if("en".equals(lang)) {
		accessibility = "en-US";
	} else {
		lang = "ko";
	}
	
	long currentTime = System.currentTimeMillis();
	
	request.setAttribute("lang", lang);
	request.setAttribute("currentTime", currentTime);
	request.setAttribute("accessibility", accessibility);
%>