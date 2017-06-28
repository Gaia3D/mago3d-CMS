<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <title>Mago3D</title>
    <!--[if lt IE 9]>
    	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
 	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet"> 
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css"/>
</head>

<body>
	<nav class="nav">
		<div>
			<h1><a href="./index.do">mago3D</a></h1>
			<ul class="menu">
				<a href="/homepage/about.do"><li>mago3D<span></span></li></a>
				<a href="/homepage/demo.do"><li>Demo<span></span></li></a>
				<a href="/homepage/download.do"><li>Download<span></span></li></a>
				<li class="on">Tutorials<span></span></li>
			</ul>
			<ul class="language">
				<li class="on">KO</li>
				<li>EN</li>
			</ul>
		</div>
	</nav>
	
	<section>
		<h2>Tutorials<span></span></h2>
		<div class="contents">
			<ul class="subMenu">				
				<li><a href="#start">Getting Started</a></li>
				<li>블록이동</li>
				<li>색깔변경</li>
				<li>highlighting</li>
				<li>Location &amp; Rotation</li>
				<li><a href="#MouseEvent">Mouse Event</a></li>
			</ul>
			<div class="subContents">
				<dl>
					<dt id="Started">Getting Started</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						시작해 볼까요?
						어떻게 하면 될까요? 잘하면 됩니다.
					</dd>
				</dl>
				<dl>
					<dt>Getting Started</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						시작해 볼까요?
						어떻게 하면 될까요? 잘하면 됩니다.
					</dd>
				</dl>
				<dl>
					<dt>Getting Started</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						시작해 볼까요?
						어떻게 하면 될까요? 잘하면 됩니다.
					</dd>
				</dl>
				<dl>
					<dt>Getting Started</dt>
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						시작해 볼까요?
						어떻게 하면 될까요? 잘하면 됩니다.
					</dd>
				</dl>
				<dl>
				
					<dt id="MouseEvent">changeMouseMoveAPI</dt>
					<dd>마우스 클릭 후 선택한 객체가 Block 인지 Object 인지를 설정해주는 API 입니다.</dd>
					<dd>html</dd>
						<div class="example-code">
						<pre>
						Block 이동 모드 <br>
							<span class="tag">< input </span>&nbsp;
							<span class="value"> type</span>
							=
							<span class="string">"radio"</span>
							&nbsp;
							<span class="value"> id </span>
							= &nbsp;
							<span class="string">"mouseBlockMove"</span>
							&nbsp;
							<span class="value">value</span>
							= &nbsp;
							<span class="string">"0"</span>
							&nbsp;
							<span class="value"> onclick</span>
							= &nbsp;
							<span class="string">changeMouseMove('0');</span>
							<span class="tag">/> </span><br>
							<span class="tag">< label </span>
							<span class="value">for</span>
							=
							<span class="string">"mouseBlockMove" ></span>
							&nbsp;Block
							<span class="tag">< /label></span> <br>
							<br>
							Object 이동 모드 <br>
							<span class="tag">< input </span>&nbsp;
							<span class="value"> type</span>
							=
							<span class="string">"radio"</span>
							&nbsp;
							<span class="value"> id </span>
							= &nbsp;
							<span class="string">"mouseObjectMove"</span>
							&nbsp;
							<span class="value">value</span>
							= &nbsp;
							<span class="string">"0"</span>
							&nbsp;
							<span class="value"> onclick</span>
							= &nbsp;
							<span class="string">changeMouseMove('0');</span>
							<span class="tag">/> </span><br>
							<span class="tag">< label </span>
							<span class="value">for</span>
							=
							<span class="string">"mouseObjectMove" ></span>
							&nbsp;Block
							<span class="tag">< /label></span>
						</pre>
					</div>
					<dd>Javascript</dd>
						<div class="example-code">
						<pre>
							<span class="function">function</span>
							changeMouseMove (mouseMoveMode) { <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(
							<span class="string">"input:radio{name='mouseMoveMode']:radio[value='"</span>
							+ mouseMoveMode +
							<span class="string">"']"</span>
							.prop(
							<span class="string">"checked"</span>
							,
							<span class="value">true</span>
							); <br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;changeMouseMoveAPI (mouseMoveMode); <br>
							}
						</pre>
					</div>

					
					<dd class="img">
						<img src="/images/${lang}/homepage/about.png">
					</dd>
					<dd>
						시작해 볼까요?
						어떻게 하면 될까요? 잘하면 됩니다.
					</dd>
				</dl>
			</div>
		</div>		
	</section>
	
	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				Mago3d에 관심이 있는 고객님께서는 아래의 담당자 email, phone 또는 방문을 부탁 드립니다.
			</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">080 2 3397 3475</li>
				<li class="mail">mago3d@gaia3d.com</li>
			</ul>
			<p class="copyright">
				&copy; Mago3D - GIS 3D web platform. All Rights Reserved. * 문구수정필요
			</p>
		</div>
	</footer>
</body>


</html>