<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="geo_tab">
	<form:form id="policyGeo" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		
		<tr>
  			<th>
		  		<form:label path="geo_view_library" cssClass="nessItem"><spring:message code='config.geo.viewlibrary'/></form:label>
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
				<form:label path="geo_data_path"><spring:message code='config.data.folder'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_data_path" cssClass="l" />
				<span class="table-desc"><spring:message code='config.directory'/></span>
				<form:errors path="geo_data_path" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_data_default_projects">시작시 로딩 프로젝트</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_data_default_projects_view" cssClass="l" />
				<form:hidden path="geo_data_default_projects" />
				<input type="button" id="projectFind" value="찾기" />
			</td>
		</tr>
  		<tr>
  			<th>
		  		<span><spring:message code='config.cullface.use.not'/></span>
 			</th>
 			<spring:message code='use' var='use'/>
 			<spring:message code='no.use' var='noUse'/>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_cull_face_enable" value="true" label="${use}" />
				<form:radiobutton path="geo_cull_face_enable" value="false" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span><spring:message code='config.timeline.use.not'/></span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_time_line_enable" value="true" label="${use}" />
				<form:radiobutton path="geo_time_line_enable" value="false" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span><spring:message code='config.init.camera.move'/></span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="geo_init_camera_enable" value="true" label="${use}" />
				<form:radiobutton path="geo_init_camera_enable" value="false" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_latitude"><spring:message code='config.init.camera.lattiude'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_latitude" cssClass="m" />
				<form:errors path="geo_init_latitude" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_longitude"><spring:message code='config.init.camera.longitude'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_longitude" cssClass="m" />
				<form:errors path="geo_init_longitude" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_height"><spring:message code='config.init.camera.height'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_height" cssClass="m" />
				<form:errors path="geo_init_height" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_duration"><spring:message code='config.init.camera.time'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_duration" cssClass="m" />
				<span class="table-desc"><spring:message code='config.second.unit'/></span>
				<form:errors path="geo_init_duration" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_default_terrain">Terrain</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_default_terrain" cssClass="l" />
				<form:errors path="geo_init_default_terrain" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_init_default_fov">Field Of View</form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_init_default_fov" cssClass="m" />
				<form:errors path="geo_init_default_fov" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod0"><spring:message code='config.geo.lod0'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod0" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod0" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod1"><spring:message code='config.geo.lod1'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod1" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod1" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod2"><spring:message code='config.geo.lod2'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod2" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod2" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod3"><spring:message code='config.geo.lod3'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod3" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod3" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod4"><spring:message code='config.geo.lod4'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod4" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod4" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_lod5"><spring:message code='config.geo.lod5'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_lod5" cssClass="m" />&nbsp;M
				<form:errors path="geo_lod5" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_ambient_reflection_coef"><spring:message code='config.geo.ambient_reflection_coeficient'/></form:label>
			</th>
			<td class="col-input" style="padding-left: 20px;">
				<div id="geo_ambient_reflection_coef" style="display: inline-block; width: 230px;">
					<div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"></div>
				</div>
				<form:hidden path="geo_ambient_reflection_coef" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_diffuse_reflection_coef"><spring:message code='config.geo.diffuse_reflection_coef'/></form:label>
			</th>
			<td class="col-input" style="padding-left: 20px;">
				<div id="geo_diffuse_reflection_coef" style="display: inline-block; width: 230px;">
					<div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"></div>
				</div>
				<form:hidden path="geo_diffuse_reflection_coef" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_specular_reflection_coef"><spring:message code='config.geo.specular_reflection_coef'/></form:label>
			</th>
			<td class="col-input" style="padding-left: 20px;">
				<div id="geo_specular_reflection_coef" style="display: inline-block; width: 230px;">
					<div id="geo_specular_reflection_coef_view" class="ui-slider-handle"></div>
				</div>
				<form:hidden path="geo_specular_reflection_coef" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_ambient_color"><spring:message code='config.geo.geo_ambient_color'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_ambient_color" cssClass="m"
					data-palette='["#D50000","#304FFE","#00B8D4","#00C853","#FFD600","#FF6D00","#FF1744","#3D5AFE","#00E5FF","#00E676","#FFEA00",
			       "#FF9100","#FF5252","#536DFE","#18FFFF","#69F0AE","#FFFF00","#FFAB40"]' />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_specular_color"><spring:message code='config.geo.geo_specular_color'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_specular_color" cssClass="m"
					data-palette='["#D50000","#304FFE","#00B8D4","#00C853","#FFD600","#FF6D00","#FF1744","#3D5AFE","#00E5FF","#00E676","#FFEA00",
			       "#FF9100","#FF5252","#536DFE","#18FFFF","#69F0AE","#FFFF00","#FFAB40"]' />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="geo_ssao_radius"><spring:message code='config.geo.ssaoradius'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="geo_ssao_radius" cssClass="m" />
				<form:errors path="geo_ssao_radius" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyGeo();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>

<!-- Dialog -->
<div id="dataDialog" class="dataDialog" title="프로젝트 목록">
	<table class="list-table scope-col">
		<col class="col-number" />
		<col class="col-name" />
		<col class="col-name" />
		<col class="col-number" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-number" />
		<col class="col-date" />
		<thead>
			<tr>
				<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
				<th scope="col" class="col-name">Key</th>
				<th scope="col" class="col-name">프로젝트명</th>
				<th scope="col" class="col-number">순서</th>
				<th scope="col" class="col-toggle">기본값</th>
				<th scope="col" class="col-toggle">사용유무</th>
				<th scope="col" class="col-toggle">위도</th>
				<th scope="col" class="col-toggle">경도</th>
				<th scope="col" class="col-toggle">높이</th>
				<th scope="col" class="col-number">이동시간</th>
				<th scope="col" class="col-date">등록일</th>
			</tr>
		</thead>
		<tbody id="projectList">
		</tbody>
	</table>
	<div class="button-group">
		<input type="button" id="projectSelect" class="button" value="선택"/>
	</div>
</div>
