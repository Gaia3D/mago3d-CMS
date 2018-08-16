<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="/css/cloud.css">
<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
<script src="/js/cloud.js"></script>
<style type="text/css">
	
</style>
</head>
<body>
<div class="default-layout">
	<!-- 왼쪽 메뉴 -->
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<!-- 왼쪽 메뉴 -->
	
	<!--  컨텐츠 -->
	<div class="content-layout">
		<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
		<div>
			<div class="content-detail">
				<!-- Start content by page -->
				
				
				
				<div class="widgets">
					<div class="row">
						<div class="widget widget-low widget-otp-usage full column">
							<div class="widget-header row">
								<div class="widget-heading u-pull-left">						
									<h3 class="widget-title">프로젝트 수<span class="widget-desc">${yearMonthDay } (<spring:message code='main.today'/>)</span></h3>
								</div>
							</div><!-- .widget-header -->
							<div class="widget-content row">
								<div class="one-third column banner-container">
									<div class="banner info-generates">
										<div class="info-device" style="background-color: #f9957b;">
											<span class="icon-glyph glyph-plus-circle"></span>
											<span class="info-numbers"></span>
										</div>
										<div>
											<span class="banner-title">프로젝트</span>
											<span id="firstCountSpinner" class="banner-number"></span>
											<span class="banner-unit"> 5 <spring:message code='main.count'/> </span>
										</div>
									</div>
								</div>
								
								<div class="one-third column banner-container">
									<div class="banner info-success">
										<div class="info-device" style="background-color: #1cc0c7;">
											<span class="icon-glyph glyph-check-circle"></span>
											<span class="info-numbers"></span>
										</div>
										<div>
											<span class="banner-title">최근 F4D 변환 결과(성공)</span>
											<span id="secondeCountSpinner" class="banner-number"></span>
											<span class="banner-unit"> 17 <spring:message code='main.count'/></span>
										</div>
									</div>
								</div>
								
								<div class="one-third column banner-container">
									<div class="banner info-failures">
										<div class="info-device" style="background-color: #ab8de2;">
											<span class="icon-glyph glyph-emark-circle"></span>
											<span class="info-numbers"></span>
										</div>
										<div>
											<span class="banner-title">최근 F4D 변환 결과(실패)</span>
											<span id="thirdCountSpinner" class="banner-number"></span>
											<span class="banner-unit"> 2 <spring:message code='main.count'/></span>
										</div>
									</div>
								</div>
							</div><!-- .widget-content -->
						</div><!-- .widget -->
		
	
						<div id="data_info_widget" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">업로드 데이터<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="dataInfoWidget" class="widget-content row">
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="uploadSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>
				<div id="project_widget_content" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">프로젝트<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="projectWidget" class="widget-content row">
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="projectSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>	
				<div id="converter_job_widget" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">f4d 변경 job<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="converter_job_widget_content" class="widget-content row">
						<div style="text-align: center; padding-top: 70px; padding-left: 40px;">
				           	F4D 변환 Job 이력이 존재하지 않습니다.	
						</div>
					</div>
				</div>
				<div id="user_widget" class="widget one-third column" style="font-size: 16px;  margin-left: 0px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">사용자 상태별<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="userWidget" class="widget-content row">
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="uploadCountSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>
				<div id="upload_count_widget" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">총 데이터 업로딩 건수<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="upload_count_widget_content" class="widget-content row">
						<div style="text-align: center; padding-top: 60px; padding-left: 250px;">
				            <div id="uploadSizeSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>
				<div id="converter_log_widget" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">데이터 건수<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="converter_log_widget_content" class="widget-content row">
						<div style="text-align: center; padding-top: 70px; padding-left: 40px;">
				           	변환 파일 목록이 존재하지 않습니다.
						</div>
					</div>
				</div>
						
			
					</div>	
				</div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				<!-- End content by page -->
			</div>
			<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
		</div>
	</div>
	<!--  컨텐츠 -->
</div>
<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>

<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pointLabels.min.js"></script>

