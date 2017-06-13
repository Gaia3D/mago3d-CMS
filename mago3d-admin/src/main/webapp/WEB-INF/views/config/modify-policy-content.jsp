<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="content_tab">
	<form:form id="policyContent" modelAttribute="policy" method="post" onsubmit="return false;">
		<form:hidden path="policy_id"/>
	<table class="input-table scope-row">
		<col class="col-label l" />
		<col class="col-input" />
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_main_widget_count">메인 화면 위젯 표시 개수</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_main_widget_count" maxlength="2" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_main_widget_interval">메인 화면 갱신 간격</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="content_main_widget_interval" maxlength="7" cssClass="m" />
				<span class="table-desc">초 단위, 기본 65초, 최소값 5초</span>
			</td>
		</tr>
		<!-- <tr>
			<th class="col-label l" scope="row">
				<form:label path="content_monitoring_interval">모니터링 감시 간격</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="content_monitoring_interval" maxlength="2" cssClass="m" />
				<span class="table-desc">분 단위</span>
			</td>
		</tr> -->
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_statistics_interval">통계 기본 검색 기간</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<select class="select" id="content_statistics_interval" name="content_statistics_interval">
	  				<option value="0">1년 단위</option>
	  				<option value="1">상/하반기</option>
	  				<option value="2">분기 단위</option>
	  				<option value="3">월 단위</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_load_balancing_interval">이중화 상태 표시 주기</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input">
				<form:input path="content_load_balancing_interval" maxlength="7" cssClass="m" />
				<span class="table-desc">초 단위, 기본 10초, 최소값 10초</span>
			</td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_menu_group_root">메뉴 그룹 최상위 그룹명</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_menu_group_root" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_user_group_root">사용자 그룹 최상위 그룹명</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_user_group_root" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_server_group_root">서버 그룹 최상위 그룹명</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_server_group_root" cssClass="m" /></td>
		</tr>
		<tr>
			<th class="col-label l" scope="row">
				<form:label path="content_object_group_root">계정 그룹 최상위 그룹명</form:label>
				<span class="icon-glyph glyph-emark-dot color-warning"></span>
			</th>
			<td class="col-input"><form:input path="content_object_group_root" cssClass="m" /></td>
		</tr>				
	</table>
	<div class="button-group">
		<div class="center-buttons">
					<a href="#" onclick="updatePolicyContent();" class="button">저장</a>
		</div>
	</div>
	</form:form>
</div>