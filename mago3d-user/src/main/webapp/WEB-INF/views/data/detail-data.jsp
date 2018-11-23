<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Data 상세 정보 | mago3D User</title>
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" href="/css/cloud.css?cache_version=${cache_version}">
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
	<link rel="stylesheet" href="/externlib/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
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
			<div id="gnb-content" class="clfix">
				<h1 style="padding-left: 20px;">
					<span style="font-size:26px;">Data 상세 정보</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="Visualization"></i>
					</span>
					<span style="font-size:12px;">Data 목록 > Data 상세 정보</span>
				</div>
			</div>

			<!-- Start content by page -->
			<div class="page-content">
				<div style="margin-top: 20px; border: 1px solid #dddddd;">
					<ul style="list-style: none; font-size: 14px; border-bottom: 3px solid #573592">
						<li style="padding-left: 10px; padding-top: 5px; width: 115px; height: 30px; color: white; background: #573690;">
							Data 상세 정보
						</li>
					</ul>
					<div id="data_tab">	
						<table class="inner-table scope-row">
							<col class="col-label" />
							<col class="col-data" />
							<tr>
								<th class="col-label" scope="row" style="width: 250px;"><spring:message code='data.project.name'/></th>
								<td class="col-data">${dataInfo.project_name }</td>
							</tr>	
							<tr>
								<th class="col-label" scope="row"><spring:message code='data.project.parent.node'/></th>
								<td class="col-data">${dataInfo.parent_name}</td>
							</tr>	
							<tr>
								<th class="col-label" scope="row">Key</th>
									<td class="col-data">${dataInfo.data_key }</td>
							</tr>	
							<tr>
								<th class="col-label" scope="row"><spring:message code='data.name'/></th>
								<td class="col-data">${dataInfo.data_name }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='data.mapping.type'/></th>
								<td class="col-data">${dataInfo.mapping_type }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='latitude'/></th>
								<td class="col-data">${dataInfo.latitude }</td>
							</tr>	
							<tr>
								<th class="col-label" scope="row"><spring:message code='longitude'/></th>
								<td class="col-data">${dataInfo.longitude }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='height'/></th>
								<td class="col-data">${dataInfo.height }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">Heading</th>
								<td class="col-data">${dataInfo.heading }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">Pitch</th>
								<td class="col-data">${dataInfo.pitch }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">Roll</th>
								<td class="col-data">${dataInfo.roll }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='properties'/></th>
								<td class="col-data">${dataInfo.attributes }</td>
							</tr>
							<tr>
								<th class="col-label" scope="row"><spring:message code='description'/></th>
								<td class="col-data">${dataInfo.description }</td>
							</tr>			
						</table>
						
						<div class="button-group" style="height: 50px; padding-top: 10px;">
							<div class="center-buttons">
								<a href="/data/list-data.do?${listParameters}" class="button"><spring:message code='list'/></a>
								<a href="/data/modify-data.do?data_id=${dataInfo.data_id }&amp;${listParameters}" class="button"><spring:message code='modified'/></a>
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

<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
	});
</script>
</body>
</html>