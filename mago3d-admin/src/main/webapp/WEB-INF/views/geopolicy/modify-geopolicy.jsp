<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="geopolicyTab">
		<form:form id="geoPolicyGeoInfo" modelAttribute="geoPolicy" method="post" onsubmit="return false;">
			<table class="input-table scope-row" summary="환경설정 공간정보 테이블">
			<caption class="hiddenTag">환경설정 공간정보 테이블</caption>
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="cesiumIonToken">Cesium ion token</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="cesiumIonToken" maxlength="256" cssClass="l" />
						<form:errors path="cesiumIonToken" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="dataServicePath">Data 폴더</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="dataServicePath" maxlength="256" cssClass="l" />
						<form:errors path="dataServicePath" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="dataChangeRequestDecision">Data 변경 요청 처리</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="결재(기본값)" path="dataChangeRequestDecision" value="approval" />
						<form:radiobutton label="자동승인" path="dataChangeRequestDecision" value="auto" />
						<form:errors path="dataChangeRequestDecision" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="terrainType">Terrain 유형</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="Cesium 기본" path="terrainType" value="cesium-default" />
						<form:radiobutton label="GeoServer" path="terrainType" value="geoserver" />
						<form:radiobutton label="Cesium Ion 기본" path="terrainType" value="cesium-ion-default" />
						<form:radiobutton label="Cesium Ion CDN" path="terrainType" value="cesium-ion-cdn" />
						<form:radiobutton label="Cesium Docker Provider" path="terrainType" value="cesium-customer" />
						<form:errors path="terrainType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="terrainValue">Terrain 값(URL 또는 Code)</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="terrainValue" maxlength="256" cssClass="l" />
						<form:errors path="terrainValue" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyGeoInfo();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>