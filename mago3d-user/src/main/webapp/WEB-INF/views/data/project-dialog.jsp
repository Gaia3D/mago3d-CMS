<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="projectDialog" title="<spring:message code='project.information'/>">
	<table class="inner-table scope-row">
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row"><spring:message code='project.name'/></th>
			<td id="project_name_info" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">공유타입</th>
			<td id="sharing_type_info" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row"><spring:message code='use.not'/></th>
			<td id="use_yn_info" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row"><spring:message code='description'/></th>
			<td id="description_info" class="col-data"></td>
		</tr>
	</table>
</div>