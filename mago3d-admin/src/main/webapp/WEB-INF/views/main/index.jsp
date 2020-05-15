<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>대시보드 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jqplot/jquery.jqplot.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css?cacheVersion=${contentCacheVersion}">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <style type="text/css">
        .jqplot-table-legend {
            width: 0%;
            border-collapse: inherit;
        }
        .jqplot-table-legend-label {
			max-width: 150px;
			overflow:hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
        }
    </style>
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="widgets">
				<div class="row">
					<div class="widget widget-low widget-otp-usage full column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.converter.status'/><span class="widget-desc">${yearMonthDay } (<spring:message code='main.today'/>)</span></h3>
							</div>
						</div><!-- .widget-header -->
						<div class="widget-content row">
							<div class="one-third column banner-container">
								<div class="banner info-generates">
									<div>
										<div class="info-device">
											<span class="icon-glyph glyph-plus-circle"></span>
											<span class="info-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title"><spring:message code='main.converter.new'/></span>
										<span id="firstCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${converterTotalCount} <spring:message code='main.count'/> </span>
									</div>
								</div>
							</div>

							<div class="one-third column banner-container">
								<div class="banner info-success">
									<div>
										<div class="info-device">
											<span class="icon-glyph glyph-check-circle"></span>
											<span class="info-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title"><spring:message code='main.converter.success'/></span>
										<span id="secondeCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${converterSuccessCount} <spring:message code='main.count'/></span>
									</div>
								</div>
							</div>

							<div class="one-third column banner-container">
								<div class="banner info-failures">
									<div>
										<div class="info-device">
											<span class="icon-glyph glyph-emark-circle"></span>
											<span class="info-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title"><spring:message code='main.converter.fail'/></span>
										<span id="thirdCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${converterFailCount} <spring:message code='main.count'/></span>
									</div>
								</div>
							</div>
						</div><!-- .widget-content -->
					</div><!-- .widget -->

