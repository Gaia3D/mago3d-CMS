<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="left-navigation-layout">
	<div class="logo-header">
		<div class="logo-icons">
			<img src="/images/ko/homepage/home-icon.png" style="padding-top:13px; width: 45px; height: 45px;">
		</div>
		<div class="logo-detail">
			<div style="padding-top: 13px; font-size:28px; font-family:Lousianne; color:#573592">
				<a href="/main/index.do" style="text-decoration: none; font-weight: bold;">mago3D</a>
			</div>
		</div>
	</div>
	
	<div class="profile-header">
		<div class="profile-icons">
			<div style="padding-top: 15px;">
				<img id="smallProfileIcons" src="/images/1px.png" width="40px;" height="40px;">
			</div>
		</div>
		<div class="profile-detail">
			<div style="padding-top: 20px;">
				<img src="/images/ko/profile_example.png" width="80px;" height="80px;" />
			</div>
			<div style="padding-left: 15px;">Profile</div>
		</div>
	</div>
	
	<div class="menu-description-header">
		<div style="padding-left: 13px; padding-top: 20px; height: 30px;">RENDERING</div>
		<div style="margin-left: 13px; width:195px; border-bottom: 1px solid #e3e7ea;"></div>
	</div>
	
	<div>
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-cubes" title="프로젝트"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="/project/list-project.do" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">프로젝트</a>
			</div>
		</div>
	</div>
	<div class="sub-menu-area" >
		<div class="sub-menu-icons">
			<div style="width: 70px;">&nbsp;</div>
		</div>
		<div class="sub-menu-detail">
			<div style="height: 25px;">
				<span style="font-size:15px; color: Mediumslateblue;">
					<i class="far fa-stop-circle"></i>
				</span>
				<a href="/project/list-project.do" style="text-decoration: none; font-size: 14px; color: #2c2d2d;">프로젝트 목록</a>
			</div>
		</div>
	</div>
	<div class="sub-menu-area" >
		<div class="sub-menu-icons">
			<div style="width: 70px;">&nbsp;</div>
		</div>
		<div class="sub-menu-detail">
			<div style="height: 25px;">
				<span style="font-size:15px; color: Mediumslateblue;">
					<i class="far fa-stop-circle"></i>
				</span>
				<a href="/project/input-project.do" style="text-decoration: none; font-size: 14px; color: #2c2d2d;">프로젝트 등록</a>
			</div>
		</div>
	</div>
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-database" title="데이터"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="/data/list-data.do" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">데이터</a>
			</div>
		</div>
	</div>
	<div class="sub-menu-area" >
		<div class="sub-menu-icons">
			<div style="width: 70px;">&nbsp;</div>
		</div>
		<div class="sub-menu-detail">
			<div style="height: 25px;">
				<span style="font-size:15px; color: Mediumslateblue;">
					<i class="far fa-stop-circle"></i>
				</span>
				<a href="/data/list-data.do" style="text-decoration: none; font-size: 14px; color: #2c2d2d;">데이터 목록</a>
			</div>
		</div>
	</div>
	<div class="sub-menu-area" >
		<div class="sub-menu-icons">
			<div style="width: 70px;">&nbsp;</div>
		</div>
		<div class="sub-menu-detail">
			<div style="height: 25px;">
				<span style="font-size:15px; color: Mediumslateblue;">
					<i class="far fa-stop-circle"></i>
				</span>
				<a href="/data/list-data-info-log.do" style="text-decoration: none; font-size: 14px; color: #2c2d2d;">변경요청 목록</a>
			</div>
		</div>
	</div>
	
	<div class="menu-description-header">
		<div style="padding-left: 13px; padding-top: 20px; height: 30px;">CONVERTER</div>
		<div style="margin-left: 13px; width:195px; border-bottom: 1px solid #e3e7ea;"></div>
	</div>
	
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-cloud-upload-alt" title="파일 업로딩"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="/upload/input-upload.do" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">파일 업로딩</a>
			</div>
		</div>
	</div>
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-list-ul" title="업로딩한 파일 목록"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="/upload/list-upload-log.do" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">업로딩한 파일 목록</a>
			</div>
		</div>
	</div>
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-hourglass-start" title="Converter 결과"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="/converter/list-converter-job.do" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">Converter 결과</a>
			</div>
		</div>
	</div>
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-map-pin" title="F4D 파일 목록"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="/converter/list-converter-log.do" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">F4D 파일 목록</a>
			</div>
		</div>
	</div>
	
	<div class="menu-description-header">
		<div style="padding-left: 13px; padding-top: 20px; height: 30px;">SETTINGS</div>
		<div style="margin-left: 13px; width:195px; border-bottom: 1px solid #e3e7ea;"></div>
	</div>
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fas fa-cog" title="기본 설정"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="#" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">기본 설정</a>
			</div>
		</div>
	</div>
	<div style="clear: both;">
		<div class="left-navigation-icons">
			<div style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
				<i class="fab fa-expeditedssl" title="mago3D 설정"></i>
			</div>
		</div>
		<div class="left-navigation-detail">
			<div style="padding-top: 20px;">
				<a href="#" style="text-decoration: none; font-weight: bold; color: #2c2d2d;">mago3D 설정</a>
			</div>
		</div>
	</div>
</div>