<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="geoserverTab">
		<form:form id="geoPolicyGeoServer" modelAttribute="geoPolicy" method="post" onsubmit="return false;">
			<table class="input-table scope-row" summary="환경설정 GeoServer 테이블">
			<caption class="hiddenTag">환경설정 GeoServer</caption>
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverEnable">Geoserver 사용유무</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="${use }" path="geoserverEnable" value="true" />
						<form:radiobutton label="${notuse }" path="geoserverEnable" value="false" />
						<form:errors path="geoserverEnable" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverWmsVersion">WMS 버전</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="geoserverWmsVersion" maxlength="5" cssClass="l" />
						<form:errors path="geoserverWmsVersion" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverDataUrl">데이터 URL</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="geoserverDataUrl" maxlength="256" cssClass="l" />
						<form:errors path="geoserverDataUrl" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverDataWorkspace">작업공간명</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="geoserverDataWorkspace" maxlength="60" cssClass="l" />
						<form:errors path="geoserverDataWorkspace" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverDataStore">저장소명</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="geoserverDataStore" maxlength="60" cssClass="l" />
						<form:errors path="geoserverDataStore" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverUser">사용자 계정</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="geoserverUser" maxlength="256" cssClass="l" />
						<form:errors path="geoserverUser" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverPassword">비밀번호</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="geoserverPassword" maxlength="256" cssClass="l" />
						<form:errors path="geoserverPassword" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderEnable">ImageryProvider 사용유무</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input radio-set">
						<form:radiobutton label="${use }" path="geoserverImageproviderEnable" value="true" />
						<form:radiobutton label="${notuse }(기본값)" path="geoserverImageproviderEnable" value="false" />
						<form:errors path="geoserverImageproviderEnable" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderUrl">ImageryProvider 요청 URL</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverImageproviderUrl" maxlength="256" cssClass="l" />
						<form:errors path="geoserverImageproviderUrl" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderLayerName">ImageryProvider 레이어 명</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverImageproviderLayerName" maxlength="60" cssClass="l" />
						<form:errors path="geoserverImageproviderLayerName" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderStyleName">ImageryProvider 스타일 명</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverImageproviderStyleName" maxlength="60" cssClass="l" />
						<form:errors path="geoserverImageproviderStyleName" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderParametersWidth">ImageryProvider 레이어 이미지 가로 크기</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverImageproviderParametersWidth" cssClass="l" onKeyPress="return numkeyCheck(event);" />
						<form:errors path="geoserverImageproviderParametersWidth" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderParametersHeight">ImageryProvider 레이어 이미지 세로 크기</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverImageproviderParametersHeight" cssClass="l" onKeyPress="return numkeyCheck(event);" />
						<form:errors path="geoserverImageproviderParametersHeight" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverImageproviderParametersFormat">ImageryProvider 레이어 포맷형식</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverImageproviderParametersFormat" maxlength="30" cssClass="l" />
						<form:errors path="geoserverImageproviderParametersFormat" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverTerrainproviderLayerName">TerrainProvider 레이어 명</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverTerrainproviderLayerName" maxlength="60" cssClass="l" />
						<form:errors path="geoserverTerrainproviderLayerName" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverTerrainproviderStyleName">TerrainProvider 스타일 명</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverTerrainproviderStyleName" maxlength="60" cssClass="l" />
						<form:errors path="geoserverTerrainproviderStyleName" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverTerrainproviderParametersWidth">TerrainProvider 레이어 이미지 가로 크기</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverTerrainproviderParametersWidth" cssClass="l" onKeyPress="return numkeyCheck(event);" />
						<form:errors path="geoserverTerrainproviderParametersWidth" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverTerrainproviderParametersHeight">TerrainProvider 레이어 이미지 세로 크기</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverTerrainproviderParametersHeight" cssClass="l" onKeyPress="return numkeyCheck(event);" />
						<form:errors path="geoserverTerrainproviderParametersHeight" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="geoserverTerrainproviderParametersFormat">TerrainProvider 레이어 포맷 형식</form:label>
					</th>
					<td class="col-input">
						<form:input path="geoserverTerrainproviderParametersFormat" maxlength="30" cssClass="l" />
						<form:errors path="geoserverTerrainproviderParametersFormat" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyGeoServer();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>