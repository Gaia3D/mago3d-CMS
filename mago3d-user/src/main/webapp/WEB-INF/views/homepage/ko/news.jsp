<%@page import="org.apache.poi.util.TempFile"%>
<%@page import="java.io.File"%>
<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>
<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>news | mago3D User</title>
	<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/externlib/${lang}/PgwSlider/pgwslider.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/PgwSlider/pgwslider.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<header class='about'>
<!-- 		<div> -->
<!-- 			<p>Architecture, Engineering, Construction</p> -->
<!-- 			<p>대용량 3차원GIS를 쉽고 빠르게 웹에서 구현합니다</p> -->
<!-- 		</div> -->
	</header>
	<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li class="mm on" onclick='selectMenu();'>mago3D<span></span>
					<ul>
						<li><a href="/homepage/about.do" style="color: white">About</a></li>
						<li><a href="#" style="color: white">News</a></li>
					</ul>
				</li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="mm" onclick='selectMenu();'>Documentation<span></span>
					<ul>
						<li><a href="/homepage/api.do" style="color: white" target="_blank">API</a></li>
						<li><a href="/homepage/spec.do" style="color: white">F4D Spec</a></li>
					</ul>
				</li>
				<li> <a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="/homepage/news.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
		<section>
			<h2>News</h2>
			<div class="news-slider" >
				<ul class="pgwSlider">
					<li><a href="/homepage/news1.do"><img src="/images/${lang}/homepage/news1.png" alt="쌍용자동차 사보에 신상희 대표의 인터뷰가 실렸습니다." data-description="쌍용자동차 사보인 ‘네바퀴로 가는 길’ 6월호에 가이아쓰리디 신상희 대표이사의 인터뷰와 회사 소개가 실렸습니다."></a></li>
					<li><a href="/homepage/news3.do"><img src="/images/${lang}/homepage/europe.jpg" alt="mago3D, FOSS4G Europe 2017의 발표 주제로 선정" data-description="가이아쓰리디의 Live3D 플랫폼인 mago3D가 FOSS4G Europe 2017 컨퍼런스에서 발표주제로 선정되었습니다."></a></li>
					<li><a href="/homepage/news4.do"><img src="/images/${lang}/homepage/boston.png" alt="가이아쓰리디의 mago3D가 FOSS4G Boston 2017에서 발표됩니다." data-description="가이아쓰리디의 Live3D 플랫폼인 mago3D가 국제 FOSS4G(Free Open Source SW for Geospatial) Boston 2017 컨퍼런스에서 발표 주제로 선정되었습니다."></a></li>
				</ul>
			</div>
			<div class="news-main" style="margin-top: 150px;">
				<div class="news-contents" style="height: 876px">
					<div id = "more" style="display: none;">
						<div class="news-more">
							<a href="/homepage/news-listview.do">모두 보기</a>
						</div>
					</div>
					<div id="news" style="display: none">
						<div class="news-items">
							<div class="news-subtitle"><a id="linkChange" href="#"></a></div>
							<p>쌍용자동차 사보인 ‘네바퀴로 가는 길’ 6월호에 가이아쓰리디 신상희 대표이사의 인터뷰와 회사 소개가 실렸습니다.</p>
							<div class="news-user">
								<div class="news-user-logo"><img src="/images/${lang}/homepage/gaialogo.png"/></div>
								<div class="news-user-des">
									<div class="news-name"><b>Gaia3D</b>
									</div>
									<div class="news-date"><p>July 15, 2017</p></div>
								</div>
							</div>
						</div>
						<div class="line"></div>
					</div>
					<div class="news-title" style="color: gray; margin-top: 70px"><h2>최근 소식 및 공지 사항</h2></div>
					<div id="morefield"></div>
					<hr>
					<div id="field"></div>
