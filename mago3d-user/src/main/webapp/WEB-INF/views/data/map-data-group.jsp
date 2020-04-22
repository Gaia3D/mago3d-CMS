<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="dataGroupInfoContent" class="contents contents-margin-none fullHeight" style="display:none;">
	<h3>데이터 공유 유형별 현황</h3>
	<form:form id="searchDataGroupForm" modelAttribute="searchDataGroupForm" method="post" onsubmit="return false;">
	<div class="dataGroupSummary table-data-group-summary">
		<table class="table-word-break" summary="데이터 공유 유형별 현황 테이블">
		<caption class="hiddenTag">데이터 공유 유형별 현황</caption>
			<colgroup>
		        <col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
				<col class="col-number" />
		    </colgroup>
		    <tbody>
		    	<tr>
					<th scope="col" class="col-number">공통</th>
					<th scope="col" class="col-number">공개</th>
					<th scope="col" class="col-number">비공개</th>
					<th scope="col" class="col-number">그룹</th>
		        </tr>
		    	<tr>
		        	<td class="col-number"><fmt:formatNumber value="${commonDataCount}" type="number" /></td>
		        	<td class="col-number"><fmt:formatNumber value="${publicDataCount}" type="number" /></td>
		        	<td class="col-number"><fmt:formatNumber value="${privateDataCount}" type="number" /></td>
		        	<td class="col-number"><fmt:formatNumber value="${groupDataCount}" type="number" /></td>
		        </tr>
		    </tbody>
		</table>
	</div>
	</form:form>
	<div class="summary-group-divide"></div>
	<h3>데이터 그룹 검색</h3>
	<div class="listSearch search-text">
		<label for="searchDataGroupName" class="hiddenTag">그룹명 입력</label>
		<input type="text" id="searchDataGroupName" name="searchDataGroupName" placeholder="그룹명을 입력하세요">
		<button type="button" id="mapDataGroupSearch" class="btnTextF" title="검색">검색</button>
	</div>
	<dl class="legendWrap">
		<dt>공유 유형</dt>
		<dd><span class="legend co">C</span>공통</dd>
		<dd><span class="legend pu">O</span>공개</dd>
		<dd><span class="legend pr">P</span>비공개</dd>
		<dd><span class="legend gr">G</span>그룹공개</dd>
	</dl>
	<div id="dataGroupListArea" style="height:calc(100% - 335px)"></div>
</div>