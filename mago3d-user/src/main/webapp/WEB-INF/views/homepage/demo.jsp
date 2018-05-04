<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>demo | mago3D User</title>
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css?cache_version=${cache_version}" />
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cache_version=${cache_version}" />
</c:if>
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css?cache_version=${cache_version}" />
	<link rel="stylesheet" href="/externlib/jquery-toast/jquery.toast.css" />
	<link rel="stylesheet" href="/externlib/treegrid/jquery.treegrid.css?cache_version=${cache_version}" />
	<link rel="stylesheet" href="/externlib/jqplot/jquery.jqplot.min.css?cache_version=${cache_version}" />
	<script type="text/javascript" src="/externlib/jquery/jquery.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/jquery-toast/jquery.toast.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/${lang}/message.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/treegrid/jquery.treegrid.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/treegrid/jquery.treegrid.bootstrap3.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.js?cache_version=${cache_version}"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>

<body>
	<input type="hidden" id="now_latitude" name="now_latitude" value="${now_latitude }" />
	<input type="hidden" id="now_longitude" name="now_longitude" value="${now_longitude }"  />

<ul class="nav">
	<li id="homeMenu" class="home">
		<img src="/images/ko/homepage/home-icon.png" style="width: 35px; height: 35px; padding-right: 2px;"/>
	</li>
	<li id="myIssueMenu" class="issue" data-tooltip-text="<spring:message code='demo.myissue.menu.description'/>"><spring:message code='issue'/>
		<br /><span id="issueListCount">${totalCount }</span></li>
	<li id="searchMenu" class="search" data-tooltip-text="<spring:message code='demo.search.menu.description'/>"><spring:message code='search'/></li>
	<li id="apiMenu" class="api" data-tooltip-text="<spring:message code='demo.api.menu.description'/>"><spring:message code='api'/></li>	
	<li id="insertIssueMenu" class="regist" data-tooltip-text="<spring:message code='demo.insert-issue.menu.description'/>"><spring:message code='registeration'/></li>
	<li id="treeMenu" class="tree" data-tooltip-text="<spring:message code='demo.tree.menu.description'/>"><spring:message code='tree'/></li>
	<li id="chartMenu" class="chart" data-tooltip-text="<spring:message code='demo.chart.menu.description'/>"><spring:message code='chart'/></li>
	<li id="logMenu" class="log" data-tooltip-text="<spring:message code='demo.log.menu.description'/>"><spring:message code='log'/></li>
	<li id="attributeMenu" class="attribute" data-tooltip-text="<spring:message code='demo.attribute.menu.description'/>"><spring:message code='attribute'/></li>
	<li id="configMenu" class="config" data-tooltip-text="<spring:message code='demo.config.menu.description'/>"><spring:message code='config'/></li>	
</ul>

<div id="menuContent" class="navContents">
	<div class="alignRight">
		<button type="button" id="menuContentClose" class="navClose"><spring:message code='close'/></button>
	</div>
	
	<ul id="homeMenuContent" class="menuList">
		<li><a href="/homepage/index.do">Home</a>
			(<a href="/homepage/about.do" onclick ="changeLanguage('ko');">KO</a> | 
			<a href="/homepage/about.do" onclick ="changeLanguage('en');">EN</a>)
		</li>
		<li><a href="/homepage/about.do">mago3D</a></li>
		<li>Demo
			<ul>
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
				<li>Cesium</li>
				<li><a href="/homepage/demo.do?viewLibrary=worldwind">World Wind</a></li>
</c:if>				
<c:if test="${geoViewLibrary eq 'worldwind' }">				
				<li><a href="/homepage/demo.do?viewLibrary=cesium">Cesium</a></li>
				<li>World Wind</li>
</c:if>
			</ul>
		</li>
		<li><a href="/homepage/download.do">Download</a></li>
		<li>Documentation
			<ul>
				<li><a href="http://www.mago3d.com/homepage/api.do">API</a></li>
				<li><a href="http://www.mago3d.com/homepage/spec.do">F4D Spec</a></li>
			</ul>
		</li>
		<li><a href="/homepage/faq.do">FAQ</a></li>
	</ul>
	
	<ul id="myIssueMenuContent" class="issueList">
		<li style="margin-bottom: 8px; font-size: 1em; font-weight: normal; color: #2955a6;">
			<spring:message code='issue.recent.list.10'/>
		</li>
<c:if test="${empty issueList }">
		<li style="text-align: center; padding-top:20px; height: 50px;">
			<spring:message code='issue.not.exist'/>
		</li>
</c:if>
<c:if test="${!empty issueList }">
	<c:forEach var="issue" items="${issueList}" varStatus="status">
		<li>
			<button type="button" title="<spring:message code='shortcut'/>" 
				onclick="gotoIssue('${issue.project_id}', '${issue.issue_id}', '${issue.issue_type}', '${issue.longitude}', '${issue.latitude}', '${issue.height}', '2')">
				<spring:message code='shortcut'/></button>
			<div class="info">
				<p class="title">
					<span>${issue.project_name }</span>
					${issue.title }
				</p>
				<ul class="tag">
					<li><span class="${issue.issue_type_css_class }"></span>${issue.issue_type_name }</li>
					<li><span class="${issue.priority_css_class }"></span>${issue.priority_name }</li>
					<li class="date">${issue.viewInsertDate }</li>
				</ul>
			</div>
		</li>
	</c:forEach>
