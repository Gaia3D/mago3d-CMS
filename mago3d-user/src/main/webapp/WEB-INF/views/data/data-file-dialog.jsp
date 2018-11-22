<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="uploadDataFileDialog" title="<spring:message code='data.all.insert'/>">
	<form id="dataFileInfo" name="dataFileInfo" action="/data/ajax-insert-data-file.do" method="post" enctype="multipart/form-data">
		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">
						<label for="project_id"><spring:message code='project.name'/></label>
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
					<th class="col-sub-label"><spring:message code='data.upload.file'/></th>
					<td>
						<div class="inner-data">
							<input type="file" id="data_file_name" name="data_file_name" class="col-data" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="dataFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>
		<table id="dataFileUploadLog" class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
			</tbody>
		</table>
	</form>
</div>
