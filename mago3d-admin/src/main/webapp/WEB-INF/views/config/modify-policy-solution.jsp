<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="solution_tab">
	<form:form id="policySolution" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_name">제품명</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_name" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_version">제품 버전</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_version" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_company">제품 회사명</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_company" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_company_phone">제품 회사 연락처</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_company_phone" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_manager">제품 회사 담당자</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_manager" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><form:label path="solution_manager_phone">제품 회사 담당자 핸드폰 번호</form:label></th>
			<td class="col-input"><form:input path="solution_manager_phone" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><form:label path="solution_manager_email">제품 회사담당자 이메일</form:label></th>
			<td class="col-input"><form:input path="solution_manager_email" cssClass="m" /></td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicySolution();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>