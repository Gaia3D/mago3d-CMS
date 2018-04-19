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
						<div class="filters">
							<form:form id="searchForm" modelAttribute="statistic" method="post" action="/statistic/index.do">
							<div class="input-group row">
								<div class="input-set">
									<label for="year_month_day">기간</label>
									<select id="year_month_day" name="year_month_day" class="select">
									</select>
								</div>
								<div class="input-set">
									<input type="submit" value="검색" />
								</div>
							</div>
							</form:form>
						</div>
							
						<table class="inner-table scope-col">
							<col class="col-type" />
							<col class="col-type" />
							<col class="col-count" />
							<col class="col-count" />
							<thead>
								<tr>
									<th scope="col" class="col-type">구분</th>
									<th scope="col" class="col-type">분류</th>
									<th scope="col" class="col-count">누적 통계</th>
									<th scope="col" id="selectTitle" class="col-count"></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td rowspan="4" class="col-type">데이터 변경 요청</td>
									<td class="col-type">요청</td>
									<td id="userTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearUserTotalCount" class="col-count">로딩중...</td>
								</tr>
								<tr>
									<td class="col-type">요청</td>
									<td id="dataInfoLogTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearDataInfoLogTotalCount" class="col-count">로딩중...</td>
								</tr>
								<tr>
									<td class="col-type">승인</td>
									<td id="notDataInfoLogTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearNotDataInfoLogTotalCount" class="col-count">로딩중...</td>
								</tr>
								<tr>
									<td class="col-type">원복</td>
									<td id="DataInfoLogNotConfigTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearDataInfoLogNotConfigTotalCount" class="col-count">로딩중...</td>
								</tr>
								<tr>
									<td rowspan="3" class="col-type">Issue 현황</td>
									<td class="col-type">Issue 요청 건수</td>
									<td id="DataInfoLogRequestTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearDataInfoLogRequestTotalCount" class="col-count">로딩중...</td>
								</tr>
								<tr>
									<td class="col-type">Issue 승인</td>
									<td id="DataInfoLogVerifyTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearDataInfoLogVerifyTotalCount" class="col-count">로딩중...</td>
								</tr>
								<tr>
									<td class="col-type">Issue 진행중</td>
									<td id="DataInfoLogVerifySuccessTotalCount" class="col-count">로딩중...</td>
									<td id="thisYearDataInfoLogVerifySuccessTotalCount" class="col-count">로딩중...</td>
								</tr>
							</tbody>
						</table>
						
						<div style="height: 30px;"></div>
						
						<div class="row">
							<div class="widget one-half column" style="height: 370px; font-size: 16px;">
								<div class="widget-header row">
									<div class="widget-heading">
										<h3 id="dataInfoLogGraph" class="widget-title">데이터 변경 요청</h3>
									</div>
								</div>
								<div id="userChart" class="widget-content row">
									<div id="userSpinner" style="width: 150px; height: 70px;"></div>
								</div>
							</div>
							<div class="widget one-half column" style="height: 370px; font-size: 16px;">
								<div class="widget-header row">
									<div class="widget-heading">
										<h3 id="issueGraph" class="widget-title">issue 요청</h3>
									</div>
								</div>
								<div id="DataInfoLogChart" class="widget-content row">
									<div id="DataInfoLogSpinner" style="width: 150px; height: 70px;"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script src="/externlib/jquery/jquery.js"></script>
