<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="security_tab">
	<form:form id="policySecurity" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
  			<th>
		  		<span>세션 타임아웃</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="security_session_timeout_yn" value="Y" label="사용" />
				<form:radiobutton path="security_session_timeout_yn" value="N" label="사용안함" />
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_session_timeout">세션 타임아웃 시간</form:label>
			</th>
			<td class="col-input">
				<form:input path="security_session_timeout" maxlength="4" cssClass="s" />
				<span class="table-desc"> 분 단위</span>
				<form:errors path="security_session_timeout" cssClass="error" />
			</td>
		</tr>
  		<tr>
  			<th>
		  		<span>로그인시 사용자 IP 체크</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="security_user_ip_check_yn" value="Y" label="사용" />
				<form:radiobutton path="security_user_ip_check_yn" value="N" label="사용안함" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_session_hijacking" cssClass="nessItem">세션 하이재킹 처리</form:label>
 			</th>
 			<td>
	  			<select id="security_session_hijacking" name="security_session_hijacking" class="select">
	  				<option value="0" selected>사용안함</option>
	  				<option value="1">사용</option>
	  				<option value="2">사용(동적IP OTP 추가인증)</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_sso" cssClass="nessItem">Single Sign-On</form:label>
 			</th>
 			<td>
	  			<select id="security_sso" name="security_sso" class="select">
	  				<option value="0" selected>사용안함</option>
	  				<option value="1">TOKEN 인증</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_sso_token_verify_time">Single Sign-On TOKEN DB검증 유효시간</form:label>
			</th>
			<td class="col-input">
				<form:input path="security_sso_token_verify_time" maxlength="3" cssClass="s" />
				<span class="table-desc">분 단위</span>
			</td>
		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_log_save_type" cssClass="nessItem">로그 저장 방법</form:label>
 			</th>
 			<td>
	  			<select id="security_log_save_type" name="security_log_save_type" class="select">
	  				<option value="0" selected>DB</option>
	  				<option value="1">파일</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_log_save_term" cssClass="nessItem">로그 보존 기간</form:label>
 			</th>
 			<td>
	  			<select id="security_log_save_term" name="security_log_save_term" class="select">
	  				<option value="1" selected>1년</option>
	  				<option value="2">2년</option>
	  				<option value="100">영구보관</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span>동적 차단</span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="security_dynamic_block_yn" value="Y" label="사용" />
				<form:radiobutton path="security_dynamic_block_yn" value="N" label="사용안함" />
			</td>
  		<tr>
		<tr>
			<th class="col-label l" scope="row">
				<span>API 호출 결과 암호화</span>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input radio-set">
				<form:radiobutton path="security_api_result_secure_yn" value="Y" label="사용" />
				<form:radiobutton path="security_api_result_secure_yn" value="N" label="사용안함" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<span>개인정보 마스킹 처리</span>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input radio-set">
				<form:radiobutton path="security_masking_yn" value="Y" label="사용" />
				<form:radiobutton path="security_masking_yn" value="N" label="사용안함" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicySecurity();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>