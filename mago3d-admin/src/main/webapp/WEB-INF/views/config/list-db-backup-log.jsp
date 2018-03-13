<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>DB 백업 - 환경설정 - ${sessionSiteName}</title>
	<link type="text/css" rel="stylesheet" href="/css/ko/layout.css" />
	<link type="text/css" rel="stylesheet" href="/css/ko/common.css" />
	<link type="text/css" rel="stylesheet" href="/css/ko/admin.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/ko/jquery-1.11.2/jquery-ui.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/ko/jquery-1.11.2/jquery-ui.theme.min.css" />
	<script type="text/javascript" src="/externlib/ko/jquery-1.11.2/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/externlib/ko/jquery-1.11.2/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/ko/common.js"></script>
	<script type="text/javascript" src="/js/ko/message.js"></script>
	<script type="text/javascript" src="/js/consoleLog.js"></script>
</head>
<body>
<div id="wrapper">
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<div id="contents">
		<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
		<div id="content">
			<div id="location">
				<ul>
		        	<li style="margin-right:12px;"><img src="/images/btn_menu_hiding.gif" /></li>
		          	<li class="s_title"><a href="/config/modify-policy.do">환경설정</a></li>
		          	<li class="next_img"></li>
			        <li class="s_title">DB 백업</li>
		        </ul>
		    </div>
		    
		    <div id="sub_content">
		    	<div class="main_content_title">
			    	<ul>
			        	<li>DB 백업</li>
			        </ul>
			    </div>
			    
				<form:form id="dBBackupLog" modelAttribute="dBBackupLog" method="post" <%-- action="/config/list-db-backup-log.do" --%>>
		    	<div id="search_area">
		        	<table class="search_condition">
		        		<tr>
		        			<th width="7%">
		        				DB 백업 시간
		        			</th>
		        			<td width="18%">
		        				매일 새벽 2시
		        			</td>
		        			<th width="7%">
		        				DB 백업 종류
		        			</th>
		        			<td width="18%">
		        				전체 백업(1주일 1회), 증분백업(매일)
		        			</td>
		        			<th width="7%">
		        				백업 보관 기간
		        			</th>
		        			<td width="18%">
		        				3개월
		        			</td>
		        			<th width="7%">
		        				디렉토리 용량
		        			</th>
		        			<td width="18%">
		        				${dbBackupInfo.file_size }
		        			</td>
		        		</tr>
			        	<tr>
			            	<th>
			                	검색어
			                </th>
			                <td>
			                	<select id="search_word" name="search_word">
			                		<option value=""> 선택 </option>
				                	<option value="dbbackup_name"> 제품명 </option>
									<option value="db_name"> DB명 </option>
			                	</select>&nbsp;&nbsp;
			                	<form:input path="search_value" cssClass="txt" size="15"/>
							</td>
							<th><label for="status">상태</label></th>
			              	<td>
			              		<select id="status" name="status">
									<option value=""> 전체 </option>
									<option value="0"> 초기상태 </option>
									<option value="1"> 성공 </option>
									<option value="2"> 실패 </option>
								</select>
							</td>
							<th><label for="start_date">기간</label></th>
			              	<td>
			              		<input type="text" id="start_date" name="start_date" class="txt" size="7" />
			                	&nbsp;~&nbsp;
			                	<input type="text" id="end_date" name="end_date" class="txt" size="7" />
							</td>
			            	<th>
			                	표시 순서
			                </th>
			                <td>
			                	<select id="order_word" name="order_word">
									<option value=""> 기본 </option>
				                	<option value="status"> 상태 </option>
									<option value="insert_date"> 등록일 </option>
		                		</select>
			                	<select id="order_value" name="order_value">
			                		<option value=""> 기본 </option>
				                	<option value="ASC"> 오름차순 </option>
									<option value="DESC"> 내림차순 </option>
			                	</select>&nbsp;&nbsp;&nbsp;
			                	<input type="submit" class="buttonPro small" value="조회" />
							</td>
						</tr>	
		          	</table>
		        </div>
		        </form:form>
		    </div>
		    
			<div id="main_content">
				<div class="list_top_area">
		        	<div class="list_top_summary">
			         	총 <fmt:formatNumber value="${pagination.totalCount}" type="number"/> 건, 
			         	&nbsp;&nbsp;<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
		          	</div>
		        </div>
        		<div id="list_area">
					<table class="list_area_table">
						<caption>DB 백업 이력 목록</caption>
						<colgroup>
							<col width="5%" />
							<col width="5%" />
							<col width="7%" />
							<col width="10%" />
							<col width="*" />
							<col width="10%" />
							<col width="10%" />
							<col width="5%" />
							<col width="15%" />
							<col width="10%" />
						</colgroup>
						<thead>
							<tr style="line-height: 30px;">
								<th scope="col">번호</th>
								<th scope="col">제품명</th>
								<th scope="col">DB명</th>
								<th scope="col">서버 IP</th>
								<th scope="col">디스크 사용량(현재/전체)</th>
								<th scope="col">사용률</th>
								<th scope="col">파일 용량</th>
								<th scope="col">상태</th>
								<th scope="col">작업시간</th>
								<th scope="col">등록일</th>
		 					</tr>
						</thead>
						<tbody>
		<c:if test="${empty dbBackupLogList }">
							<tr style="line-height: 30px;">
								<td colspan="10" style="text-align: center;">DB 백업 이력이 존재하지 않습니다.</td>
							</tr>
		</c:if>
		<c:if test="${!empty dbBackupLogList }">
			<c:forEach var="dbBackupLog" items="${dbBackupLogList}" varStatus="status">
							<tr style="line-height: 30px;">
								<td style="text-align: center;">${pagination.rowNumber - status.index }</td>
								<td style="text-align: center;">${dbBackupLog.dbbackup_name }</td>
								<td style="text-align: center;">${dbBackupLog.db_name }</td>
								<td style="text-align: center;">${dbBackupLog.server_ip }</td>
								<td style="text-align: center;">${dbBackupLog.disk_usage_size }/${dbBackupLog.disk_full_size }</td>
								<td style="text-align: center;">${dbBackupLog.disk_usage_percent }</td>
								<td style="text-align: center;">${dbBackupLog.file_size }</td>
								<td style="text-align: center;">${dbBackupLog.status }</td>
								<td style="text-align: center;">${dbBackupLog.start_date } ~ ${dbBackupLog.end_date }</td>
								<td style="text-align: center;">${accessLog.viewRegisterDate }</td>
							</tr>
			</c:forEach>
		</c:if>
						</tbody>
					</table>
				</div>
				
				<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
			
			</div>
			<!-- main content 종료 -->
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		/* $( ".date" ).datepicker({ 
			dateFormat : "yymmdd",
			dayNames : [ "일", "월", "화", "수", "목", "금", "토" ],
			dayNamesShort : [ "일", "월", "화", "수", "목", "금", "토" ],
			dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
			monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthNamesShort : [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			prevText : "",
			nextText : "",
			showMonthAfterYear : true,
			yearSuffix : "년"
		}); */
		
		var search_word = "${dBBackupLog.search_word}";
		if(search_word != null && search_word != "") {
			$("#search_word > option[value=${dBBackupLog.search_word}]").attr("selected", "true");
		}
		
		var status = "${dBBackupLog.status}";
		if(status != null && status != "") {
			$("#status > option[value=${dBBackupLog.status}]").attr("selected", "true");
		}
		
		$("#start_date").datepicker( { dateFormat: 'yymmdd' } );
		$("#end_date").datepicker( { dateFormat: 'yymmdd' } );
		
		var start_date = "${dBBackupLog.start_date}";
		var end_date = "${dBBackupLog.end_date}";
		$("#start_date").val(start_date.substring(0,8));
		$("#end_date").val(end_date.substring(0,8));
		
        var order_word = "${dBBackupLog.order_word}";
		if(order_word != null && order_word != "") {
			$("#order_word > option[value=${dBBackupLog.order_word}]").attr("selected", "true");
		}
		var order_value = "${dBBackupLog.order_value}";
		if(order_value != null && order_value != "") {
			$("#order_value > option[value=${dBBackupLog.order_value}]").attr("selected", "true");
		}
	});
</script>
</body>
</html>