<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="ko-KR">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width">
    <meta name="robots" content="index,nofollow"/>
	<title>오류 | NDTP</title>
    <link rel="shortcut icon" href="/images/favicon.ico">
	<link rel="stylesheet" href="/css/ko/style.css"/>
</head>

<body>
	
<div id="errorPage" style="width: 100%; text-align: center; padding-top: 200px;">
	<img src="/images/ko/no_page.png">
	<div style="margin-top: 10px; font-size: 16px;">
		<p style="height: 30px;">오류 메시지 ${httpStatusCode }</p>
		<p style="height: 30px;">요청 하신 페이지에서 오류가 발생 하였습니다.</p>
		<p style="height: 30px;">장시간 발생시 관리자에게 문의하여 주십시오.</p>
		<p style="height: 30px;">&nbsp;</p>
		<a href="/sign/signin" style="margin-top: 40px; font-size: 18px;"><b>이 페이지 나가기</b></a>
	</div>
</div>

</body>
</html>