<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Dialog -->
<div id="projectDialog" class="projectDialog" title="시작시 로딩 프로젝트">
	<table class="list-table scope-col">
		<col class="col-number" />
		<col class="col-name" />
		<col class="col-name" />
		<col class="col-number" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-toggle" />
		<col class="col-number" />
		<col class="col-date" />
		<thead>
			<tr>
				<th scope="col" class="col-checkbox"><input type="checkbox" id="chk_all" name="chk_all" /></th>
				<th scope="col" class="col-name">공유타입</th>
				<th scope="col" class="col-name"><spring:message code='project.name'/></th>
				<th scope="col" class="col-number"><spring:message code='order'/></th>
				<th scope="col" class="col-toggle"><spring:message code='default.value'/></th>
				<th scope="col" class="col-toggle"><spring:message code='status'/></th>
				<th scope="col" class="col-toggle"><spring:message code='latitude'/></th>
				<th scope="col" class="col-toggle"><spring:message code='longitude'/></th>
				<th scope="col" class="col-toggle"><spring:message code='height'/></th>
				<th scope="col" class="col-number"><spring:message code='movement.time'/></th>
				<th scope="col" class="col-date"><spring:message code='insert.date'/></th>
			</tr>
		</thead>
		<tbody id="projectList">
		</tbody>
	</table>
	<div class="button-group">
		<input type="button" id="projectSelect" class="button" value="<spring:message code='select'/>"/>
	</div>
</div>