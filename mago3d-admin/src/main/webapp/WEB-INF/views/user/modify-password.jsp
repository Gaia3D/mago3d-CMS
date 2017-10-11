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
						<div class="input-header row">
	<c:if test="${userInfo.error_code ne null && userInfo.error_code ne ''}">					
							<div class="list-desc u-pull-left">
								<h6 style="padding-left: 10px; color: red;">* 
		<c:if test="${userInfo.error_code eq 'user.password.exception'}">
									<spring:message code='user.password.error'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.invalid'}">
									<spring:message code='user.password.policy'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.compare.invalid'}">
									<spring:message code='user.password.basic'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.exception.char'}">
									<spring:message code='user.password.special'/> ${policy.password_exception_char } <spring:message code='user.password.security'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.digit.invalid'}">
									<spring:message code='user.password.count'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.upper.invalid'}">
									<spring:message code='user.password.upper.case'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.lower.invalid'}">
									<spring:message code='user.password.lower.case'/>
		</c:if>
		<c:if test="${userInfo.error_code eq 'user.password.special.invalid'}">
									<spring:message code='user.password.special.count'/>
		</c:if>						
		<c:if test="${userInfo.error_code eq 'user.password.continuous.char.invalid'}">
									<spring:message code='user.password.continuity'/>
		</c:if>		
								</h6>
							</div>
	</c:if>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div>
						<form:form id="userInfo" modelAttribute="userInfo" method="post" action="/user/update-password.do" onsubmit="return check();">
						<table class="input-table scope-row">
							<col class="col-label" />
							<col class="col-input" />
							<tr>
								<th class="col-label" scope="row">
									<form:label path="password"><spring:message code='user.password.now'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="password" cssClass="m" />
									<form:errors path="password" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="new_password"><spring:message code='user.password.new'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="new_password" class="m" />
									<span class="table-desc"><spring:message code='user.password.capital.letter'/> ${policy.password_eng_upper_count}, <spring:message code='user.password.small.letter'/> ${policy.password_eng_lower_count},
										 <spring:message code='number'/> ${policy.password_number_count}, <spring:message code='user.password.special.characters'/> ${policy.password_special_char_count} <spring:message code='user.password.required.characters'/>
										 ${policy.password_min_length} ~ ${policy.password_max_length}<spring:message code='user.password.characters'/></span>
									<form:errors path="new_password" cssClass="error" />
								</td>
							</tr>
							<tr>
								<th class="col-label" scope="row">
									<form:label path="new_password_confirm"><spring:message code='user.password.check'/></form:label>
									<span class="icon-glyph glyph-emark-dot color-warning"></span>
								</th>
								<td class="col-input">
									<form:password path="new_password_confirm" cssClass="m" />
									 	<form:errors path="new_password_confirm" cssClass="error" />
								</td>
							</tr>
						</table>
						
						<div class="button-group">
							<div id="insertServerLink" class="center-buttons">
								<input type="submit" value="<spring:message code='user.password.change'/>" />
								<a href="/login/login.do" class="button" onclick="return laterChangePasswordConfirm();" ><spring:message code='user.password.next.change'/></a>
							</div>
						</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	function check() {
		if ($("#password").val() == "") {
			alert("현재 비밀번호를 입력하여 주십시오.");
			$("#password").focus();
			return false;
		}
		if ($("#new_password").val() == "") {
			alert("새로운 비밀번호를 입력하여 주십시오.");
			$("#new_password").focus();
			return false;
		}
		if ($("#new_password_confirm").val() == "") {
			alert("비밀번호 확인을 입력하여 주십시오.");
			$("#new_password_confirm").focus();
			return false;
		}
		if ($("#password").val() == $("#new_password").val()) {
			alert("현재 비밀번호와 일치합니다. ");
			$("#new_password").focus();
			return false;
		}
		if ($("#new_password").val() != $("#new_password_confirm").val()) {
			alert("새로운 비밀번호와 일치하지 않습니다.");
			$("#new_password_confirm").focus();
			return false;
		}	
	}

	function laterChangePasswordConfirm() {
		return confirm("다음에 변경 시 로그인 페이지로 돌아가며 서비스를 사용할 수 없습니다. 비밀번호를 다음에 변경하시겠습니까?");
	}
</script>
</body>

</html>