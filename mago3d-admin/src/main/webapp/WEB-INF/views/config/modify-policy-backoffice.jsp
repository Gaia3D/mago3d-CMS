<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="backoffice_tab">
	<form:form id="policyBackoffice" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-sub-label" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="rowgroup" rowspan="4">E-mail 연동</th>
			<td class="col-sub-label"><form:label path="backoffice_email_host">SMTP HOST</form:label></td>
			<td class="col-input"><form:input path="backoffice_email_host" cssClass="m" /></td>
		</tr>
		<tr>
			<td class="col-sub-label"><form:label path="backoffice_email_port">PORT</form:label></td>
			<td class="col-input"><form:input path="backoffice_email_port" cssClass="m" /></td>
		</tr>
		<tr>
			<td class="col-sub-label"><form:label path="backoffice_email_user">유저명</form:label></td>
			<td class="col-input"><form:input path="backoffice_email_user" cssClass="m" /></td>
		</tr>
		<tr>
			<td class="col-sub-label"><form:label path="backoffice_email_password">패스워드</form:label></td>
			<td class="col-input"><form:input path="backoffice_email_password" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="rowgroup" rowspan="5">사용자 등록용 DB 연동</th>
			<td class="col-sub-label"><form:label path="backoffice_user_db_driver">JDBC Driver</form:label></td>
			<td class="col-input">
				<select id="backoffice_user_db_driver" name="backoffice_user_db_driver" class="select">
					<option value="oracle">Oracle</option>
					<option value="postgresql">PostgreSQL</option>
					<option value="mysql">My-SQL</option>
					<option value="mssql">MS-SQL</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="col-sub-label"><form:label path="backoffice_user_db_url">URL</form:label></td>
			<td class="col-input">
				<form:input path="backoffice_user_db_url" cssClass="l" />
			</td>
		</tr>
		<tr>
			<td class="col-sub-label"><form:label path="backoffice_user_db_user">User</form:label></td>
			<td class="col-input"><form:input path="backoffice_user_db_user" cssClass="m" /></td>
		</tr>
		<tr>
			<td class="col-sub-label"><form:label path="backoffice_user_db_password">Password</form:label></td>
			<td class="col-input">
				<form:password path="backoffice_user_db_password" showPassword="true" cssClass="m" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyBackoffice();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>