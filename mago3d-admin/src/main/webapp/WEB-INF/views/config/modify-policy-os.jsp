<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="os_tab">
	<form:form id="policyOs" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row"><form:label path="os_timezone">TimeZone</form:label>
			</th>
			<td class="col-input">
				<form:select path="os_timezone" class="select">
	  				<form:option value="Asia/Seoul">Asia/Seoul</form:option>
	  				<form:option value="UTC">UTC(세계협정시)</form:option>
				</form:select>
			</td>
		</tr>							
		<tr>
			<th class="col-label l" scope="row"><form:label path="os_ntp">NTP 서버 설정</form:label>
			</th>
			<td class="col-input">
				<form:select path="os_ntp" class="select">
	  				<form:option value="">직접입력</form:option>
	  				<form:option value="time.bora.net">LG 유플러스</form:option>
	  				<form:option value="time.nuri.net">아이네트 호스팅</form:option>
	  				<form:option value="time.windows.com">마이크로소프트</form:option>
				</form:select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><label for="os_ntp_day">시간 설정</label></th>
			<td class="col-input">
				<form:input path="os_ntp_day" cssClass="s date" />
				<select id="os_ntp_hour" name="os_ntp_hour" class="select">
  					<option value="">시간</option>
  				</select>
				<span class="delimeter">:</span>
				<select id="os_ntp_minute" name="os_ntp_minute" class="select">
  					<option value="">분</option>
  				</select>
			</td>
		</tr>
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicyOs();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>