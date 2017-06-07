<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="password_tab">
	<form:form id="policyPassword" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id" />
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_change_term">변경 주기</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_change_term" maxlength="5" cssClass="m" />
				<span class="table-desc">일 단위</span>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_min_length">최소 길이</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_min_length" maxlength="2" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_max_length">최대 길이</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_max_length" maxlength="2" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_eng_upper_count">영문 대문자 개수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_eng_upper_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_eng_lower_count">영문 소문자 개수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_eng_lower_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_number_count">숫자 개수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_number_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_special_char_count">특수 문자 개수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_special_char_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_continuous_char_count">연속 문자 제한 개수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="password_continuous_char_count" maxlength="5" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_create_type">초기 패스워드 생성 방법</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<select id="password_create_type" name="password_create_type" class="select">
	  				<option value="0">아이디 + 초기문자</option>
	  				<option value="1">초기문자</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_create_char">초기 패스워드 생성 문자열</form:label>
			</th>
			<td class="col-input"><form:input path="password_create_char" maxlength="32" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="password_exception_char">패스워드 사용불가 문자(XSS)</form:label>
			</th>
			<td class="col-input"><form:input path="password_exception_char" maxlength="10" cssClass="m" /></td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyPassword();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>