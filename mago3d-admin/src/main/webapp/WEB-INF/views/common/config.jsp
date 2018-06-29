<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.gaia3d.domain.SessionKey"%>
<%
	String accessibility = "en-US";
	
	String lang = (String)request.getSession().getAttribute(SessionKey.LANG.name());
	if(lang == null || "".equals(lang)) {
		Locale myLocale = request.getLocale();
		lang = myLocale.getLanguage();
	}
	
	if("en".equals(lang)) {
		accessibility = "en-US";
	} else if("ja".equals(lang)) {
		accessibility = "ja-JP";
	} else if("ko".equals(lang)) {
		accessibility = "ko-KR";
	} else {
		// TODO Because it does not support multilingual besides English and Japanese Based on English
		lang = "en";
		accessibility = "en-US";
	}
	
	request.setAttribute("lang", lang);
	request.setAttribute("accessibility", accessibility);
%>