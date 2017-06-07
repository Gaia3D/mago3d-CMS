<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/ko/font/font.css" />
	<link rel="stylesheet" href="/images/ko/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/ko/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/ko/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/externlib/ko/jqplot/jquery.jqplot.min.css" />
	<link rel="stylesheet" href="/css/ko/style.css" />
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
							<div class="content-title u-pull-left">마우스로 위젯을 끌어 당겨, 메인 화면에 표시할 위치를 정하신 후 저장 버튼을 눌러 주십시오.</div>
						</div>
						<form:form id="widget" modelAttribute="widget" method="post" onsubmit="return false;">
				  			<form:hidden path="widget_order" />
						<div id="sortable" class="widgets row">
<c:forEach var="dbWidget" items="${widgetList }">
	<c:choose>
		<c:when test="${dbWidget.name == 'cpuWidget'}">
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">CPU 현황<span class="widget-desc">최근 30분</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/monitoring/list-monitoring-log.do" title="CPU 현황 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'memoryWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">메모리 현황<span class="widget-desc">최근 30분</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/monitoring/list-monitoring-log.do" title="메모리 현황 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
								</div>
							</div>
		</c:when>		
		<c:when test="${dbWidget.name == 'diskUsageWidget'}">			
							<div id="${dbWidget.widget_id }" class="widget widget-disk-usage one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">디스크 사용 현황<span class="widget-desc">최근 30분</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/monitoring/list-monitoring-log.do" title="디스크 사용 현황 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div><!-- .widget-header -->
								
								<div class="widget-content row">
									<div id="${dbWidget.name}" class="u-pull-left" style="font-size: 18px;">
									</div>
									<div id="monitoringDefault" class="u-pull-right">
										<div class="web-status">
											<h6>웹상태</h6>
											<div class="status-bar">
					<c:if test="${webStatus eq 'A'}">					
												<span class="status-on">정상</span>
					</c:if>
					<c:if test="${webStatus eq 'D'}">					
												<span class="status-off">다운</span>
					</c:if>
					<c:if test="${webStatus eq 'U'}">					
												<span class="status-off">알수없음</span>
					</c:if>
										    	<span class="bar"></span>
											</div>
										</div>
										<div class="db-status">
											<h6>DB상태</h6>
											<div class="status-bar">
					<c:if test="${dbStatus eq 'A'}">					
												<span class="status-on">정상</span>
					</c:if>
					<c:if test="${dbStatus eq 'D'}">					
												<span class="status-off">다운</span>
					</c:if>
					<c:if test="${dbStatus eq 'U'}">					
												<span class="status-off">알수없음</span>
					</c:if>
										    	<span class="bar"></span>
											</div>
										</div>
										<div class="db-usage">
											<h6>DB사용량</h6>
											<div>
										    	<span class="icon-glyph glyph-db"></span>
										    	&nbsp;&nbsp;${dbSize } MB
											</div>
										</div>
									</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'userWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">사용자 상태별 현황<span class="widget-desc">${today } 기준</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/user/list-user.do" title="사용자 상태별 현황 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'userOTPLogWidget'}">
							<div id="${dbWidget.widget_id }" class="widget one-third column" style="font-size: 16px;">
					        	<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">OTP 사용 현황<span class="widget-desc">오늘</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/user/list-user-otp-log.do" title="OTP 사용 이력 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
					            <div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
						            	<div id="userOTPLogSpinner" style="width: 150px; height: 70px;"></div>
						            </div>
								</div>
							</div>
		</c:when>			
		<c:when test="${dbWidget.name == 'userOTPLogListWidget'}">	
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">OTP 사용 이력<span class="widget-desc">${thisYear }년 최근 7건</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/user/list-user-otp-log.do" title="OTP 사용 이력 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
					            		<div id="userOTPLogListSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>				
		<c:when test="${dbWidget.name == 'scheduleLogListWidget'}">	
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">스케줄 실행 이력<span class="widget-desc">${thisYear }년 최근 7건</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/schedule/list-schedule-log.do" title="스케줄 실행 이력 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
					            		<div id="scheduleLogListSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'accessLogWidget'}">		
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">사용자 추적<span class="widget-desc">${today } 기준</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/log/list-access-log.do" title="사용자 추적 이력 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								
								<div id="${dbWidget.name}" class="widget-content row">
									<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
					            		<div id="accessLogSpinner" style="width: 150px; height: 70px;"></div>
					            	</div>
								</div>
							</div>
		</c:when>
		<c:when test="${dbWidget.name == 'dbcpWidget'}">
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">DB Connection Pool 현황<span class="widget-desc">${today } 기준</span></h3>
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
												<em>속성</em>
											</td>
											<td class="col-center">
												<em>관리자</em>
											</td>
											<td class="col-center">
												<em>사용자</em>
											</td>
											<td class="col-center">
												<em>상태</em>
											</td>
										</tr>
										<tr>
											<td class="col-left">
												<span class="icon-glyph glyph-users-circle"></span>
												<em>현재 세션 접속자수</em>
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
												<em>초기값</em> (initialSize)
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
												<em>최대생성</em> (maxTotal)
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
												<em>최대유지</em> (maxIdle)
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
												<em>사용중</em> (numActive)
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
												<em>최소유지, 유지수</em> (minIdle, numIdle)
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
		<c:when test="${dbWidget.name == 'dbSessionWidget'}">			
							<div id="${dbWidget.widget_id }" class="widget one-third column">
								<div class="widget-header row">
									<div class="widget-heading u-pull-left">						
										<h3 class="widget-title">DB 세션 현황(${dbSessionCount })<span class="widget-desc">${today } 기준</span></h3>
									</div>
									<div class="widget-functions u-pull-right">
										<a href="/monitoring/list-db-session.do" title="DB 세션 현황 더보기"><span class="icon-glyph glyph-plus"></span></a>
									</div>
								</div>
								<div id="${dbWidget.name}" class="widget-content row">
									<table class="widget-table">
										<col class="col-left" />
										<col class="col-left" />
					<c:if test="${empty dbSessionList }">					
										<tr>
											<td colspan="2" class="col-none">DB 세션 정보가 존재하지 않습니다.</td>
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
								<input type="submit" value="저장" onclick="updateWidget(); return false;" />
							</div>
						</div>
					</div>				
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/ko/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jquery-ui/jquery-ui-1.11.4.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/ko/jqplot/plugins/jqplot.pointLabels.min.js"></script>
<script type="text/javascript" src="/externlib/ko/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/ko/spinner/raphael.js"></script>
<script type="text/javascript" src="/js/ko/common.js"></script>
<script type="text/javascript" src="/js/ko/message.js"></script>
<script type="text/javascript" src="/js/consoleLog.js"></script>
<script type="text/javascript" src="/js/ko/navigation.js"></script>
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
		
 		cpuWidget();
		memoryWidget();
		diskUsageWidget();
		startSpinner("userOTPLogListSpinner");
		ajaxUserOTPLogListWidget();
		ajaxUserOTPLogWidget();
		userWidget();
		startSpinner("scheduleLogListSpinner");
		ajaxScheduleLogListWidget();
		startSpinner("accessLogSpinner");
		ajaxAccessLogWidget();
	});
	
	// CPU & 메모리 변동 그래프
	function cpuWidget() {
		var monitoringLogListSize = "${monitoringLogListSize}";
		var totalCount = parseInt(monitoringLogListSize);
		var cpuData = new Array(totalCount);
		
		var i=0;
		var xMin = "";
		var xMax = "";
		var yMax = 0;
		<c:forEach var="monitoringLog" items="${monitoringLogList}" varStatus="status">
			cpuData[i] = new Array(2);
			
			// yyyy/MM/dd HH:mm
			var year = "${monitoringLog.year}";
			var month = "${monitoringLog.month}";
			var day = "${monitoringLog.day}";
			var hour = "${monitoringLog.hour}";
			var minute = "${monitoringLog.minute}";
			var cpu_usage = "${monitoringLog.cpu_usage}";
			
			var xLabel = "0";
			xLabel = year + "/" + month + "/" + day + " " + hour + ":" + minute;
			if(i == 0) {
				xMax = xLabel;
			}
			xMin = xLabel;
			if(yMax < parseInt(cpu_usage)) {
				yMax = parseInt(cpu_usage);
			}
			
			cpuData[i][0] = xLabel;
			cpuData[i][1] = Math.round(cpu_usage);
			
			i++;
		</c:forEach>
		
		if(yMax < 10) {
			yMax = 10;
		} else if(yMax < 20) {
			yMax = 20;
		} else if(yMax < 50) {
			yMax = 50;
		} else {
			yMax = 100;
		}
		
		console.log(cpuData);
		
		if(totalCount > 0) {
			var plot = $.jqplot("cpuWidget", [cpuData], {
				//title : "CPU 현황",
				height: 205,
          		seriesColors: [ "#eb586d"],
				grid: {
					background: "#d4b9ca",
					gridLineWidth: 0.7,
					gridLineColor: "#ffffff",
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
				animate: true,
				series:[ 
					{
						fill : true,
						rendererOptions: {
							animation: {
	                        	speed: 2000
	                        },
	                        smooth: true
						}
					}
				],
	            axesDefaults: {
	            	pad: 0
				},
	            axes: {
					xaxis: {
						min : xMin,
						max : xMax,
						numberTicks : 5,
						renderer:$.jqplot.DateAxisRenderer,
						tickOptions:{ 
		                	formatString:"%H:%M",
		                	fontSize: "10pt"
		                }
					},
		            yaxis: {
		            	numberTicks : 6,
		                min : 0,
		                max : yMax,
		                tickOptions:{ 
		                	formatString: "%'d%",
		                	fontSize: "10pt"
		                }
					}
				}
		    });
	    } 
	}
	
	// 메모리 변동 그래프
	function memoryWidget() {
		var monitoringLogListSize = "${monitoringLogListSize}";
		var totalCount = parseInt(monitoringLogListSize);
		var memoryData = new Array(totalCount);
		
		var i=0;
		var xMin = "";
		var xMax = "";
		var yMax = 0;
		<c:forEach var="monitoringLog" items="${monitoringLogList}" varStatus="status">
			memoryData[i] = new Array(2);
			
			// yyyy/MM/dd HH:mm
			var year = "${monitoringLog.year}";
			var month = "${monitoringLog.month}";
			var day = "${monitoringLog.day}";
			var hour = "${monitoringLog.hour}";
			var minute = "${monitoringLog.minute}";
			var memory_usage = "${monitoringLog.memory_usage}";
			
			var xLabel = "0";
			xLabel = year + "/" + month + "/" + day + " " + hour + ":" + minute;
			
			if(i == 0) {
				xMax = xLabel;
			}
			xMin = xLabel;
			if(yMax < parseInt(memory_usage)) {
				yMax = parseInt(memory_usage);
			}
			
			memoryData[i][0] = xLabel;
			memoryData[i][1] = parseInt(memory_usage);
			
			i++;
		</c:forEach>
		
		if(yMax < 10) {
			yMax = 10;
		} else if(yMax < 20) {
			yMax = 20;
		} else if(yMax < 50) {
			yMax = 50;
		} else {
			yMax = 100;
		}
		
		console.log(memoryData);
		
		if(totalCount > 0) {
			var plot = $.jqplot("memoryWidget", [memoryData], {
				//title : "메모리 현황",
				height: 205,
				seriesColors: [ "#74cd4c", "#3fbdf8" ],
				grid: {
					background: "#fff",
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
				animate: true,
				series:[ 
					{
						linePattern: "dotted",
						lineWidth : 2,
						markerOptions : {
							style: "filledCircle",
		                    size: 5
						},
						//fill : true,
						rendererOptions: {
							animation: {
	                        	speed: 2000
	                        },
	                        smooth: true
						}
					}
				],
	            axesDefaults: {
	            	pad: 0
				},
	            axes: {
					xaxis: {
						min : xMin,
						max : xMax,
						numberTicks : 5,
						renderer:$.jqplot.DateAxisRenderer,
		                tickOptions:{ 
		                	formatString:"%H:%M",
		                	fontSize: "10pt"
		                } 
					},
		            yaxis: {
		            	numberTicks : 6,
		                min : 0,
		                max : yMax,
		                tickOptions:{ 
		                	formatString: "%'d%",
		                	fontSize: "10pt"
		                } 
					}
				}
		    });
	    }
	}
	
	// 서버 디스크 사용량
	function diskUsageWidget() {
		var freeDisk = "${freeDisk}";
		var usageDisk = "${usageDisk}";
		
		var webStatus = "${webStatus}";
		var dbStatus = "${dbStatus}";
		
		var content = "";
			content += 	"<div class=\"web-status\">"
					+	"	<h6>웹상태</h6>"
					+	"	<div class=\"status-bar\">";
		if(webStatus == "A") {					
			content +=	"		<span class=\"status-on\">정상</span>";
		}
		if(webStatus == "D") {					
			content +=	"		<span class=\"status-off\">다운</span>";
		}
		if (webStatus == "U") {					
			content +=	"		<span class=\"status-off\">알수없음</span>";
		}
			content +=	"  		<span class=\"bar\"></span>"
					+	"	</div>"
					+	"</div>"
					+	"<div class=\"db-status\">"
					+	"	<h6>DB상태</h6>"
					+	"	<div class=\"status-bar\">"
		if(dbStatus == "A") {					
			content 	+=	"	<span class=\"status-on\">정상</span>";
		}
		if(dbStatus == "D") {					
			content 	+=	"	<span class=\"status-off\">다운</span>";
		}
		if (dbStatus == "U") {					
			content 	+=	"	<span class=\"status-off\">알수없음</span>";
		}
			content +=	"  		<span class=\"bar\"></span>"
					+	"	</div>"
					+	"</div>"
					+	"<div class=\"db-usage\">"
					+	"	<h6>DB사용량</h6>"
					+	"	<div>"
					+	"    	<span class=\"icon-glyph glyph-db\"></span>"
					+	"		${dbSize} MB" 
					+	"	</div>"
					+	"</div>";
		$("#monitoringDefault").empty();
		$("#monitoringDefault").html(content);
		
		var data = [["남은 공간", parseFloat(freeDisk)],["사용 공간", parseFloat(usageDisk)]];
		
		var plot = $.jqplot("diskUsageWidget", [data], {
			//title : "디스크 사용현황",
			seriesColors: [ "#99a0ac", "#a67ee9" ],
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
			    	dataLabelFormatString: "%.1f%"
			    },
		  	},
		  	legend: {            
				show: true,
				fontSize: "10pt",
				placement : "outside",
			    rendererOptions: {                
			    	numberRows: 1            
			    },            
			    location: "s",
			    border: "none", 
			    marginLeft: "70px"
		  	}
		});
	}
	
	// 오늘 OTP 사용 이력
	function userOTPLogWidget(drawType, jsonData) {
		var userOTPCreatTotalcount = null;
		var userOTPSuccessTotalcount = null;
		var userOTPFailTotalcount = null;
		
		if(drawType == 0) {
			// el 데이터 표시
			// userOTPCreatTotalcount = parseInt("${userOTPCreatTotalcount}");
			// userOTPSuccessTotalcount = parseInt("${userOTPSuccessTotalcount}");
			// userOTPFailTotalcount = parseInt("${userOTPFailTotalcount}");
			userOTPCreatTotalcount = 0;
			userOTPSuccessTotalcount = 0;
			userOTPFailTotalcount = 0;
		} else {
			// ajax 데이터 표시
			userOTPCreatTotalcount = parseInt(jsonData.userOTPCreatTotalcount);
			userOTPSuccessTotalcount = parseInt(jsonData.userOTPSuccessTotalcount);
			userOTPFailTotalcount = parseInt(jsonData.userOTPFailTotalcount);
		}
		
		var otpValues = [ userOTPCreatTotalcount, userOTPSuccessTotalcount, userOTPFailTotalcount];
		var ticks = ["생성 수", "성공 수", "실패 수"];
		var yMax = 10;
		if(userOTPCreatTotalcount > 10 || userOTPSuccessTotalcount > 10 || userOTPFailTotalcount > 10) {
			yMax = Math.max(userOTPCreatTotalcount, userOTPSuccessTotalcount, userOTPFailTotalcount) + (userOTPCreatTotalcount * 0.2);
		}
		
        var plot = $.jqplot("userOTPLogWidget", [otpValues], {
        	//title : "OTP 사용 이력",
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
	
	// 사용자 상태별 현황
	function userWidget() {
		var activeUserTotalCount = parseInt("${activeUserTotalCount}");
		var fobidUserTotalCount = parseInt("${fobidUserTotalCount}");
		var failUserTotalCount = parseInt("${failUserTotalCount}");
		var sleepUserTotalCount = parseInt("${sleepUserTotalCount}");
		var expireUserTotalCount = parseInt("${expireUserTotalCount}");
		var tempPasswordUserTotalCount = parseInt("${tempPasswordUserTotalCount}");
		
		var otpValues = [ activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount];
		var ticks = ["사용중", "사용중지", "실패횟수", "휴면", "기간만료", "임시비밀번호"];
		var yMax = 10;
		if(activeUserTotalCount > 10 || fobidUserTotalCount > 10 || failUserTotalCount > 10 || sleepUserTotalCount > 10 || expireUserTotalCount > 10 || tempPasswordUserTotalCount > 10) {
			yMax = Math.max(activeUserTotalCount, fobidUserTotalCount, failUserTotalCount, sleepUserTotalCount, expireUserTotalCount, tempPasswordUserTotalCount) + (activeUserTotalCount * 0.2);
		}
		
		var plot = $.jqplot("userWidget", [otpValues], {
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
	
	// OTP 이력 정보 갱신
	function ajaxUserOTPLogWidget() {
		$.ajax({
			url : "/config/ajax-user-otp-log-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					$("#userOTPLogWidget").empty();
					userOTPLogWidget(1, msg);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	// OTP 이력 목록 정보 갱신
	function ajaxUserOTPLogListWidget() {
		$.ajax({
			url : "/config/ajax-user-otp-log-list-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var userOTPLogList = msg.userOTPLogList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-center\" />"
								+	"<col class=\"col-center\" />";
					if(userOTPLogList == null || userOTPLogList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">OTP 이력이 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<userOTPLogList.length; i++ ) {
							var userOTP = null;
							userOTP = userOTPLogList[i];
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\"><em>" + userOTP.group_name + "</em>(" + userOTP.user_name + ")</td>";
							// // 상태. 0 : 생성, 1 : 검증성공, 2 : 실패, 3 : 시간만료
							var imageName = "";
							var statusName = "";
							if(userOTP.otp_number_status == "0") {
								imageName = "otp-create.png";
								statusName = "OTP 생성";
							} else if(userOTP.otp_number_status == "1") {
								imageName = "otp-success.png";
								statusName = "인증 성공";
							} else if(userOTP.otp_number_status == "2") {
								imageName = "otp-fail.png";
								statusName = "OTP 실패";
							} else if(userOTP.otp_number_status == "3") {
								imageName = "otp-success.png";
								statusName = "시간만료";
							}
							content += 	"<td class=\"col-center\">"
								+		"	<img style=\"margin-top:8px\" src=\"/images/ko/icon/" + imageName + "\" alt=\"" +  statusName + "\" />"		
								+		"</td>"
								+ 		"<td class=\"col-center\">" + userOTP.viewRegisterDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#userOTPLogListWidget").empty();
					$("#userOTPLogListWidget").html(content);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	}
	
	// 스케줄 실행 이력 갱신
	function ajaxScheduleLogListWidget() {
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
								+	"	<td colspan=\"3\" class=\"col-none\">스케줄 실행 이력이 존재하지 않습니다.</td>"
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
	function ajaxAccessLogWidget() {
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
			alert("수정된 컨텐츠가 존재하지 않습니다.");
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
				async : false,
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