<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>about | mago3D User</title>
	<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<header class='about'>
	</header>

	<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li class="mm on" onclick='selectMenu();'>mago3D<span></span>
					<ul>
						<li><a href="#" style="color: white">About</a></li>
						<li><a href="/homepage/news.do" style="color: white" onclick="alert('준비 중 입니다.'); return false">News</a></li>
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
<!-- 						<li><a href="/homepage/tutorials.do" style="color: white">Tutorials</a></li> -->
					</ul>
				</li>
				<li> <a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN" class=""><a href="/homepage/about.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<h2>mago3D</h2>
		<div class="contents">
			<ul class="tab">
				<li><a href="#about">About</a></li>
				<li><a href="#now">Now</a></li>
				<li><a href="#will">Will be</a></li>
			</ul>
			<div id="about" class="part">
				<h3>
					About<span></span>
				</h3>
				<p>mago3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인
					3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. mago3D는 기존의
					솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 이에 따라,
					mago3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter
					Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을
					진행할 수 있습니다.</p>
				<h4>mago3D의 특징</h4>
				<ul>
					<li>BIM/AEC와 3D GIS의 통합</li>
					<li>실내외 공간의 끊김 없는 통합(Seamless integration of indoor | outdoor	space)</li>
					<li>웹브라우저 상에서 구동되며, 별도의 플러그인이나 엑티브엑스 설치가 필요 없음</li>
					<li>오픈소스(Cesium, World Wind)를 기반으로 개발된 오픈소스로서 개방성과 확장성이 뛰어남</li>
					<li>초대용량 3차원 파일의 효율적 관리 및 초고속 렌더링</li>
				</ul>
				<div class="row_demo">
					<div class="wrapper_demo">
						<div class="highlight">
								<a href="/homepag/demo.do"> 
								<span class="image left"> <img
										src="/images/${lang}/homepage/gangbuk.png"
										alt="3DS포맷이 mago3D에 올라간 화면입니다.">
								</span>
								<span class="description">
									<b>3DS</b>
								</span>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight two">
							<a href="/homepage/demo.do">  
							<span class="image fit"> <img
									src="/images/${lang}/homepage/Collada_model.png"
									alt="COLLADA 포맷이 mago3D에 올라간 화면 입니다.">
							</span>
								<span class="description">
									<b>COLLADA</b>
								</span>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight three">
							<a href="/homepage/demo.do"> 
							 <span class="image left"> <img
									src="/images/${lang}/homepage/IFC_model.png"
									alt="IFC(BIM)포맷이 mago3D에 올라간 화면입니다.">
							</span>
								<span class="description ">
									<b>IFC(BIM)</b>
								</span>
							</a>
						</div>
					</div>
				</div>

				<h4>
					지원포맷<span></span>
				</h4>
				<table>
					<tr>
						<th>포맷</th>
						<th>세부 정보</th>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/IFC.png"
							alt="ifc(BIM) 포맷 이미지" /></td>
						<td>IFC(Industry Foundation Classes)건축 BIM 정보 교환을 위한 표준 포맷</td>
					</tr>

					<tr>
						<td><img src="/images/${lang}/homepage/obj.png"
							alt="obj 포맷 이미지" /></td>
						<td>OBJ(Wavefront File Format Specification) 3차원 좌표 (다각형 선과 점), 텍스쳐 매핑 및 기타 오브젝트 정보를 포함하는 3차원 파일 포맷</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/3DS.png"
							alt="3ds 포맷 이미지" /></td>
						<td>3DS(3D Studio File Format)) AutoDesk의 3D Studio에서 사용되는 파일 포맷</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/dae.png"
							alt="dae 포맷 이미지"></td>
						<td>COLLADA(COLLAborative Design Activity) - 3D 자료를 교환하기 위한 XML 스키마 기반의 개방형 표준 포맷</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/JT.png"
							alt="jt 포맷 이미지" /></td>
						<td>JT(Jupiter Tessellation) Siemens PLM Software 에서 개발된 경량화 3D 모델 포맷 - JT포맷 지원이 필요한 경우 별도 연락 요망</td>
					</tr>
				</table>
				<h4>Rendering Algoritm</h4>
				<div class="wrapper-algo">
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="삼각형 꼭지점 순서 보정 이미지" style="background-image:url(/images/${lang}/homepage/triangle.png)">
								<div>
									<h3>삼각형 꼭지점 순서 보정</h3>
									<p>WebGL이 지원하는 성능 향상 기법</p>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Model/Reference 이미지"
								style="background-image:url(/images/${lang}/homepage/model_reference.png)">
								<div>
									<h3>Model/Reference</h3>
									<P>Multi-instance 경량화 기법</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="VBO 생성 이미지"
								style="background-image:url(/images/${lang}/homepage/tri.jpg)">
								<div>
									<h3>VBO 생성</h3>
									<P>삼각형 크기 별로 정렬해서 저장</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="3D 공간 Octree"
								style="background-image:url(/images/${lang}/homepage/octree.png)">
								<div>
									<h3>3D 공간 Octree</h3>
									<P>Flexible octree depth 적용</P>
								</div>
							</div>
						</a>
					</div>
				</div>
				<div class="wrapper-algo">
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Lego Strucure 이미지"
								style="background-image:url(/images/${lang}/homepage/lego.png)">
								<div>
									<h3>Lego Strucure</h3>
									<P>Rougher LOD를 위한 데이터 생성</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="가시성 색인 이미지"
								style="background-image:url(/images/${lang}/homepage/indexing.png)">
								<div>
									<h3>가시성 색인</h3>
									<P>Occlusion을 위한 pre-processing</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="원시 데이터 로딩 이미지"
								style="background-image:url(/images/${lang}/homepage/loading.png)">
								<div>
									<h3>원시 데이터 로딩</h3>
									<P>Loading time out 적용</P>
								</div>
							</div>
						</a>
					</div>
					<div class="algo-row">
						<a href="#">
							<div class="aglo-thumbnail" alt="Bounding box이미지" style="background-image:url(/images/${lang}/homepage/boundingbox.png)">
								<div>
									<h3>Bounding box</h3>
									<P>Bounding box 계산</P>
								</div>
							</div>
						</a>
					</div>
				</div>
				<a href="#" class="goTop">위로</a>
			</div>
			<!-- // ABOUT -->

			<div id="now" class="part">
				<h3>
					NOW<span></span>
				</h3>
				<h4>Architecture</h4>
				<p>mago3D는 spring framework(spring boot) 기반의 3D 플랫폼입니다. 공간 정보 DB
					관련 처리를 위해 PostGis를 사용하고 있으며, 3D 렌더링 부분은 cesium, world wind 등을 오픈 소스
					javascript library를 사용하고 있습니다. 3D 데이터를 웹에서 Rendering 하기 위해서 자체 개발한
					F4D 포맷 및 Converter를 사용하고 있으며 가시화 및 렌더링 처리를 담당하는 mago3DJS(javascript
					library)로 이루어져 있습니다.
				</p>
				<div class="architecture">
					<img src="/images/${lang}/homepage/arc.png"
						style="width: 590px; margin-top: 60px;" alt="mago3D 아키텍쳐"> <img
						src="/images/${lang}/homepage/sw.png" style="width: 590px;"
						alt="mago3D 소프트웨어 구성도">
				</div>
				<a href="#" class="goTop">위로</a>
			</div>

			<!-- // NOW -->

			<div id="will" class="part">
				<h3>
					Will be<span></span>
				</h3>
				<h4>컨텐츠관리 플랫폼</h4>
				<p>관리자, 일반 사용자 사이트를 제공하며 아래와 같은 기능을 제공 합니다.</p>
				<div class="wrap">
					<div class="colspan-2 column">
						<img src="/images/${lang}/homepage/dashboard.png"
							alt="관리자 페이지에 dashboard" style="width: 800px; height: 500px;">
					</div>
					<div class="colspan-1 column">
						<h2>관리자 페이지</h2>
						<p>관리자 페이지에서 DashBoard 제공하고 있습니다. 신규 이슈, 진행 중인 이슈, 완료된 이슈 등
							다양한 이슈를 한눈에 볼 수 있습니다. DB 같은 경우에는 DB Connection Pool 현황, DB 세션 현황을
							보고 쉽게 관리 할 수 있습니다. 그뿐만 아니라 사용자 상태별 현황, 스케줄 실행 사용 이력, 사용자 추적 기능이
							제공되어 사용자도 관리 할 수 있습니다.</p>
					</div>
					<div class="colspan-1 column text-left clear">
						<h2>이슈 관리</h2>
						<p>
							이슈를 관리해주는 페이지입니다. 이슈 목록에서는 현재 이슈 상태를 확인할 수 있습니다. 그 이슈의 등록일, 마감일
							상태, 유형 등 다양한 정보를 얻을 수 있습니다. <b>수정 / 삭제</b>도 할 수 있습니다. <br>
							이슈 등록에서는 Issue type, 제목, 내용 등 필수 항목을 기재하시면 이슈를 등록할 수 있습니다.
						</p>
					</div>
					<div class="colspan-2 column text-left">
						<img src="/images/${lang}/homepage/issue.png"
							alt="관리자 페이지에  이슈 관리를 해주는 페이지의 이미지입니다." style="width: 800px;">
					</div>
					<div class="colspan-2 column clear">
						<img src="/images/${lang}/homepage/data.png"
							alt="관리자 페이지에 데이터 관리를 해주는 페이지의 이미지입니다. " style="width: 800px; ">
					</div>
					<div class="colspan-1 column">
						<h2>데이터 관리</h2>
						<p>
							데이터를 관리해주는 페이지입니다. 데이터 목록에서는 현재 데이터 상태를 확인할 수 있습니다. 데이터는 등록 페이지에서
							하나하나 등록할 수도 있지만, 엑셀 형식으로 일괄등록이 가능합니다. 데이터의 <b>삭제 / 수정 / 잠금</b> 등
							많은 기능을 제공하고 있습니다. 데이터 그룹에서는 데이터를 그룹화시킬 수 있습니다.
						</p>
					</div>
				</div>
				<h4>추가 기능</h4>
				<table>
					<tr>
						<td>관리자 페이지 DashBoard 제공</td>
						<td>사용자 그룹의 역할 기반 접근-제어 기능 제공</td>
					</tr>
					<tr>
						<td>3D Object 정보 PogstGIS 연동, RestAPI, 캐싱 기능 제공</td>
						<td>F4D 변환 배치 기능 제공</td>
					</tr>
					<tr>
						<td>이슈 현황 신규 이슈, 진행 중인 이슈, 완료된 이슈</td>
						<td>사용자 상태별 현황을 그래프로 되어 있어 보기 편함</td>
					</tr>
					<tr>
						<td>DB Connection Pool 현황이나 DB세션 현황</td>
						<td>통계및이력 기능 제공</td>
					</tr>
					<tr>
						<td>스케줄 기능 제공</td>
						<td></td>
					</tr>
				</table>
				<h4>클라우드 환경 제공</h4>
				<p>Amazon, Google, Azure 등 클라우드 서비스를 제공할 예정입니다. 사용자는 클라우드 환경 하에서
					자신이 가지고 있는 파일(jt,obj,collada,3ds,ifc 등)을 업로딩 후 mago3D에서 실시간으로 확인할수
					있습니다.</p>
				<h4>Acknowledgement</h4>
				<ul>
					<li>본 프로젝트는 국토교통부 '공간정보 SW활용을 위한 오픈소스 가공기술개발(과제번호:17NSIP-B080778-04)'의 일환입니다.</li>
					<li>서울시 3차원 데이터는 한국공간정보산업진흥원의 허가를 받아 연구목적으로 사용 중입니다.</li>
					<li>서울시 실내 데이터는 서울시의 허가를 받아 연구목적으로 사용 중입니다.</li>
					<li>기타 자료는 각 저작권자의 허락을 받아 서비스합니다.</li>
				</ul>
				<a href="#" class="goTop">위로</a>
			</div>
			<!-- // WILL -->

		</div>

	</section>

	<footer>
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


</html>
