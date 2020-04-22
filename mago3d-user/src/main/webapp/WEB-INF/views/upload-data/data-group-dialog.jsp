<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="dataGroupDialog" class="dialog">
	<table class="list-table scope-col">
		<col class="col-name" />
		<col class="col-toggle" />
		<col class="col-id" />
		<col class="col-function" />
		<col class="col-date" />
		<col class="col-toggle" />
		<thead>
			<tr>
				<th scope="col" class="col-name">데이터 그룹명</th>
				<th scope="col" class="col-toggle">사용 여부</th>
				<th scope="col" class="col-toggle">공유 유형</th>
				<th scope="col" class="col-toggle">설명</th>
				<th scope="col" class="col-date">등록일</th>
				<th scope="col" class="col-date">선택</th>
			</tr>
		</thead>
		<tbody>
<c:if test="${empty dataGroupList }">
		<tr>
			<td colspan="6" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
		</tr>
</c:if>
<c:if test="${!empty dataGroupList }">
	<c:set var="paddingLeftValue" value="0" />
	<c:forEach var="dataGroup" items="${dataGroupList}" varStatus="status">
		<c:if test="${dataGroup.depth eq '1' }">
           <c:set var="depthClass" value="oneDepthClass" />
           <c:set var="paddingLeftValue" value="0px" />
       </c:if>
       <c:if test="${dataGroup.depth eq '2' }">
           <c:set var="depthClass" value="twoDepthClass" />
           <c:set var="paddingLeftValue" value="40px" />
       </c:if>
       <c:if test="${dataGroup.depth eq '3' }">
           <c:set var="depthClass" value="threeDepthClass" />
           <c:set var="paddingLeftValue" value="80px" />
       </c:if>

		<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
			<td class="col-name ellipsis" style="max-width:300px; text-align: left;" nowrap="nowrap">
				<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"></span>
		<c:if test="${dataGroup.depth eq 1 }">
				<span style="font-size: 1.5em; color: Dodgerblue;">
	            	<i class="fa fa-folder oneFolder" aria-hidden="true"></i>
	            </span>
		</c:if>
		<c:if test="${dataGroup.depth eq 2 }">
				<span style="font-size: 1.5em; color: Mediumslateblue;">
	            	<i class="fa fa-folder oneFolder" aria-hidden="true"></i>
	            </span>
		</c:if>
		<c:if test="${dataGroup.depth eq 3 }">
				<span style="font-size: 1.5em; color: Tomato;;">
	            	<i class="fa fa-folder oneFolder" aria-hidden="true"></i>
	            </span>
		</c:if>
				${dataGroup.dataGroupName }
			</td>
			<td class="col-type">
       <c:if test="${dataGroup.available eq 'true' }">
               	사용
       </c:if>
       <c:if test="${dataGroup.available eq 'false' }">
       			미사용
       </c:if>
		    </td>
		    <td class="col-type">${dataGroup.sharing }</td>
		    <td class="col-key">${dataGroup.description }</td>
		    <td class="col-date">
		    	<fmt:parseDate value="${dataGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
		    </td>
		    <td class="col-toggle">
		    	<a href="#" onclick="confirmDataGroup('${dataGroup.dataGroupId}', '${dataGroup.dataGroupName}'); return false;">확인</a></td>
		</tr>
	</c:forEach>
</c:if>
		</tbody>
	</table>
</div>
