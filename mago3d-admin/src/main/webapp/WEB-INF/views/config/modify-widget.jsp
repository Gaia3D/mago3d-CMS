<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<script src="/externlib/webix/codebase/webix.js?v=6.0.5" type="text/javascript"></script>
	<link rel="STYLESHEET" type="text/css" href="/externlib/webix/codebase/webix.css?v=6.0.5">
</head>

<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="content-header row">
							<div class="content-title u-pull-left"><spring:message code='config.widget.top'/></div>
						</div>
						<form:form id="widget" modelAttribute="widget" method="post" onsubmit="return false;">
				  			<form:hidden path="widget_order" />
						<div id="sortable" class="widgets row">
<c:forEach var="dbWidget" items="${widgetList }">
	<c:choose>
		<c:when test="${dbWidget.name == 'projectWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">기본 프로젝트 데이터 현황<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/data/list-data.do" title="<spring:message code='config.widget.project.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row" style="margin-top:0px; padding-top:0px; width:95%; height:90%;">
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dataInfoWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">데이터 상태별 현황<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/data/list-data.do" title="<spring:message code='config.widget.data.info.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row" style="margin-top:0px; padding-top:0px; width:95%; height:90%;">
									<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            		<div id="dataInfoSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dataInfoLogListWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">데이터 변경 요청 이력<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/data/list-data-log.do" title="<spring:message code='config.widget.data.info.log.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            		<div id="dataInfoLogListSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'issueWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">최근 이슈<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/issue/list-issue.do" title="<spring:message code='config.widget.issue.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 80px; padding-left: 30px;">
					            		Recent Issue List is under development...
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'userWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title"><spring:message code='config.widget.user.status'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/user/list-user.do" title="<spring:message code='config.widget.user.status.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row" style="margin-top:0px; padding-top:0px; width:95%; height:90%;">
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'scheduleLogListWidget'}">	
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title"><spring:message code='config.widget.schedule'/><span class="widget-desc">${thisYear }<spring:message code='config.widget.last.year.7'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/schedule/list-schedule-log.do" title="<spring:message code='config.widget.schedule.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            		<div id="scheduleLogListSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'accessLogWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title"><spring:message code='config.widget.user.tracking'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/log/list-access-log.do" title="<spring:message code='config.widget.user.tracking.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            		<div id="accessLogSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbcpWidget'}">
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title"><spring:message code='config.widget.db.connection'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
								</div>
								
								<div id="${dbWidget.name}" class="widget-content row">
									<table class="widget-table">
										<col class="col-left" />
										<col class="col-center" />
										<col class="col-center" />
										<col class="col-center" />
										<tr>
											<td class="col-left">
												<em><spring:message code='config.widget.db.property'/></em>
											</td>
											<td class="col-center">
												<em><spring:message code='config.widget.db.admin'/></em>
											</td>
											<td class="col-center">
												<em><spring:message code='config.widget.db.user'/></em>
											</td>
											<td class="col-center">
												<em><spring:message code='config.widget.db.status'/></em>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-users-circle"></span>
												<em><spring:message code='config.widget.db.now.session'/></em>
											</td>
											<td class="col-center">
												<span id="userSessionCount" class="tendency increase">${userSessionCount }</span>
											</td>
											<td class="col-center">
												<span id="userUserSessionCount" class="tendency increase">${userUserSessionCount }</span>
											</td>
											<td class="col-center">
												<span class="tendency increase">
													<span class="icon-glyph glyph-up"></span>
												</span>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-imark-circle"></span>
												<em><spring:message code='config.widget.db.init'/></em> (initialSize)
											</td>
											<td class="col-center">
												<span id="initialSize" class="tendency increase">${initialSize }</span>
											</td>
											<td class="col-center">
												<span id="userInitialSize" class="tendency increase">${userInitialSize }</span>
											</td>
											<td class="col-center">
												<span class="tendency increase">
													<span class="icon-glyph glyph-up"></span>
												</span>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-plus-circle"></span>
												<em><spring:message code='config.widget.db.max.total'/></em> (maxTotal)
											</td>
											<td class="col-center">
												<span id="maxTotal" class="tendency decrease">${maxTotal }</span>
											</td>
											<td class="col-center">
												<span id="userMaxTotal" class="tendency decrease">${userMaxTotal }</span>
											</td>
											<td class="col-center">
												<span class="tendency decrease">
													<span class="icon-glyph glyph-down"></span>
												</span>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-top-circle"></span>
												<em><spring:message code='config.widget.db.max.idle'/></em> (maxIdle)
											</td>
											<td class="col-center">
												<span id="maxIdle" class="tendency decrease">${maxIdle }</span>
											</td>
											<td class="col-center">
												<span id="userMaxIdle" class="tendency decrease">${userMaxIdle }</span>
											</td>
											<td class="col-center">
												<span class="tendency decrease">
													<span class="icon-glyph glyph-down"></span>
												</span>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-mouse-circle"></span>
												<em><spring:message code='config.widget.db.using'/></em> (numActive)
											</td>
											<td class="col-center">
												<span id="numActive" class="tendency increase">${numActive }</span>
											</td>
											<td class="col-center">
												<span id="userNumActive" class="tendency increase">${userNumActive }</span>
											</td>
											<td class="col-center">
												<span class="tendency increase">
													<span class="icon-glyph glyph-up"></span>
												</span>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-bottom-circle"></span>
												<em><spring:message code='config.widget.db.min.idle'/></em> (minIdle, numIdle)
											</td>
											<td class="col-center">
												<span id="minIdle" class="tendency increase">${minIdle },${numIdle }</span>
											</td>
											<td class="col-center">
												<span id="userMinIdle" class="tendency increase">${userMinIdle },${userNumIdle }</span>
											</td>
											<td class="col-center">
												<span class="tendency increase">
													<span class="icon-glyph glyph-up"></span>
												</span>
											</td>
										</tr>
									</table>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbSessionWidget'}">			
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title"><spring:message code='config.widget.db.session'/>(${dbSessionCount })<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/monitoring/list-db-session.do" title="<spring:message code='config.widget.db.session.more'/>"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<table class="widget-table">
										<col class="col-left" />
										<col class="col-left" />
					<c:if test="${empty dbSessionList }">					
										<tr>
											<td colspan="2" class="col-none"><spring:message code='config.widget.db.session.no'/></td>
										</tr>
					</c:if>
					<c:if test="${!empty dbSessionList }">
						<c:forEach var="pGStatActivity" items="${dbSessionList}" varStatus="status">
										<tr>
											<td class="col-left">
												<span class="index"></span>
												${pGStatActivity.client_addr }
											</td>
											<td class="col-left">${pGStatActivity.viewQuery }</td>
										</tr>
						</c:forEach>
					</c:if>
									</table>
								</div>
							</div>
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
</c:forEach>
						</div>
						</form:form>
						<div class="button-group">
							<div class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="updateWidget(); return false;"/>
							</div>
						</div>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#sortable").sortable({  
			update: function( event, ui ) {
				var widgetValue = "";
				$(".widget").each(function() {  
					widgetValue = widgetValue + "," + $(this).attr("id");
				});
				$("#widget_order").val(widgetValue);
				console.log(widgetValue);
			}
		});
		$("#sortable").disableSelection();
		
		projectWidget();
		dataInfoWidget();
		startSpinner("dataInfoSpinner");
		dataInfoLogWidget();
		startSpinner("dataInfoLogListSpinner");
 		userWidget();
		startSpinner("scheduleLogListSpinner");
		scheduleLogListWidget();
		startSpinner("accessLogSpinner");
		accessLogWidget();
	});
	
	function projectWidget() {
		var url = "/config/ajax-project-data-widget.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					showProject(msg.projectList);
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
	
	function showProject(projectList) {
		if(projectList == null || projectList.length == 0) {
			return;
		} 
		
		var dataset = [];
		var projectColor = ["#a67ee9", "#FE642E", "#01DF01", "#2E9AFE", "#F781F3", "#F6D8CE", "#99a0ac"];
		var projectCount =  projectList.length;
		for(i=0; i<projectCount; i++ ) {
			var projectJson = new Object();
			projectJson.project_name = projectList[i].project_name;
			projectJson.data_count = projectList[i].data_count;
			projectJson.color = projectColor[i];
			dataset.push(projectJson);
		}
		
		webix.ui({
			container: "projectWidget",
			margin : 0,
			padding : 0,
			borderless:true,
			cols:[{
				rows:[{
					view: "chart",
					type:"pie",
					value:"#data_count#",
					color:"#color#",
					pieInnerText:"#data_count#",
					legend:{
						//width:200,
						align:"right",
						valign:"top",
						template:"#project_name#"
					},
					shadow:0,
					x:150,
					y:100,
					data:dataset
				}]
			}]
		});
	}
	
	function dataInfoWidget() {
		$.ajax({
			url : "/config/ajax-data-status-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					showDataInfo(msg);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	function showDataInfo(jsonData) {
		$("#dataInfoWidget").empty();
		var useTotalCount = parseInt(jsonData.useTotalCount);
		var forbidTotalCount = parseInt(jsonData.forbidTotalCount);
		var etcTotalCount = parseInt(jsonData.etcTotalCount);
		
		var use = "<spring:message code='data.status.use'/>";
		var unused = "<spring:message code='data.status.unused'/>";
		var etc = "<spring:message code='data.status.etc'/>";
		
		var dataset = [];
		var dataValues = [ useTotalCount, forbidTotalCount, etcTotalCount];
		var ticks = [use, unused, etc];
		var yMax = 10;
		var yStep = 1;
		if(useTotalCount > 10 || forbidTotalCount > 10 || etcTotalCount > 10) {
			yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
			yStep = parseInt(yMax / 5);
		}
		
		for(i=0; i<dataValues.length; i++ ) {
			var dataInfoJson = new Object();
			dataInfoJson.status = ticks[i];
			dataInfoJson.count = dataValues[i];
			dataset.push(dataInfoJson);
		}
		
		webix.ui({
            container:"dataInfoWidget",
            borderless:true,
            //height:220,
            rows:[
                {
                    view:"chart",
                    type:"bar",
                    value:"#count#",
                    label:"#count#",
                    barWidth:50,
                    color:"#40a7fe",
                    /* tooltip:{
                        template:"#count#"
                    }, */
                    xAxis:{
                        template:"#status#"
                    },
                    yAxis:{
                        start:0,
                        end:yMax,
                        step:yStep,
                        template:function(obj){
                            return (obj%yStep?"":obj)
                        }
                    },
                    padding:{
                        left: 40
                    },
                    radius:0,
                    data: dataset
                }
            ]
        });
	} 
	
	function dataInfoLogWidget() {
		$.ajax({
			url : "/config/ajax-data-info-log-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var dataInfoLogList = msg.dataInfoLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />";
					if(dataInfoLogList == null || dataInfoLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">데이터 변경 요청 이력이 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<dataInfoLogList.length; i++ ) {
							var dataInfoLog = null;
							dataInfoLog = dataInfoLogList[i];
							var viewStatus = "";
							if(dataInfoLog.status === "0") viewStatus = "<spring:message code='request'/>";
							else if(dataInfoLog.status === "1") viewStatus = "<spring:message code='complete'/>";
							else if(dataInfoLog.status === "2") viewStatus = "<spring:message code='reject'/>";
							else if(dataInfoLog.status === "3") viewStatus = "<spring:message code='reset'/>";
							
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + dataInfoLog.data_name + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + viewStatus + "</td>"
								+ 		"<td class=\"col-left\">" + dataInfoLog.view_insert_date + "</td>"
								+ 	"</tr>";
						}
					}
					$("#dataInfoLogListWidget").empty();
					$("#dataInfoLogListWidget").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	function issueWidget() {
		
	}
	
	// 사용자 상태별 현황
	function userWidget() {
		var activeUserTotalCount = parseInt("${activeUserTotalCount}");
		var fobidUserTotalCount = parseInt("${fobidUserTotalCount}");
		var failUserTotalCount = parseInt("${failUserTotalCount}");
		var sleepUserTotalCount = parseInt("${sleepUserTotalCount}");
		var expireUserTotalCount = parseInt("${expireUserTotalCount}");
		var tempPasswordUserTotalCount = parseInt("${tempPasswordUserTotalCount}");
		
		var used = "<spring:message code='config.widget.use'/>";
		var disable = "<spring:message code='config.widget.stop.use'/>";
		var failureCount = "<spring:message code='config.widget.failure.count'/>";
		var dormancy = "<spring:message code='config.widget.dormancy'/>";
		var expiration = "<spring:message code='config.widget.expiration'/>";
		var temporaryPassword = "<spring:message code='config.widget.temporary.password'/>";
		
		var dataset = [];
		var userValues = [ activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount];
		var ticks = [used, disable, failureCount, dormancy, expiration, temporaryPassword];
		var yMax = 10;
		var yStep = 1;
		if(activeUserTotalCount > 10 || fobidUserTotalCount > 10 || failUserTotalCount > 10 || sleepUserTotalCount > 10 || expireUserTotalCount > 10 || tempPasswordUserTotalCount > 10) {
			yMax = Math.max(activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount) + (activeUserTotalCount * 0.2);
			yStep = parseInt(yMax / 5);
		}
		
		for(i=0; i<userValues.length; i++ ) {
			var userJson = new Object();
			userJson.status = ticks[i];
			userJson.count = userValues[i];
			dataset.push(userJson);
		}
		
		webix.ui({
            container:"userWidget",
            borderless:true,
          	//height:230,
            rows:[
                {
                    view:"chart",
                    type:"bar",
                    value:"#count#",
                    label:"#count#",
                    barWidth:50,
                    color:"#ffa076",
                    /* tooltip:{
                        template:"#count#"
                    }, */
                    xAxis:{
                        template:"#status#"
                    },
                    yAxis:{
                        start:0,
                        end:yMax,
                        step:yStep,
                        template:function(obj){
                            return (obj%yStep?"":obj)
                        }
                    },
                    padding:{
                        left: 40
                    },
                    radius:0,
                    data: dataset
                }
            ]
        });
	}
	
	// 스케줄 실행 이력 갱신
	function scheduleLogListWidget() {
		$.ajax({
			url : "/config/ajax-schedule-log-list-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var scheduleLogList = msg.scheduleLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-center\" style=\"min-width:50px;\"/>"
								+	"<col class=\"col-center\" />";
					if(scheduleLogList == null || scheduleLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">"+ JS_MESSAGE["config.schedule.widget.does.not.exist"] + "</td>"
								+	"</tr>";
					} else {
						for(i=0; i<scheduleLogList.length; i++ ) {
							var scheduleLog = null;
							scheduleLog = scheduleLogList[i];
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\"><em>" + scheduleLog.schedule_name + "</em></td>"
								+ 	"	<td class=\"col-center\">"  + scheduleLog.viewExecuteResult + "</td>"
								+ 	"	<td class=\"col-center\">" + scheduleLog.viewRegisterDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#scheduleLogListWidget").empty();
					$("#scheduleLogListWidget").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	// 사용자 추적
	function accessLogWidget() {
		$.ajax({
			url : "/config/ajax-access-log-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var accessLogList = msg.accessLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />";
					if(accessLogList == null || accessLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"2\" class=\"col-none\">사용자 추적 이력이 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<accessLogList.length; i++ ) {
							var accessLog = null;
							accessLog = accessLogList[i];
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + accessLog.user_name + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + accessLog.viewRequestUri + "</td>"
								+ 	"</tr>";
						}
					}
					$("#accessLogWidget").empty();
					$("#accessLogWidget").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 저장
	var updateFlag = true;
	function updateWidget() {
		if ($("#widget_order").val() == "") {
			alert(JS_MESSAGE["config.widget.content.does.not.exit"]);
			return false;
		}
		if (updateFlag) {
			updateFlag = false;
			var info = "widget_order=" + $("#widget_order").val();
			$.ajax({
				url : "/config/ajax-update-widget.do",
				type : "POST",
				data : info,
				cache : false,
				dataType : "json",
				success : function(msg) {
					if (msg.result == "success") {
						alert(JS_MESSAGE["update"]);
						$("#widget_order").val("");
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateFlag = true;
				},
				error : function(request, status, error) {
					alert(JS_MESSAGE["ajax.error.message"]);
					updateFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>