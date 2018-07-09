<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<aside id="left-panel" class="left-panel">
	<nav class="navbar navbar-expand-sm navbar-default">

		<div class="navbar-header">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
				<i class="fa fa-bars"></i>
			</button>
			<a class="navbar-brand" href="/main/index.do"><img src="/images/${lang }/logo.png" alt="Logo"></a>
			<a class="navbar-brand hidden" href="/main/index.do">M</a>
		</div>

		<div id="main-menu" class="main-menu collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<li class="active">
					<a href="/user/modify-user.do"> <i class="menu-icon fa fa-user"></i>Profile </a>
				</li>
										
				<li><h3 class="menu-title">Rendering</h3></li>
				<li class="menu-item-has-children dropdown">
					<a href="/project/list-project.do" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="menu-icon fa fa-cubes"></i>프로젝트</a>
					<ul class="sub-menu children dropdown-menu">
						<li><i class="fa fa-building"></i><a href="/project/list-project.do">프로젝트 목록</a></li>
						<li><i class="fa fa-id-badge"></i><a href="/project/input-project.do">프로젝트 등록</a></li>
					</ul>
				</li>
				<li class="menu-item-has-children dropdown">
					<a href="/data/list-data.do" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="menu-icon fa fa-database"></i>데이터</a>
					<ul class="sub-menu children dropdown-menu">
						<li><i class="fa fa-list"></i><a href="/data/list-data.do">데이터 목록</a></li>
						<li><i class="fa fa-table"></i><a href="/data/list-data-info-log.do">데이터 변경 요청 목록</a></li>
					</ul>
				</li>

				<li><h3 class="menu-title">Converter</h3></li>
				<li><a href="/upload/input-upload.do"><i class="menu-icon fa fa-cloud-upload"></i>파일 업로딩</a></li>
				<li><a href="/upload/list-upload-log.do"><i class="menu-icon fa fa-cloud-upload"></i>업로딩한 파일 목록</a></li>
				<li><a href="/converter/list-converter-job.do"><i class="menu-icon fa fa-calendar-times-o"></i>Converter 실행 결과 </a></li>
				<li><a href="/converter/list-converter-log.do"><i class="menu-icon fa fa-sticky-note"></i>F4D 파일 목록</a></li>

				<li><h3 class="menu-title">Settings</h3></li>
				<li><a href="#"><i class="menu-icon fa fa-cogs"></i>기본 설정</a></li>
				<li><a href="#"> <i class="menu-icon fa fa-key"></i>mago3D 설정</a></li>
			</ul>
		</div><!-- /.navbar-collapse -->
	</nav>
</aside>