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
								<li><a href="#user_info_tab">기본정보</a></li>
								<li><a href="#user_otp_tab">OTP</a></li>
								<li><a href="#user_device_tab">디바이스</a></li>
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
										<th class="col-label" scope="row">사용자 그룹</th>
										<td class="col-data">${userInfo.user_group_name}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row">이름</th>
										<td class="col-data">${userInfo.user_name}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row">비밀번호</th>
										<td class="col-data">********</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">전화번호</th>
										<td class="col-data">${userInfo.viewMaskingTelePhone}</td>
									</tr>	
									<tr>
										<th class="col-label" scope="row">핸드폰번호</th>
										<td class="col-data">${userInfo.viewMaskingMobilePhone}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">이메일</th>
										<td class="col-data">${userInfo.viewMaskingEmail}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">메신저</th>
										<td class="col-data">${userInfo.messanger}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">주소</th>
										<td class="col-data">${userInfo.postal_code} ${userInfo.address} ${userInfo.viewMaskingAddressEtc}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">로그인 실패 횟수</th>
										<td class="col-data">${userInfo.fail_login_count}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">마지막 로그인 날짜</th>
										<td class="col-data">${userInfo.viewLastLoginDate}</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">상태</th>
										<td class="col-input radio-set">
	<c:if test="${userInfo.status eq '0'}">
												<span class="icon-glyph glyph-on on" style="float: left;"></span>
	</c:if>
	<c:if test="${userInfo.status ne '0'}">
												<span class="icon-glyph glyph-off off" style="float: left;"></span>
	</c:if>
												<span class="icon-text" style="padding-left: 5px;">${userInfo.viewStatus}</span>									
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">등록유형</th>
										<td class="col-data">
											${userInfo.viewUserInsertType}									
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">Single Sign-On</th>
										<td class="col-data">
											${userInfo.viewSsoUseYn}									
										</td>
									</tr>
								</table>
							</div>
							
							<div id="user_otp_tab">
								<form:form id="userOTP" modelAttribute="userOTP" method="post" onsubmit="return false;">
								<table class="input-table scope-row">
									<col class="col-label" />
									<col class="col-input" />
									<col class="col-input" />
									<col class="col-input" />
									<col class="col-input" />
									<tr>
										<th class="col-label" scope="row">
											<span>OTP 사용 여부</span>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input radio-set" colspan="3">
											<input type="radio" id="otp_use_y" name="otp_use_yn" value="Y" />
											<label for="otp_use_y">사용</label>
											<input type="radio" id="otp_use_n" name="otp_use_yn" value="N" />
											<label for="otp_use_n">사용안함</label>
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<span>OTP 상태</span>
										</th>
										<td class="col-input radio-set" colspan="3">
		<c:if test="${userOTP.otp_status eq '0'}">
												<span class="icon-glyph glyph-on on"></span>								
		</c:if>		
		<c:if test="${userOTP.otp_status ne null && userOTP.otp_status ne '0'}">
												<span class="icon-glyph glyph-off off"></span>							
		</c:if>							
												<span class="icon-text">${userOTP.viewOtpStatus }</span>										
										</td>
									</tr>												
									<tr>
										<th class="col-label" scope="rowgroup" rowspan="${otpTypeCount }">
											<span>OTP 인증 방식</span>
										</th>
										<td class="col-input radio-set">
											<input type="radio" id="otp_type_app" name="otp_type" value="0" />
											<label for="otp_type_app">모바일(앱) 이용</label>
										</td>
										<td class="col-input">앱 OTP Key</td>
										<td class="col-input">
											<form:input path="mobile_app_key" class="l" />
										</td>
									</tr>
<c:if test="${policy.user_otp_sms_yn eq 'Y'}">																					
									<tr>
										<td class="col-input radio-set">
											<input type="radio" id="otp_type_sms" name="otp_type" value="1" />
											<label for="otp_type_sms">SMS 전송</label>
										</td>
										<td class="col-input">핸드폰 번호</td>
										<td id="reloadMobilePhone" class="col-input" colspan="2">${userOTP.viewMaskingMobilePhone}</td>
									</tr>
</c:if>																					
									<tr>
										<td class="col-input radio-set">
											<input type="radio" id="otp_type_pc" name="otp_type" value="2" />
											<label for="otp_type_pc">PC(Web) 이용</label>
										</td>
										<td class="col-input">
											PIN 번호
										</td>
										<td class="col-input" colspan="2">
											${userOTP.viewMaskingPinNumber }
										</td>
									</tr>
