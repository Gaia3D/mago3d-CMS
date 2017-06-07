<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geo_tab">
	<form:form id="policyGeo" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
  			<th>
		  		<form:label path="geo_view_library" cssClass="nessItem">View Library</form:label>
 			</th>
 			<td>
	  			<select id="geo_view_library" name="geo_view_library" class="select">
	  				<option value="cesium" selected>Cesium</option>
	  				<option value="worldwind">WorldWind</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_data_path">Data 폴더</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_data_path" cssClass="l" />
				<span class="table-desc"> 디렉토리</span>
				<form:errors path="geo_data_path" cssClass="error" />
			</td>
		</tr>
  		<tr>
  			<th>
		  		<span>CullFace 사용유무</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_cull_face_enable" value="Y" label="사용" />
				<form:radiobutton path="geo_cull_face_enable" value="N" label="사용안함" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span>TimeLine 표시유무</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_time_line_enable" value="Y" label="사용" />
				<form:radiobutton path="geo_time_line_enable" value="N" label="사용안함" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span>초기 카메라 이동 유무</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_init_camera_enable" value="Y" label="사용" />
				<form:radiobutton path="geo_init_camera_enable" value="N" label="사용안함" />
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_latitude">초기 카메라 이동 위도</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_latitude" cssClass="m" />
				<form:errors path="geo_init_latitude" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_longitude">초기 카메라 이동 경도</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_longitude" cssClass="m" />
				<form:errors path="geo_init_longitude" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_height">초기 카메라 이동 높이</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_height" cssClass="m" />
				<form:errors path="geo_init_height" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_duration">초기 카메라 이동 시간</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_duration" cssClass="m" />
				<span class="table-desc"> 초단위</span>
				<form:errors path="geo_init_duration" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyGeo();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>