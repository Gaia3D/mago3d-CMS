<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- Dialog 그룹 정보 보기 -->
	<div id="userGroupInfoDialog" title="사용자 그룹 정보" class="dialog">
		<table class="inner-table scope-row" summary="사용자 그룹 정보 보기">
		<caption class="hiddenTag">그룹 정보</caption>
			<col class="col-label" />
			<col class="col-data" />
			<tr>
				<th class="col-label" scope="row">사용자 그룹명</th>
				<td id="userGroupNameInfo" class="col-data ellipsis"></td>
			</tr>
			<tr>
				<th class="col-label" scope="row">그룹Key</th>
				<td id="userGroupKeyInfo" class="col-data"></td>
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
				<th class="col-label" scope="row"><spring:message code='description'/></th>
				<td id="descriptionInfo" class="col-data"></td>
			</tr>
		</table>
	</div>

	<!-- Dialog 그룹 목록 보기 -->
	<div id="userGroupListDialog" title="사용자 그룹 선택" class="dialog">
		<table class="list-table scope-col" summary="사용자 그룹 선택">
		<caption class="hiddenTag">그룹 선택</caption>
			<col class="col-name" />
			<col class="col-toggle" />
			<col class="col-id" />
			<col class="col-function" />
			<col class="col-date" />
			<col class="col-toggle" />
			<thead>
				<tr>
					<th scope="col" class="col-name">사용자 그룹명</th>
					<th scope="col" class="col-toggle">사용 여부</th>
					<th scope="col" class="col-toggle">설명</th>
					<th scope="col" class="col-date">등록일</th>
					<th scope="col" class="col-date">선택</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty userGroupList}">
					<tr>
						<td colspan="6" class="col-none">사용자 그룹이 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:if test="${!empty userGroupList}">
					<c:set var="paddingLeftValue" value="0" />
					<c:forEach var="userGroup" items="${userGroupList}" varStatus="status">
						<c:if test="${userGroup.depth eq '1'}">
				            <c:set var="depthClass" value="oneDepthClass" />
				            <c:set var="paddingLeftValue" value="0px" />
				        </c:if>
				        <c:if test="${userGroup.depth eq '2'}">
				            <c:set var="depthClass" value="twoDepthClass" />
				            <c:set var="paddingLeftValue" value="40px" />
				        </c:if>
				        <c:if test="${userGroup.depth eq '3'}">
				            <c:set var="depthClass" value="threeDepthClass" />
				            <c:set var="paddingLeftValue" value="80px" />
				        </c:if>
						<tr class="${depthClass} ${depthParentClass} ${ancestorClass}" style="${depthStyleDisplay}">
							<td class="col-name ellipsis" style="max-width:200px; text-align: left;" nowrap="nowrap">
								<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"></span>
								${userGroup.userGroupName }
							</td>
							<td class="col-type">
						        <c:if test="${userGroup.available eq 'true'}">사용</c:if>
						        <c:if test="${userGroup.available eq 'false'}">미사용</c:if>
						    </td>
						    <td class="col-key">${userGroup.description}</td>
						    <td class="col-date">
						    	<fmt:parseDate value="${userGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
						    </td>
						    <td class="col-toggle">
						    	<a href="#" onclick="confirmParent('${userGroup.userGroupId}', '${userGroup.userGroupName}'); return false;">확인</a></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		<div class="button-group">
			<input type="button" id="rootParentSelect" class="button" value="최상위(ROOT) 그룹으로 저장"/>
		</div>
	</div>
