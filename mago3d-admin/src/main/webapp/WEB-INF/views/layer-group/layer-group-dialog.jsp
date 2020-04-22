<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="layerGroupDialog" class="dialog">
	<table class="list-table scope-col" summary="2D 레이어 그룹 다이얼로그">
	<caption class="hiddenTag">2D 레이어 그룹 다이얼로그</caption>
		<col class="col-number" />
			<col class="col-name" />
			<col class="col-toggle" />
			<col class="col-id" />
			<col class="col-function" />
			<col class="col-date" />
			<col class="col-toggle" />
			<thead>
				<tr>
					<th scope="col" class="col-name">Layer 그룹명</th>
					<th scope="col" class="col-toggle">사용 여부</th>
					<th scope="col" class="col-toggle">사용자 아이디</th>
					<th scope="col" class="col-toggle">설명</th>
					<th scope="col" class="col-date">등록일</th>
					<th scope="col" class="col-date">선택</th>
				</tr>
			</thead>
		<tbody>
<c:if test="${empty layerGroupList }">
		<tr>
			<td colspan="6" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
		</tr>
</c:if>
<c:if test="${!empty layerGroupList }">
	<c:set var="paddingLeftValue" value="0" />
	<c:forEach var="layerGroup" items="${layerGroupList}" varStatus="status">
		<c:if test="${layerGroup.depth eq '1' }">
           <c:set var="depthClass" value="oneDepthClass" />
           <c:set var="paddingLeftValue" value="0px" />
       </c:if>
       <c:if test="${layerGroup.depth eq '2' }">
           <c:set var="depthClass" value="twoDepthClass" />
           <c:set var="paddingLeftValue" value="40px" />
       </c:if>
       <c:if test="${layerGroup.depth eq '3' }">
           <c:set var="depthClass" value="threeDepthClass" />
           <c:set var="paddingLeftValue" value="80px" />
       </c:if>

		<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
			<td class="col-name ellipsis" style="max-width:300px; text-align: left;" nowrap="nowrap">
				<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"></span>
		<c:if test="${layerGroup.depth eq 1 }">
				<span style="font-size: 1.5em; color: Dodgerblue;">
	            	<i class="fa fa-folder oneFolder" aria-hidden="true"></i>
	            </span>
		</c:if>
		<c:if test="${layerGroup.depth eq 2 }">
				<span style="font-size: 1.5em; color: Mediumslateblue;">
	            	<i class="fa fa-folder oneFolder" aria-hidden="true"></i>
	            </span>
		</c:if>
		<c:if test="${layerGroup.depth eq 3 }">
				<span style="font-size: 1.5em; color: Tomato;;">
	            	<i class="fa fa-folder oneFolder" aria-hidden="true"></i>
	            </span>
		</c:if>
				${layerGroup.layerGroupName }
			</td>
			<td class="col-type">
       <c:if test="${layerGroup.available eq 'true' }">
               	사용
       </c:if>
       <c:if test="${layerGroup.available eq 'false' }">
       			미사용
       </c:if>
		    </td>
		    <td class="col-type">${layerGroup.userId }</td>
		    <td class="col-key">${layerGroup.description }</td>
		    <td class="col-date">
		    	<fmt:parseDate value="${layerGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
		    </td>
		    <td class="col-toggle">
		    	<a href="#" onclick="confirmParent('${layerGroup.layerGroupId}', '${layerGroup.layerGroupName}', '${layerGroup.depth}'); return false;">확인</a></td>
		</tr>
	</c:forEach>
</c:if>
		</tbody>
	</table>
</div>
