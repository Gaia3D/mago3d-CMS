<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%-- 일괄등록(File) --%>
	<div class="dataFileDialog" title="<spring:message code='data.all.insert.data'/>">
		<form id="fileInfo" name="fileInfo" action="/data/ajax-insert-data-file.do" method="post" enctype="multipart/form-data">
			<table id="dataFileUpload" class="inner-table scope-row">
				<col class="col-sub-label xl" />
				<col class="col-data" />
				<tbody>
					<tr>
						<th class="col-sub-label">
							<label for="project_id">프로젝트명</label>
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
								<input type="file" id="file_name" name="file_name" class="col-data" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button-group">
				<input type="button" onclick="fileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
			</div>
		</form>
	</div>
	<%-- 일괄등록(Excel) --%>