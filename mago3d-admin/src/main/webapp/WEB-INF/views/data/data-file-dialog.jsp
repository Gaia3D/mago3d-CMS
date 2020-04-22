<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="uploadDataFileDialog" title="<spring:message code='data.all.insert'/>">
	<form:form id="dataFileInfo" name="dataFileInfo" action="/datas/bulk-upload" method="post" enctype="multipart/form-data">
		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">
						<label for="dataGroupId">데이터 그룹명</label>
					</th>
					<td>
						<select id="dataGroupId" name="dataGroupId" class="selectBoxClass">
<c:forEach var="dataGroup" items="${dataGroupList}">
							<option value="${dataGroup.dataGroupId}">${dataGroup.dataGroupName}</option>
</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th class="col-sub-label"><spring:message code='data.upload.file'/></th>
					<td>
						<div class="inner-data">
							<input type="file" id="dataFileName" name="dataFileName" class="col-data" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="uploadDataFileSave();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>
		<table id="dataFileUploadLog" class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
			</tbody>
		</table>
	</form:form>
</div>

<script id="templateDataFileUploadLog" type="text/x-handlebars-template">
	<tr>
		<td colspan="2" style="text-align: center;">Result of parsing</td>
	</tr>
	<tr>
		<td> 총 건 수</td>
		<td>{{totalCount}}</td>
	</tr>
	<tr>
		<td> 성공 건수 </td>
		<td>{{parseSuccessCount}}</td>
	</tr>
	<tr>
		<td> 실패 건수 </td>
		<td> {{parseErrorCount}}</td>
	</tr>
	<tr>
		<td> DB 등록 건수 </td>
		<td> {{insertSuccessCount}} </td>
	</tr>
	<tr>
		<td> DB 수정 건수 </td>
		<td> {{updateSuccessCount}} </td>
	</tr>
	<tr>
		<td> DB 실패 건수 </td>"
		<td> {{insertErrorCount}}</td>
	</tr>
</script>
