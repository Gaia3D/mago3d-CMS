<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Mago3d Admin</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jqplot/jquery.jqplot.min.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
</head>

<body class="home">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<div class="site-body">
		<div class="container">
			<div class="widgets">
				<div class="row">
					<div class="widget widget-low widget-otp-usage full column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">이슈 현황<span class="widget-desc">${yearMonthDay } (오늘)</span></h3>
							</div>
						</div><!-- .widget-header -->
						<div class="widget-content row">
							<div class="one-third column banner-container">
								<div class="banner otp-generates">
									<div>
										<div class="otp-device">
											<span class="icon-glyph glyph-plus-circle"></span>
											<span class="otp-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title">신규 이슈</span>
										<span id="userOTPCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> 0 개</span>
									</div>
								</div>
							</div>
							
							<div class="one-third column banner-container">
								<div class="banner otp-success">
									<div>
										<div class="otp-device">
											<span class="icon-glyph glyph-check-circle"></span>
											<span class="otp-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title">진행중인 이슈</span>
										<span id="userOTPSuccessCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> 0 개</span>
									</div>
								</div>
							</div>
							
							<div class="one-third column banner-container">
								<div class="banner otp-failures">
									<div>
										<div class="otp-device">
											<span class="icon-glyph glyph-emark-circle"></span>
											<span class="otp-numbers"></span>
										</div>
									</div>
									<div>
										<span class="banner-title">완료된 이슈</span>
										<span id="userOTPFailCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> 0 개</span>
									</div>
								</div>
							</div>
						</div><!-- .widget-content -->
					</div><!-- .widget -->
	
<c:forEach var="dbWidget" items="${widgetList }">
	<c:choose>		
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
		<c:when test="${dbWidget.name == 'scheduleLogListWidget'}">	
					<div id="${dbWidget.widget_id }" class="widget one-third column">
						<div class="widget-header row">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">스케줄 실행 사용 이력<span class="widget-desc">${thisYear }년 최근 7건</span></h3>
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
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.min.js"></script>

<script type="text/javascript" src="/externlib/${lang}/jqplot/jquery.jqplot.min.js"></script>

<script type="text/javascript" src="/externlib/${lang}/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jqplot/plugins/jqplot.pointLabels.min.js"></script>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	var refreshTime = parseInt("${widgetInterval}") * 1000;
	var userDraw = "${userDraw}";
	var scheduleLogListDraw = "${scheduleLogListDraw}";
	var dbcpDraw = "${dbcpDraw}";
	var accessLogDraw = "${accessLogDraw}";
	
	$(document).ready(function() {
		if(userDraw == "true") {
			userWidget(0, null);
		}
		if(scheduleLogListDraw == "true") {
			startSpinner("scheduleLogListSpinner");
			ajaxScheduleLogListWidget();
		}
		if(dbcpDraw == "true") {
			setTimeout(callDbcp, 1000);
		}
		if(accessLogDraw == "true") {
			startSpinner("accessLogSpinner");
		    setTimeout(callAccessLog, 2000);
		}
		
		var isActive = "${isActive}";
		if(isActive == "true") {
			// Active 일때만 화면을 갱신함
			setInterval(refreshMain, refreshTime);
		}
	});
	
	function refreshMain() {
		if(userDraw == "true") {
			ajaxUserWidget();
		}
	}
	
	// DB Connection Pool 현황
	function callDbcp() {
		ajaxDbcpWidget();
		setInterval(ajaxDbcpWidget, refreshTime);
	}
	
	// 사용자 추적
	function callAccessLog() {
		ajaxAccessLogWidget();
		setInterval(ajaxAccessLogWidget, refreshTime);
	}
	
	// 사용자 상태별 현황
	function userWidget(drawType, jsonData) {
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
	
	// 사용자 상태별 현황 정보 갱신
	function ajaxUserWidget() {
		$.ajax({
			url : "/main/ajax-user-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
					$("#userWidget").empty();
					userWidget(1, msg);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(사용자) 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}
	
	// 스케줄 실행 이력 갱신
	function ajaxScheduleLogListWidget() {
		$.ajax({
			url : "/main/ajax-schedule-log-list-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
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
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(OTP 이력) 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}
	
	// DB Connection Pool 현황
	function ajaxDbcpWidget() {
		$.ajax({
			url : "/main/ajax-dbcp-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
					$("#userSessionCount").html(msg.userSessionCount);
					$("#userUserSessionCount").html(msg.userUserSessionCount);
					$("#initialSize").html(msg.initialSize);
					$("#userInitialSize").html(msg.userInitialSize);
					$("#maxTotal").html(msg.maxTotal);
					$("#userMaxTotal").html(msg.userMaxTotal);
					$("#maxIdle").html(msg.maxIdle);
					$("#userMaxIdle").html(msg.userMaxIdle);
					$("#numActive").html(msg.numActive);
					$("#userNumActive").html(msg.userNumActive);
					$("#minIdle").html(msg.minIdle + "," + msg.numIdle);
					$("#userMinIdle").html(msg.userMinIdle + "," + msg.userNumIdle);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(DBCP) 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}
	
	// 사용자 추적
	function ajaxAccessLogWidget() {
		$.ajax({
			url : "/main/ajax-access-log-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "user.session.empty") {
					//alert("로그인 후 사용 가능한 서비스 입니다.");
				} else if (msg.result == "db.exception") {
					//alert("데이터 베이스 장애가 발생하였습니다. 잠시 후 다시 이용하여 주시기 바랍니다.");
				} else if (msg.result == "success") {
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
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(DBCP) 반복될 경우 관리자에게 문의하여 주십시오.");
				$("#accessLogWidget").empty();
				$("#accessLogWidget").html(content);
			}
		});
	}
</script>
</body>
</html>