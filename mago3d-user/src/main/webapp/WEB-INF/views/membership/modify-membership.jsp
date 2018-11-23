<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Membership 설정 | mago3D User</title>
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
					<span style="font-size:26px;">Membership 설정</span>
				</h1>
				<div class="location">
					<span style="padding-top:10px; font-size:12px; color: Mediumslateblue;">
						<i class="fas fa-cubes" title="Settings"></i>
					</span>
					<span style="font-size:12px;">Settings > Membership 설정</span>
				</div>
			</div>
				
			<!-- Start content by page -->
			<div class="page-content">
				<div class="content-desc u-pull-right" style="padding-right: 10px;">
					<span class="icon-glyph glyph-emark-dot color-warning" style="display: inline-block; padding-bottom: 2px;"></span>
					<span style="display: inline-block; padding-bottom: 2px;"><spring:message code='check'/></span>
				</div>
				<div style="margin-top: 20px; border: 1px solid #dddddd;">
					<ul style="list-style: none; font-size: 14px; border-bottom: 3px solid #573592">
						<li style="padding-left: 10px; padding-top: 5px; width: 235px; height: 30px; color: white; background: #573690;">
							클라우드 서비스 Membership 설정
						</li>
					</ul>
					<div id="project_tab">
						<form:form id="membership" modelAttribute="membership" method="post" onsubmit="return false;">
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
					  			<th style="width: 20%;">
							  		<span>회원 타입</span>
					 			</th>
					 			<td class="col-input radio-set">
					 				<form:radiobutton path="membership_type" value="0" label="기본" />
									<form:radiobutton path="membership_type" value="1" label="실버" />
									<form:radiobutton path="membership_type" value="2" label="골드" />
						  		</td>
					  		</tr>
					  		<tr>
					  			<th>
							  		<span>요금 결제 방식</span>
					 			</th>
					 			<td class="col-input radio-set">
					 				<form:radiobutton path="charge_type" value="0" label="사용안함" />
									<form:radiobutton path="charge_type" value="1" label="월정액" />
									<form:radiobutton path="charge_type" value="2" label="년비" />
						  		</td>
					  		</tr>
						</table>
						
						<div class="button-group">
							<div id="updateLink" class="center-buttons">
								<input type="submit" value="<spring:message code='save'/>" onclick="updateMembership();" />
							</div>
						</div>
						</form:form>
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
	});
	
	// membership update
	var updateMembershipFlag = true;
	function updateMembership() {
		if( $("input[name=membership_type]:checked").val() === null 
			|| $("input[name=membership_type]:checked").val() === undefined
			|| $("input[name=charge_type]:checked").val() === null
			|| $("input[name=charge_type]:checked").val() === undefined ) {
			alert("선택 후 저장 가능 합니다.");
			return false;
		}
		
		if(updateMembershipFlag) {
			// validation 나중에
			updateMembershipFlag = false;
			var info =$("#membership").serialize();
			
			$.ajax({
				url: "/membership/ajax-update-membership.do",
				type: "POST",
				data: info,
				cache: false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateMembershipFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateMembershipFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>
