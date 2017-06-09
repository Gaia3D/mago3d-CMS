<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/jquery/jquery-ui.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/jquery/jquery-ui.theme.min.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery-1.11.2.min.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery-ui.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
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
		          	<li class="s_title"><a href="/user/list-user.do">사용자</a></li>
		          	<li class="next_img"></li>
			        <li class="s_title">사용자 그룹등록</li>
		        </ul>
		    </div>
		    
			<div id="main_content">
				<div class="input_box">
					<div class="main_content_title">
			        	<ul>
			            	<li>사용자 그룹등록
			            		<p class="nessTxt" style="font-size: 12px; font-weight:lighter; ">
			            			<span>체크</span>표시는 필수입력 항목입니다.
			            		</p>
			            	</li>
			          	</ul>
			        </div>
			        <div>
						<table class="input_area">
						<form:form id="userGroup" modelAttribute="userGroup" method="post" action="/user/insertUserGroup.do" onsubmit="return check();">
							<legend>Login Info</legend>
							<tr>
				  				<th width="25%">
							  		<form:label path="group_key" cssClass="nessItem">그룹 Key</form:label>
					 			</th>
					 			<td>
						  			<form:input path="group_key" class="input_default" />
						  			<form:errors path="group_key" cssClass="error" />
						  		</td>
					  		</tr>
					  		<tr>
					  			<th>
							  		<form:label path="name" cssClass="nessItem">그룹명</form:label>
					 			</th>
					 			<td>
						  			<form:input path="name" class="input_default" />
						  			<form:errors path="name" cssClass="error" />
						  		</td>
					  		</tr>
					  		<tr>
					  			<th>부모</th>
					 			<td>${userGroup.parent}</td>
					  		</tr>
					  		<tr>
					  			<th>깊이</th>
					 			<td>${userGroup.depth}</td>
					  		</tr>
					  		<tr>
					  			<th>순서</th>
					 			<td>
					 				<form:input path="view_order" class="input_default" />
						  			<form:errors path="view_order" cssClass="error" />
					 			</td>
					  		</tr>
					  		<tr>
					  			<th>
							  		<form:label path="use_yn">사용유무</form:label>
					 			</th>
					 			<td>
						  			<form:radiobutton path="use_yn" value="Y" label="사용" />&nbsp;&nbsp;
									<form:radiobutton path="use_yn" value="N" label="미사용" />
						  		</td>
					  		</tr>
					  		<tr>
					  			<th>
							  		<form:label path="description">설명</form:label>
					 			</th>
					 			<td>
						  			<form:input path="description" class="input_default_css" size="100" />
						  			<form:errors path="description" cssClass="error" />
						  		</td>
					  		</tr>
					  		<tr style="line-height: 40px;">
					  			<td colspan="2" style="text-align: center;">
					  				<input type="submit" value="저장" class="buttonPro purple" />
					  				<a href="/user/list-user-group.do" class="buttonPro purple">목록</a>
					  			</td>
				  			</tr>
				  		</form:form>
					 	</table>
					 </div>
				</div>
				
			</div>
			<!-- main content 종료 -->
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("input:radio[name=use_yn]:input[value='Y']").attr("checked", true);
	});
	function check() {
		if ($("#group_key").val() == "") {
			alert(JS_MESSAGE["user.group.key.empty"]);
			$("#group_key").focus();
			return false;
		}
		if ($("#name").val() == "") {
			alert(JS_MESSAGE["user.group.name.empty"]);
			$("#name").focus();
			return false;
		}
	}
</script>
</body>
</html>