<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- data object attribute 등록 --%>
<div class="uploadProjectDataAttributeDialog" title="Project Data Attribute">
	<form id="projectDataAttributeInfo" name="projectDataAttributeInfo" action="/data/ajax-insert-project-data-attribute-file.do" method="post">
		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">
						<label for="project_id"><spring:message code='data.project.name'/></label>
					</th>
					<td>
						<select id="project_id" name="project_id" class="select">
							<option value="0"><spring:message code='all'/></option>
<c:forEach var="project" items="${projectList}">
							<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th class="col-sub-label"><spring:message code='data.attribute.path'/></th>
					<td>
						<div class="inner-data">
							<input type="text" id="project_data_attribute_path" name="project_data_attribute_path" class="l" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="projectDataAttributeFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>
		<table id="projectDataAttributeUploadLog" class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
			</tbody>
		</table>
	</form>
</div>
	