<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="security_tab">
	<form:form id="policySecurity" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
  			<th>
		  		<span><spring:message code='config.session.timeout'/></span>
 			</th>
 			<spring:message code='use' var='use'/>
 			<spring:message code='no.use' var='noUse'/>
 			<spring:message code='config.use.otp' var='otp'/>
 			<spring:message code='config.token' var='configToken'/>
 			<spring:message code='config.file' var='file'/>
 			<spring:message code='config.one.year' var='oneYear'/>
 			<spring:message code='config.two.year' var='twoYear'/>
 			<spring:message code='config.permanent.storage' var='permanent'/>
 			<td class="col-input radio-set">
 				<form:radiobutton path="security_session_timeout_yn" value="Y" label="${use}" />
				<form:radiobutton path="security_session_timeout_yn" value="N" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_session_timeout"><spring:message code='config.session.time.out.time'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="security_session_timeout" maxlength="4" cssClass="s" />
				<span class="table-desc"> <spring:message code='config.minute.unit'/></span>
				<form:errors path="security_session_timeout" cssClass="error" />
			</td>
		</tr>
  		<tr>
  			<th>
		  		<span><spring:message code='config.login.user.ip.check'/></span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="security_user_ip_check_yn" value="Y" label="${use}" />
				<form:radiobutton path="security_user_ip_check_yn" value="N" label="${noUse}" />
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_session_hijacking" cssClass="nessItem"><spring:message code='config.session.high'/></form:label>
 			</th>
 			<td>
	  			<select id="security_session_hijacking" name="security_session_hijacking" class="select">
	  				<option value="0" selected>${noUse}</option>
	  				<option value="1">${use}</option>
	  				<option value="2">${otp}</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_sso" cssClass="nessItem">Single Sign-On</form:label>
 			</th>
 			<td>
	  			<select id="security_sso" name="security_sso" class="select">
	  				<option value="0" selected>${noUse}</option>
	  				<option value="1">${configToken}</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
			<th class="col-label l" scope="row">
				<form:label path="security_sso_token_verify_time"><spring:message code='config.single.token'/></form:label>
			</th>
			<td class="col-input">
				<form:input path="security_sso_token_verify_time" maxlength="3" cssClass="s" />
				<span class="table-desc"><spring:message code='config.minute.unit'/></span>
			</td>
		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_log_save_type" cssClass="nessItem"><spring:message code='config.log.save'/></form:label>
 			</th>
 			<td>
	  			<select id="security_log_save_type" name="security_log_save_type" class="select">
	  				<option value="0" selected>DB</option>
	  				<option value="1">${file}</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<form:label path="security_log_save_term" cssClass="nessItem"><spring:message code='config.log.time'/></form:label>
 			</th>
 			<td>
	  			<select id="security_log_save_term" name="security_log_save_term" class="select">
	  				<option value="1" selected>${oneYear}</option>
	  				<option value="2">${twoYear}</option>
	  				<option value="100">${permanent}</option>
	  			</select>
	  		</td>
  		</tr>
  		<tr>
  			<th>
		  		<span><spring:message code='config.dynamic.blocking'/></span>
 			</th>
 			<td class="col-input radio-set">
 				<form:radiobutton path="security_dynamic_block_yn" value="Y" label="${use}" />
				<form:radiobutton path="security_dynamic_block_yn" value="N" label="${noUse}" />
			</td>
  		<tr>
		<tr>
			<th class="col-label l" scope="row">
				<span><spring:message code='config.api.result'/></span>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input radio-set">
				<form:radiobutton path="security_api_result_secure_yn" value="Y" label="${use}" />
				<form:radiobutton path="security_api_result_secure_yn" value="N" label="${noUse}" />
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<span><spring:message code='config.single.information'/></span>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input radio-set">
				<form:radiobutton path="security_masking_yn" value="Y" label="${use}" />
				<form:radiobutton path="security_masking_yn" value="N" label="${noUse}" />
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicySecurity();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>