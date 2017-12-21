<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="content_tab">
	<form:form id="policyContent" modelAttribute="policy" method="post" onsubmit="return false;">
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_cache_version">Cache Version</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_cache_version" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_main_widget_count"><spring:message code='config.main.widget.count'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_main_widget_count" maxlength="2" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_main_widget_interval"><spring:message code='config.main.screen'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="content_main_widget_interval" maxlength="7" cssClass="m" />
				<span class="table-desc"><spring:message code='config.basic.65.5'/></span>
			</td>
		</tr>
		<!-- <tr>
			<th class="col-label l" scope="row">
				<form:label path="content_monitoring_interval">모니터링 감시 간격</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="content_monitoring_interval" maxlength="2" cssClass="m" />
				<span class="table-desc">분 단위</span>
			</td>
		</tr> -->
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_statistics_interval"><spring:message code='config.basic.search'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<spring:message code='config.one.year.unit' var='yearunit'/>
			<spring:message code='config.up.down' var='upDown'/>
			<spring:message code='config.quarter.unit' var='quarterUnit'/>
			<spring:message code='config.month' var='month'/>
			<td class="col-input">
				<select class="select" id="content_statistics_interval" name="content_statistics_interval">
	  				<option value="0">${yearunit}</option>
	  				<option value="1">${upDown}</option>
	  				<option value="2">${quarterUnit}</option>
	  				<option value="3">${month}</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_load_balancing_interval"><spring:message code='config.status.cycle'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="content_load_balancing_interval" maxlength="7" cssClass="m" />
				<span class="table-desc"><spring:message code='config.basic.10.10'/></span>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_menu_group_root"><spring:message code='config.menu.groupname'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_menu_group_root" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_user_group_root"><spring:message code='config.user.group.groupname'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_user_group_root" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_server_group_root"><spring:message code='config.server.groupname'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_server_group_root" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_data_group_root"><spring:message code='config.data.groupname'/></form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_data_group_root" cssClass="m" /></td>
		</tr>				
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyContent();" class="button"><spring:message code='save'/></a>
		</div>
	</div>
	</form:form>
</div>