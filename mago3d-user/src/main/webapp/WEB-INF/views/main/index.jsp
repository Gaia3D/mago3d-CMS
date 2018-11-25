<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Main | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/webix/codebase/webix.css?v=6.0.5">
	
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/cloud.js?cache_version=${cache_version}"></script>
</head>
<body>

<div class="site-body">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="site-content" class="on">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		
		<div id="content-wrap">
		
			<div class="widgets">
				<div class="row">
					<div class="widget widget-low widget-otp-usage full column">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">프로젝트 현황<span class="widget-desc">${yearMonthDay } (<spring:message code='main.today'/>)</span></h3>
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
										<span class="banner-title">공개 프로젝트</span>
										<span id="firstCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${publicProjectCount } <spring:message code='main.count'/> </span>
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
										<span class="banner-title">개인 프로젝트</span>
										<span id="secondeCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${privateProjectCount } <spring:message code='main.count'/></span>
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
										<span class="banner-title">공유 프로젝트</span>
										<span id="thirdCountSpinner" class="banner-number"></span>
										<span class="banner-unit"> ${sharingProjectCount} <spring:message code='main.count'/></span>
									</div>
								</div>
							</div>
						</div><!-- .widget-content -->
					</div><!-- .widget -->
	
					<div id="upload_data_widget_content" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">최근 업로딩 데이터 현황<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/upload-data/list-upload-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="uploadDataWidget" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            <div id="uploadDataSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>
					<div id="upload_data_count_widget" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">총 업로딩 건수<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/upload-data/list-upload-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="uploadDataCountWidget" class="widget-content row" style="margin-top:0px; padding-top:0px; width:97%; height:86%;">
							<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
					            <div id="uploadDataCountSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>	
					<div id="converter_job_widget_content" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">최근 Converter 현황 <span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/converter/list-converter-job.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="converterJobWidget" class="widget-content row">
							<div style="text-align: center; padding-top: 70px; padding-left: 40px;">
					           	<div id="converterJobSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>
					<div id="conveter_job-file_widget_content" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">Converter 파일 이력<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/converter/list-converter-job-file.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="converterJobFileWidget" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
			            		<div id="converterJobFileSpinner" style="width: 150px; height: 70px;"></div>
			            	</div>
						</div>
					</div>
					<div id="data_info_widget_content" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">데이터 정보 <span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/data/list-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="dataInfoWidget" class="widget-content row">
							<div style="text-align: center; padding-top: 60px; padding-left: 150px;">
					            <div id="dataInfoSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>
					<div id="upload_data_size_widget" class="widget one-third column" style="font-size: 16px;">
						<div class="widget-header row" style="height: 25px;">
							<div class="widget-heading u-pull-left">						
								<h3 class="widget-title">총 업로딩 용량<span class="widget-desc">${today } <spring:message code='config.widget.basic'/></span></h3>
							</div>
							<div class="widget-functions u-pull-right">
								<a href="/upload-data/list-upload-data.do" title="more"><span class="icon-glyph glyph-plus"></span></a>
							</div>
						</div>
						<div id="uploadDataSizeWidget" class="widget-content row" style="margin-top:0px; padding-top:0px; width:97%; height:86%;">
							<div style="text-align: center; padding-top: 60px; padding-left: 200px;">
					            <div id="uploadDataSizeSpinner" style="width: 150px; height: 70px;"></div>
							</div>
						</div>
					</div>
				</div>	
			</div>
			
		<!-- End content by page -->
		</div>	
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script type="text/javascript" src="/externlib/jqplot/jquery.jqplot.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
<script type="text/javascript" src="/externlib/jqplot/plugins/jqplot.pointLabels.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>
<script type="text/javascript" src="/externlib/webix/codebase/webix.js?v=6.0.5" ></script>

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	
	// 메뉴 접히고 시작
	toggleMenu();
	
	var refreshTime = parseInt("${widgetInterval}") * 1000;
	$(document).ready(function() {
		startSpinner("uploadDataSpinner");
		uploadDataWidget();
		startSpinner("converterJobSpinner");
		converterJobWidget();
		startSpinner("converterJobFileSpinner");
		setTimeout(converterJobFileWidget, 1000);
		startSpinner("dataInfoSpinner");
		setTimeout(dataInfoWidget, 2000);
		startSpinner("uploadDataCountSpinner");
	    setTimeout(uploadDataCountWidget, 3000);
	    startSpinner("uploadDataSizeSpinner");
	    setTimeout(uploadDataSizeWidget, 4000);
		
	    // Active 일때만 화면을 갱신함
		setInterval(refreshMain, refreshTime);
	});
	
	function refreshMain() {
		uploadDataWidget();
		converterJobWidget();
		converterJobFileWidget();
		dataInfoWidget();
		uploadDataCountWidget();
		uploadDataSizeWidget();
	}
	
	function uploadDataWidget() {
		var url = "/upload-data/ajax-upload-data-widget.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					$("#uploadDataWidget").empty();
					drawUploadData(msg);
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
	
	function drawUploadData(jsonData) {
		var uploadDataListSize = jsonData.uploadDataListSize;
		
		var totalCount = parseInt(uploadDataListSize);
		var uploadDataArray = new Array(totalCount);
		
		var i=0;
		var xMin = "";
		var xMax = "";
		var yMax = 0;
		
		var uploadDataList = jsonData.uploadDataList;
		for(i=0; i<uploadDataList.length; i++ ) {
			var uploadData = null;
			uploadData = uploadDataList[i];
			uploadDataArray[i] = new Array(2);
			
			// yyyy/MM/dd HH:mm
			var year = uploadData.year;
			var month = uploadData.month;
			var day = uploadData.day;
			var hour = uploadData.hour;
			var minute = uploadData.minute;
			var file_count = uploadData.file_count;
			
			var xLabel = "0";
			xLabel = year + "/" + month + "/" + day + " " + hour + ":" + minute;
			if(i == 0) {
				xMax = xLabel;
			}
			xMin = xLabel;
			if(yMax < parseInt(file_count)) {
				yMax = parseInt(file_count);
			}
			
			uploadDataArray[i][0] = xLabel;
			uploadDataArray[i][1] = Math.round(file_count);
		}
		
		if(yMax < 10) {
			yMax = 10;
		} else if(yMax < 20) {
			yMax = 20;
		} else if(yMax < 50) {
			yMax = 50;
		} else if(yMax < 100) {
			yMax = 100;
		} else if(yMax < 1000) {
			yMax = 1000;
		} else {
			yMax = 1000;
		}
		
		if(totalCount > 0) {
			var plot = $.jqplot("uploadDataWidget", [uploadDataArray], {
				//title : "upload data 현황",
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
		                	formatString:"%#m/%#d",
		                	fontSize: "10pt"
		                }
					},
		            yaxis: {
		            	numberTicks : 6,
		                min : 0,
		                max : yMax,
		                tickOptions:{ 
		                	formatString: "%d",
		                	fontSize: "10pt"
		                }
					}
				}
		    }); 
		}
	}
	
	function converterJobWidget() {
		var url = "/converter/ajax-converter-job-widget.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					$("#converterJobWidget").empty();
					drawConverterJob(msg);
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
	
	function drawConverterJob(jsonData) {
		var converterJobListSize = jsonData.converterJobListSize;
		
		var totalCount = parseInt(converterJobListSize);
		var converterJobArray = new Array(totalCount);
		
		var i=0;
		var xMin = "";
		var xMax = "";
		var yMax = 0;
		
		var converterJobList = jsonData.converterJobList;
		for(i=0; i<converterJobList.length; i++ ) {
			var converterJob = null;
			converterJob = converterJobList[i];
			converterJobArray[i] = new Array(2);
			
			// yyyy/MM/dd HH:mm
			var year = converterJob.year;
			var month = converterJob.month;
			var day = converterJob.day;
			var hour = converterJob.hour;
			var minute = converterJob.minute;
			var converter_file_count = converterJob.converter_file_count;
			
			var xLabel = "0";
			xLabel = year + "/" + month + "/" + day + " " + hour + ":" + minute;
			if(i == 0) {
				xMax = xLabel;
			}
			xMin = xLabel;
			if(yMax < parseInt(converter_file_count)) {
				yMax = parseInt(converter_file_count);
			}
			
			converterJobArray[i][0] = xLabel;
			converterJobArray[i][1] = Math.round(converter_file_count);
		}
		
		if(yMax < 10) {
			yMax = 10;
		} else if(yMax < 20) {
			yMax = 20;
		} else if(yMax < 50) {
			yMax = 50;
		} else if(yMax < 100) {
			yMax = 100;
		} else if(yMax < 1000) {
			yMax = 1000;
		} else {
			yMax = 1000;
		}
		
		if(totalCount > 0) {
			var plot = $.jqplot("converterJobWidget", [converterJobArray], {
				//title : "upload data 현황",
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
		                	formatString:"%#m/%#d",
		                	fontSize: "10pt"
		                }
					},
		            yaxis: {
		            	numberTicks : 6,
		                min : 0,
		                max : yMax,
		                tickOptions:{ 
		                	formatString: "%d",
		                	fontSize: "10pt"
		                }
					}
				}
		    }); 
		}
	}
	
	function converterJobFileWidget() {
		$.ajax({
			url : "/converter/ajax-converter-job-file-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var converterJobFileList = msg.converterJobFileList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />";
								+	"<col class=\"col-left\" />";
					if(converterJobFileList == null || converterJobFileList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">Converter Job File이 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<converterJobFileList.length; i++ ) {
							var converterJobFile = null;
							converterJobFile = converterJobFileList[i];
							var viewStatus = "";
							if(converterJobFile.status === "0") viewStatus = "성공";
							else if(converterJobFile.status === "1") viewStatus = "확인필요";
							else if(converterJobFile.status === "2") viewStatus = "실패";
							
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + converterJobFile.file_name + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + viewStatus + "</td>"
								+ 		"<td class=\"col-left\">" + converterJobFile.viewInsertDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#converterJobFileWidget").empty();
					$("#converterJobFileWidget").html(content);
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
	
	function dataInfoWidget() {
		$.ajax({
			url : "/data/ajax-data-info-widget.do",
			type : "GET",
			cache : false,
			dataType : "json",
			success : function(msg) {
				if (msg.result == "success") {
					var dataInfoList = msg.dataInfoList;
					var content = "";
					content 	= "<table class=\"widget-table\">"
								+	"<col class=\"col-left\" />"
								+	"<col class=\"col-left\" />";
								+	"<col class=\"col-left\" />";
					if(dataInfoList == null || dataInfoList.length == 0) {
						content += 	"<tr>"
								+	"	<td colspan=\"3\" class=\"col-none\">데이터 정보가 존재하지 않습니다.</td>"
								+	"</tr>";
					} else {
						for(i=0; i<dataInfoList.length; i++ ) {
							var dataInfo = null;
							dataInfo = dataInfoList[i];
							var viewStatus = "";
							if(dataInfo.status === "0") viewStatus = "사용중";
							else if(dataInfo.status === "1") viewStatus = "사용중지";
							else if(dataInfo.status === "2") viewStatus = "기타";
							
							content = content 
								+ 	"<tr>"
								+ 	"	<td class=\"col-left\">"
								+		"	<span class=\"index\"></span>"
								+		"	<em>" + dataInfo.data_name + "</em>"
								+		"</td>"
								+ 		"<td class=\"col-left\">" + viewStatus + "</td>"
								+ 		"<td class=\"col-left\">" + dataInfo.viewInsertDate + "</td>"
								+ 	"</tr>";
						}
					}
					$("#dataInfoWidget").empty();
					$("#dataInfoWidget").html(content);
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
	
	function uploadDataCountWidget() {
		var url = "/upload-data/ajax-upload-data-count-widget.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					drawUploadDataCount(msg);
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
	
	function drawUploadDataCount(jsonData) {
		$("#uploadDataCountWidget").empty();
		var uploadDataSet = [
			{ totalCount: (1000 - jsonData.uploadDataTotalCount), countLevel:"업로딩 가능 건수", color: "#a9ee36" },
			{ totalCount: jsonData.uploadDataTotalCount, countLevel:"업로딩 파일 건수", color: "#ee9e36" }
		];
		
		webix.ui({
            container: "uploadDataCountWidget",
            cols:[
                {
                    rows:[
                        {
                            view: "chart",
                            type:"pie",
                            value:"#totalCount#",
                            color:"#color#",
                           	pieInnerText:"#totalCount#",
                           	legend:{
                           	    width:175,
                                align:"right",
                                valign:"middle",
                                template:"#countLevel#"
                            },
                            shadow:0,
                            x:120,
                            y:100,
                            data:uploadDataSet
                        }
                    ]
                }
            ]
        });
	}
	
	function uploadDataSizeWidget() {
		var url = "/upload-data/ajax-upload-data-size-widget.do";
		var info = "";
		$.ajax({
			url: url,
			type: "GET",
			data: info,
			dataType: "json",
			headers: { "X-mago3D-Header" : "mago3D"},
			success : function(msg) {
				if(msg.result === "success") {
					drawUploadDataSize(msg);
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
	
	function drawUploadDataSize(jsonData) {
		$("#uploadDataSizeWidget").empty();
		var uploadDataSet = [
			{ totalCount: (1000000 - jsonData.uploadDataTotalSize), countLevel:"사용 가능 용량(M)", color: "#367fee" },
			{ totalCount: jsonData.uploadDataTotalSize, countLevel:"현재 사용량(M)", color: "#9b36ee" }
		];
		
		webix.ui({
            container: "uploadDataSizeWidget",
            cols:[
                {
                    rows:[
                        {
                            view: "chart",
                            type:"pie",
                            value:"#totalCount#",
                            color:"#color#",
                           	pieInnerText:"#totalCount#",
                           	legend:{
                           	    width:175,
                                align:"right",
                                valign:"middle",
                                template:"#countLevel#"
                            },
                            shadow:0,
                            x:120,
                            y:100,
                            data:uploadDataSet
                        }
                    ]
                }
            ]
        });
	}
	
</script>
</body>
</html>
