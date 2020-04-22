<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<div id="contentTab">
		<form:form id="policyContent" modelAttribute="policy" method="post" onsubmit="return false;">
			<table class="input-table scope-row" summary="환경설정 컨텐츠  테이블">
			<caption class="hiddenTag">환경설정 컨텐츠</caption>
				<col class="col-label l" />
				<col class="col-input" />
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="contentCacheVersion">css, js 갱신용 cache version</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="contentCacheVersion" maxlength="3" cssClass="s" onKeyPress="return numkeyCheck(event);" />
						<form:errors path="contentCacheVersion" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="contentMenuGroupRoot">메뉴 그룹 최상위 그룹명</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="contentMenuGroupRoot" maxlength="2" cssClass="s" />
						<form:errors path="contentMenuGroupRoot" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="contentUserGroupRoot">사용자 그룹 최상위 그룹명</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="contentUserGroupRoot" maxlength="2" cssClass="s" />
						<form:errors path="contentUserGroupRoot" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="contentLayerGroupRoot">레이어 그룹 최상위 그룹명</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="contentLayerGroupRoot" maxlength="2" cssClass="s" />
						<form:errors path="contentLayerGroupRoot" cssClass="error" />
					</td>
				</tr>
				<tr>
					<th class="col-label l" scope="row">
						<form:label path="contentDataGroupRoot">데이터 그룹 최상위 그룹명</form:label>
						<span class="icon-glyph glyph-emark-dot color-warning"></span>
					</th>
					<td class="col-input">
						<form:input path="contentDataGroupRoot" maxlength="2" cssClass="s" />
						<form:errors path="contentDataGroupRoot" cssClass="error" />
					</td>
				</tr>
			</table>
			<div class="button-group">
				<div class="center-buttons">
					<a href="#" onclick="updatePolicyContent();" class="button"><spring:message code='save'/></a>
				</div>
			</div>
		</form:form>
	</div>