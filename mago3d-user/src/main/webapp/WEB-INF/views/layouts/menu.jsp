<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="clfix">
	<div id="nav-main">
		<ul class="nav-main-list" style="list-style: none;">
			<li class="profile-menu" style="height: 110px;">
				<img id="smallUserProfileImage" src="/images/1px.png">
			</li>
			<li class="project-menu" style="height: 190px;" onclick="location.href='/project/list-project.do'">
				<span style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
					<i class="fas fa-cubes" title="프로젝트"></i>
				</span>
			</li>
			<li class="converter-menu" style="height: 150px;" onclick="location.href='/upload-data/input-upload-data.do'">
				<span style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
					<i class="fas fa-cloud-upload-alt" title="Converter"></i>
				</span>
			</li>
			<li class="settings-menu" style="height: 100px;" onclick="location.href='/membership/modify-membership.do'">
				<span style="padding-top:0px; font-size:35px; color: Mediumslateblue;">
					<i class="fas fa-cog" title="Settings"></i>
				</span>
			</li>
		</ul>
	</div>
	<div id="nav-sub">
		<ul class="nav-sub-list" style="list-style: none;">
			<li style="height: 110px;">
				<img id="userProfileImage" src="/images/ko/profile_example.png" style="width: 80px; height: 80px;" />
				<div style="padding-left: 15px;">Profile</div>
			</li>
			<li>
				<span style="display:inline-block; padding-top: 20px; height: 50px;">
					<a href="#" style="text-decoration: none; font-size:15px; font-weight: bold; color: #2c2d2d;">Visualization</a>
				</span> 
				<span style="float:right; padding-top:15px; padding-right:10px; font-size:25px; color: Mediumslateblue;">
					<i class="fas fa-angle-down" title="펼치기"></i>
				</span>
				<ul style="list-style: none;">
					<li style="padding-top:0px; height: 105px; font-size: 14px;">
						<a href="/project/map-project.do" style="text-decoration: none; color: #2c2d2d;">프로젝트 목록</a>
						<form id="projectMenuForm" action="">
						<ul style="list-style: none; margin-top: 5px; padding-top: 8px; height: 80px; width: 150px; background: #f5f5f5;">
							<li style="padding-left: 6px; padding-top:0px; height: 30px; font-size: 14px;">
								<select id="project_sharing_type" name="project_sharing_type" class="select" style="width: 140px; height: 32px;">
									<option value="1" selected="selected"> 공개 프로젝트 </option>
									<option value="2" disabled="disabled"> 개인 프로젝트 </option>
					          		<option value="3" disabled="disabled"> 공유 프로젝트 </option>
					          		<option value="0" disabled="disabled"> 공통 프로젝트 </option>
								</select>
							</li>
							<li style="padding-left: 6px; padding-top:5px; height: 30px; font-size: 14px;">
								<label for="project_view_map">MAP</label>
							    <input type="radio" id="project_view_map" name="project_view_type" class="project-view-radio"> 
							    <label for="project_view_table">TABLE</label>
							    <input type="radio" id="project_view_table" name="project_view_type" class="project-view-radio">
							</li>
						
						</ul>
						</form>
					</li>
					<li style="padding-top:10px; height: 35px; font-size: 14px;">
						<a href="/data/list-data.do" style="text-decoration: none; color: #2c2d2d;">데이터 목록</a>
					</li>
				</ul>
			</li>
			<li>
				<span style="display:inline-block; padding-top: 20px; height: 50px;">
					<a href="#" style="text-decoration: none; font-size:15px; font-weight: bold; color: #2c2d2d;">Converter</a>
				</span> 
				<span style="float:right; padding-top:15px; padding-right:10px; font-size:25px; color: Mediumslateblue;">
					<i class="fas fa-angle-down" title="펼치기"></i>
				</span>
				<ul style="list-style: none;">
					<li style="padding-top:0px; height: 25px; font-size: 14px;">
						<a href="/upload-data/input-upload-data.do" style="text-decoration: none; color: #2c2d2d;">파일 업로딩</a>
					</li>
					<li style="padding-top:0px; height: 25px; font-size: 14px;">
						<a href="/upload-data/list-upload-data.do" style="text-decoration: none; color: #2c2d2d;">업로딩 파일 목록</a>
					</li>
					<li style="padding-top:0px; height: 25px; font-size: 14px;">
						<a href="/converter/list-converter-job.do" style="text-decoration: none; color: #2c2d2d;">Converter 목록</a>
					</li>
					<li style="padding-top:0px; height: 25px; font-size: 14px;">
						<a href="/converter/list-converter-job-file.do" style="text-decoration: none; color: #2c2d2d;">Converter 파일 목록</a>
					</li>
				</ul>
			</li>
			<li>
				<span style="display:inline-block; padding-top: 20px; height: 50px;">
					<a href="#" style="text-decoration: none; font-size:15px; font-weight: bold; color: #2c2d2d;">Settings</a>
				</span> 
				<span style="float:right; padding-top:15px; padding-right:10px; font-size:25px; color: Mediumslateblue;">
					<i class="fas fa-angle-down" title="펼치기"></i>
				</span>
				<ul style="list-style: none;">
					<li style="padding-top:0px; height: 25px; font-size: 14px;">
						<a href="/membership/modify-membership.do" style="text-decoration: none; color: #2c2d2d;">Membership 설정</a>
					</li>
					<li style="padding-top:0px; height: 25px; font-size: 14px;">
						<a href="/user/modify-user-policy.do" style="text-decoration: none; color: #2c2d2d;">mago3D 설정 </a>
					</li>
				</ul>
			</li>
		</ul>
	</div>
</nav>