<c:forEach var="dbWidget" items="${widgetList }">
	<c:choose>
		<c:when test="${dbWidget.name eq 'dataGroupWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.data.group'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data/list" title="<spring:message code='config.widget.project.more'/>"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            <div id="dataGroupSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'dataStatusWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.use.data'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data/list" title="<spring:message code='config.widget.data.info.more'/>"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					      		<div id="dataStatusSpinner" style="width: 150px; height: 70px;"></div>
					       	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'dataAdjustLogWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.data.log'/><span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data-adjust-log/list" title="<spring:message code='config.widget.data.info.log.more'/>"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					       		<div id="dataAdjustLogSpinner" style="width: 150px; height: 70px;"></div>
					       	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'userStatusWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.userstatus'/><span class="widget-desc">${today } <spring:message code='main.standard'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.moreuserstatus' var="moreuserstatus"/>
								<a href="/user/list" title="${moreuserstatus}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'userAccessLogWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.user.tracking'/><span class="widget-desc">${today } <spring:message code='main.standard'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.user.moretracking' var='moreTracking'/>
								<%-- <a href="/access/list" title="${moreTracking}"><span class="icon-glyph glyph-plus"></span></a> --%>
							</div>
						</div>

						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
			            		<div id="userAccessLogSpinner" style="width: 150px; height: 70px;"></div>
			            	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'civilVoiceWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.civilvoice.data'/><span class="widget-desc">${thisYear }<spring:message code='main.status.civilvoice.date'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.civilvoice.moreexecution' var="moreExectuion"/>
								<a href="/civil-voice/list?orderWord=comment_count&orderValue=DESC" title="${moreExectuion}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
			            		<div id="civilVoiceSpinner" style="width: 150px; height: 70px;"></div>
			            	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'systemUsageWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.system.usage'/><span class="widget-desc">${today } <spring:message code='main.standard'/></span></h3>
							</div>
						</div>

						<div id="${dbWidget.name}" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
			            		<div id="systemUsageSpinner" style="width: 150px; height: 70px;"></div>
			            	</div>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'dbcpStatusWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.db.connection.pool'/><span class="widget-desc">${today } <spring:message code='main.standard'/></span></h3>
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
										<em><spring:message code='main.status.property'/></em>
									</td>
									<td class="col-center">
										<em><spring:message code='main.status.admin'/></em>
									</td>
									<td class="col-center">
										<em><spring:message code='main.status.user'/></em>
									</td>
									<td class="col-center">
										<em><spring:message code='main.status'/></em>
									</td>
								</tr>
								<tr>
									<td class="col-left">
										<span class="icon-glyph glyph-users-circle"></span>
										<em><spring:message code='main.status.usersession.count'/></em>
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
										<em><spring:message code='main.status.initialSize' /></em> (initialSize)
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
										<em><spring:message code='main.status.maxtotal'/></em> (maxTotal)
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
										<em><spring:message code='main.status.maxIdle'/></em> (maxIdle)
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
										<em><spring:message code='main.status.numactive'/></em> (numActive)
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
										<em><spring:message code='main.status.minIdle'/></em> (minIdle, numIdle)
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
								<%-- <tr>
									<td class="col-left">
										<span class="icon-glyph glyph-check-circle"></span>
										<em>유지수</em> (numIdle)
									</td>
									<td class="col-center">
										<span id="numIdle" class="tendency increase">${numIdle }</span>
									</td>
									<td class="col-center">
										<span id="userNumIdle" class="tendency increase">${userNumIdle }</span>
									</td>
									<td class="col-center">
										<span class="tendency increase">
											<span class="icon-glyph glyph-up"></span>
										</span>
									</td>
								</tr> --%>
							</table>
						</div>
					</div>
		</c:when>
		<c:when test="${dbWidget.name eq 'dbSessionWidget'}">
					<div id="${dbWidget.widgetId }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">
								<h3 class="widget-title"><spring:message code='main.status.db.session'/>(${dbSessionCount })<span class="widget-desc">${today }<spring:message code='main.standard'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<spring:message code='main.status.db.moresession' var='moreSession'/>
								<a href="/monitoring/list-db-session.do" title="${moreSession}"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="${dbWidget.name}" class="widget-content row">
							<table class="widget-table">
								<col class="col-left" />
								<col class="col-left" />
			<c:if test="${empty dbSessionList }">
								<tr>
									<td colspan="2" class="col-none"><spring:message code='main.status.db.nosession'/></td>
								</tr>
			</c:if>
			<c:if test="${!empty dbSessionList }">
				<c:forEach var="pGStatActivity" items="${dbSessionList}" varStatus="status">
								<tr>
									<td class="col-left">
										<span class="index"></span>
										${pGStatActivity.clientAddr }
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
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>

<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.dateAxisRenderer.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pointLabels.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.donutRenderer.min.js?cacheVersion=${contentCacheVersion}"></script>

