<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="uploadDataAttributeDialog" title="Data Attribute">
	<form:form id="dataAttributeInfo" name="dataAttributeInfo" action="/datas/attributes" method="post" enctype="multipart/form-data">
		<input type="hidden" id="attributeFileDataId" name="attributeFileDataId" value="" />
		<table class="inner-table scope-row" style="width: 95%;" summary="데이터 속성정보 ">
		<caption class="hiddenTag">데이터 속성정보</caption>
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">데이터명</th>
					<td id="attributeDataName"></td>
				</tr>
				<tr>
					<th class="col-sub-label">업로딩 파일</th>
					<td>
						<div class="inner-data">
							<label for="attributeFileName" class="hiddenTag">속성파일이름</label>
							<input type="file" id="attributeFileName" name="attributeFileName" class="col-data" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="dataAttributeFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>

		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody id="dataAttributeUploadLog">
			</tbody>
		</table>
	</form:form>
</div>

<script id="templateDataAttributeUploadLog" type="text/x-handlebars-template">
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