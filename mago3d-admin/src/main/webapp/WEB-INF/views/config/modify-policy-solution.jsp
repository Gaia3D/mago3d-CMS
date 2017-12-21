<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="solution_tab">
	<form:form id="policySolution" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_name"><spring:message code='config.product.name'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_name" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_version"><spring:message code='config.product.version'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_version" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_company"><spring:message code='config.product.company.name'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_company" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_company_phone"><spring:message code='config.product.company.phone'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_company_phone" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="solution_manager"><spring:message code='config.product.admin'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="solution_manager" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><form:label path="solution_manager_phone"><spring:message code='config.product.admin.phone'/></form:label></th>
			<td class="col-input"><form:input path="solution_manager_phone" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><form:label path="solution_manager_email"><spring:message code='config.product.admin.email'/></form:label></th>
			<td class="col-input"><form:input path="solution_manager_email" cssClass="m" /></td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicySolution();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>