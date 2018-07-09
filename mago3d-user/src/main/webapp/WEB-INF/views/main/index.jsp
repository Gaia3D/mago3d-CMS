<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>main | mago3D User</title>
	<link rel="stylesheet" href="/externlib/sufee-template/css/bootstrap.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/font-awesome.min.css">
	<link rel="stylesheet" href="/externlib/sufee-template/css/themify-icons.css">
	<link rel="stylesheet" href="/externlib/sufee-template/scss/style.css">
	<link rel="stylesheet" href="/css/ko/style.css">
	<style>
	.bg-primary {
		background-color: #fb9678!important;
	}
	.bg-cyan {
		background-color: #01c0c8!important;
	}
	.bg-purple {
		background-color: #ab8ce4!important;
	}
	.bg-success {
		background-color: #00c292!important;
	}
	.progress-bar {
		display: flex;
		flex-direction: column;
		justify-content: center;
		color: #fff;
		text-align: center;
		background-color: #fb9678;
		transition: width .6s ease;
	}
	.card {
		display:inline-block; width: 24.5%; border-right: 1px solid #e9ecef;
	}
	</style>
</head>
<body>
	
<!-- Left Panel -->
<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
<!-- Left Panel -->

<!-- Right Panel -->
<div id="right-panel" class="right-panel">

	<!-- Header-->
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
    <!-- Header-->

	<!-- Page Header-->
	<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
    <!-- Page Header-->
			
	<div class="content mt-3" style="min-width:1140px; min-height: 750px; background-color: white;">
		<div style="width:100%;">
			<!-- card start -->
			<div style="width:100%; margin-top:5px;">
			    <div class="card">
			       <div class="card-body">
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="d-flex no-block align-items-center">
			                        <div>
			                            <h3><i class="icon-screen-desktop"></i></h3>
			                            <p class="text-muted">가시화 프로젝트</p>
			                        </div>
			                        <div class="ml-auto">
			                            <h2 class="counter text-primary">23</h2>
			                        </div>
			                    </div>
			                </div>
			                <div class="col-12">
			                    <div class="progress">
			                        <div class="progress-bar bg-primary" role="progressbar" style="width: 85%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			    <div class="card">
			        <div class="card-body">
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="d-flex no-block align-items-center">
			                        <div>
			                            <h3><i class="icon-note"></i></h3>
			                            <p class="text-muted">F4D Converter 실행 파일 수</p>
			                        </div>
			                        <div class="ml-auto">
			                            <h2 class="counter text-cyan">169</h2>
			                        </div>
			                    </div>
			                </div>
			                <div class="col-12">
			                    <div class="progress">
			                        <div class="progress-bar bg-cyan" role="progressbar" style="width: 85%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			    <div class="card">
			        <div class="card-body">
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="d-flex no-block align-items-center">
			                        <div>
			                            <h3><i class="icon-doc"></i></h3>
			                            <p class="text-muted">F4D Converter 실행 성공</p>
			                        </div>
			                        <div class="ml-auto">
			                            <h2 class="counter text-purple">157</h2>
			                        </div>
			                    </div>
			                </div>
			                <div class="col-12">
			                    <div class="progress">
			                        <div class="progress-bar bg-purple" role="progressbar" style="width: 85%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			    <div class="card">
			        <div class="card-body">
			            <div class="row">
			                <div class="col-md-12">
			                    <div class="d-flex no-block align-items-center">
			                        <div>
			                            <h3><i class="icon-bag"></i></h3>
			                            <p class="text-muted">F4D Converter 실행 실패</p>
			                        </div>
			                        <div class="ml-auto">
			                            <h2 class="counter text-success">431</h2>
			                        </div>
			                    </div>
			                </div>
			                <div class="col-12">
			                    <div class="progress">
			                        <div class="progress-bar bg-success" role="progressbar" style="width: 85%; height: 6px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
			<!-- card end -->
			
			<div>
				<div id="upload_widget" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">업로드 데이터<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="upload_widget_content" class="widget-content row">
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="uploadSpinner" style="width: 150px; height: 70px;"></div>
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
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="converterJobSpinner" style="width: 150px; height: 70px;"></div>
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
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="converterLogSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>
				<div id="upload_size_widget" class="widget one-third column" style="font-size: 16px;  margin-left: 0px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">총 데이터 사용량<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="upload_size_widget_content" class="widget-content row">
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
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="uploadSizeSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>
				<div id="project_widget" class="widget one-third column" style="font-size: 16px;">
					<div class="widget-header row">
						<div class="widget-heading u-pull-left">						
							<h3 class="widget-title">프로젝트<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
						</div>
						<div class="widget-functions u-pull-right">
							<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
						</div>
					</div>
					<div id="project_widget_content" class="widget-content row">
						<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
				            <div id="projectSpinner" style="width: 150px; height: 70px;"></div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- footer -->
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
    <!-- footer -->
</div>
<!-- Right Panel -->

<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/sufee-template/js/plugins.js"></script>
<script src="/externlib/sufee-template/js/main.js"></script>

<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pointLabels.min.js"></script>

<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>

<script type="text/javascript">
	jQuery.noConflict();
	
	var refreshTime = parseInt("${widgetInterval}") * 1000;
	$(document).ready(function() {
		startSpinner("uploadSpinner");
		startSpinner("converterJobSpinner");
		startSpinner("converterLogSpinner");
		startSpinner("uploadCountSpinner");
		startSpinner("uploadSizeSpinner");
		startSpinner("projectSpinner");
		
		projectWidget();
		startSpinner("dataInfoSpinner");
		dataInfoWidget();
		startSpinner("dataInfoLogListSpinner");
		dataInfoLogListWidget();
	
		startSpinner("accessLogSpinner");
	    setTimeout(callAccessLogWidget, 1000);
		setTimeout(callDbcpWidget, 2000);
		//startSpinner("dbSessionSpinner");
	    setTimeout(dbSessionWidget, 3000);
		
	    // Active 일때만 화면을 갱신함
		setInterval(refreshMain, refreshTime);
	});
	
	function refreshMain() {
		if(isProjectDraw == "true") {
			projectWidget();
		}
		if(isDataInfoDraw == "true") {
			dataInfoWidget();
		}
		if(isDataInfoLogListDraw == "true") {
			dataInfoLogListWidget();
		}
		if(isIssueDraw == "true") {
			issueWidget();
		}
		if(isUserDraw == "true") {
			userWidget();
		}
		// TODO You'll need to add the remaining widgets later 
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

</script>
</body>
</html>