<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js?cacheVersion=${contentCacheVersion}"></script>

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/navigation.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	var refreshTime = parseInt("${widgetInterval}") * 1000;

	var isDataGroupDraw = "${isDataGroupDraw}";
	var isDataStatusDraw = "${isDataStatusDraw}";
	var isDataAdjustLogDraw = "${isDataAdjustLogDraw}";
	var isUserStatusDraw = "${isUserStatusDraw}";
	var isUserAccessLogDraw = "${isUserAccessLogDraw}";
	var isCivilVoiceDraw = "${isCivilVoiceDraw}";
	var isSystemUsageDraw = "${isSystemUsageDraw}";
	var isDbcpStatusDraw = "${isDbcpStatusDraw}";
	var isDbSessionDraw = "${isDbSessionDraw}";
	var isIssueDraw = "${isIssueDraw}";

	$(document).ready(function() {
		if(isDataGroupDraw == "true") {
			startSpinner("dataGroupSpinner");
			dataGroupWidget();
		}
		if(isDataStatusDraw == "true") {
			startSpinner("dataStatusSpinner");
			dataStatusWidget();
		}
		if(isDataAdjustLogDraw == "true") {
			startSpinner("dataAdjustLogSpinner");
			dataAdjustLogWidget();
		}
		if(isUserStatusDraw == "true") {
			userStatusWidget(0, null);
		}
		if(isUserAccessLogDraw == "true") {
			startSpinner("userAccessLogSpinner");
		    setTimeout(callUserAccessLogWidget, 1000);
		}
		if(isCivilVoiceDraw == "true") {
			startSpinner("civilVoiceSpinner");
			civilVoiceWidget();
		}
		if(isSystemUsageDraw == "true") {
			startSpinner("systemUsageSpinner");
		    setTimeout(callSystemUsageWidget, 1000);
		}
		if(isDbcpStatusDraw == "true") {
			setTimeout(callDbcpStatusWidget, 2000);
		}
		if(isDbSessionDraw == "true") {
			//startSpinner("dbSessionSpinner");
		    setTimeout(dbSessionWidget, 3000);
		}
		if(isIssueDraw == "true") {
			// TODO spinner
			issueWidget();
		}

		var isActive = "${isActive}";
		if(isActive == "true") {
			// Active 일때만 화면을 갱신함
			setInterval(refreshMain, refreshTime);
		}
	});

	function refreshMain() {
		if(isDataGroupDraw == "true") {
			dataGroupWidget();
		}
		if(isDataStatusDraw == "true") {
			dataStatusWidget();
		}
		if(isDataAdjustLogDraw == "true") {
			dataAdjustLogWidget();
		}
		if(isUserStatusDraw == "true") {
			//userStatusWidget();
		}
		if(isIssueDraw == "true") {
			issueWidget();
		}
		// TODO You'll need to add the remaining widgets later
	}

	// DB Connection Pool 현황
	function callDbcpStatusWidget() {
		dbcpStatusWidget();
		setInterval(dbcpStatusWidget, refreshTime);
	}

	// 사용자 추적
	function callUserAccessLogWidget() {
		userAccessLogWidget();
		setInterval(userAccessLogWidget, refreshTime);
	}

	// 시스템 사용량
	function callSystemUsageWidget() {
		systemUsageWidget();
		setInterval(systemUsageWidget, refreshTime);
	}

	function dataGroupWidget() {
		var url = "/widgets/data-group-statistics";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.statusCode <= 200) {
					$("#dataGroupWidget").empty();
					showDataGroup(msg.dataGroupWidgetList);
				} else {
					$("#dataGroupWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#dataGroupWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function showDataGroup(dataGroupWidgetList) {
		if(dataGroupWidgetList == null || dataGroupWidgetList.length == 0) {
			return;
		}

		var data = [];
		var dataGroupCount =  dataGroupWidgetList.length;
		for(i=0; i<dataGroupCount; i++ ) {
			var dataGroupStatisticsArray = [ dataGroupWidgetList[i]["name"], dataGroupWidgetList[i]["count"]];
			data.push(dataGroupStatisticsArray);
		}

		var plot = $.jqplot("dataGroupWidget", [data], {
            //title : "project 별 chart",
            seriesColors: [ "#a67ee9", "#FE642E", "#01DF01", "#2E9AFE", "#F781F3", "#F6D8CE", "#99a0ac" ],
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: "#ffffff",
                shadow:false
            },
            gridPadding: {top:0, bottom:85, left:0, right:170},
            seriesDefaults:{
                renderer:$.jqplot.PieRenderer,
                trendline : { show : false},
                rendererOptions: {
                    padding:8,
                    showDataLabels: true,
                    dataLabels: "value",
                    startAngle: -90,
                    //dataLabelFormatString: "%.1f%"
                },
            },
            legend: {
                show: true,
                fontSize: "10pt",
                placement : "outside",
                rendererOptions: {
                    numberRows: 7,
                    numberColumns: 1
                },
                location: "e",
                //border: "none",
                marginLeft: "10px"
            }
        });
	}

	function dataStatusWidget() {
		$.ajax({
			url : "/widgets/data-status-statistics",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					$("#dataStatusWidget").empty();
					showDataStatus(msg.statistics);
				} else {
					$("#dataStatusWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#dataStatusWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function showDataStatus(jsonData) {
		var useTotalCount = parseInt(jsonData.useTotalCount);
		var forbidTotalCount = parseInt(jsonData.forbidTotalCount);
		var etcTotalCount = parseInt(jsonData.etcTotalCount);

		var use = "<spring:message code='data.status.use'/>";
		var unused = "<spring:message code='data.status.unused'/>";
		var etc = "<spring:message code='data.status.etc'/>";

		var dataValues = [ useTotalCount, forbidTotalCount, etcTotalCount];
		var ticks = [use, unused, etc];
		var yMax = 10;
		if(useTotalCount > 10 || forbidTotalCount > 10 || etcTotalCount > 10) {
			yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
		}

		var plot = $.jqplot("dataStatusWidget", [dataValues], {
        	//title : "data info status",
        	height: 205,
        	animate: !$.jqplot.use_excanvas,
        	seriesColors: [ "#40a7fe", "#3fbdf8" ],
        	seriesDefaults:{
            	shadow:false,
            	renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true },
                rendererOptions: {
                	barWidth: 50
                }
            },
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

	function dataAdjustLogWidget() {
		$.ajax({
			url : "/widgets/data-adjust-log",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					var dataAdjustLogList = msg.dataAdjustLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\"/>"
								+	"<col class=\"col-center\"/>"
								+	"<col class=\"col-center\" />"
								+	"<thead><tr>"
								+	"	<td class=\"col-left\"><em>데이터 명</em></td>"
								+	"	<td class=\"col-center\"><em>요청 현황</em></td>"
								+ 	"	<td class=\"col-center\"><em>요청 일시</em></td>"
								+	"</tr></thead>";
					if(dataAdjustLogList == null || dataAdjustLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">데이터 변경 요청 이력이 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<dataAdjustLogList.length; i++ ) {
							var dataAdjustLog = null;
							dataAdjustLog = dataAdjustLogList[i];
							var viewStatus = "";
							if(dataAdjustLog.status === "request") viewStatus = "요청";
							else if(dataAdjustLog.status === "approval") viewStatus = "승인";
							else if(dataAdjustLog.status === "reject") viewStatus = "반려";
							else if(dataAdjustLog.status === "rollback") viewStatus = "원복";

							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-left ellipsis\" style=\"max-width:160px;\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + dataAdjustLog.dataName + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-center\" style=\"width:60px;\">" + viewStatus + "</td>"
								+ 		"<td class=\"col-center\">" + dataAdjustLog.viewInsertDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#dataAdjustLogWidget").empty();
					$("#dataAdjustLogWidget").html(content);
				} else {
					$("#dataAdjustLogWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#dataAdjustLogWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function issueWidget() {

	}

	// 사용자 상태별 현황
	function showUserStatus(drawType, jsonData) {
		var activeUserTotalCount = null;
		var fobidUserTotalCount = null;
		var failUserTotalCount = null;
		var sleepUserTotalCount = null;
		var expireUserTotalCount = null;
		var tempPasswordUserTotalCount = null;

		if(drawType == 0) {
			// el 데이터 표시
			activeUserTotalCount = parseInt("${activeUserTotalCount}");
			fobidUserTotalCount = parseInt("${fobidUserTotalCount}");
			failUserTotalCount = parseInt("${failUserTotalCount}");
			sleepUserTotalCount = parseInt("${sleepUserTotalCount}");
			expireUserTotalCount = parseInt("${expireUserTotalCount}");
			tempPasswordUserTotalCount = parseInt("${tempPasswordUserTotalCount}");
		} else {
			// ajax 데이터 표시
			activeUserTotalCount = parseInt(jsonData.activeUserTotalCount);
			fobidUserTotalCount = parseInt(jsonData.fobidUserTotalCount);
			failUserTotalCount = parseInt(jsonData.failUserTotalCount);
			sleepUserTotalCount = parseInt(jsonData.sleepUserTotalCount);
			expireUserTotalCount = parseInt(jsonData.expireUserTotalCount);
			tempPasswordUserTotalCount = parseInt(jsonData.tempPasswordUserTotalCount);
		}

		var userValues = [ activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount];
		var ticks = [JS_MESSAGE["main.status.in.use"], JS_MESSAGE["main.status.stop.use"], JS_MESSAGE["main.status.fail.count"], JS_MESSAGE["main.status.dormancy"], JS_MESSAGE["main.status.expires"], JS_MESSAGE["main.status.temporary.password"]];
		var yMax = 10;
		if(activeUserTotalCount > 10 || fobidUserTotalCount > 10 || failUserTotalCount > 10 || sleepUserTotalCount > 10 || expireUserTotalCount > 10 || tempPasswordUserTotalCount > 10) {
			yMax = Math.max(activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount) + (activeUserTotalCount * 0.2);
		}

        var plot = $.jqplot("userStatusWidget", [userValues], {
        	//title : "사용자 상태별 현황",
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

	// 사용자 상태별 현황 정보 갱신
	function userStatusWidget() {
		$.ajax({
			url : "/widgets/user-status-statistics",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					$("#userStatusWidget").empty();
					showUserStatus(1, msg.statistics);
				} else {
					$("#userStatusWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#userStatusWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 사용자 추적
	function userAccessLogWidget() {
		$.ajax({
			url : "/widgets/user-access-log",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					var userAccessLogList = msg.userAccessLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />"
								+	"<thead><tr>"
								+	"	<td class=\"col-left\"><em>사용자 명</em></td>"
								+	"	<td class=\"col-left\"><em>접근 URL</em></td>"
								+	"</tr></thead>";
					if(userAccessLogList == null || userAccessLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"2\" class=\"col-none\"><spring:message code='main.status.no.user.tracking'/></td>"
								+	"</tr>";
					} else {
						for(i=0; i<userAccessLogList.length; i++ ) {
							var userAccessLog = null;
							userAccessLog = userAccessLogList[i];
							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + userAccessLog.userName + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + userAccessLog.viewRequestUri + "</td>"
								+ 	"</tr>";
						}
					}
					$("#userAccessLogWidget").empty();
					$("#userAccessLogWidget").html(content);
				} else {
					$("#userAccessLogWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#userAccessLogWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 스케줄 실행 이력 갱신
	function civilVoiceWidget() {
		$.ajax({
			url : "/widgets/civil-voice-status",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					var civilVoiceList = msg.civilVoiceList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\"/>"
								+	"<col class=\"col-center\"/>"
								+	"<col class=\"col-center\"/>"
								+	"<thead><tr>"
								+	"	<td class=\"col-left\"><em>제목</em></td>"
								+	"	<td class=\"col-center\"><em>동의 수</em></td>"
								+ 	"	<td class=\"col-center\"><em>등록 일시</em></td>"
								+	"</tr></thead>";
					if(civilVoiceList == null || civilVoiceList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\"><spring:message code='main.status.no.civilvoice'/></td>"
								+	"</tr>";
					} else {
						for(i=0; i<civilVoiceList.length; i++ ) {
							var civilVoice = null;
							civilVoice = civilVoiceList[i];
							content = content
								+ 	"<tr>"
								+ 	"	<td class=\"col-left ellipsis\" style=\"max-width:160px;\">"
								+	"		<span class=\"index\"></span>"
								+ 	"		<em>" + civilVoice.title + "</em>"
								+	"	</td>"
								+ 	"	<td class=\"col-center\" style=\"width:70px;\">"
								+	"		<span class='likes-icon' style='float: left;'>icon</span>"
								+	"		<span style='font-weight:bold;'>" + formatNumber(civilVoice.commentCount) + "</span>"
								+	"	</td>"
								+ 	"	<td class=\"col-center\">" + civilVoice.viewInsertDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#civilVoiceWidget").empty();
					$("#civilVoiceWidget").html(content);
				} else {
					$("#civilVoiceWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#civilVoiceWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// 시스템 사용량
	function systemUsageWidget() {
		$.ajax({
			url : "/widgets/system-usage-status",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					var stat = msg.statistics;

					// disk
					var diskMax = stat.diskSpaceTotal;
					var diskUsed = (diskMax - stat.diskSpaceFree);
					var diskValue = diskUsed / diskMax * 100;

					// memory
					var memoryMax = stat.jvmMemoryMax[0]["value"];
					var memoryUsed = stat.jvmMemoryUsed[0]["value"];
					var memoryValue = memoryUsed / memoryMax * 100;

					// cpu
					var cpuMax = stat.systemCpuUsage[0]["value"];
					if(!cpuMax) cpuMax = 1;
					var cpuUsed = stat.processCpuUsage[0]["value"];
					var cpuValue = cpuUsed / cpuMax * 100;

					var res = {
						disk: {
							id: 'pie-chart1',
							title: 'Disk',
							value: Math.round(diskValue),
							color: 'tomato'
						},
						memory: {
							id: 'pie-chart2',
							title: 'JVM Memory',
							value: Math.round(memoryValue),
							color: '#8b22ff'
						},
						cpu: {
							id: 'pie-chart3',
							title: 'CPU',
							value: Math.round(cpuValue),
							color: '#1cabf1'
						}
					}

					$("#systemUsageWidget").empty();
					$("#systemUsageWidget").html('<div class="gaugeGraph"></div>');

					for(var property in res) {
						showSystemUsageHtml(res[property]);
						showSystemUsageGraph(res[property]);
					}
				} else {
					$("#systemUsageWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#systemUsageWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	// DB Connection Pool 현황
	function dbcpStatusWidget() {
		$.ajax({
			url : "/widgets/dbcp-status",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if(msg.statusCode <= 200) {
					var dbcp = msg.dbcp;
					$("#userSessionCount").html(dbcp.userSessionCount);
					$("#userUserSessionCount").html(dbcp.userUserSessionCount);
					$("#initialSize").html(dbcp.initialSize);
					$("#userInitialSize").html(dbcp.userInitialSize);
					$("#maxTotal").html(dbcp.maxTotal);
					$("#userMaxTotal").html(dbcp.userMaxTotal);
					$("#maxIdle").html(dbcp.maxIdle);
					$("#userMaxIdle").html(dbcp.userMaxIdle);
					$("#numActive").html(dbcp.numActive);
					$("#userNumActive").html(dbcp.userNumActive);
					$("#minIdle").html(dbcp.minIdle + "," + dbcp.numIdle);
					$("#userMinIdle").html(dbcp.userMinIdle + "," + dbcp.userNumIdle);
				} else {
					$("#dbcpStatusWidget").html(JS_MESSAGE[msg.errorCode]);
					//alert(JS_MESSAGE[msg.errorCode]);
					//console.log("---- " + msg.errorCode);
				}
			},
			error : function(request, status, error) {
				$("#dbcpStatusWidget").html(JS_MESSAGE["ajax.error.message"]);
				//alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}

	function showSystemUsageHtml(data) {
		var content = "";
		content += "<div id='"+ data.id +"' class='pie-chart'>";
		content += "	<span class='center'>" + data.value + "%</span>";
		content += "	<span class='title'>" + data.title + "</span>";
		content += "</div>";
		$('#systemUsageWidget div.gaugeGraph').append(content);
	}

	function showSystemUsageGraph(data) {
		var usageValues = [[data.title, data.value], ['blank', (100-data.value)]];

		$.jqplot(data.id, [usageValues], {
      		seriesColors: [data.color, "#e0e0e0"],
            grid: {
                drawBorder: false,
                drawGridlines: false,
                background: "#ffffff",
                shadow: false
            },
            seriesDefaults:{
            	renderer:$.jqplot.DonutRenderer,
          		rendererOptions:{
		            sliceMargin: 0,
		            startAngle: -90,
		            diameter : 100,
		            padding: 10
          		}
            },
            legend: {
                background: 'white',
                textColor: 'black',
                fontFamily: 'Times New Roman',
                border: '1px solid black'
            }
      	});
	}

	function goMagoAPIGuide() {
		var url = "/guide/help";
		var width = 1200;
		var height = 800;

		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupX = (window.screen.width / 2) - (width / 2);
		var popupY = (window.screen.height / 2) - (height / 2);

		var popWin = window.open(url, "", "toolbar=no, width=" + width + " ,height=" + height + ", top=" + popupY + ", left=" + popupX +
				", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
		return false;
	}

</script>
</body>
</html>