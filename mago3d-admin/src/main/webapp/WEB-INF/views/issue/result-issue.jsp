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
						
						<div class="list">
							<div class="main_content_title">
					    	<ul>
					        	<li>이슈 처리 결과</li>
					        </ul>
					    </div>
						<ul>
							<li style="line-height: 30px;">
				<c:if test="${method_mode eq 'insert'}">등록 되었습니다.</c:if>
				<c:if test="${method_mode eq 'update'}">수정 되었습니다.</c:if>
				<c:if test="${method_mode eq 'delete'}">삭제 되었습니다.</c:if>
					  		</li>
				<c:if test="${method_mode eq 'insert' || method_mode eq 'update'}">
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">데이터 그룹</span>
					 			<span>${issue.data_group_name}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">이슈명</span>
					 			<span>${issue.title}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">우선순위</span>
					 			<span>${issue.priority}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">예정일</span>
					 			<span>${issue.due_date}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">이슈 유형</span>
					 			<span>${issue.issue_type}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">상태</span>
					 			<span>${issue.status}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">위도</span>
					 			<span>${issue.latitude}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">경도</span>
					 			<span>${issue.longitude}</span>
					  		</li>
					  		<li style="line-height: 30px;">
					  			<span style="display:inline-block; width: 200px;">등록일</span>
					 			<span>${issue.viewInsertDate}</span>
					  		</li>
				</c:if>
					  		<li style="text-align: center;">
					  			<a href="/issue/list-issue.do">목록</a>
					  		</li>
					 	</ul>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>

</body>
</html>