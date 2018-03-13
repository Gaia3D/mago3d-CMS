<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="dataInfoLogDialog" title="Data Info Change Log">
	<table class="inner-table scope-row" style="width: 100%;">
		<col class="col-label" />
		<col class="col-data" />
		<col class="col-data" />
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="width: 30%; text-align: center"><spring:message code='common.categorize'/></th>
			<th class="col-label" scope="row" style="width: 35%; text-align: center"><spring:message code='common.before'/></th>
			<th class="col-label" scope="row" style="width: 35%; text-align: center"><spring:message code='common.after'/></th>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left;"><spring:message code='common.latitude'/></th>
			<td id="beforeLatitude" class="col-data"></td>
			<td id="afterLatitude" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='common.longitude'/></th>
			<td id="beforeLongitude" class="col-data"></td>
			<td id="afterLongitude" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='common.height'/></th>
			<td id="beforeHeight" class="col-data"></td>
			<td id="afterHeight" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='common.heading'/></th>
			<td id="beforeHeading" class="col-data"></td>
			<td id="afterHeading" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='common.pitch'/></th>
			<td id="beforePitch" class="col-data"></td>
			<td id="afterPitch" class="col-data" style="color: blue"></td>
		</tr>
		<tr style="height: 30px;">
			<th class="col-label" scope="row" style="text-align: left"><spring:message code='common.roll'/></th>
			<td id="beforeRoll" class="col-data"></td>
			<td id="afterRoll" class="col-data" style="color: blue"></td>
		</tr>
	</table>
</div>