<script src="/externlib/jquery-ui/jquery-ui.js"></script>		
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		alert("개발중입니다.");
		
		var selectTitle = "${year} 년 전체 통계";
		var userGraph = "${year} Data 변경 요청 현황";
		var otpGraph = "${year} Issue 현황";
		
		getYearMonth();
		var year_month_day = "${statistic.year_month_day}";
		$("#year_month_day").val(year_month_day);
		$( ".select" ).selectmenu();
		
		if(year_month_day != "") {
			selectTitle = $("#year_month_day option:selected").text();
			dataInfoLogGraph = $("#year_month_day option:selected").text() + " 사용자 현황";
			otpGraph = $("#year_month_day option:selected").text() + " OTP 현황";
		}
		
		$("#selectTitle").html(selectTitle);
		$("#userGraph").html(userGraph);
		$("#otpGraph").html(otpGraph);
		
		startSpinner("userSpinner");
		startSpinner("DataInfoLogSpinner");
		ajaxUserStatistics();
		ajaxDataInfoLogStatistics();
	});
	
	// 사용자 통계
	function ajaxUserStatistics() {
		$.ajax({
    		url: "/statistic/ajax-user-statistics.do",
    		data: { type : "${policy.content_statistics_interval}", year_month_day : $("#year_month_day option:selected").val() },
    		type: "GET",
    		cache: false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				var target = "userChart";
    				var data = [ msg.thisYearUserTotalCount, msg.thisYearDataInfoLogTotalCount, msg.thisYearNotDataInfoLogTotalCount, msg.thisYearDataInfoLogNotConfigTotalCount ];
    				var ticks = [ "전체 사용자", "OTP 상태 사용", "OTP 상태 사용안함" , "OTP 미설정" ];
    				var yMax = 10;
    				if(msg.thisYearUserTotalCount > 10 || msg.thisYearDataInfoLogTotalCount > 10 || msg.thisYearNotDataInfoLogTotalCount > 10 || msg.thisYearDataInfoLogNotConfigTotalCount > 10) {
    					yMax = Math.max(msg.thisYearUserTotalCount, msg.thisYearDataInfoLogTotalCount, msg.thisYearNotDataInfoLogTotalCount, msg.thisYearDataInfoLogNotConfigTotalCount) + (msg.thisYearUserTotalCount * 0.2);
    				}
    				$("#userChart").empty();
    				drawBarChart(target, data, ticks, yMax);

					$("#userTotalCount").html(numberWithCommas(msg.userTotalCount));
    				$("#DataInfoLogTotalCount").html(numberWithCommas(msg.DataInfoLogTotalCount));
    				$("#notDataInfoLogTotalCount").html(numberWithCommas(msg.notDataInfoLogTotalCount));
    				$("#DataInfoLogNotConfigTotalCount").html(numberWithCommas(msg.DataInfoLogNotConfigTotalCount));
   					$("#thisYearUserTotalCount").html(numberWithCommas(msg.thisYearUserTotalCount));
    				$("#thisYearDataInfoLogTotalCount").html(numberWithCommas(msg.thisYearDataInfoLogTotalCount));
    				$("#thisYearNotDataInfoLogTotalCount").html(numberWithCommas(msg.thisYearNotDataInfoLogTotalCount));
    				$("#thisYearDataInfoLogNotConfigTotalCount").html(numberWithCommas(msg.thisYearDataInfoLogNotConfigTotalCount));
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
    	});
	}
	
	// data info log 통계
	function ajaxDataInfoLogStatistics() {
		$.ajax({
    		url: "/statistic/ajax-data-info-log-statistics.do",
    		data: { type : "${policy.content_statistics_interval}", year_month_day : $("#year_month_day option:selected").val() },
    		type: "GET",
    		cache: false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				var target = "DataInfoLogChart";
    				var data = [ msg.thisYearDataInfoLogRequestTotalCount, msg.thisYearDataInfoLogVerifyTotalCount, msg.thisYearDataInfoLogVerifySuccessTotalCount, msg.thisYearDataInfoLogVerifyFailTotalCount ];
    				var ticks = [ "data info 변경 요청", "data info 승인", "data info 반려", "data info 원복" ];
    				var yMax = 10;
    				if(msg.thisYearDataInfoLogRequestTotalCount > 10 || msg.thisYearDataInfoLogVerifyTotalCount > 10 || msg.thisYearDataInfoLogVerifySuccessTotalCount > 10 || msg.thisYearDataInfoLogVerifyFailTotalCount > 10) {
    					yMax = Math.max(msg.thisYearDataInfoLogRequestTotalCount, msg.thisYearDataInfoLogVerifyTotalCount, msg.thisYearDataInfoLogVerifySuccessTotalCount, msg.thisYearDataInfoLogVerifyFailTotalCount) 
    							+ (msg.thisYearDataInfoLogRequestTotalCount * 0.2);
    				}
    				$("#DataInfoLogChart").empty();
    				drawBarChart(target, data, ticks, yMax);
    				
    				$("#DataInfoLogRequestTotalCount").html(numberWithCommas(msg.DataInfoLogRequestTotalCount));
        			$("#DataInfoLogVerifyTotalCount").html(numberWithCommas(msg.DataInfoLogVerifyTotalCount));
        			$("#DataInfoLogVerifySuccessTotalCount").html(numberWithCommas(msg.DataInfoLogVerifySuccessTotalCount));
        			$("#DataInfoLogVerifyFailTotalCount").html(numberWithCommas(msg.DataInfoLogVerifyFailTotalCount));
    				$("#thisYearDataInfoLogRequestTotalCount").html(numberWithCommas(msg.thisYearDataInfoLogRequestTotalCount));
    				$("#thisYearDataInfoLogVerifyTotalCount").html(numberWithCommas(msg.thisYearDataInfoLogVerifyTotalCount));
    				$("#thisYearDataInfoLogVerifySuccessTotalCount").html(numberWithCommas(msg.thisYearDataInfoLogVerifySuccessTotalCount));
    				$("#thisYearDataInfoLogVerifyFailTotalCount").html(numberWithCommas(msg.thisYearDataInfoLogVerifyFailTotalCount));
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
			error : function(request, status, error) {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
    	});
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// Bar Chart 그래프
	function drawBarChart(target, data, ticks, yMax) {
		var plot = $.jqplot(target, [data], {
        	//title : "사용자 상태별 현황",
        	animate: !$.jqplot.use_excanvas,
        	seriesColors: [ "#40a7fe", "#3fbdf8" ],
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
		        left:80,
		        right:10,
		        top:20,
		        bottom:45
		    },
            seriesDefaults:{
            	shadow:false,
            	renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true },
                rendererOptions: {
                	barWidth: 50
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
	            	numberTicks : 10,
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
	
	// 통계 엑셀 다운로드 값 설정
	function statisticExcel() {
		$("#select_title").val($("#selectTitle").text());
		$("#user_total_count").val($("#userTotalCount").text());
		$("#this_year_user_total_count").val($("#thisYearUserTotalCount").text());
		$("#user_data_info_log_total_count").val($("#DataInfoLogTotalCount").text());
		$("#this_year_user_data_info_log_total_count").val($("#thisYearDataInfoLogTotalCount").text());
		$("#not_user_data_info_log_total_count").val($("#notDataInfoLogTotalCount").text());
		$("#this_year_not_user_data_info_log_total_count").val($("#thisYearNotDataInfoLogTotalCount").text());
		$("#user_data_info_log_not_config_total_count").val($("#DataInfoLogNotConfigTotalCount").text());
		$("#this_year_user_data_info_log_not_config_total_count").val($("#thisYearDataInfoLogNotConfigTotalCount").text());
		$("#user_data_info_log_request_total_count").val($("#DataInfoLogRequestTotalCount").text());
		$("#this_year_user_data_info_log_request_total_count").val($("#thisYearDataInfoLogRequestTotalCount").text());
		$("#user_data_info_log_verify_total_count").val($("#DataInfoLogVerifyTotalCount").text());
		$("#this_year_user_data_info_log_verify_total_count").val($("#thisYearDataInfoLogVerifyTotalCount").text());
		$("#user_data_info_log_verify_success_total_count").val($("#DataInfoLogVerifySuccessTotalCount").text());
		$("#this_year_user_data_info_log_verify_success_total_count").val($("#thisYearDataInfoLogVerifySuccessTotalCount").text());
		$("#user_data_info_log_verify_fail_total_count").val($("#DataInfoLogVerifyFailTotalCount").text());
		$("#this_year_user_data_info_log_verify_fail_total_count").val($("#thisYearDataInfoLogVerifyFailTotalCount").text());
	}
	
	function getYearMonth() {
		var periodYearMonth = "${periodYearMonth}";
		var year = parseInt(periodYearMonth.substring(0,4));
		var month = parseInt(periodYearMonth.substring(5,7));
		var content_statistics_interval = "${policy.content_statistics_interval}";
		
		if(content_statistics_interval == "0") {
			var name = new Array("전체", year + " 년", (year - 1) + " 년");
			var value = new Array("", year + "0101", (year - 1) + "0101");
			for(var i=0; i<name.length; i++) {
				document.getElementById("year_month_day").options[i] = new Option(name[i], value[i]);
			}
		} else if(content_statistics_interval == "1") {
			var name = null;
			var value = null;
			if(month > 6) {
				name = new Array("전체", year + " 년 하반기", year + " 년 상반기", (year - 1) + " 년 하반기", (year - 1) + " 년 상반기");
				value = new Array("", year + "0701", year + "0101", (year - 1) + "0701", (year - 1) + "0101");
			} else {
				name = new Array("전체", year + " 년 상반기", (year - 1) + " 년 하반기", (year - 1) + " 년 상반기");
				value = new Array("", year + "0101", (year - 1) + "0701", (year - 1) + "0101");
			}
			for(var i=0; i<name.length; i++) {
				document.getElementById("year_month_day").options[i] = new Option(name[i], value[i]);
			}
		} else if(content_statistics_interval == "2") {
			var name = null;
			var value = null;
			if(month > 9) {
				name = new Array("전체", year + " 년 4분기", year + " 년 3분기", year + " 년 2분기", year + " 년 1분기", (year - 1) + " 년 4분기", (year - 1) + " 년  3분기", (year - 1) + " 년 2분기", (year - 1) + " 년  1분기");
				value = new Array("", year + "1001", year + "0701", year + "0401", year + "0101", (year - 1) + "1001", (year - 1) + "0701", (year - 1) + "0401", (year - 1) + "0101");
			} else if(month > 6) {
				name = new Array("전체", year + " 년 3분기", year + " 년 2분기", year + " 년 1분기", (year - 1) + " 년 4분기", (year - 1) + " 년  3분기", (year - 1) + " 년 2분기", (year - 1) + " 년  1분기");
				value = new Array("", year + "0701", year + "0401", year + "0101", (year - 1) + "1001", (year - 1) + "0701", (year - 1) + "0401", (year - 1) + "0101");
			} else if(month > 3) {
				name = new Array("전체", year + " 년 2분기", year + " 년 1분기", (year - 1) + " 년 4분기", (year - 1) + " 년  3분기", (year - 1) + " 년 2분기", (year - 1) + " 년  1분기");
				value = new Array("", year + "0401", year + "0101", (year - 1) + "1001", (year - 1) + "0701", (year - 1) + "0401", (year - 1) + "0101");
			} else {
				name = new Array("전체", year + " 년 1분기", (year - 1) + " 년 4분기", (year - 1) + " 년  3분기", (year - 1) + " 년 2분기", (year - 1) + " 년  1분기");
				value = new Array("", year + "0101", (year - 1) + "1001", (year - 1) + "0701", (year - 1) + "0401", (year - 1) + "0101");
			}
			for(var i=0; i<name.length; i++) {
				document.getElementById("year_month_day").options[i] = new Option(name[i], value[i]);
			}
		} else if(content_statistics_interval == "3") {
			var name = new Array("전체");
			var value = new Array("");
			for(var i=month; i>=1; i--) {
				name.push(year + " 년 " + i + " 월");
				if(i < 10) {
					value.push(year + "0" + i + "01");
				} else {
					value.push(year + i.toString() + "01");
				}
			}
			for(var i=12; i>=1; i--) {
				name.push((year-1) + " 년 " + i + " 월");
				if(i < 10) {
					value.push(year-1 + "0" + i + "01");
				} else {
					value.push(year-1 + i.toString() + "01");
				}
			}
			for(var i=0; i<name.length; i++) {
				document.getElementById("year_month_day").options[i] = new Option(name[i], value[i]);
			}
		}
	}
</script>
</body>
</html>