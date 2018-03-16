<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="uploadDataAttributeDialog" title="Data Origin Attribute">
	<form id="dataAttributeInfo" name="dataAttributeInfo" action="/data/ajax-insert-data-attribute-file.do" method="post" enctype="multipart/form-data">
		<input type="hidden" id="attribute_file_data_id" name="attribute_file_data_id" value="" />
		<table class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
				<tr>
					<th class="col-sub-label"><spring:message code='data.name'/></th>
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
		<table id="dataAttributeUploadLog" class="inner-table scope-row" style="width: 95%;">
			<col class="col-sub-label xl" />
			<col class="col-data" />
			<tbody>
			</tbody>
		</table>
	</form>
</div>