</c:if>
	</ul>
	
	<form:form id="searchForm" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="searchMenuContent" class="searchWrap">
		<table>
			<tr style="height: 35px;">
				<td style="width: 80px;"><label for="project_id"><spring:message code='project'/></label></td>
				<td><select id="project_id" name="project_id" class="select">
						<option value=""> <spring:message code='all'/></option>
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td><label for="search_word"><spring:message code='categorize'/></label></td>
				<td>
					<select id="search_word" name="search_word" class="select">
						<option value="data_name"><spring:message code='data.name'/></option>
						<option value="title"><spring:message code='issue.name'/></option>
					</select>
					<select id="search_option" name="search_option" class="select">
						<option value="1"><spring:message code='included'/></option>
						<option value="0"><spring:message code='matches'/></option>
					</select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<label for="search_value"><spring:message code='search.word'/></label></td>
				<td><input type="text" id="search_value" name="search_value" size="31"/></td>
			</tr>
			<tr style="height: 35px;">
				<td><label for="start_date"><spring:message code='day'/></label></td>
				<td><input type="text" class="s date" id="start_date" name="start_date" size="12" />
					<span class="delimeter tilde">~</span>
					<input type="text" class="s date" id="end_date" name="end_date" size="12" /></td>
			</tr>
			<tr style="height: 30px;">
				<td><label for="order_word"><spring:message code='view.order'/></label></td>
				<td><select id="order_word" name="order_word" class="select" style="width: 30%">
						<option value=""> <spring:message code='basic'/> </option>
				       	<option value="insert_date"> <spring:message code='register.date'/> </option>
					</select>
					<select id="order_value" name="order_value" class="select" style="width: 30%">
						<option value=""> <spring:message code='basic'/> </option>
					   	<option value="ASC"> <spring:message code='asc'/> </option>
						<option value="DESC"> <spring:message code='desc'/> </option>
					</select>
					<select id="list_counter" name="list_counter" class="select" style="width: 30%">
						<option value="5"> <spring:message code='listing.5'/> </option>
					 	<option value="10"> <spring:message code='listing.10'/> </option>
						<option value="50"> <spring:message code='listing.50'/> </option>
					</select>
				</td>
			</tr>
		</table>
		<div class="btns">
			<button type="button" id="searchData" class="full"><spring:message code='search'/></button>
		</div>
		<ul id="searchList" class="searchList"></ul>
	</div>
	</form:form>
	
	<div id="apiMenuContent" class="apiWrap">
		<div>
			<h3><spring:message code='demo.local.search'/></h3>
			<ul class="apiLocal">
				<li>
					<label for="localSearchProjectId"><spring:message code='project'/></label>
					<select id="localSearchProjectId" name="localSearchProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="localSearchDataKey"><spring:message code='data.key'/></label>
					<input type="text" id="localSearchDataKey" name="localSearchDataKey" size="20" />
					<button type="button" id="localSearch" class="btn"><spring:message code='search'/></button> 
				</li>
			</ul>
		</div>
		<div>
			<h3><spring:message code='demo.property.rendering'/></h3>
			<ul class="apiLocal">
				<li>
					<input type="radio" id="showPropertyRendering" name="propertyRendering" value="true" />
					<label for="showLabel"> <spring:message code='show'/> </label>
					<input type="radio" id="hidePropertyRendering" name="propertyRendering" value="false" />
					<label for="hideLabel"> <spring:message code='hide'/> </label>
				</li>
				<li>
					<label for="propertyRenderingProjectId"> <spring:message code='project'/> </label>
					<select id="propertyRenderingProjectId" name="propertyRenderingProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="propertyRenderingWord"><spring:message code='property'/></label>
					<input type="text" id="propertyRenderingWord" name="propertyRenderingWord" size="21" placeholder="isMain=true" />
					<button type="button" id="changePropertyRendering" class="btn"><spring:message code='change'/></button> 
				</li>
			</ul>
		</div>
		<div>
			<h3><spring:message code='demo.color.change'/></h3>
			<ul class="apiLocal">
				<li>
					<label for="colorProjectId"> <spring:message code='project'/> </label>
					<select id="colorProjectId" name="colorProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="colorDataKey"><spring:message code='data.key'/></label>
					<input type="text" id="colorDataKey" name="colorDataKey" size="30" />
				</li>
				<li>
					<label for="colorObjectIds"><spring:message code='object.id'/></label>
					<input type="text" id="colorObjectIds" name="colorObjectIds" placeholder=" , <spring:message code='delimiter'/>" size="30" />
				</li>
				<li>
					<label for="colorProperty"><spring:message code='property'/></label>
					<input type="text" id="colorProperty" name="colorProperty" size="30" placeholder="isMain=true" />
				</li>
				<li>
					<label for="updateColor"><spring:message code='color'/></label>
					<select id="updateColor" name="updateColor" class="select">
						<option value="255,0,0"> <spring:message code='color.red'/></option>
						<option value="255,255,0"> <spring:message code='color.yellow'/></option>
						<option value="0,255,0"> <spring:message code='color.green'/></option>
						<option value="0,0,255"> <spring:message code='color.blue'/></option>
						<option value="255,0,255"> <spring:message code='color.pink'/></option>
						<option value="0,0,0"> <spring:message code='color.black'/></option>
					</select>
					<button type="button" id="changeColor" class="btn"><spring:message code='change'/></button> 
					<button type="button" id="deleteAllChangeColor" class="btn"><spring:message code='all.delete'/></button>
				</li>
			</ul>
		</div>
		<div>
			<h3><spring:message code='demo.location.and.rotation'/></h3>
			<ul class="apiLocal">
				<li>
					<label for="moveProjectId"><spring:message code='project'/></label>
					<select id="moveProjectId" name="moveProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</select>
				</li>
				<li>
					<label for="moveDataKey"><spring:message code='data.key'/></label>
					<input type="text" id="moveDataKey" name="moveDataKey" size="25" />
				</li>
				<li>
					<label for="moveLatitude"><spring:message code='latitude'/> </label>
					<input type="text" id="moveLatitude" name="moveLatitude" size="25"/>
				</li>
				<li>
					<label for="moveLongitude"><spring:message code='longitude'/> </label>
					<input type="text" id="moveLongitude" name="moveLongitude" size="25"/>
				</li>
				<li>
					<label for="moveHeight"><spring:message code='height'/> </label>
					<input type="text" id="moveHeight" name="moveHeight" size="25" />
				</li>
				<li>
					<label for="moveHeading"><spring:message code='heading'/> </label>
					<input type="text" id="moveHeading" name="moveHeading" size="15" />
				</li>
				<li>
					<label for="movePitch"><spring:message code='pitch'/> </label>
					<input type="text" id="movePitch" name="movePitch" size="15" />
				</li>
				<li>
					<label for="moveRoll"><spring:message code='roll'/> </label>
					<input type="text" id="moveRoll" name="moveRoll" size="15" />
					<button type="button" id="changeLocationAndRotation" class="btn"><spring:message code='change'/></button>
					<button type="button" id="updateLocationAndRotation" class="btn"><spring:message code='save'/></button>
				</li>
			</ul>
		</div>
		<div>
			<h3><spring:message code='demo.now.location.issue.list'/></h3>
			<input type="radio" id="showNearGeoIssueList" name="nearGeoIssueList" value="true" onclick="changeNearGeoIssueList(true);" />
			<label for="showNearGeoIssueList"> <spring:message code='show'/> </label>
			<input type="radio" id="hideNearGeoIssueList" name="nearGeoIssueList" value="false" onclick="changeNearGeoIssueList(false);"/>
			<label for="hideNearGeoIssueList"> <spring:message code='hide'/> </label>
		</div>
		<div>
			<h3><spring:message code='demo.click.point.location'/></h3>
			<ul class="apiLocal">
				<li>
					<label for="positionLatitude"> <spring:message code='latitude'/> </label>
					<input type="text" id="positionLatitude" name="positionLatitude" size="25" />
				</li>
				<li>
					<label for="positionLongitude"> <spring:message code='longitude'/> </label>
					<input type="text" id="positionLongitude" name="positionLongitude" size="25" />
				</li>
				<li>
					<label for="positionAltitude"> <spring:message code='height'/> </label>
					<input type="text" id="positionAltitude" name="positionAltitude" size="25" />
				</li>
			</ul>
		</div>
	</div>
	
	<form:form id="issue" modelAttribute="issue" method="post" onsubmit="return false;">
	<div id="insertIssueMenuContent" class="insertIssueWrap">
		<table>
			<tr style="height: 35px;">
				<td style="width: 100px;" nowrap="nowrap">
					<form:label path="issueProjectId"><spring:message code='project'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:select path="issueProjectId" cssClass="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="issue_type"><spring:message code='issue.type'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:select path="issue_type" cssClass="select">
<c:forEach var="commonCode" items="${issueTypeList}">
						<option value="${commonCode.code_key}">${commonCode.code_name}</option>
</c:forEach>
					</form:select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<spring:message code='issue.location'/>
				</td>
				<td>
					<button type="button" id="insertIssueEnableButton" class="btn" style="font-size: 11px;"><spring:message code='issue.insert.control.button'/></button> 
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="data_key"><spring:message code='data.name'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:input path="data_key" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" />
					<form:errors path="data_key" cssClass="error" />
					<form:hidden path="object_key"/>
					<form:hidden path="height"/>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="latitude"><spring:message code='latitude'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:input path="latitude" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" />
					<form:errors path="latitude" cssClass="error" />
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<form:label path="longitude"><spring:message code='longitude'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:input path="longitude" readonly="true" size="25" cssStyle="background-color: #CBCBCB;" />
					<form:errors path="longitude" cssClass="error" />
				</td>
			</tr>
			<tr style="height: 60px;">
				<td><form:label path="title"><spring:message code='issue.title'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:textarea path="title" rows="2" cols="32" />
					<form:errors path="title" cssClass="error" />
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="priority"><spring:message code='issue.priority'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td>
					<form:select path="priority" cssClass="select">
<c:forEach var="commonCode" items="${issuePriorityList}">
						<option value="${commonCode.code_key}">${commonCode.code_name}</option>
</c:forEach>
					</form:select>
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="due_day"><spring:message code='issue.duedate'/></form:label></td>
				<td><form:hidden path="due_date" />
					<input type="text" id="due_day" name="due_day" class="date" maxlength="10" style="width: 33%"/>
					<spring:message code='day'/>&nbsp;&nbsp;
					<input type="text" id="due_hour" name="due_hour" placeholder=" 00" maxlength="2" style="width: 12%;"/> :
					<input type="text" id="due_minute" name="due_minute" placeholder=" 00" maxlength="2" style="width: 12%;"/>
					<spring:message code='minute'/>
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="assignee"><spring:message code='issue.assignee'/></form:label></td>
				<td>
					<spring:message code='notice.preparing' var='noticePreparing' />
					<spring:message code='issue.assignee.description' var="assigneeDescription"/>
					<form:input path="assignee" cssClass="m" placeholder="${assigneeDescription}" size="22" />
					<button type="button" class="btn" onclick="alert('${noticePreparing}');"><spring:message code='selection'/></button> 
					<form:errors path="assignee" cssClass="error" />
				</td>
			</tr>
			
			<tr style="height: 35px;">
				<td><form:label path="reporter"><spring:message code='issue.reporter'/></form:label></td>
				<td>
					<spring:message code='issue.reporter.description' var="reporterDescription" />
					<form:input path="reporter" cssClass="m" placeholder="${reporterDescription}" size="22" />
					<button type="button" class="btn" onclick="alert('${noticePreparing}');"><spring:message code='selection'/></button> 
					<form:errors path="reporter" cssClass="error" />
				</td>
			</tr>
			
			<tr>
				<td><form:label path="contents"><spring:message code='issue.contents'/></form:label>
					<span class="icon-glyph glyph-emark-dot color-warning"></span>
				</td>
				<td><form:textarea path="contents" rows="5" cols="32" />
					<form:errors path="contents" cssClass="error" />
				</td>
			</tr>
		</table>
		
		<div class="btns">
			<button type="button" id="issueSaveButton" class="full"><spring:message code='save'/></button>
		</div>
	</div>
	</form:form>
	
	<div id="treeMenuContent" class="treeWrap">
		<div>
			<h3><spring:message code='demo.data.tree'/></h3>
			<ul>
				<li>
					<label for="treeProjectId">Project </label>
					<select id="treeProjectId" name="treeProjectId" onchange="initDataTree();" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>					
					</select>
				</li>
			</ul>
		</div>
		<div style="margin-top: 20px; margin-left: 10px; margin-bottom: 20px;">
			<table id="dataTree" class="table dataTree table-bordered table-striped table-condensed" style="padding-bottom: 20px; width: 310px;">
			</table>
		</div>
	</div>

	<div id="chartMenuContent" class="chartWrap">
		<div>
			<h3><spring:message code='demo.chart.data.number'/></h3>
		</div>
		<div id="projectChart" style="width: 340px; height: 340px; font-size: 18px;"></div>
		<div style="height: 20px;"></div>
		<div style="margin-top: 30px;">
			<h3><spring:message code='demo.chart.data.status'/></h3>
		</div>
		<div id="dataStatusChart" style="width: 340px; height: 340px; font-size: 18px; margin-bottom: 30px;"></div>
	</div>

	<div id="logMenuContent" class="logWrap">
		<div>
			<h3><spring:message code='demo.log.data.change'/> (<spring:message code='demo.data.change.request.log.list.10'/>)</h3>
		</div>
		<table class="list-table scope-col" style="width: 100%; margin-top: 10px;">
			<col class="col-number" />
			<col class="col-name" />
			<col class="col-name" />
			<tr>
				<th rowspan="2" scope="col" class="col-number">No</th>
				<th scope="col" class="col-name">Name</th>
				<th scope="col" class="col-name">Data Name</th>
			</tr>
			<tr>
				<th scope="col" class="col-toggle">Status</th>
				<th scope="col" class="col-date">Date</th>
			</tr>
			<tbody id="dataInfoChangeRequestLog">
			</tbody>
		</table>
	</div>

	<form id="attributeForm" action="#" method="post" onsubmit="return false;">
	<div id="attributeMenuContent" class="attributeWrap">
		<div>
			<h3>Object Attribute Search</h3>
		</div>
		<table style="margin-top: 30px;">
			<tr style="height: 35px;">
				<td style="width: 80px;"><label for="objectAttributeProjectId">Project</label></td>
				<td><select id="objectAttributeProjectId" name="objectAttributeProjectId" class="select">
