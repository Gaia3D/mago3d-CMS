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
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
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
		    
			<div id="main_content">
				<div style="line-height: 30px;">여기에 스케줄명이 나와야 겠지? ㅋ.ㅋ</div>
				<div class="list_top_area">
		        	<div class="list_top_summary">
			         	총 <fmt:formatNumber value="${pagination.totalCount}" type="number"/> 건, 
			         	&nbsp;&nbsp;<fmt:formatNumber value="${pagination.pageNo}" type="number"/> / <fmt:formatNumber value="${pagination.lastPage }" type="number"/> 페이지
		          	</div>
		        </div>
				
				<table border="1" summary="스케줄 상세 이력 목록" style="margin-bottom:10px; width: 1200px;">
					<caption>스케줄 상세 이력</caption>
					<colgroup>
						<col width="5%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="*%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr style="line-height: 30px;">
							<th scope="col">번호</th>
							<th scope="col">시스템</th>
							<th scope="col">계정</th>
							<th scope="col">결과</th>
							<th scope="col">상세내용</th>
							<th scope="col">등록일</th>
	 					</tr>
					</thead>
					<tbody>
	<c:if test="${empty scheduleDetailLogList }">
						<tr style="line-height: 30px;">
							<td colspan="6" style="text-align: center;">스케줄 이력이 존재하지 않습니다.</td>
						</tr>
	</c:if>
	<c:if test="${!empty scheduleDetailLogList }">
		<c:forEach var="scheduleDetailLog" items="${scheduleDetailLogList}" varStatus="status">
						<tr style="line-height: 30px;">
							<td style="text-align: center;">${pagination.rowNumber - status.index }</td>
							<td style="text-align: center;">${scheduleDetailLog.system_id }</td>
							<td style="text-align: center;">${scheduleDetailLog.account_id }</td>
							<td style="text-align: center;">${scheduleDetailLog.result }</td>
							<td style="text-align: left;">${scheduleDetailLog.message }</td>
							<td style="text-align: center;">${scheduleDetailLog.viewRegisterDate }</td>
						</tr>
		</c:forEach>
	</c:if>
					</tbody>
				</table>
				
				<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
				
				<div style="line-height: 30px;">나중에 시간 되면 이건 목록이 아니고 Facebook 처럼 더보기를 해서 밑에 쭈욱 붙이는 형태로....</div>
			
				</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
			
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.form.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>		
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
</body>
</html>