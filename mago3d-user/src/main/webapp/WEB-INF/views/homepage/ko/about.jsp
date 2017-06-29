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
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/css/${lang}/hojun-style.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<header>
		<div>
			<p>Architecture, Engineering, Construction</p>
			<p>대용량 3차원GIS를 쉽고 빠르게 웹에서 구현합니다</p>
		</div>
	</header>
	
	<nav class="nav">
		<div>
			<h1><a href="./index.do">Mago3D</a></h1>
			<ul class="menu">
				<li class="on">Mago3D</li>
				<li><a href="/homepage/demo.do">Demo</a></li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li><a href="/homepage/tutorials.do">Tutorials</a></li>
			</ul>
			<ul class="language">
				<li class="on">KO</li>
				<li>EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="contents">
			<ul class="tab">
				<li><a href="#about"></a>About</li>
				<li><a href="#now">Now</a></li>
				<li><a href="#will">Will be</a></li>
			</ul>
			<div id="about" class="part">
				<h3>About<span></span></h3>
				<p>
					Mago3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다.
					Mago3D는 기존의 솔루션과 달리 공간의 끊김 없는 통합 (Seamless integration of indoor & outdoor space)으로 실내외 구별 없이 끊김 없이 AFC와 3D GIS를 웹 브라우저에서 통합해 줍니다.
					오픈소스 (Cesium, World Wind)를 기반으로 개발된 오픈소스로서 개방성과 확장성 또한 뛰어납니다. 이에 따라, Mago3D 사용자는 다양한 Rendering 알고리즘을 사용하여 
					초대용량 BIM(Building Information Modelling), JT (Jupiter), 
					IFC, 3DS...등  3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다. 
				</p>			
				<div class="row_demo">
					<div class="wrapper_demo">
						<div class="highlight">
							<a href="#">
								<span class="image left">
									<img src="/images/${lang}/homepage/gangbuk.png">
								</span>
								<div class="description">
									<h2>3DS</h2>
									<p>3DS Modeling</p>
								</div>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight two">
							<a href="#">
								<span class="image fit">
									<img src="/images/${lang}/homepage/Collada_model.png">
								</span>
								<div class="description">
									<h2>COLLADA</h2>
									<p>COLLADA Modeling</p>
								</div>
							</a>
						</div>
					</div>
					<div class="wrapper_demo">
						<div class="highlight three">
							<a href="#">
								<span class="image left">
									<img src="/images/${lang}/homepage/IFC_model.png">
								</span>
								<div class="description ">
									<h2>IFC</h2>
									<p>IFC Modeling</p>
								</div>
							</a>
						</div>
					</div>
				</div>
				
				<h4>지원포맷<span></span></h4>
				<table>
					<tr>
						<th>포맷</th> <th>세부 정보</th>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/IFC.png"/></td> <td> IFC(Industry Foundation Classes)건축 BIM 정보 교환을 위한 표준 포맷 </td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/JT.png"/></td> <td>JT(Jupiter Tesselation) Siemens PLM Software 에서 개발된 경량화 3D 모델 포맷.</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/obj.png"/></td> <td>OBJ(Wavefront file format specification) 3 차원 좌표 (다각형 선과 점), 텍스쳐 매핑 및 기타 오브젝트 정보를 포함하는 삼차원 물체에 사용되는 파일 포맷</td>
					</tr>
					<tr>
						<td><img src="/images/${lang}/homepage/3DS.png"/></td> <td>3DS(3D-Studio File Format)) AutoDesk의 3D-Studio에서 사용되는 파일 포맷입니다. </td>
					</tr>
					<tr>
						<td width="64px"><img src="/images/${lang}/homepage/dae.png"></td> <td> COLLADA(COLLAborative Design Activity) - 3D assets 을 교환하기 위한 open standard XML schema 파일 포맷</td>
					</tr>
				</table>
				<a href="#" class="goTop">위로</a>
			</div>
      
			<!-- // ABOUT -->

			<div id="now" class="part">
				<h3>NOW<span></span></h3>
				<h4>Architecture</h4>
				<p>
					Mago3D는 spring framework(springboot) 기반의 3d 플랫폼 입니다.공간 정보 DB 관련 처리를 위해 PostGis를 사용하고 있으며, 3D 렌더링 부분은 cesium, worldwind 등을 오픈 소스 javascript librar를 사용하고 있습니다. 3D 데이터를 웹에서 Rendering 하기 위해서 자체 개발한 F4D 포맷 및 Converter를 사용하고 있으며 가시화 및 렌더링 처리를 담당하는 mago3djs(javascript library)로 이루어져 있습니다.
				</p>
				<div class="architecture">
					<img src="/images/${lang}/homepage/arc.png" alt="">
					<img src="/images/${lang}/homepage/sw.png" alt="">
				</div>
				
				<a href="#" class="goTop">위로</a>
			</div>
      
			<!-- // NOW -->

			<div id="will" class="part">
				<h3>Will be<span></span></h3>
				<h4>3d 통합 관제 &amp;이슈 관리 시스템</h4>
				<p>
					관리자, 일반 사용자 사이트를 제공하며 아래와 같은 기능을 제공 합니다.
				</p>
        <div class="wrap">
          <div class="colspan-2 column">
            <img src="/images/${lang}/homepage/dashboard.png">
          </div>
          <div class="colspan-1 column">
            <h2>관리자 페이지</h2>
            <p>
              관리자 페이지에서 DashBoard 제공하고 있습니다.
              신규 이슈, 진행 중인 이슈, 완료된 이슈 등 다양한 이슈를 한눈에 볼 수 있습니다.
              DB 같은 경우에는 DB Connection Pool 현황, DB 세션 현황을 보고 쉽게 관리 할 수 있습니다.
              그뿐만 아니라 사용자 상태별 현황, 스케줄 실행 사용 이력, 사용자 추적 기능이 제공되어 사용자도 관리 할 수 있습니다.
              </p>
          </div>
          <div class="colspan-1 column text-left clear">
            <h2>이슈 관리</h2>
            <p>
              이슈를 관리해주는 페이지입니다. 이슈 목록에서는 현재 이슈 상태를 확인할
              수 있습니다. 그 이슈의 등록일, 마감일 상태, 유형 등 다양한 정보를 얻을 수 있습니다.
              <b>수정 / 삭제</b>도 할 수 있습니다. <br>
              이슈 등록에서는 Issue type, 제목, 내용 등 필수 항목을 기재하시면 이슈를 등록 할 수 있습니다.
            </p>
          </div>
          <div class="colspan-2 column text-left">
            <img src="/images/${lang}/homepage/issue.png">
          </div>
          <div class="colspan-2 column">
            <img src="/images/${lang}/homepage/data.png">
          </div>
          <div class="colspan-1 column">
            <h2>데이터 관리</h2>
            <p>
              데이터를 관리해주는 페이지입니다. 데이터 목록에서는 현재 데이터 상태를 확인할 수 있습니다.
              데이터는 등록 페이지에서 하나하나 등록할 수도 있지만 엑셀 형식으로 일괄등록이 가능합니다.
              삭제 / 수정 DATA 잠금 등 많은 기능을 제공하고 있습니다. <br>
              데이터 그룹에서는 데이터를 그룹화 시킬 수 있습니다.
            </p>
          </div>
        </div>

        <h4>추가 기능</h4>
				<table>
					<tr>
						<td>관리자 페이지 DashBoard 제공</td>
						<td>용자 그룹 Role Based Acess Controll 기능 제공</td>
					</tr>
					<tr>
						<td>3d object 정보 PogstGis 연동, RestAPI, 캐싱 기능 제공</td>
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
          </tr>
				</table>
				<h4>클라우드 환경 제공</h4>
				<p>
					Amazon, Google, Azure 등 클라우드 서비스를 제공 할 예정 입니다.
					사용자는 클라우드 환경 하에서 자신이 가지고 있는 jt, obj, collada 파일 등을 실시간 업로딩 후 Mago3D에서 확인 하실 수 있습니다.
				</p>
				<a href="#" class="goTop">위로</a>
			</div>
			<!-- // WILL -->

		</div>
	</section>

	<footer>
		<div>
			<h2>
				Contact
				<span></span>
			</h2>
			<p>
				Mago3D에 관심이 있는 고객님께서는 아래의 담당자 email, phone 또는 방문을 부탁 드립니다.
			</p>
			<ul class="contact">
				<li class="company">www.gaia3d.com</li>
				<li class="address">080 2 3397 3475</li>
				<li class="mail">mago3d@gaia3d.com</li>
			</ul>
			<p class="copyright">
				&copy; 2017. Mago3D all rights reserved.
			</p>
		</div>
	</footer>
</body>


</html>
