<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="dataInfoChangeDialog" title="Data Info Change Log">
	<table class="list-table scope-col" style="width: 100%;">
		<col class="col-label" />
		<col class="col-data" />
		<col class="col-data" />
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="width: 30%; text-align: center"><spring:message code='categorize'/></th>
			<th class="col-label" scope="row" style="width: 35%; text-align: center"><spring:message code='before'/></th>
			<th class="col-label" scope="row" style="width: 35%; text-align: center"><spring:message code='after'/></th>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left;"><spring:message code='latitude'/></th>
			<td id="beforeLatitude" class="col-data"></td>
			<td id="afterLatitude" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='longitude'/></th>
			<td id="beforeLongitude" class="col-data"></td>
			<td id="afterLongitude" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='height'/></th>
			<td id="beforeHeight" class="col-data"></td>
			<td id="afterHeight" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='heading'/></th>
			<td id="beforeHeading" class="col-data"></td>
			<td id="afterHeading" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='pitch'/></th>
			<td id="beforePitch" class="col-data"></td>
			<td id="afterPitch" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='roll'/></th>
			<td id="beforeRoll" class="col-data"></td>
			<td id="afterRoll" class="col-data" style="color: blue"></td>
		</tr>
	</table>
</div>