<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	
	var refreshTime = parseInt("${widgetInterval}") * 1000;
	$(document).ready(function() {
		projectWidget();
		dataInfoWidget();
		dataInfoLogListWidget();
		userWidget();
	
		setTimeout(callAccessLogWidget, 1000);
		setTimeout(callDbcpWidget, 2000);
		//startSpinner("dbSessionSpinner");
	    setTimeout(dbSessionWidget, 3000);
		
	    // Active 일때만 화면을 갱신함
		setInterval(refreshMain, refreshTime);
	});
	
	function refreshMain() {
			projectWidget();
			dataInfoWidget();
			dataInfoLogListWidget();
			issueWidget();
		// TODO You'll need to add the remaining widgets later 
	}
	
	function projectWidget() {
		var url = "/main/ajax-project-data-widget.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					showProject(msg.projectNameList, msg.dataTotalCountList);
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
	
function showProject(projectNameList, dataTotalCountList) {
		
		$("#projectWidget").empty();
		if(projectNameList == null || projectNameList.length == 0) {
			return;
		} 
		
		var data = [];
		var projectCount =  projectNameList.length;
		for(i=0; i<projectCount; i++ ) {
			var projectStatisticsArray = [ projectNameList[i], dataTotalCountList[i]];
			data.push(projectStatisticsArray);
		}
		
		var plot = $.jqplot("projectWidget", [data], {
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
                    //dataLabelFormatString: "%.1f%"
                },
            },
            legend: {
                show: true,
                fontSize: "10pt",
                placement : "outside",
                rendererOptions: {
                    numberRows: 7,
                    numberCols: 1
                },
                location: "e",
                border: "none",
                marginLeft: "10px"
            }
        });
	}

	//project 별 chart
	function projectChart() {
		var url = "/data/ajax-project-data-statistics.do";
		var info = "";
		jQuery.ajax({
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
	
	drawProjectChart(null, null);
	
	function drawProjectChart(projectNameList, dataTotalCountList) {
		/* if(projectNameList == null || projectNameList.length == 0) {
			return;
		}  */
		
		var data = [];
		/* var projectCount =  projectNameList.length;
		for(i=0; i<projectCount; i++ ) {
			var projectStatisticsArray = [ projectNameList[i], dataTotalCountList[i]];
			data.push(projectStatisticsArray);
		} */
		
		var projectStatisticsArray = [ 'total', 100];
		data.push(projectStatisticsArray);
		projectStatisticsArray = [ 'thismonth', 30];
		data.push(projectStatisticsArray);
		
		jQuery("#upload_count_widget_content").html("");
	    //var data = [["3DS", 37],["IFC(Cultural Assets)", 1],["IFC", 42],["IFC(MEP)", 1],["Sea Port", 7],["Collada", 7],["IFC(Japan)", 5]];
	    var plot = jQuery.jqplot("upload_count_widget_content", [data], {
	        //title : "project 별 chart",
	       /*  seriesColors: [ "#a67ee9", "#FE642E", "#01DF01", "#2E9AFE", "#F781F3", "#F6D8CE", "#99a0ac" ], */
	       seriesColors: [ "#a67ee9", "#FE642E" ],
	        grid: {
	            drawBorder: false,
	            drawGridlines: false,
	            background: "#ffffff",
	            shadow:false
	        },
	        gridPadding: {top:0, bottom:115, left:0, right:20},
	        seriesDefaults:{
	            renderer:jQuery.jqplot.PieRenderer,
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
	                numberRows: 1,
	                numberCols: 2
	            },
	            location: "s",
	            border: "none",
	            marginLeft: "10px"
	        }
	    });
	}
	
	function dataInfoWidget() {
		$.ajax({
			url : "/main/ajax-data-status-widget.do",
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
		
		var dataValues = [ useTotalCount, forbidTotalCount, etcTotalCount];
		var ticks = [use, unused, etc];
		var yMax = 10;
		if(useTotalCount > 10 || forbidTotalCount > 10 || etcTotalCount > 10) {
			yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
		}
		
		var plot = $.jqplot("dataInfoWidget", [dataValues], {
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
	
	function dataInfoLogListWidget() {
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
								+	"<col class=\"col-left\" />";
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
		
		var dataValues = [ useTotalCount, forbidTotalCount, etcTotalCount];
		var ticks = [use, unused, etc];
		var yMax = 10;
		if(useTotalCount > 10 || forbidTotalCount > 10 || etcTotalCount > 10) {
			yMax = Math.max(useTotalCount, forbidTotalCount, etcTotalCount) + (useTotalCount * 0.2);
		}
		
		var plot = $.jqplot("dataInfoWidget", [dataValues], {
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
	
	function dataInfoLogListWidget() {
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
								+	"<col class=\"col-left\" />";
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
	
	function callAccessLogWidget() {
		
	}
	
	function callDbcpWidget() {
		
	}
	
	function dbSessionWidget() {
		
	}
	
	// 사용자 상태별 현황
	function showUser(drawType, jsonData) {
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
		
        var plot = $.jqplot("userWidget", [userValues], {
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
	function userWidget() {
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
					showUser(1, msg);
				}
			},
			error : function(request, status, error) {
				//alert("잠시 후 이용해 주시기 바랍니다. 장시간 같은 현상이(사용자) 반복될 경우 관리자에게 문의하여 주십시오.");
			}
		});
	}
	
</script>
</body>
</html>