<c:forEach var="project" items="${projectList}">
						<option value="${project.project_id}">${project.project_name}</option>
</c:forEach>
				</select>
				</td>
			</tr>
			<tr style="height: 35px;">
				<td><label for="objectAttributeDataKey">Data Key</label></td>
				<td>
					<input type="text" id="objectAttributeDataKey" name="objectAttributeDataKey" size="22" />
				</td>
			</tr>
			<tr style="height: 35px;">
				<td><label for="objectAttributeObjectId">Object Id</label></td>
				<td>
					<input type="text" id="objectAttributeObjectId" name="objectAttributeObjectId" size="22" />
				</td>
			</tr>
			<tr style="height: 35px;">
				<td>
					<label for="objectAttributeSearchValue">SearchWord</label></td>
				<td><input type="text" id="objectAttributeSearchValue" name="objectAttributeSearchValue" size="31" /></td>
			</tr>
		</table>
		<div class="btns">
			<button type="button" id="objectAttributeSearch" class="full">Search</button>
		</div>
		<table id="objectAttributeSearchList" class="" style="width: 100%;">
			<col style="width: 30%;" />
			<col style="width: 40%;" />
			<col style="width: 30%;" />
			<tbody></tbody>
		</table>
	</div>
	</form>
	
	<div id="configMenuContent" class="configWrap">
		<div>
			<h3><spring:message code='label'/></h3>
			<input type="radio" id="showLabel" name="labelInfo" value="true" onclick="changeLabel(true);" />
			<label for="showLabel"> <spring:message code='show'/> </label>
			<input type="radio" id="hideLabel" name="labelInfo" value="false" onclick="changeLabel(false);"/>
			<label for="hideLabel"> <spring:message code='hide'/> </label>
		</div>
		<div>
			<h3><spring:message code='object.info'/></h3>
			<input type="radio" id="showObjectInfo" name="objectInfo" value="true" onclick="changeObjectInfoViewMode(true);" />
			<label for="showObjectInfo"> <spring:message code='show'/> </label>
			<input type="radio" id="hideObjectInfo" name="objectInfo" value="false" onclick="changeObjectInfoViewMode(false);"/>
			<label for="hideObjectInfo"> <spring:message code='hide'/> </label>
		</div>
		<div>
			<h3><spring:message code='origin'/></h3>
			<input type="radio" id="showOrigin" name="origin" value="true" onclick="changeOrigin(true);" />
			<label for="showOrigin"> <spring:message code='show'/> </label>
			<input type="radio" id="hideOrigin" name="origin" value="false" onclick="changeOrigin(false);"/>
			<label for="hideOrigin"> <spring:message code='hide'/> </label>
		</div>
		<div>
			<h3><spring:message code='boundingbox'/></h3>
			<input type="radio" id="showBoundingBox" name="boundingBox" value="true" onclick="changeBoundingBox(true);" />
			<label for="showBoundingBox"> <spring:message code='show'/> </label>
			<input type="radio" id="hideBoundingBox" name="boundingBox" value="false" onclick="changeBoundingBox(false);"/>
			<label for="hideBoundingBox"> <spring:message code='hide'/> </label>
		</div>
		<div>
			<h3><spring:message code='demon.selection.and.moving'/></h3>
			<input type="radio" id="objectNoneMove" name="objectMoveMode" value="2" onclick="changeObjectMove('2');"/>
			<label for="objectNoneMove"> <spring:message code='demo.object.none.move'/> </label>
			<input type="radio" id="objectAllMove" name="objectMoveMode" value="0" onclick="changeObjectMove('0');"/>
			<label for="objectAllMove"> <spring:message code='demo.object.all.move'/> </label>
			<input type="radio" id="objectMove" name="objectMoveMode" value="1" onclick="changeObjectMove('1');"/>
			<label for="objectMove"> <spring:message code='demo.object.move'/> </label>
			
			<button type="button" id="saveObjectMoveButton" class="btn"><spring:message code='save'/></button>
			<button type="button" id="deleteAllObjectMoveButton" class="btn"><spring:message code='all.delete'/></button>
		</div>
		<div>
			<h3><spring:message code='demo.object.occlusion.culling'/></h3>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='selection'/></div>
				<input type="radio" id="useOcclusionCulling" name="occlusionCulling" value="true" />
				<label for="useOcclusionCulling"> <spring:message code='use'/> </label>
				<input type="radio" id="unusedOcclusionCulling" name="occlusionCulling" value="false" />
				<label for="unusedOcclusionCulling"> <spring:message code='unused'/> </label>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='data.key'/></div>
				<input type="text" id="occlusion_culling_data_key" name="occlusion_culling_data_key" size="22" />
				<button type="button" id="changeOcclusionCullingButton" class="btn"><spring:message code='change'/></button>
			</div>
		</div>
		<div>
			<h3><spring:message code='lod'/></h3>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='lod0'/></div>
				<input type="text" id="geo_lod0" name="geo_lod0" value="${policy.geo_lod0 }" size="15" />&nbsp;<spring:message code='meter'/>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='lod1'/></div>
				<input type="text" id="geo_lod1" name="geo_lod1" value="${policy.geo_lod1 }" size="15" />&nbsp;<spring:message code='meter'/>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='lod2'/></div>
				<input type="text" id="geo_lod2" name="geo_lod2" value="${policy.geo_lod2 }" size="15" />&nbsp;<spring:message code='meter'/>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='lod3'/></div>
				<input type="text" id="geo_lod3" name="geo_lod3" value="${policy.geo_lod3 }" size="15" />&nbsp;<spring:message code='meter'/>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='lod4'/></div>
				<input type="text" id="geo_lod4" name="geo_lod4" value="${policy.geo_lod4 }" size="15" />&nbsp;<spring:message code='meter'/>
			</div>
			<div style="height: 30px;">
				<div style="display: inline-block; width: 70px;"><spring:message code='lod5'/></div>
				<input type="text" id="geo_lod5" name="geo_lod5" value="${policy.geo_lod5 }" size="15" />&nbsp;<spring:message code='meter'/>&nbsp;&nbsp;
				<button type="button" id="changeLodButton" class="btn"><spring:message code='change'/></button>
			</div>
		</div>
		<div>
			<h3><spring:message code='lighting'/></h3>
			<div style="height: 30px;"><spring:message code='demo.ambient.reflection.coef'/></div>
			<div id="ambient_reflection_coef" style="display: inline-block; width: 65%;">
				<div id="geo_ambient_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_ambient_reflection_coef" name="geo_ambient_reflection_coef" value="0.5" />
			</div>
			<div style="height: 30px;"><spring:message code='demo.diffuse.reflection.coef'/></div>
			<div id="diffuse_reflection_coef" style="display: inline-block; width: 65%;">
				<div id="geo_diffuse_reflection_coef_view" class="ui-slider-handle"></div>
				<input type="hidden" id="geo_diffuse_reflection_coef" name="geo_diffuse_reflection_coef" value="1" />
			</div>
			<div style="height: 30px;"><spring:message code='demo.specular_reflection.coef'/></div>
			<div>
				<div id="specular_reflection_coef" style="display: inline-block; width: 65%;">
					<div id="geo_specular_reflection_coef_view" class="ui-slider-handle"></div>
					<input type="hidden" id="geo_specular_reflection_coef" name="geo_specular_reflection_coef" value="1" />
				</div>
				<div style="float: right;">
					<button type="button" id="changeLightingButton" class="btn"><spring:message code='change'/></button>
				</div>
			</div>
			<div style="text-align: center">
			</div>
		</div>
		<div>
			<h3><label for="geo_ssao_radius"><spring:message code='demo.ssao.radius'/></label></h3>
			<input type="text" id="geo_ssao_radius" name="geo_ssao_radius" />
			<button type="button" id="changeSsaoRadiusButton" class="btn"><spring:message code='change'/></button>
		</div>
		<div>
			<h3><spring:message code='demo.view.mode'/></h3>
			<input type="radio" id="mode3PV" name="viewMode" value ="false" onclick="changeViewMode(false);"/>
			<label for="mode3PV"> <spring:message code='demo.third.person.mode'/> </label>
			<input type="radio" id="mode1PV" name="viewMode" value ="true" onclick="changeViewMode(true);"/>
			<label for="mode1PV"> <spring:message code='demo.first.person.mode'/> </label>
		</div>
	</div>
