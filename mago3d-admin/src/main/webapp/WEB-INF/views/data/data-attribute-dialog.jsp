<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%-- data origin attribute 등록 --%>
	<div class="dataAttributeDialog" title="Data Origin 속성 다이얼로그">
		<form id="dataAttributeInfo" name="dataAttributeInfo" action="/data/ajax-insert-data-attribute-file.do" method="post" enctype="multipart/form-data">
			<input type="hidden" id="attribute_file_data_id" name="attribute_file_data_id" value="" />
			<table id="dataAttributeUpload" class="inner-table scope-row">
				<col class="col-sub-label xl" />
				<col class="col-data" />
				<tbody>
					<tr>
						<th class="col-sub-label">데이터명</th>
						<td id="attributeDataName"></td>
					</tr>
					
					<tr>
						<th class="col-sub-label"><spring:message code='data.upload.file'/></th>
						<td>
							<div class="inner-data">
								<input type="file" id="attribute_file_name" name="attribute_file_name" class="col-data" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button-group">
				<input type="button" onclick="dataAttributeFileUpload();" class="button" value="<spring:message code='data.file.save'/>"/>
			</div>
		</form>
	</div>