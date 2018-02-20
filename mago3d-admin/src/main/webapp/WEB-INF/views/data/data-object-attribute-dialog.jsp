<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%-- data object attribute 등록 --%>
	<div class="dataObjectAttributeDialog" title="Data Object 속성 다이얼로그">
		<form id="dataObjectAttributeInfo" name="dataObjectAttributeInfo" action="/data/ajax-insert-data-object-attribute-file.do" method="post" enctype="multipart/form-data">
			<input type="hidden" id="object_attribute_file_data_id" name="object_attribute_file_data_id" value="" />
			<table id="dataObjectAttributeUpload" class="inner-table scope-row">
				<col class="col-sub-label xl" />
				<col class="col-data" />
				<tbody>
					<tr>
						<th class="col-sub-label">데이터명</th>
						<td id="objectAttributeDataName"></td>
					</tr>
					
					<tr>
						<th class="col-sub-label"><spring:message code='data.upload.file'/></th>
						<td>
							<div class="inner-data">
								<input type="file" id="object_attribute_file_name" name="object_attribute_file_name" class="col-data" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button-group">
				<input type="button" onclick="objectAttributeFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
			</div>
		</form>
	</div>
	