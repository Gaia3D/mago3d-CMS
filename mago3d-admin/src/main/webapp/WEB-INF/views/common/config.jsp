<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.gaia3d.domain.SessionKey"%>
<%
	String accessibility = "ko-KR";
	
	String lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
	if("en".equals(lang)) {
		accessibility = "en-US";
	} else if("ja".equals(lang)) {
		accessibility = "ja-JP";
	} else {
		lang = "ko";
	}
	
	request.setAttribute("lang", lang);
	request.setAttribute("accessibility", accessibility);
%>