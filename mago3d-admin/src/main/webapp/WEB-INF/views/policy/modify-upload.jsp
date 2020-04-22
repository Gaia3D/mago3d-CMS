<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="uploadTab">
		<form:form id="policyUpload" modelAttribute="policy" method="post" onsubmit="return false;">
			<table class="input-table scope-row" summary="환경설정 사용자 업로딩 파일 테이블">
			<caption class="hiddenTag">환경설정 사용자 업로딩 파일</caption>
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userUploadType">업로딩 가능 확장자</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userUploadType" maxlength="256" cssClass="l" />
						<form:errors path="userUploadType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userConverterType">변환 가능 확장자</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userConverterType" maxlength="256" cssClass="l" />
						<form:errors path="userConverterType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="shapeUploadType">shpae 업로딩 가능 확장자</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="shapeUploadType" maxlength="256" cssClass="l" />
						<form:errors path="shapeUploadType" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userUploadMaxFilesize">최대 업로딩 사이즈</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userUploadMaxFilesize" maxlength="10" cssClass="m" onKeyPress="return numkeyCheck(event);" />
						<span class="table-desc">MB</span>
						<form:errors path="userUploadMaxFilesize" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="userUploadMaxCount">최대 업로딩 파일 수</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="userUploadMaxCount" maxlength="10" cssClass="m" onKeyPress="return numkeyCheck(event);" />
						<span class="table-desc">개</span>
						<form:errors path="userUploadMaxCount" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyUpload();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>