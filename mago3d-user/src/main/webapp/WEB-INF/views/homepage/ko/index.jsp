<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
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
			<h1><a href="./index.html">mago3D</a></h1>
			<ul class="menu">
				<li class="on">mago3D <span></span></li>
				<li><a href="/homepage/${lang}/demo.jsp">Demo</a><span></span></li>
				<li><a href="/homepage/${lang}/download.jsp">Download</a><span></span></li>
				<li><a href="/homepage/${lang}/tutorial.jsp">Tutorials</a><span></span></li>
			</ul>
			<ul class="language">
				<li class="on">KO</li>
				<li>EN</li>
			</ul>
		</div>
	</nav>
		<ul class="tab">
				<li><a href="#about">About</a></li>
				<li><a href="#now">Now</a></li>
				<li><a href="#will">Will be</a></li>
		</ul>
	<section>
		<div class="contents">
			<div id="about" class="part">
				<h3>About<span></span></h3>
				<p>
					MAGO3D는 AEC(Architecture, Engineering, Construction) 영역과 전통적인 3차원 공간정보(3D GIS)를 통합적으로 관리, 가시화해 주는 차세대 3차원 플랫폼입니다. MAGO3D는 기존의 솔루션과 달리 실내외 구별 없이 끊김 없이 AEC와 3D GIS를 웹 브라우저에서 통합해 줍니다. 이에 따라, MAGO3D 사용자는 초대용량 BIM(Building Information Modelling), JT(Jupiter Tessellation), 3D GIS 파일 등을 별도의 프로그램 설치 없이 웹 브라우저 상에서 바로 살펴보고 협업작업을 진행할 수 있습니다.
				</p>

				<h4>특징<span></span></h4>
				<p>
          공간의 끊김 없는 통합(Seamless integration of indoor & outdoor space) 웹브라우저 상에서 구동되며, 별도의 플러그인이나 엑티브엑스
          설치가 필요 없습니다. 오픈소스(Cesium, World Wind)를 기반으로 개발된 오픈소스로서 개방성과 확장성 또한 뛰어납니다. 다양한 Rendering 알고리즘을 사용하여
          초대용량 3차원 포맷(.jt, .ifc, .obj, .3ds, .dae)을 초고속 렌더링 뿐만 아니라 효율적으로 관리를 할 수 있습니다.
				</p>
        <div class="wrapper_clear">
          <h4>Rendering Algorithm</h4>
          <br>
          <div id="market" class="container">
            <div class="row">
              <div class="3u">
                  <h2>삼각형 꼭지점 순서 보정</h2>
                <p class="sub_title">WebGL이 지원하는 성능 향상 기법</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="MORE" class="button">
              </div>
              <div class="3u">
                  <h2>model/reference</h2>
                <p class="sub_title">multi-instance - 경량화 logic</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="MORE" class="button">
              </div>
              <div class="3u">
                  <h2>VBO 생성</h2>
                <p class="sub_title">생성할 때 삼각형을 크기별로 정렬</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="MORE" class="button">
              </div>
              <div class="3u">
                  <h2>3D 공간 octree</h2>
                <p class="sub_title">공간자료를 volume 별로 묶는 단위</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="more" class="button">
              </div>
            </div>
          </div>
        </div>
        <div class="wrapper_clear">
          <div id="market" class="container">
            <div class="row">
              <div class="3u">
                  <h2>Lego Structure</h2>
                <p class="sub_title">simplified data</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="more" class="button">
              </div>
              <div class="3u">
                  <h2>가시성 색인</h2>
                <p class="sub_title">pre-processing - Visibility Indexing</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="more" class="button">
              </div>
              <div class="3u">
                  <h2>context device</h2>
                <p class="sub_title">....</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="more" class="button">
              </div>
              <div class="3u">
                <h2>dependency 제거</h2>
                <p class="sub_title">...</p>
                <p>
                  <a href="#">
                    <img src="/images/${lang}/homepage/octree.png" alt="">
                  </a>
                </p>
                <input type="button" name="MORE" value="more" class="button">
              </div>
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
						<td><img src="/images/${lang}/homepage/3ds.png"/></td> <td>3DS(3D-Studio File Format)) AutoDesk의 3D-Studio에서 사용되는 파일 포맷입니다. </td>
					</tr>
					<tr>
						<td width="64px"><img src="/images/${lang}/homepage/dae.png"></td> <td> COLLADA(COLLAborative Design Activity) - 3D assets 을 교환하기 위한 open standard XML schema 파일 포맷</td>
					</tr>
				</table>

				<h4>실적 사례<span></span></h4>
        <div id="featured">
          <div class="container">
            <div class="row">
              <div class="4u">
                <div class="box">
                  <a href="#" class="image-left">
                      <img src="/images/${lang}/homepage/Integration.jpg">
                  </a>
                  <h3>남극과학기지</h3>
                  <p>웹기반 3차원</p>
                  <input type="button" name="MORE" value="more" class="button">
                </div>
              </div>
              <div class="4u">
                <div class="box">
                  <a href="#" class="image-left">
                      <img src="/images/${lang}/homepage/Integration.jpg" alt="">
                  </a>
                  <h3>남극과학기지</h3>
                  <p>웹기반 3차원</p>
                  <input type="button" name="MORE" value="more" class="button">
                </div>
              </div>
              <div class="4u">
                <div class="box">
                  <a href="#" class="image-left">
                      <img src="/images/${lang}/homepage/Integration.jpg" alt="">
                  </a>
                  <h3>남극과학기지</h3>
                  <p>웹기반 3차원</p>
                  <input type="button" name="MORE" value="more" class="button">
                </div>
              </div>
            </div>
          </div>
        </div>
				<a href="#" class="goTop">위로</a>
			</div>
      <span class="simplebar"></span>
			<!-- // ABOUT -->

			<div id="now" class="part">
				<h3>NOW<span></span></h3>
				<h4>Architecture</h4>
				<p>
					mago3d는 spring framework(springboot) 기반의 3d 플랫폼 입니다.공간 정보 DB 관련 처리를 위해 PostGis를 사용하고 있으며, 3D 렌더링 부분은 cesium, worldwind 등을 오픈 소스 javascript librar를 사용하고 있습니다. 3D 데이터를 웹에서 Rendering 하기 위해서 자체 개발한 F4D 포맷 및 Converter를 사용하고 있으며 가시화 및 렌더링 처리를 담당하는 mago3djs(javascript library)로 이루어져 있습니다.
				</p>
				<img src="/images/${lang}/homepage/about.png" alt="">

				<h4>API</h4>
				<table>
					<tr>
						<td>mago3d 상태 변경</td>
						<td>deploy 상태 변경</td>
					</tr>
					<tr>
						<td>BoundingBox 상태 변경</td>
						<td>OutFitting 상태 변경</td>
					</tr>
					<tr>
						<td>그림자 상태 변경</td>
						<td>가시거리 변경</td>
					</tr>
          <tr>
            <td>블록 검색</td>
            <td>HighLighting</td>
          </tr>
          <tr>
            <td>Color 변경</td>
            <td>Location & Roatation 변경</td>
          </tr>
          <tr>
            <td>Location & Roatation 취득</td>
            <td>블록 마우스 이동</td>
          </tr>
          <tr>
            <td>블록 Location & Rotation   Notice</td>
            <td>마우스 클릭 객체 이동 대상 변경</td>
          </tr>
				</table>
				<div class="api">
					<a href="">
						<p>Show API</p>
					</a>
				</div>
				<a href="#" class="goTop">위로</a>
			</div>
      <span class="simplebar"></span>
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
					사용자는 클라우드 환경 하에서 자신이 가지고 있는 jt,obj,collada 파일 등을 실시간 업로딩 후 mago3d에서 확인 하실 수 있습니다.
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
