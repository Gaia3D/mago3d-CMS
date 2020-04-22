<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="dataGroupDialog" title="데이터 그룹 정보">
	<table class="inner-table scope-row" summary="데이터 그룹 정보">
	<caption class="hiddenTag">데이터 그룹</caption>
		<col class="col-label" />
		<col class="col-data" />
		<tr>
			<th class="col-label" scope="row">데이터 그룹명</th>
			<td id="dataGroupNameInfo" class="col-data ellipsis"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터 그룹 Key</th>
			<td id="dataGroupKeyInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">그룹 분류</th>
			<td id="dataGroupTargetInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">공유타입</th>
			<td id="sharingInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">사용자 아디디</th>
			<td id="userIdInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">기본유무</th>
			<td id="basicInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">사용유무</th>
			<td id="availableInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">경도 / 위도</th>
			<td id="locationInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">데이터 건수</th>
			<td id="dataCountInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row">메타정보</th>
			<td id="metainfoInfo" class="col-data"></td>
		</tr>
		<tr>
			<th class="col-label" scope="row"><spring:message code='description'/></th>
			<td id="descriptionInfo" class="col-data"></td>
		</tr>
	</table>
</div>