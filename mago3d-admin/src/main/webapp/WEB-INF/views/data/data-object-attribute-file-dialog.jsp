<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- data object attribute 등록 --%>
<div class="uploadDataObjectAttributeDialog" title="Data Object Attribute">
	<form:form id="dataObjectAttributeInfo" name="dataObjectAttributeInfo" action="/datas/object/attributes" method="post" enctype="multipart/form-data">
		<input type="hidden" id="objectAttributeFileDataId" name="objectAttributeFileDataId" value="" />
		<table class="inner-table scope-row" style="width: 95%;" summary="업로드 데이터 오브젝트 속성 다이얼로그">
		<caption class="hiddenTag">업로드 데이터 오브젝트 속성 다이얼로그</caption>
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label">데이터명</th>
					<td id="objectAttributeDataName"></td>
				</tr>
				<tr>
					<th class="col-sub-label">업로딩 파일</th>
					<td>
						<div class="inner-data">
							<label for="objectAttributeFileName" class="hiddenTag">오브젝트 속성 파일명</label>
							<input type="file" id="objectAttributeFileName" name="objectAttributeFileName" class="col-data" />
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" onclick="dataObjectAttributeFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
		</div>
		<table class="inner-table scope-row" style="width: 95%;" summary="데이터 오브젝트 속성 업로드 테이블">
		<caption class="hiddenTag">데이터 오브젝트 속성 업로드</caption>
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody id="dataObjectAttributeUploadLog">
			</tbody>
		</table>
	</form:form>
</div>

<script id="templateDataObjectAttributeUploadLog" type="text/x-handlebars-template">
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