<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="dataAttributeDialog" title="Data Detail Info">
	<div><b><spring:message code='geo.spatial.info'/></b></div>
	<table class="list-table scope-col" style="width: 100%;">
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row" style="text-align: left; width: 30%"><spring:message code='data.key'/></th>
			<td id="detailDataKey" class="col-data" style="width: 70%;"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='data.name'/></th>
			<td id="detailDataName" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='latitude'/></th>
			<td id="detailLatitude" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='longitude'/></th>
			<td id="detailLongitude" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='height'/></th>
			<td id="detailHeight" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='heading'/></th>
			<td id="detailHeading" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='pitch'/></th>
			<td id="detailPitch" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='roll'/></th>
			<td id="detailRoll" class="col-data"></td>
		</tr>
	</table>
	<div style="margin-top: 10px;">
		<b>Data Attribute</b>(It is stored in json format in PostgreSQL.)<br/>
	</div>
	<div style="border: 1px solid #d9d9d9;">
		<div id="detailAttribute" style="padding: 5px;"></div>
	</div>
	<div style="margin-top: 10px;"><b>Object Attribute</b></div>
	<div style="border: 1px solid #d9d9d9;">
		<div style="padding: 5px;">
			There is a maximum of 1 million objects per IFC data. <br/>
			For lists, the number is too large to provide search functionality.
		</div>
	</div>
</div>