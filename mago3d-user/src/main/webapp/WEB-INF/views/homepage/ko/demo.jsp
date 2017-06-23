<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans"> 
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
</head>

<body>
<!-- 공통메뉴 -->
<div class="trigger" >
	<button type="button">메뉴</button>
	<ul>
		<li><a href="/homepage/about.do">Mago3D</a></li>
		<li><a href="/homepage/tutorials.do">Tutorials</a></li>
		<li><a href="/homepage/download.do">Download</a></li>
	</ul>
</div>

 <ul class="dropdownmenu">
	<li>샘플1
		<ul>
			<li>하위제목1</li>
			<li>하위제목2</li>
			<li>하위제목3</li>
		</ul>
	</li>

	<li>샘플2
		<ul>
			<li>순서목록의 번호</li>
			<li>순서목록의 번호시작번호바꾸기</li>
			<li>하위제목3</li>
			<li>하위제목4</li>
			<li>하위제목5</li>
			<li>하위제목6</li>
			<li>하위제목7</li>
		</ul>
	</li>

	<li>샘플3
		<ul>
			<li>하위제목1</li>
			<li>하위제목2</li>
			<li>하위제목3</li>
			<li>하위제목4</li>
		</ul>
	</li>
	<li>샘플4
		<ul>
			<li>하위제목1</li>
			<li>하위제목2</li>
		</ul>
	</li>
</ul>

<!-- 맵영역 -->
<div class="mapWrap"></div>

<!-- 레이어 -->
<div class="layer" style="top:50%; left:50%; width:350px; margin:-250px 0 0 -150px; ">
    <div class="layerHeader">
        <h2>레이어</h2>
        <div>
            <button type="button" title="닫기">닫기</button>
        </div>
    </div>
    <div class="layerContents">
        <h4>테이블</h4>
        <table>
        	<tr>
        		<th>소제목</th>
        		<td>
        			<input type="text">
        		</td>
        	</tr>
        	<tr>
        		<th>소제목</th>
        		<td>
        			<select>
        				<option>Web</option>
        				<option>App</option>
        			</select>
        		</td>
        	</tr>
        	<tr>
        		<th>내용</th>
        		<td>
        			<textarea name="" id="" cols="30" rows="4"></textarea>
        		</td>
        	</tr>
        </table>
        
        <h4>체크박스 타입</h4>
        <ul class="group">
            <li><label><input type="checkbox"> 기온</label></li>
            <li><label><input type="checkbox"> 최고기온</label></li>
            <li><label><input type="checkbox"> 최저기온</label></li>
        </ul>
         
        <h4>라디오버튼</h4>
        <ul class="group">
            <li><label><input type="radio"> 기온</label></li>
            <li><label><input type="radio"> 최고기온</label></li>
            <li><label><input type="radio"> 최저기온</label></li>
        </ul>
        <div class="btns">
            <button id="">적용</button>
        </div>
    </div>
</div>

</body>
</html>