</div>

<ul class="shortcut">
	<c:forEach var="project" items="${projectList}" varStatus="status">
	<li onclick="gotoProject('${project.project_id }', '${project.longitude}', '${project.latitude}', '${project.height}', '${project.duration}')">${project.project_name }</li>
	</c:forEach>	
</ul>

<!-- 맵영역 -->
<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
<div id="magoContainer" class="mapWrap"></div>
<canvas id="objectLabel"></canvas>
</c:if>
<c:if test="${geoViewLibrary eq 'worldwind' }">
<div style="position: absolute; width: 100%; height: 100%; margin-top: 0; padding: 0; overflow: hidden;">
	<canvas id="magoContainer" style="width: 100%; height: 100%">
        Your browser does not support HTML5 Canvas.
    </canvas>
    <canvas id="objectLabel"></canvas>
</div>
</c:if>

<%@ include file="/WEB-INF/views/homepage/data-attribute-dialog.jsp" %>
<%@ include file="/WEB-INF/views/homepage/data-info-log-dialog.jsp" %>
<%@ include file="/WEB-INF/views/homepage/data-object-attribute-dialog.jsp" %>

<c:if test="${geoViewLibrary == null || geoViewLibrary eq '' || geoViewLibrary eq 'cesium' }">
<script type="text/javascript" src="/externlib/cesium/Cesium.js?cache_version=${cache_version}"></script>
</c:if>
<c:if test="${geoViewLibrary eq 'worldwind' }">
<script type="text/javascript" src="/externlib/webworldwind/worldwind.js?cache_version=${cache_version}"></script>
</c:if>
<script type="text/javascript" src="/js/mago3d.js?cache_version=${cache_version}"></script>
<script>
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('chrome') < 0) { 
		alert(JS_MESSAGE["demo.browser.recommend"]);
	}

	var managerFactory = null;
	var policyJson = ${policyJson};
	var initProjectJsonMap = ${initProjectJsonMap};
	var menuObject = { 	homeMenu : false, myIssueMenu : false, searchMenu : false, apiMenu : false, insertIssueMenu : false, 
						treeMenu : false, chartMenu : false, logMenu : false, attributeMenu : false, configMenu : false };
	var insertIssueEnable = false;
	var FPVModeFlag = false;
	
	var imagePath = "/images/${lang}";
	var dataInformationUrl = "/data/ajax-project-data-by-project-id.do";
	magoStart();
	var intervalCount = 0;
	var timerId = setInterval("startMogoUI()", 1000);
	
	$(document).ready(function() {
	});
	
	function startMogoUI() {
		intervalCount++;
		if(managerFactory != null && managerFactory.getMagoManagerState() === CODE.magoManagerState.READY) {
			initJqueryCalendar();
			// Label 표시
			changeLabel(false);
			// object 정보 표시
			changeObjectInfoViewMode(true);
			// Origin 표시
            changeOrigin(false);
			// BoundingBox
			changeBoundingBox(false);
			// Selecting And Moving
			changeObjectMove("2");
			// slider, color-picker
			initRendering();
			// 3PView Mode
			changeViewMode(false);
			
			clearInterval(timerId);
			console.log(" managerFactory != null, managerFactory.getMagoManagerState() = " + managerFactory.getMagoManagerState() + ", intervalCount = " + intervalCount);
			return;
		}
		console.log("--------- intervalCount = " + intervalCount);
	}
	
	// mago3d 시작, 정책 데이터 파일을 로딩
	function magoStart() {
		var initProjectsLength = ${initProjectsLength};
		if(initProjectsLength === null || initProjectsLength === 0) {
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, null, null, null, imagePath);
		} else {
			var projectIdArray = new Array(initProjectsLength);
			var projectDataArray = new Array(initProjectsLength);
			var projectDataFolderArray = new Array(initProjectsLength);
			var index = 0;
			for(var projectId in initProjectJsonMap) {
				projectIdArray[index] = projectId;
				var projectJson = JSON.parse(initProjectJsonMap[projectId]);
				projectDataArray[index] = projectJson;
				projectDataFolderArray[index] = projectJson.data_key;
				index++;
			}
			
			managerFactory = new ManagerFactory(null, "magoContainer", policyJson, projectIdArray, projectDataArray, projectDataFolderArray, imagePath);			
		}
	}
	
	// 프로젝트를 로딩한 후 이동
	function gotoProject(projectId, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			$.ajax({
				url: dataInformationUrl,
				type: "POST",
				data: "project_id=" + projectId,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						var projectDataJson = JSON.parse(msg.projectDataJson);
						if(projectDataJson === null || projectDataJson === undefined) {
							alert(JS_MESSAGE["project.data.no.found"]);
							return;
						}
						gotoProjectAPI(managerFactory, projectId, projectDataJson, projectDataJson.data_key, longitude, latitude, height, duration);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				}
			});
		} else {
			gotoProjectAPI(managerFactory, projectId, projectData, projectData.data_key, longitude, latitude, height, duration);	
		}
		
		// 현재 좌표를 저장
		saveCurrentLocation(latitude, longitude);
	}
	
	// 이슈 위치로 이동
	function gotoIssue(projectId, issueId, issueType, longitude, latitude, height, duration) {
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
		if (projectData === null || projectData === undefined) {
			$.ajax({
				url: dataInformationUrl,
				type: "POST",
				data: "project_id=" + projectId,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						var projectDataJson = JSON.parse(msg.projectDataJson);
						if(projectDataJson === null || projectDataJson === undefined) {
							alert(JS_MESSAGE["project.data.no.found"]);
							return;
						}
						gotoIssueAPI(managerFactory, projectId, projectDataJson, projectDataJson.data_key, issueId, issueType, longitude, latitude, height, duration);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				}
			});
		} else {
			gotoIssueAPI(managerFactory, projectId, projectData, projectData.data_key, issueId, issueType, longitude, latitude, height, duration);	
		}
		
		// 현재 좌표를 저장
		saveCurrentLocation(latitude, longitude);
	}
	
	// issue 위치 버튼을 클릭 했을 경우
	$("#insertIssueEnableButton").click(function() {
		if(insertIssueEnable) {
			$("#insertIssueEnableButton").removeClass("on");
			$("#insertIssueEnableButton").text(JS_MESSAGE["demo.select.object.message"]);
			insertIssueEnable = false;
		} else {
			$("#insertIssueEnableButton").addClass("on");
			$("#insertIssueEnableButton").text(JS_MESSAGE["demo.issue.enable.status"]);
			insertIssueEnable = true;
		}
		changeInsertIssueModeAPI(managerFactory, insertIssueEnable);
	});
	
	// issue input layer call back function
	function showInsertIssueLayer(projectId, dataKey, objectKey, latitude, longitude, height) {
		if(insertIssueEnable) {
			$("#issueProjectId").val(projectId);
			$("#data_key").val(dataKey);
			$("#object_key").val(objectKey);
			$("#latitude").val(latitude);
			$("#longitude").val(longitude);
			$("#height").val(height);
			
			// 현재 좌표를 저장
			saveCurrentLocation(latitude, longitude);
		}
	}
	
	// 이슈 등록
	var isInsertIssue = true;
	$("#issueSaveButton").click(function() {
		if (check() == false) {
			return false;
		}
		if(isInsertIssue) {
			isInsertIssue = false;
			var url = "/issue/ajax-insert-issue.do";
			var info = $("#issue").serialize() + "&project_id=" + $("#issueProjectId").val();
			$.ajax({
				url: url,
				type: "POST",
				data: info,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						alert(JS_MESSAGE["insert"]);
						// pin image를 그림
						drawInsertIssueImageAPI(managerFactory, 1, msg.issue.issue_id, msg.issue.issue_type, 
								$("#data_key").val(), $("#latitude").val(), $("#longitude").val(), $("#height").val());
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					
					isInsertIssue = true;
					ajaxIssueList();
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
					console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
					isInsertIssue
				}
			});
			
			// issue 등록 버튼, css, 상태를 변경
			$("#insertIssueEnableButton").removeClass("on");
			$("#insertIssueEnableButton").text(JS_MESSAGE["demo.select.object.message"]);
			insertIssueEnable = false;
			
			changeInsertIssueStateAPI(managerFactory, 0);
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	function check() {
		if ($("#data_key").val() === "") {
			alert(JS_MESSAGE["issue.datakey.empty"]);
			$("#data_key").focus();
			return false;
		}
		if ($("#title").val() === "") {
			alert(JS_MESSAGE["issue.title.empty"]);
			$("#title").focus();
			return false;
		}
		if ($("#contents").val() === "") {
			alert(JS_MESSAGE["issue.contents.empty"]);
			$("#contents").focus();
			return false;
		}
	}
	
	// TODO issue url 밑에 있어야 할지도 모르겠다.
	function ajaxIssueList() {
		var info = "";
		var url = "/homepage/ajax-list-issue.do";
		$.ajax({
			url: url,
			type: "POST",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					var issueRecentList10Message = "<spring:message code='issue.recent.list.10'/>";
					var issueDoesNotExistMessage = "<spring:message code='issue.not.exist'/>";
					var commonShortcutMessage = "<spring:message code='shortcut'/>";
					
					var issueList = msg.issueList;
					var content = "";
					var issueListCount = 0;
					content = content 
						+	"<li style=\"margin-bottom: 8px; font-size: 1em; font-weight: normal; color: #2955a6;\">"
						+ 		issueRecentList10Message
						+	"</li>";
					if(issueList === null || issueList.length === 0) {
						content += 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
								+	issueDoesNotExistMessage
								+	"</li>";
					} else {
						issueListCount = issueList.length;
						for(i=0; i<issueListCount; i++ ) {
							var issue = issueList[i];
							content = content 
								+ 	"<li>"
								+ 	"	<button type=\"button\" title=\"" + commonShortcutMessage + "\""
								+			"onclick=\"gotoIssue('" + issue.project_id + "', '" + issue.issue_id + "', '" + issue.issue_type + "', '" 
								+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2')\">" + commonShortcutMessage + "</button>"
								+ 	"	<div class=\"info\">"
								+ 	"		<p class=\"title\">"
								+ 	"			<span>" + issue.project_name + "</span>"
								+ 				issue.title
								+ 	"		</p>"
								+ 	"		<ul class=\"tag\">"
								+ 	"			<li><span class=\"" + issue.issue_type_css_class + "\"></span>" + issue.issue_type_name + "</li>"
								+ 	"			<li><span class=\"" + issue.priority_css_class + "\"></span>" + issue.priority_name + "</li>"
								+ 	"			<li class=\"date\">" + issue.insert_date.substring(0,19) + "</li>"
								+ 	"		</ul>"
								+ 	"	</div>"
								+ 	"</li>";
						}
					}
					$("#issueListCount").empty();
					$("#issueListCount").html(msg.totalCount);
					$("#myIssueMenuContent").empty();
					$("#myIssueMenuContent").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}
	
	// 왼쪽 메뉴 클릭시 ui 처리
	$("#homeMenu").click(function() {
		menuSlideControl("homeMenu");
	});
	$("#myIssueMenu").click(function() {
		menuSlideControl("myIssueMenu");
	});
	$("#searchMenu").click(function() {
		menuSlideControl("searchMenu");
	});
	$("#apiMenu").click(function() {
		menuSlideControl("apiMenu");
	});
	$("#insertIssueMenu").click(function() {
		menuSlideControl("insertIssueMenu");
	});
	$("#treeMenu").click(function() {
        menuSlideControl("treeMenu");
        initDataTree();
    });
    $("#chartMenu").click(function() {
        menuSlideControl("chartMenu");
        initDataChart();
    });
    $("#logMenu").click(function() {
        menuSlideControl("logMenu");
        dataInfoChangeRequestLogList();
    });
    $("#attributeMenu").click(function() {
        menuSlideControl("attributeMenu");
    });
	$("#configMenu").click(function() {
		menuSlideControl("configMenu");
	});
	
	function menuSlideControl(menuName) {
		var compareMenuState = menuObject[menuName];
		for(var key in menuObject) {
		    // state 값 변경하고, css 변경
			if(key === menuName) {
			    var value = menuObject[key];
				if(value) {
					$("#" + menuName).removeClass("on");
					$("#menuContent").hide();
					$("#" + menuName + "Content").hide();
				} else {
					$("#" + menuName).addClass("on");
					$("#menuContent").show();
					$("#" + menuName + "Content").show();
				}
				menuObject[menuName] = !compareMenuState;
			} else {
				$("#" + key).removeClass("on");
				$("#" + key + "Content").hide();
			}
		}
	}
	
	// menu content close 버튼
	$("#menuContentClose").click(function() {
		for(var key in menuObject) {
            var value = menuObject[key];
            if(value) {
				$("#menuContent").hide();
				$("#" + key + "Content").hide();
				$("#" + key).removeClass("on");
				menuObject[key] = !value;
			}
		}
		// 이슈 등록 비활성화 상태
		changeInsertIssueStateAPI(managerFactory, 0);
	});
	
	// Data 검색
	var searchDataFlag = true;
	$("#searchData").click(function() {
		if ($.trim($("#search_value").val()) === ""){
			alert(JS_MESSAGE["search.word.empty"]);
			$("#search_value").focus();
			return false;
		}
		
		if(searchDataFlag) {
			searchDataFlag = false;
			var info = $("#searchForm").serialize();
			var url = null;
			if($("#search_word").val() === "data_name") {
				url = "/data/ajax-search-data.do";
			} else {
				url = "/homepage/ajax-list-issue.do";
			}
			
			$.ajax({
				url: url,
				type: "POST",
				data: info,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						var issueDoesNotExistMessage = "<spring:message code='issue.not.exist'/>";
						var dataDoesNotExistMessage = "<spring:message code='data.not.exist'/>";
						var commonShortcutMessage = "<spring:message code='shortcut'/>";
						
						var searchType = $("#search_word").val();
						var content = "";
						if(searchType === "data_name") {
							var dataInfoList = msg.dataInfoList;
							if(dataInfoList == null || dataInfoList.length == 0) {
								content = content	
									+ 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
									+	dataDoesNotExistMessage
									+	"</li>";
							} else {
								dataInfoListCount = dataInfoList.length;
								for(i=0; i<dataInfoListCount; i++ ) {
									var dataInfo = dataInfoList[i];
									content = content 
										+ 	"<li>";
									if(dataInfo.parent !== 0) {	
										content = content 
										+ 	"	<button type=\"button\" title=\"" + commonShortcutMessage + "\""
										+ 	" 		onclick=\"gotoData('" + dataInfo.project_id + "', '" + dataInfo.data_key + "');\">" + commonShortcutMessage + "</button>";
									}
									content = content 
										+ 	"	<div class=\"info\">"
										+ 	"		<p class=\"title\">"
										+ 	"			<span>" + dataInfo.project_name + "</span>"
										+ 				dataInfo.data_name
										+ 	"		</p>"
										+ 	"		<ul class=\"tag\">"
										+ 	"			<li><span class=\"t3\"></span>" + dataInfo.latitude + "</li>"
										+ 	"			<li><span class=\"t3\"></span>" + dataInfo.longitude + "</li>"
										+ 	"			<li class=\"date\">" + dataInfo.insert_date.substring(0,19) + "</li>"
										+ 	"		</ul>"
										+ 	"	</div>"
										+ 	"</li>";
								}
							}
						} else {
							var issueList = msg.issueList;
							if(issueList === null || issueList.length === 0) {
								content = content	
									+ 	"<li style=\"text-align: center; padding-top:20px; height: 50px;\">"
									+	issueDoesNotExistMessage
									+	"</li>";
							} else {
								issueListCount = issueList.length;
								for(i=0; i<issueListCount; i++ ) {
									var issue = issueList[i];
									content = content 
										+ 	"<li>"
										+ 	"	<button type=\"button\" title=\"" + commonShortcutMessage + "\""
										+			" onclick=\"gotoIssue('" + issue.project_id + "', '" + issue.issue_id + "', '" + issue.issue_type + "', '" 
										+ 				issue.longitude + "', '" + issue.latitude + "', '" + issue.height + "', '2');\">" + commonShortcutMessage + "</button>"
										+ 	"	<div class=\"info\">"
										+ 	"		<p class=\"title\">"
										+ 	"			<span>" + issue.project_name + "</span>"
										+ 				issue.title
										+ 	"		</p>"
										+ 	"		<ul class=\"tag\">"
										+ 	"			<li><span class=\"" + issue.issue_type_css_class + "\"></span>" + issue.issue_type_name + "</li>"
										+ 	"			<li><span class=\"" + issue.priority_css_class + "\"></span>" + issue.priority_name + "</li>"
										+ 	"			<li class=\"date\">" + issue.insert_date.substring(0,19) + "</li>"
										+ 	"		</ul>"
										+ 	"	</div>"
										+ 	"</li>";
								}
							}
						}
						
						$("#searchList").empty();
						$("#searchList").html(content);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					searchDataFlag = true;
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
			    	console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
					searchDataFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	// 데이터 위치로 이동
	function gotoData(projectId, dataKey) {
		searchDataAPI(managerFactory, projectId, dataKey);
	}
	
	$("#localSearch").click(function() {
		if ($.trim($("#localSearchDataKey").val()) === ""){
			alert(JS_MESSAGE["data.key.empty"]);
			$("#localSearchDataKey").focus();
			return false;
		}
		searchDataAPI(managerFactory, $("#localSearchProjectId").val(), $("#localSearchDataKey").val());
	});
	
	// object 정보 표시 call back function
	function showSelectedObject(projectId, dataKey, objectId, latitude, longitude, height, heading, pitch, roll) {
		var objectInfoViewFlag = $(':radio[name="objectInfo"]:checked').val();
		if(objectInfoViewFlag) {
			$("#moveProjectId").val(projectId);
			$("#moveDataKey").val(dataKey);
			$("#moveLatitude").val(latitude);
			$("#moveLongitude").val(longitude);
			$("#moveHeight").val(height);
			$("#moveHeading").val(heading);
			$("#movePitch").val(pitch);
			$("#moveRoll").val(roll);
			
			$.toast({
			    heading: 'Click Object Info',
			    text: [
			    	'projectId : ' + projectId,
			        'dataKey : ' + dataKey, 
			        'objectId : ' + objectId,
			        'latitude : ' + latitude,
			        'longitude : ' + longitude,
			        'height : ' + height,
			        'heading : ' + heading,
			        'pitch : ' + pitch,
			        'roll : ' + roll
			    ],
				bgColor : '#393946',
				hideAfter: 5000,
				icon: 'info',
				position : 'bottom-right'
			});
			
			// occlusion culling
			$("#occlusion_culling_data_key").val(dataKey);
			// 현재 좌표를 저장
			saveCurrentLocation(latitude, longitude);
		}
	}
	// 속성 가시화
	$("#changePropertyRendering").click(function(e) {
		var isShow = $(':radio[name="propertyRendering"]:checked').val();
		if(isShow === undefined){
			alert(JS_MESSAGE["demo.selection"]);
			return false;
		}
		if ($.trim($("#propertyRenderingWord").val()) === ""){
			alert(JS_MESSAGE["demo.property.empty"]);
			$("#propertyRenderingWord").focus();
			return false;
		}
		changePropertyRenderingAPI(managerFactory, isShow, $("#propertyRenderingProjectId").val(), $("#propertyRenderingWord").val());
	});
	
	// 색변경
	$("#changeColor").click(function(e) {
		if ($.trim($("#colorDataKey").val()) === ""){
			alert(JS_MESSAGE["data.key.empty"]);
			$("#colorDataKey").focus();
			return false;
		}
		
		var objectIds = null;
		var colorObjectIds = $("#colorObjectIds").val();
		if(colorObjectIds !== null && colorObjectIds !== "") objectIds = colorObjectIds.split(",");
		changeColorAPI(managerFactory, $("#colorProjectId").val(), $("#colorDataKey").val(), objectIds, $("#colorProperty").val(), $("#updateColor").val());
	});
	// 색깔 변경 이력 삭제
	$("#deleteAllChangeColor").click(function () {
		if(confirm("삭제 하시겠습니까?")) {
			deleteAllChangeColorAPI(managerFactory);
		}
	});
	
	// 변환행렬
	$("#changeLocationAndRotation").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
		changeLocationAndRotationAPI(	managerFactory, $("#moveProjectId").val(),
										$("#moveDataKey").val(), $("#moveLatitude").val(), $("#moveLongitude").val(), 
										$("#moveHeight").val(), $("#moveHeading").val(), $("#movePitch").val(), $("#moveRoll").val());
	});
	function changeLocationAndRotationCheck() {
		if ($.trim($("#moveDataKey").val()) === ""){
			alert(JS_MESSAGE["data.key.empty"]);
			$("#moveDataKey").focus();
			return false;
		}
		if ($.trim($("#moveLatitude").val()) === ""){
			alert(JS_MESSAGE["data.latitude.empty"]);
			$("#moveLatitude").focus();
			return false;
		}
		if ($.trim($("#moveLongitude").val()) === ""){
			alert(JS_MESSAGE["data.longitude.empty"]);
			$("#moveLongitude").focus();
			return false;
		}
		if ($.trim($("#moveHeight").val()) === ""){
			alert(JS_MESSAGE["data.height.empty"]);
			$("#moveHeight").focus();
			return false;
		}
		if ($.trim($("#moveHeading").val()) === ""){
			alert(JS_MESSAGE["data.heading.empty"]);
			$("#moveHeading").focus();
			return false;
		}
		if ($.trim($("#movePitch").val()) === ""){
			alert(JS_MESSAGE["data.pitch.empty"]);
			$("#movePitch").focus();
			return false;
		}
		if ($.trim($("#moveRoll").val()) === ""){
			alert(JS_MESSAGE["data.roll.empty"]);
			$("#moveRoll").focus();
			return false;
		}
		return true;
	}
	
	// 변환행렬 수정
	var isUpdateLocationAndRotation = true;
	$("#updateLocationAndRotation").click(function() {
		if(!changeLocationAndRotationCheck()) return false;
								
		if(isUpdateLocationAndRotation) {
			isUpdateLocationAndRotation = false;
			var url = "/data/ajax-update-data-location-and-rotation.do";
			var info = 	"project_id=" + $("#moveProjectId").val()
						+ "&data_key=" + $("#moveDataKey").val()
						+ "&latitude=" + $("#moveLatitude").val()
						+ "&longitude=" + $("#moveLongitude").val()
						+ "&height=" + $("#moveHeight").val()
						+ "&heading=" + $("#moveHeading").val()
						+ "&pitch=" + $("#movePitch").val()
						+ "&roll=" + $("#moveRoll").val();
			$.ajax({
				url: url,
				type: "POST",
				data: info,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						alert(JS_MESSAGE["insert"]);
						// ajax
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					isUpdateLocationAndRotation = true;
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
			    	console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			    	isUpdateLocationAndRotation = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	});
	
	// 인접 지역 이슈 표시
	function changeNearGeoIssueList(isShow) {
		$("input:radio[name='nearGeoIssueList']:radio[value='" + isShow + "']").prop("checked", true);
		if(isShow) {
			// 현재 위치의 latitude, logitude를 가지고 가장 가까이에 있는 데이터 그룹에 속하는 이슈 목록을 최대 100건 받아서 표시
			var now_latitude = $("#now_latitude").val();
			var now_longitude = $("#now_longitude").val();
			var info = "latitude=" + now_latitude + "&longitude=" + now_longitude;
			var url = "/issue/ajax-list-issue-by-geo.do";
			$.ajax({
				url: url,
				type: "POST",
				data: info,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						var issueList = msg.issueList;
						if(issueList != null && issueList.length > 0) {
							for(i=0; i<issueList.length; i++ ) {
								var issue = issueList[i];
								drawInsertIssueImageAPI(managerFactory, 0, issue.issue_id, issue.issue_type, issue.data_key, issue.latitude, issue.longitude, issue.height);
							}
						}
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
			    	console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
				}
			});
		}
		changeNearGeoIssueListViewModeAPI(managerFactory, isShow);
	}
	
	function initDataTree() {
        var projectId = $("#treeProjectId").val();
		var projectData = getDataAPI(CODE.PROJECT_ID_PREFIX + projectId);
        if (projectData === null || projectData === undefined) {
            $.ajax({
            	url: dataInformationUrl,
				type: "POST",
				data: "project_id=" + projectId,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
                success: function(msg) {
                	if(msg.result === "success") {
						var projectDataJson = JSON.parse(msg.projectDataJson);
						if(projectDataJson === null || projectDataJson === undefined) {
							alert(JS_MESSAGE["project.data.no.found"]);
							return;
						}
						drawDataTree(projectId, projectDataJson);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
                },
                error : function(request, status, error) {
                	alert(JS_MESSAGE["ajax.error.message"]);
                    console.log("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                }
            });
        } else {
            drawDataTree(projectId, projectData);
        }
	}

	function drawDataTree(projectId, projectData) {
	    var content = 	"";
	    var dataCssId = 1;
	    content 	= 	content
					+ 	"<tr class=\"treegrid-" + dataCssId + "\" style=\"height: 25px; background-color: #F79F81\">"
					+ 		"<td style=\"padding-left: 10px\" nowrap=\"nowrap\"></td>"
					+		"<td colspan=\"3\"> <b>" + projectData.data_name + "</b></td>"
					+	"</tr>";
	    var childrenCount = projectData.children.length;
	    if(childrenCount > 0) {
            var childrenContent = getChildrenContent(projectId, dataCssId, projectData.children);
            content = content + childrenContent;
        }

        $("#dataTree").html("");
		$("#dataTree").append(content);
        $('.dataTree').treegrid({
            expanderExpandedClass: 'glyphicon glyphicon-minus',
            expanderCollapsedClass: 'glyphicon glyphicon-plus'
        });
	}

	function getChildrenContent(projectId, dataCssId, children) {
        var content = 	"";
       	var count = children.length;
       	var parentClass = " treegrid-parent-" + dataCssId;
       	var evenColor = "background-color: #ccc";
       	var oddColor = "background-color: #eee";
       	for(var i=0; i<count; i++) {
       		dataCssId++;
			var bgcolor = (dataCssId % 2 == 0) ? evenColor : oddColor;
			var myClass = "treegrid-" + dataCssId;
	        var dataInfo = children[i];
			content 	= 	content
                + 	"<tr class=\"" + myClass + parentClass + "\" style=\"height: 25px;" + bgcolor + "\">"
                + 		"<td style=\"padding-left: 2px\" nowrap=\"nowrap\"></td>"
                +		"<td title=\"" + dataInfo.data_key + "\"> " + dataInfo.data_name + "</td>"
                +		"<td style=\"padding-left: 5px\"><button type=\"button\" title=\"Shortcuts\" class=\"dataShortcut\" onclick=\"gotoData('" + projectId + "', '" + dataInfo.data_key + "');\">Shortcuts</button></td>"
                +		"<td style=\"padding-left: 5px; padding-right: 5px;\"><a href=\"#\" onclick=\"viewDataAttribute('" + dataInfo.data_id + "'); return false; \">Details</a></td>"
                +	"</tr>";
            var childrenCount = dataInfo.children.length;
            if(childrenCount > 0) {
                var childrenContent = getChildrenContent(projectId, dataCssId, dataInfo.children);
                content = content + childrenContent;
            }
		}
		return content;
	}

    var dataAttributeDialog = $( ".dataAttributeDialog" ).dialog({
        autoOpen: false,
        width: 400,
        height: 550,
		modal: true,
        resizable: false
    });

    // data key 를 이용하여 dataInfo 정보를 취득
    function viewDataAttribute(dataId) {
    	var url = "/data/ajax-data-by-data-id.do";
		var info = "data_id=" + dataId;
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					showDataInfo(msg.dataInfo);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
    }

    // data info daialog callback
    function showDataInfo(dataInfo) {
        dataAttributeDialog.dialog( "open" );
        $("#detailDataKey").html(dataInfo.data_key);
        $("#detailDataName").html(dataInfo.data_name);
        $("#detailLatitude").html(dataInfo.latitude);
        $("#detailLongitude").html(dataInfo.longitude);
        $("#detailHeight").html(dataInfo.height);
        $("#detailHeading").html(dataInfo.heading);
        $("#detailPitch").html(dataInfo.pitch);
        $("#detailRoll").html(dataInfo.roll);
        showDataAttribute(dataInfo.data_id);
	}
    
    function showDataAttribute(dataId) {
    	var url = "/data/ajax-data-attribute-by-data-id.do";
		var info = "data_id=" + dataId;
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					if(msg.dataInfoAttribute === null || msg.dataInfoAttribute.attributes === null || msg.dataInfoAttribute.attributes === "") {
						var message = "<spring:message code='demo.data.attribute.not.exist'/>";
						$("#detailAttribute").html(message);
					} else {
						$("#detailAttribute").html("");
						$("#detailAttribute").html(msg.dataInfoAttribute.attributes);
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}
    
	// chart 표시
	function initDataChart() {
        projectChart();
        dataStatusChart();
	}

	// project 별 chart
	function projectChart() {
		var url = "/data/ajax-project-data-statistics.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					drawProjectChart(msg.projectNameList, msg.dataTotalCountList);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}
	
	function drawProjectChart(projectNameList, dataTotalCountList) {
		if(projectNameList == null || projectNameList.length == 0) {
			return;
		} 
		
		var data = [];
		var projectCount =  projectNameList.length;
		for(i=0; i<projectCount; i++ ) {
			var projectStatisticsArray = [ projectNameList[i], dataTotalCountList[i]];
			data.push(projectStatisticsArray);
		}
		
		$("#projectChart").html("");
        //var data = [["3DS", 37],["IFC(Cultural Assets)", 1],["IFC", 42],["IFC(MEP)", 1],["Sea Port", 7],["Collada", 7],["IFC(Japan)", 5]];
        var plot = $.jqplot("projectChart", [data], {
            //title : "project 별 chart",
            seriesColors: [ "#a67ee9", "#FE642E", "#01DF01", "#2E9AFE", "#F781F3", "#F6D8CE", "#99a0ac" ],
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: "#ffffff",
                shadow:false
            },
            gridPadding: {top:0, bottom:115, left:0, right:20},
            seriesDefaults:{
                renderer:$.jqplot.PieRenderer,
                trendline : { show : false},
                rendererOptions: {
                    padding:8,
                    showDataLabels: true,
                    dataLabels: "value",
                    //dataLabelFormatString: "%.1f%"
                },
            },
            legend: {
                show: true,
                fontSize: "10pt",
                placement : "outside",
                rendererOptions: {
                    numberRows: 3,
                    numberCols: 3
                },
                location: "s",
                border: "none",
                marginLeft: "10px"
            }
        });
	}

	function dataStatusChart() {
		var url = "/data/ajax-data-status-statistics.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					drawDataStatusChart(msg.useTotalCount, msg.forbidTotalCount, msg.etcTotalCount);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}
	
	function drawDataStatusChart(useTotalCount, forbidTotalCount, etcTotalCount) {
        $("#dataStatusChart").html("");
        
        var useTotalCountLabel = "<spring:message code='demo.data.statistics.use'/>";
        var forbidTotalCountLabel = "<spring:message code='demo.data.statistics.forbid'/>";
        var etcTotalCountLabel = "<spring:message code='demo.data.statistics.etc'/>";
        var dataValues = [ useTotalCount, forbidTotalCount, etcTotalCount];
        var ticks = [useTotalCountLabel, forbidTotalCountLabel, etcTotalCountLabel];
        var yMax = 100;
        if(useTotalCount > 100 || forbidTotalCount > 100 || etcTotalCount > 100) {
			yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
		}

        var plot = $.jqplot("dataStatusChart", [dataValues], {
            //title : "data 상태별 차트",
            height: 205,
            animate: !$.jqplot.use_excanvas,
            seriesColors: [ "#ffa076"],
            grid: {
                background: "#fff",
                //background: "#14BA6C"
                gridLineWidth: 0.7,
                //borderColor: 'transparent',
                shadow: false,
                borderWidth:0.1
                //shadowColor: 'transparent'
            },
            gridPadding:{
                left:35,
                right:1,
                to:40,
                bottom:27
            },
            seriesDefaults:{
                shadow:false,
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true },
                rendererOptions: {
                    barWidth: 40
                }
            },
            axes: {
                xaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer,
                    ticks: ticks,
                    tickOptions:{
                        formatString: "%'d",
                        fontSize: "10pt"
                    }
                },
                yaxis: {
                    numberTicks : 6,
                    min : 0,
                    max : yMax,
                    tickOptions:{
                        formatString: "%'d",
                        fontSize: "10pt"
                    }
                }
            },
            highlighter: { show: false }
        });
	}
	
	function dataInfoChangeRequestLogList() {
		var dataInfoLogListDoesNotExistMessage = "<spring:message code='demo.data.change.request.log.not.exist'/>";
		var requestMessage = "<spring:message code='request'/>";
		var completeMessage = "<spring:message code='complete'/>";
		var rejectMessage = "<spring:message code='reject'/>";
		var resetMessage = "<spring:message code='reset'/>";
		
		var url = "/data/ajax-list-data-change-request-log.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					var dataInfoLogList = msg.dataInfoLogList;
					var totalCount = msg.totalCount;
					var content = "";
					var dataInfoLogListCount = 0;
					if(dataInfoLogList === null || dataInfoLogList.length === 0) {
						content += 	"<tr style=\"text-align: center; vertical-align: middle; padding-top:20px; height: 50px;\">"
								+	"	<td colspan=\"3\" rowspan=\"2\">" +	dataInfoLogListDoesNotExistMessage + "</td>"
								+	"</tr>";
					} else {
						dataInfoLogListCount = dataInfoLogList.length;
						for(i=0; i<dataInfoLogListCount; i++ ) {
							var dataInfoLog = dataInfoLogList[i];
							var status = "";
							if(dataInfoLog.status == "0") status = requestMessage;
							else if(dataInfoLog.status == "1") status = completeMessage;
							else if(dataInfoLog.status == "2") status = rejectMessage;
							else if(dataInfoLog.status == "3") status = resetMessage;
							
							content = content 
							+	"<tr style=\"height: 30px;\">"
							+	"	<td rowspan=\"2\">" + (totalCount - i) + "</td>"
							+	"	<td>" + dataInfoLog.user_id + "</td>"
							+	"	<td><a href=\"#\" onclick=\"dataChangeLog('" + dataInfoLog.data_info_log_id + "'); return false;\">" + dataInfoLog.data_name + "</a></td>"
							+	"</tr>"
							+	"<tr style=\"height: 30px;\">"
							+	"	<td>" + status + "</td>"
							+	"	<td>" + dataInfoLog.view_insert_date + "</td>"
							+	"</tr>";
						}
					}
					$("#dataInfoChangeRequestLog").empty();
					$("#dataInfoChangeRequestLog").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}
	
	// data info change request log
    var dataInfoChangeDialog = $( ".dataInfoChangeDialog" ).dialog({
        autoOpen: false,
        width: 400,
        height: 300,
        modal: true,
        resizable: false
    });
	function dataChangeLog(dataInfoLogId) {
		var url = "/data/ajax-data-info-log.do";
		var info = "data_info_log_id=" + dataInfoLogId;
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					var dataInfoLog = msg.dataInfoLog;
					$("#beforeLatitude").html(dataInfoLog.before_latitude);
					$("#afterLatitude").html(dataInfoLog.latitude);
					$("#beforeLongitude").html(dataInfoLog.before_longitude);
					$("#afterLongitude").html(dataInfoLog.longitude);
					$("#beforeHeight").html(dataInfoLog.before_height);
					$("#afterHeight").html(dataInfoLog.height);
					$("#beforeHeading").html(dataInfoLog.before_heading);
					$("#afterHeading").html(dataInfoLog.heading);
					$("#beforePitch").html(dataInfoLog.before_pitch);
					$("#afterPitch").html(dataInfoLog.pitch);
					$("#beforeRoll").html(dataInfoLog.before_roll);
					$("#afterRoll").html(dataInfoLog.roll);
					
					dataInfoChangeDialog.dialog({title: dataInfoLog.data_name + " Change Request Log"}).dialog( "open" );
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
	}
	
	// Data Object Attribute 검색
	var objectAttributeSearchFlag = true;
    $("#objectAttributeSearch").click(function() {
        if ($.trim($("#objectAttributeDataKey").val()) === "") {
            alert(JS_MESSAGE["data.key.empty"]);
            $("#objectAttributeDataKey").focus();
            return false;
        }
        if ($.trim($("#objectAttributeObjectId").val()) === "") {
        	alert(JS_MESSAGE["object.id.empty"]);
            $("#objectAttributeObjectId").focus();
            return false;
        }

        if(objectAttributeSearchFlag) {
            objectAttributeSearchFlag = false;
            var doesNotExistMessage = "<spring:message code='data.object.does.not.exist'/>";
            
			var url = "/data/ajax-list-data-object-attribute.do";
			var info = 	"project_id=" + $("#objectAttributeProjectId").val()
						+ "&data_key=" + $("#objectAttributeDataKey").val()
						+ "&object_id=" + $("#objectAttributeObjectId").val()
						+ "&search_value=" + $("#objectAttributeSearchValue").val();
			$.ajax({
				url: url,
				type: "GET",
				data: info,
				dataType: "json",
				headers: { "X-mago3D-Header" : "mago3D"},
				success : function(msg) {
					if(msg.result === "success") {
						var dataInfoObjectAttributeList = msg.dataInfoObjectAttributeList;
						var totalCount = msg.totalCount;
						var content = "";
						var dataInfoObjectAttributeListCount = 0;
						if(dataInfoObjectAttributeList === null || dataInfoObjectAttributeList.length === 0) {
							content += 	"<tr style=\"text-align: center; vertical-align: middle; padding-top:20px; height: 50px;\">"
									+	"	<td colspan=\"3\">" +	doesNotExistMessage + "</td>"
									+	"</tr>";
						} else {
							dataInfoObjectAttributeListCount = dataInfoObjectAttributeList.length;
							for(i=0; i<dataInfoObjectAttributeListCount; i++ ) {
								var dataInfoObjectAttribute = dataInfoObjectAttributeList[i];
								
								content = content
								+ 	"<tr style=\"height: 30px; background-color: #eee\">"
								+ 		"<td style=\"padding-left: 2px\" nowrap=\"nowrap\">" + dataInfoObjectAttribute.data_id + "</td>"
								+		"<td>" + dataInfoObjectAttribute.object_id + "</td>"
								+		"<td style=\"padding-left: 5px; padding-right: 5px;\">"
								+		"	<a href=\"#\" onclick=\"viewDataObjectAttribute('" 
								+ 				dataInfoObjectAttribute.data_object_attribute_id + "'); return false; \">Details</a></td>"
								+	"</tr>";	
							}
						}
						
						$("#objectAttributeSearchList > tbody:last").html("");
			            $("#objectAttributeSearchList > tbody:last").append(content);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					objectAttributeSearchFlag = true;
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
			    	console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			    	objectAttributeSearchFlag = true;
				}
			});
        } else {
            alert("In progress.");
            return;
        }
    });

    var dataObjectAttributeDialog = $( ".dataObjectAttributeDialog" ).dialog({
        autoOpen: false,
        width: 600,
        height: 550,
        modal: true,
        resizable: false
    });

    // data key 를 이용하여 dataInfo 정보를 취득
	function viewDataObjectAttribute(dataObjectAttributeId) {
        dataObjectAttributeDialog.dialog( "open" );
        
        var url = "/data/ajax-data-object-attribute.do";
		var info = "data_object_attribute_id=" + dataObjectAttributeId;
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					//var jsonAttribute = JSON.stringify(msg.dataInfoObjectAttribute.attributes, null, 2);
	                $("#dataObjectAttributeContent").append(msg.dataInfoObjectAttribute.attributes);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
				console.log("code : " + request.status + "\n message : " + request.responseText + "\n error : " + error);
			}
		});
    }
	
	// 설정 메뉴 시작
	// Label 표시
	function changeLabel(isShow) {
		$("input:radio[name='labelInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeLabelAPI(managerFactory, isShow);
	}
	// object info 표시
	function changeObjectInfoViewMode(isShow) {
		$("input:radio[name='objectInfo']:radio[value='" + isShow + "']").prop("checked", true);
		changeObjectInfoViewModeAPI(managerFactory, isShow);
	}
	// Origin 표시/비표시
    function changeOrigin(isShow) {
        $("input:radio[name='origin']:radio[value='" + isShow + "']").prop("checked", true);
        changeOriginAPI(managerFactory, isShow);
    }
	// boundingBox 표시/비표시
	function changeBoundingBox(isShow) {
		$("input:radio[name='boundingBox']:radio[value='" + isShow + "']").prop("checked", true);
		changeBoundingBoxAPI(managerFactory, isShow);
	}
	// 마우스 클릭 객체 이동 모드 변경
	function changeObjectMove(objectMoveMode) {
		$("input:radio[name='objectMoveMode']:radio[value='" + objectMoveMode + "']").prop("checked", true);
		changeObjectMoveAPI(managerFactory, objectMoveMode);
		// ALL 인 경우 Origin도 같이 표시
        var originValue = $(':radio[name="origin"]:checked').val();
        if(objectMoveMode === "0") {
		    if(originValue === "true") {
            } else {
            }
            changeOriginAPI(managerFactory, true);
        } else {
            if(originValue === "true") {
            } else {
                changeOriginAPI(managerFactory, false);
            }
        }
	}
	// 마우스 클릭 객체 이동 모드 변경 저장
	$("#saveObjectMoveButton").click(function () {
		alert(JS_MESSAGE["preparing"]);
		return;
		var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
		if(objectMoveMode === "2") {
			alert(JS_MESSAGE["demo.none.mode.not.save"]);
			return;
		}
		saveObjectMoveAPI(managerFactory, objectMoveMode);
	});
	// 마우스 클릭 객체 이동 모드 변경 삭제
	$("#deleteAllObjectMoveButton").click(function () {
		var objectMoveMode = $(':radio[name="objectMoveMode"]:checked').val();
		if(confirm("삭제 하시겠습니까?")) {
			deleteAllObjectMoveAPI(managerFactory, objectMoveMode);
		}
	});
	// Object Occlusion culling
	$("#changeOcclusionCullingButton").click(function() {
		var isUse = $(':radio[name="occlusionCulling"]:checked').val();
		if(isUse === undefined){
			alert(JS_MESSAGE["demo.occlusion.culling.selection"]);
			return;
		}
		if($.trim($("#occlusion_culling_data_key").val()) === ""){
			alert(JS_MESSAGE["data.key.empty"]);
			$("#occlusion_culling_data_key").focus();
			return;
		}
		changeOcclusionCullingAPI(managerFactory, ($(':radio[name="occlusionCulling"]:checked').val() === "true"), $("#occlusion_culling_data_key").val());
	});
	
	// 카메라 모드 전환
	function changeViewMode(isFPVMode) {
		$("input:radio[name='viewMode']:radio[value='" + isFPVMode + "']").prop("checked", true);
		changeFPVModeAPI(managerFactory, isFPVMode);
	}
	
	// rendering 설정
	function initRendering() {
		var ambient = $( "#geo_ambient_reflection_coef_view" );
		$( "#ambient_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '0.5', // default value of slider
			create: function() {
				ambient.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				ambient.text( ui.value);
				$("#geo_ambient_reflection_coef" ).val(ui.value);
			}
		});
		var diffuse = $( "#geo_diffuse_reflection_coef_view" );
		$( "#diffuse_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '1.0', // default value of slider
			create: function() {
				diffuse.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				diffuse.text( ui.value);
				$("#geo_diffuse_reflection_coef" ).val(ui.value);
			}
		});
		var specular = $( "#geo_specular_reflection_coef_view" );
		$( "#specular_reflection_coef" ).slider({
			range: "max",
			min: 0, // min value
			max: 1, // max value
			step: 0.01,
			value: '1.0', // default value of slider
			create: function() {
				specular.text( $( this ).slider( "value" ) );
			},
			slide: function( event, ui ) {
				specular.text( ui.value);
				$("#geo_specular_reflection_coef" ).val(ui.value);
			}
		});
	}
	
	// LOD 설정
	$("#changeLodButton").click(function() {
		changeLodAPI(managerFactory, $("#geo_lod0").val(), $("#geo_lod1").val(), $("#geo_lod2").val(), $("#geo_lod3").val(), $("#geo_lod4").val(), $("#geo_lod5").val());
	});
	// Lighting 설정
	$("#changeLightingButton").click(function() {
		changeLightingAPI(managerFactory, $("#geo_ambient_reflection_coef").val(), $("#geo_diffuse_reflection_coef").val(), $("#geo_specular_reflection_coef").val(), null, null);
	});
	// Ssadradius 설정
	$("#changeSsaoRadiusButton").click(function() {
		if($.trim($("#geo_ssao_radius").val())==="") {
			alert(JS_MESSAGE["demo.ssao.empty"]);
			$("#geo_ssao_radius").focus();
			return;
		}
		changeSsaoRadiusAPI(managerFactory, $("#geo_ssao_radius").val());
	});

	// click poisition call back function
	function showClickPosition(position) {
		$("#positionLatitude").val(position.lat);
		$("#positionLongitude").val(position.lon);
		$("#positionAltitude").val(position.alt);
	}
	
	// 모든 데이터 비표시
	function clearAllData() {
		clearAllDataAPI(managerFactory);
	}
	
	// general callback alert function
	function showApiResult(apiName, result) {
		if(apiName === "searchData") {
			if(result === "-1") {
				alert(JS_MESSAGE["demo.information.not.loading"]);
			}
		}
	}
	
	function saveCurrentLocation(latitude, longitude) {
		// 현재 좌표를 저장
		$("#now_latitude").val(latitude);
		$("#now_longitude").val(longitude);
	}
	
	// moved data callback
	function showMovedData(projectId, dataKey, objectId, latitude, longitude, height, heading, pitch, roll) {
		$("#moveProjectId").val(projectId);
		$("#moveDataKey").val(dataKey);
        $("#moveLatitude").val(latitude);
        $("#moveLongitude").val(longitude);
        $("#moveHeight").val(height);
        $("#moveHeading").val(heading);
        $("#movePitch").val(pitch);
        $("#moveRoll").val(roll);
    }
</script>
</body>
</html>