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
						<div class="inner-header row">
							<div class="content-title u-pull-left">API 상세 내용</div>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<table class="inner-table scope-row">
							<col class="col-label" />
							<col class="col-sub-label xl" />
							<col class="col-data" />
							<tr>
								<td colspan="3" class="col-center">HttpClient 를 사용하여 API를 호출, 데이터 포맷은 JSON</td>
							</tr>
							<tr>
								<th scope="rowgroup" class="col-label" rowspan="14">입력(Input)</th>
								<th class="col-sub-label xl">
									<span>API 코드</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-data">
									<div class="inner-data">
										service_code<br />
									</div>
								</td>
							</tr>
							<tr>
								<th class="col-sub-label xl">
									<span>API 이름</span>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-data">
									<div class="inner-data">
										service_name<br />
										테스트스
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript" src="/externlib/spinner/progressSpin.min.js"></script>
<script type="text/javascript" src="/externlib/spinner/raphael.js"></script>
</body>
</html>