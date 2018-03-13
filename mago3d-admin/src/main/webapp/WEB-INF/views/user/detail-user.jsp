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
						<div class="tabs">
							<ul>
								<li><a href="#user_info_tab"><spring:message code='user.input.information'/></a></li>
								<li><a href="#user_device_tab"><spring:message code='user.input.device'/></a></li>
							</ul>
							<div id="user_info_tab">
								<table class="inner-table scope-row">
									<col class="col-label" />
									<col class="col-data" />
									<tr>
										<th class="col-label" scope="row"><spring:message code='user.id'/></th>
										<td class="col-data">${userInfo.user_id}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='user.group.usergroup'/></th>
										<td class="col-data">${userInfo.user_group_name}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='name'/></th>
										<td class="col-data">${userInfo.user_name}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='password'/></th>
										<td class="col-data">********</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='phone.number'/></th>
										<td class="col-data">${userInfo.viewMaskingTelePhone}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row"><spring:message code='mobile'/></th>
										<td class="col-data">${userInfo.viewMaskingMobilePhone}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='email'/></th>
										<td class="col-data">${userInfo.viewMaskingEmail}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='messenger'/></th>
										<td class="col-data">${userInfo.messanger}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='address'/></th>
										<td class="col-data">${userInfo.postal_code} ${userInfo.address} ${userInfo.viewMaskingAddressEtc}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='config.login.fail.count'/></th>
										<td class="col-data">${userInfo.fail_login_count}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='user.group.last.login'/></th>
										<td class="col-data">${userInfo.viewLastLoginDate}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='status'/></th>
										<td class="col-input radio-set">
	<c:if test="${userInfo.status eq '0'}">
												<span class="icon-glyph glyph-on on" style="float: left;"></span>
												<spring:message code='use'/>
	</c:if>
	<c:if test="${userInfo.status ne '0'}">
												<span class="icon-glyph glyph-off off" style="float: left;"></span>
												<spring:message code='no.use'/>
	</c:if>
																					
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row"><spring:message code='insert.type'/></th>
										<td class="col-data">
											${userInfo.viewUserInsertType}									
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">Single Sign-On</th>
										<td class="col-data">
	<c:if test="${user_info.sso_use_yn eq 'N'}">
											<spring:message code='no.use'/>
	</c:if>									
										</td>
									</tr>
								</table>
							</div>
							
							<div id="user_device_tab">
								<table class="inner-table scope-col">
									<col class="col-number" />
									<col class="col-name" />
									<col class="col-type" />
									<col class="col-ip" />
									<col class="col-toggle" />
									<thead>
										<tr>
											<th class="col-number" scope="col"><spring:message code='user.device.priority'/></th>
											<th class="col-name" scope="col"><spring:message code='user.device.device.name'/></th>
											<th class="col-type" scope="col"><spring:message code='user.device.type'/></th>
											<th class="col-ip" scope="col"><spring:message code='user.device.ip'/></th>
											<th class="col-toggle" scope="col"><spring:message code='user.device.use.not'/></th>
										</tr>
									</thead>
									<tbody>
	<c:if test="${userDevice.device_name1 != null && userDevice.device_name1 != ''}">
										<tr>
											<td class="col-number">${userDevice.device_priority1}</td>
											<td class="col-name">${userDevice.device_name1}</td>
											<td class="col-type">${userDevice.viewDeviceType1}</td>
											<td class="col-ip">${userDevice.device_ip1}</td>
											<td class="col-toggle">${userDevice.viewUseYn1}</td>
										</tr>
	</c:if>
	<c:if test="${userDevice.device_name2 != null && userDevice.device_name2 != ''}">
										<tr>
											<td class="col-number">${userDevice.device_priority2}</td>
											<td class="col-name">${userDevice.device_name2}</td>
											<td class="col-type">${userDevice.viewDeviceType2}</td>
											<td class="col-ip">${userDevice.device_ip2}</td>
											<td class="col-toggle">${userDevice.viewUseYn2}</td>
										</tr>
	</c:if>
	<c:if test="${userDevice.device_name3 != null && userDevice.device_name3 != ''}">
										<tr>
											<td class="col-number">${userDevice.device_priority3}</td>
											<td class="col-name">${userDevice.device_name3}</td>
											<td class="col-type">${userDevice.viewDeviceType3}</td>
											<td class="col-ip">${userDevice.device_ip3}</td>
											<td class="col-toggle">${userDevice.viewUseYn3}</td>
										</tr>
	</c:if>
	<c:if test="${userDevice.device_name4 != null && userDevice.device_name4 != ''}">
										<tr>
											<td class="col-number">${userDevice.device_priority4}</td>
											<td class="col-name">${userDevice.device_name4}</td>
											<td class="col-type">${userDevice.viewDeviceType4}</td>
											<td class="col-ip">${userDevice.device_ip4}</td>
											<td class="col-toggle">${userDevice.viewUseYn4}</td>
										</tr>
	</c:if>
	<c:if test="${userDevice.device_name5 != null && userDevice.device_name5 != ''}">
										<tr>
											<td class="col-number">${userDevice.device_priority5}</td>
											<td class="col-name">${userDevice.device_name5}</td>
											<td class="col-type">${userDevice.viewDeviceType5}</td>
											<td class="col-ip">${userDevice.device_ip5}</td>
											<td class="col-toggle">${userDevice.viewUseYn5}</td>
										</tr>
	</c:if>
									</tbody>
								</table>
							</div>
						</div>
						
						<div class="button-group">
							<div class="center-buttons">
								<a href="/user/list-user.do?${listParameters}" class="button"><spring:message code='list'/></a>
								<a href="/user/modify-user.do?user_id=${userInfo.user_id }&amp;${listParameters}" class="button"><spring:message code='modified'/></a>
							</div>
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
<script type="text/javascript">
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		
		$("#mobile_app_key").attr("disabled", true);
		
		$("#use_constraint_y").attr("disabled", true);
		$("#use_constraint_n").attr("disabled", true);
		$("#allow_counter").attr("disabled", true);
		$("input[name=use_monday_yn]").attr("disabled", true);
		$("input[name=use_tuesday_yn]").attr("disabled", true);
		$("input[name=use_wednesday_yn]").attr("disabled", true);
		$("input[name=use_thursday_yn]").attr("disabled", true);
		$("input[name=use_friday_yn]").attr("disabled", true);
		$("input[name=use_saturday_yn]").attr("disabled", true);
		$("input[name=use_sunday_yn]").attr("disabled", true);
	});
	

</script>
</body>
</html>