<!-- 					<div class="news-items"> -->
<!-- 						<div class="news-subtitle"><a href="/homepage/news2.do">mago3D 웹페이지 오픈 안내</a></div> -->
<!-- 						<div class="news-user"> -->
<%-- 							<div class="news-user-logo"><img src="/images/${lang}/homepage/gaialogo.png"/></div> --%>
<!-- 							<div class="news-user-des"> -->
<!-- 								<div class="news-name"><b>Gaia3D</b> -->
<!-- 								</div> -->
<!-- 								<div class="news-date"><p>July 04, 2017</p></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="line"></div> -->
<!-- 					<div class="news-items"> -->
<!-- 						<div class="news-subtitle"><a href="/homepage/news3.do">mago3D, FOSS4G Europe 2017의 발표 주제로 선정</a></div> -->
<!-- 						<div class="news-user"> -->
<%-- 							<div class="news-user-logo"><img src="/images/${lang}/homepage/gaialogo.png"/></div> --%>
<!-- 							<div class="news-user-des"> -->
<!-- 								<div class="news-name"><b>Gaia3D</b> -->
<!-- 								</div> -->
<!-- 								<div class="news-date"><p>May 12, 2017</p></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="line"></div> -->
<!-- 					<div class="news-items"> -->
<!-- 						<div class="news-subtitle"><a href="/homepage/news4.do">가이아쓰리디의 mago3D가 FOSS4G Boston 2017에서 발표됩니다.</a></div> -->
<!-- 						<div class="news-user"> -->
<%-- 							<div class="news-user-logo"><img src="/images/${lang}/homepage/gaialogo.png"/></div> --%>
<!-- 							<div class="news-user-des"> -->
<!-- 								<div class="news-name"><b>Gaia3D</b> -->
<!-- 								</div> -->
<!-- 								<div class="news-date"><p>May 1, 2017</p></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="line"></div> -->
				</div>
			</div>
			<div class="secondary-content">
				<div class="con" style="margin-top: 70px;">
					<h3>문의하기</h3>
					<a href="mailto:info@gaia3d.com" style="color: blue;">info@gaia3d.com</a><br>
				</div>
				<div class="">
					<h3>트위터</h3>
					<div class="secondary-tw">RT : <a href="https://twitter.com/endofcap">@endofcap</a> <a href="https://twitter.com/OSGeo"> @OSGeo</a></div>
				</div>
			</div>
	</section>
	<footer style="position: relative; top: -250px">
		<div>
			<h2>
				Contact <span></span>
			</h2>
			<p>mago3D 에 관심있는 고객들께서는 연락(이메일, 전화) 또는 직접 방문을 부탁드립니다.</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">+82-(0)2-3397-3475</li>
				<li class="mail">info@gaia3d.com</li>
			</ul>
			<p class="copyright">&copy; 2017 Gaia3D, Inc.</p>
		</div>
	</footer>
</body>
<%
	String title = request.getParameter("title");
	System.out.println("제목 :" + title);
	String fileDir = "WEB-INF/views/homepage/ko"; //파일을 보여줄 디렉토리
	String filePath = request.getSession().getServletContext().getRealPath(fileDir);
	String fileName = ".jsp";
	int fileCount = 1;
	File f = new File(filePath); 
	File [] files = f.listFiles(); //파일의 리스트를 대입
	
	for ( int i = 0; i < files.length; i++ ) {
	  if ( files[i].isFile()){ 
		  if(files[i].getName().contains("article")) {
			  fileCount+=1;
			  out.println(files[i].getName());
			  System.out.println(files[i].getName());  
		  }
		  
	  }
	}
%>
<script>
var count;
var filesCount= <%= fileCount%>

$(document).ready(function(){
	$('.pgwSlider').pgwSlider();
	for(count = 0; count < filesCount; count++) {
		AddNews();	
	}
});
function AddNews() {
	$("#linkChange").attr("href", "/homepage/article"+ (count + 1) + ".do");
    var div = document.createElement('div');
    div.innerHTML = document.getElementById('news').innerHTML;
    document.getElementById('field').appendChild(div);
    if(count > 3 ) {
    	div.innerHTML = document.getElementById('more').innerHTML;
    	document.getElementById('morefield').appendChild(div);
    }
}
</script>
</html>
