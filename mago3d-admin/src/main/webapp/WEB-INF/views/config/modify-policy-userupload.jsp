<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="userupload_tab">
	<form:form id="policyUserUpload" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_upload_type">업로딩 파일 타입</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_upload_type" cssClass="l" />
				<form:errors path="user_upload_type" cssClass="error" />
			</td>
		</tr>			
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_upload_max_filesize">업로딩 최대 사이즈(M)</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_upload_max_filesize" cssClass="l" />
				<form:errors path="user_upload_max_filesize" cssClass="error" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="user_upload_max_count">1회 업로딩 최대 파일수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="user_upload_max_count" cssClass="l" />
				<form:errors path="user_upload_max_count" cssClass="error" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyUserUpload();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>