<c:if test="${policy.user_otp_email_yn eq 'Y'}">																					
									<tr>
										<td class="col-input radio-set">
											<input type="radio" id="otp_type_email" name="otp_type" value="3" />
											&nbsp;이메일 전송
										<td class="col-input">이메일</td>
										<td id="reloadEmail" class="col-input" colspan="2">${userOTP.viewMaskingEmail}</td>
									</tr>
</c:if>
<c:if test="${policy.user_otp_messanger_yn eq 'Y'}">																					
									<tr>
										<td class="col-input radio-set">
											<input type="radio" id="otp_type_messanger" name="otp_type" value="4" />
											&nbsp;메신저 전송
										<td class="col-input">메신저</td>
										<td id="reloadMessanger" class="col-input" colspan="2">${userOTP.messanger}</td>
									</tr>
</c:if>
<c:if test="${policy.user_otp_radius_yn eq 'Y'}">
									<tr>
										<td class="col-input radio-set">
											<input type="radio" id="otp_type_radius" name="otp_type" value="6" />
											<label for="otp_type_radius">RADIUS</label>
										</td>
										<td class="col-input">Radius 프로토콜 (도움말)</td>
										<td class="col-input" colspan="2"></td>
									</tr>
</c:if>												
									<tr>
										<th class="col-label" scope="rowgroup" rowspan="5">
											<span>OTP 사용 접속 제어</span>
										</th>
										<td class="col-input radio-set" colspan="3">
											<input type="radio" id="use_constraint_y" name="use_constraint_yn" value="Y" />
											<label for="use_constraint_y">사용</label>
											<input type="radio" id="use_constraint_n" name="use_constraint_yn" value="N" />
											<label for="use_constraint_n">사용안함</label>
										</td>
									</tr>
																					
									<tr>
										<td class="col-input">
											<label for="allow_counter">건수</label>
										</td>
										<td class="col-input" colspan="3">
											<form:input path="allow_counter" cssClass="s" maxlength="5" />
											<span class="table-desc">회 (사용 가능)</span>
										</td>
									</tr>
																		
									<tr>
										<td class="col-input">
											<label for="use_start_day">날짜</label>
										</td>
										<td class="col-input" colspan="3">
											<form:input path="use_start_day" cssClass="s date" />
											<span class="delimeter tilde">~</span>
											<form:input path="use_end_day" cssClass="s date" />
										</td>
									</tr>
									
									<tr>
										<td class="col-input">
											<label for="use_monday_yn">요일</label>
										</td>
										<td class="col-input checkbox-set" colspan="3">
											<input type="checkbox" id="use_monday_yn" name="use_monday_yn" />
											<label for="use_monday_yn">월</label>
											<input type="checkbox" id="use_tuesday_yn" name="use_tuesday_yn" />
											<label for="use_tuesday_yn">화</label>
											<input type="checkbox" id="use_wednesday_yn" name="use_wednesday_yn" />
											<label for="use_wednesday_yn">수</label>
											<input type="checkbox" id="use_thursday_yn" name="use_thursday_yn" />
											<label for="use_thursday_yn">목</label>
											<input type="checkbox" id="use_friday_yn" name="use_friday_yn" />
											<label for="use_friday_yn">금</label>
											<input type="checkbox" id="use_saturday_yn" name="use_saturday_yn" />
											<label for="use_saturday_yn">토</label>
											<input type="checkbox" id="use_sunday_yn" name="use_sunday_yn" />
											<label for="use_sunday_yn">일</label>
										</td>
									</tr>
									
									<tr>
										<td class="col-input">
											<label for="use_start_hour">시간</label>
										</td>
										<td class="col-input" colspan="3">
											<select id="use_start_hour" name="use_start_hour" class="select">
							  					<option value="">시간</option>
							  				</select>
											<span class="delimeter">:</span>
											<select id="use_start_minute" name="use_start_minute" class="select">
							  					<option value="">분</option>
							  				</select>
											<span class="delimeter">~</span>
											<select id="use_end_hour" name="use_end_hour" class="select">
							  					<option value="">시간</option>
							  				</select>
											<span class="delimeter">:</span>
											<select id="use_end_minute" name="use_end_minute" class="select">
							  					<option value="">분</option>
							  				</select>
										</td>
									</tr>
								</table>
								</form:form>
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
											<th class="col-number" scope="col">우선순위</th>
											<th class="col-name" scope="col">사용기기명</th>
											<th class="col-type" scope="col">타입</th>
											<th class="col-ip" scope="col">접속 IP</th>
											<th class="col-toggle" scope="col">사용여부</th>
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
								<a href="/user/list-user.do?${listParameters}" class="button">목록</a>
								<a href="/user/modify-user.do?user_id=${userInfo.user_id }&amp;${listParameters}" class="button">수정</a>
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
		
		$("[name=otp_use_yn]").filter("[value='${userOTP.otp_use_yn}']").prop("checked",true);
		$("[name=otp_type]").filter("[value='${userOTP.otp_type}']").prop("checked",true);
		
		$("#mobile_app_key").attr("disabled", true);
		
		// OTP 접속 제어 날짜 및 시간, 요일 설정
		initOTPUseTime();
		$("#use_start_hour").val("${userOTP.use_start_hour}");
		$("#use_start_minute").val("${userOTP.use_start_minute}");
		$("#use_end_hour").val("${userOTP.use_end_hour}");
		$("#use_end_minute").val("${userOTP.use_end_minute}");
		
		$( ".select" ).selectmenu();
		
		$("#otp_use_y").attr("disabled", true);
		$("#otp_use_n").attr("disabled", true);
		$("#otp_type_app").attr("disabled", true);
		$("#otp_type_sms").attr("disabled", true);
		$("#otp_type_pc").attr("disabled", true);
		$("#otp_type_email").attr("disabled", true);
		$("#otp_type_messanger").attr("disabled", true);
		$("#otp_type_token").attr("disabled", true);
		$("#otp_type_radius").attr("disabled", true);
		
		$("#use_start_day").attr("disabled", true);
		$("#use_end_day").attr("disabled", true);
		$("#use_start_hour").attr("disabled", true);
		$("#use_start_minute").attr("disabled", true);
		$("#use_end_hour").attr("disabled", true);
		$("#use_end_minute").attr("disabled", true);
		$("[name=use_constraint_yn]").filter("[value='${userOTP.use_constraint_yn}']").prop("checked",true);
		if("${userOTP.use_monday_yn}" == "Y") {
			$("[name=use_monday_yn]").prop("checked",true);
		}
		if("${userOTP.use_tuesday_yn}" == "Y") {
			$("[name=use_tuesday_yn]").prop("checked",true);
		}
		if("${userOTP.use_wednesday_yn}" == "Y") {
			$("[name=use_wednesday_yn]").prop("checked",true);
		}
		if("${userOTP.use_thursday_yn}" == "Y") {
			$("[name=use_thursday_yn]").prop("checked",true);
		}
		if("${userOTP.use_friday_yn}" == "Y") {
			$("[name=use_friday_yn]").prop("checked",true);
		}
		if("${userOTP.use_saturday_yn}" == "Y") {
			$("[name=use_saturday_yn]").prop("checked",true);
		}
		if("${userOTP.use_sunday_yn}" == "Y") {
			$("[name=use_sunday_yn]").prop("checked",true);
		}
		
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
	
	// 시작/종료 날짜의 시간/분 값 설정
	function initOTPUseTime() {
		for(var i=0; i<24; i++) {
			if(i < 10) {
				$("#use_start_hour").append("<option value='0"+ i +"'>0" + i + "</option>");
				$("#use_end_hour").append("<option value='0"+ i +"'>0" + i + "</option>");
			} else {
				$("#use_start_hour").append("<option value='"+ i +"'>" + i + "</option>");
				$("#use_end_hour").append("<option value='"+ i +"'>" + i + "</option>");
			}
		}
		for(var i=0; i<60; i++) {
			if(i < 10) {
				$("#use_start_minute").append("<option value='0"+ i +"'>0" + i + "</option>");
				$("#use_end_minute").append("<option value='0"+ i +"'>0" + i + "</option>");
			} else {
				$("#use_start_minute").append("<option value='"+ i +"'>" + i + "</option>");
				$("#use_end_minute").append("<option value='"+ i +"'>" + i + "</option>");
			}
		}
	}
</script>
</body>
</html>