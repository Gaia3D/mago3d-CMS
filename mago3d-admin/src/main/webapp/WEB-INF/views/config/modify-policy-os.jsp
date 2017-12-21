<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="os_tab">
	<form:form id="policyOs" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row"><form:label path="os_timezone">TimeZone</form:label>
			</th>
			<td class="col-input">
				<form:select path="os_timezone" class="select">
	  				<form:option value="Asia/Seoul">Asia/Seoul</form:option>
	  				<form:option value="UTC"><spring:message code='config.utc'/></form:option>
				</form:select>
			</td>
		</tr>							
		<tr>
			<th class="col-label l" scope="row"><form:label path="os_ntp"><spring:message code='config.ntp.server.setting'/></form:label>
			</th>
			<td class="col-input">
				<form:select path="os_ntp" class="select">
	  				<form:option value=""><spring:message code='config.direct.input'/></form:option>
	  				<form:option value="time.bora.net"><spring:message code='config.lg'/></form:option>
	  				<form:option value="time.nuri.net"><spring:message code='config.inet'/></form:option>
	  				<form:option value="time.windows.com"><spring:message code='config.microsoft'/></form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><label for="os_ntp_day"><spring:message code='config.time.setting'/></label></th>
			<spring:message code='config.t' var='time'/>
			<spring:message code='config.m' var='m'/>
			<td class="col-input">
				<form:input path="os_ntp_day" cssClass="s date" />
				<select id="os_ntp_hour" name="os_ntp_hour" class="select">
  					<option value="">${time}</option>
  				</select>
				<span class="delimeter">:</span>
				<select id="os_ntp_minute" name="os_ntp_minute" class="select">
  					<option value="">${m}</option>
  				</select>
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyOs();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>