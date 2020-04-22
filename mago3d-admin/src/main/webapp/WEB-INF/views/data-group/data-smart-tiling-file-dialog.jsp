<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="uploadDataSmartTilingDialog" title="SmartTiling 데이터 등록">
	<form:form id="dataSmartTilingFileInfo" name="dataSmartTilingFileInfo" action="/datas/smart-tiling" method="post" enctype="multipart/form-data">
		<input type="hidden" id="smartTilingFileDataGroupId" name="smartTilingFileDataGroupId" value="" />
		<table class="inner-table scope-row" style="width: 95%;" summary="SmatTiling 데이터 등록">
		<caption class="hiddenTag">데이터 등록</caption>
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">데이터 그룹명</th>
					<td id="smartTilingDataGroupName"></td>
				</tr>
				<tr>
					<th class="col-sub-label">업로딩 파일</th>
					<td>
						<div class="inner-data">
							<label for="smartTilingFileName" class="hiddenTag">smartTiling 파일이름</label>
							<input type="file" id="smartTilingFileName" name="smartTilingFileName" class="col-data" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="dataSmartTilingFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>

		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody id="dataSmartTilingUploadLog">
			</tbody>
		</table>
	</form:form>
</div>

<script id="templateDataSmartTilingUploadLog" type="text/x-handlebars-template">
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