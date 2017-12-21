<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="site_tab">
	<form:form id="policySite" modelAttribute="policy" method="post" onsubmit="return false;" >
		<form:hidden path="uploadfile_top_value"/>
		<form:hidden path="uploadfile_bottom_value"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="server_ip"><spring:message code='config.server.ip'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="server_ip" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="site_name"><spring:message code='config.service.name'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="site_name" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row"><label for="site-admin"><spring:message code='config.admin.name'/></label></th>
			<td class="col-input"><form:input path="site_admin_name" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="site_admin_mobile_phone"><spring:message code='config.admin.phone'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="site_admin_mobile_phone" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="site_admin_email"><spring:message code='config.admin.email'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="site_admin_email" cssClass="m" /></td>
		</tr>
		<%-- <tr>
			<th class="col-label l" scope="row"><form:label path="uploadfile_top">상단 로고</form:label></th>
			<td class="col-input">
				<input type="file" id="uploadfile_top" name="uploadfile_top" class="l" />
				<input type="submit" class="button" value="전송" />
			</td>
		</tr>
		
		<tr>
			<th class="col-label l" scope="row"><form:label path="uploadfile_bottom">하단 로고</form:label></th>
			<td class="col-input">
				<input type="file" id="uploadfile_bottom" name="uploadfile_bottom" class="l" />
				<input type="submit" class="button" value="전송" />
			</td>
		</tr>			 --%>			
	</table>
	<div class="button-group">
		<div class="center-buttons">
			<a href="#" onclick="updatePolicySite();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>