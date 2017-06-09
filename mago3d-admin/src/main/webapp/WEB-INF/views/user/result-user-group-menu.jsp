<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link type="text/css" rel="stylesheet" href="/css/${lang}/layout.css" />
	<link type="text/css" rel="stylesheet" href="/css/${lang}/common.css" />
	<link type="text/css" rel="stylesheet" href="/css/${lang}/admin.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
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
			        <li class="s_title">사용자 그룹 메뉴 처리 결과</li>
		        </ul>
		    </div>
		    
			<div id="main_content">
				<div class="detail_box">
					<div class="main_content_title">
			        	<ul>
			            	<li>사용자 그룹 메뉴 처리 결과
			            	</li>
			          	</ul>
			        </div>
			        <div>
						<table class="list_table">
							<tr>
						  		<td colspan="4">
						  			${userGroup.name } 메뉴 권한이 
					<c:if test="${method_mode eq 'insert'}">등록 되었습니다.</c:if>
					<c:if test="${method_mode eq 'update'}">수정 되었습니다.</c:if>
					<c:if test="${method_mode eq 'delete'}">삭제 되었습니다.</c:if>
					  			</td>
					  		</tr>
	<c:if test="${method_mode eq 'insert' || method_mode eq 'update'}">
					  		<tr>
					  			<th scope="col" width="20%">메뉴명</th>
								<th scope="col" width="10%">사용유무</th>
								<th scope="col" width="20%">전체 권한</th>
								<th scope="col" width="*">개별 권한</th>
			 				</tr>
		<c:if test="${empty userGroupMenuList }">
							<tr>
								<td colspan="4">사용자 그룹 메뉴 권한 목록이 존재하지 않습니다.</td>
							</tr>
		</c:if>
		<c:if test="${!empty userGroupMenuList }">
			<c:forEach var="userGroupMenu" items="${userGroupMenuList}" varStatus="status">
				<c:if test="${userGroupMenu.depth == 1 }"> 
					<c:set var="menuPadding" value="15px;" />
					<c:set var="toggleClass" value="" />
					<c:set var="toggleLink" value="+" />
				</c:if>
				<c:if test="${userGroupMenu.depth == 2 }"> 
					<c:set var="menuPadding" value="45px;" />
					<c:set var="toggleMenuParent" value="toggle_menu_${userGroupMenu.parent}" />
					<c:set var="toggleClass" value="toggle_menu ${toggleMenuParent}" />
					<c:set var="toggleLink" value="" />
				</c:if>
				<c:if test="${userGroupMenu.depth == 3 }"> 
					<c:set var="menuPadding" value="70px;" />
					<c:set var="toggleClass" value="toggle_menu ${toggleMenuParent}" />
					<c:set var="toggleLink" value="" />
				</c:if>
							<tr class="${toggleClass }">
			<c:if test="${userGroupMenu.depth == 1 }">
								<td style="padding-left:${menuPadding}; text-align: left;">
									<a href="#" onclick="toggleMenu('${userGroupMenu.menu_id}')">${toggleLink }</a> ${userGroupMenu.name }
								</td>
			</c:if>
			<c:if test="${userGroupMenu.depth > 1 }">
								<td style="padding-left:${menuPadding}; text-align: left;">
									${toggleLink } ${userGroupMenu.name }
								</td>
			</c:if>
								<td style="text-align: center;">${userGroupMenu.viewUseYn }</td>
								<td style="text-align: center;">
			<c:if test="${userGroupMenu.all_yn == 'Y'}">O</c:if>
			<c:if test="${userGroupMenu.all_yn == 'N'}">X</c:if>
								</td>
								<td style="padding-left:5px; text-align: left;">
									읽기(
			<c:if test="${userGroupMenu.read_yn == 'Y'}">O</c:if>
			<c:if test="${userGroupMenu.read_yn == 'N'}">X</c:if>
									) &nbsp;&nbsp;&nbsp;
									쓰기(
			<c:if test="${userGroupMenu.write_yn == 'Y'}">O</c:if>
			<c:if test="${userGroupMenu.write_yn == 'N'}">X</c:if>
									) &nbsp;&nbsp;&nbsp;
									수정(
			<c:if test="${userGroupMenu.update_yn == 'Y'}">O</c:if>
			<c:if test="${userGroupMenu.update_yn == 'N'}">X</c:if>
									) &nbsp;&nbsp;&nbsp;
									삭제(
			<c:if test="${userGroupMenu.delete_yn == 'Y'}">O</c:if>
			<c:if test="${userGroupMenu.delete_yn == 'N'}">X</c:if>
									)
								</td>
							</tr>
			</c:forEach>
		</c:if>
	</c:if>
							<tr style="line-height: 40px;">
					  			<td colspan="4" style="text-align: center;">
					  				<a href="/user/list-user-group.do" class="buttonPro purple">그룹 목록</a>
					  			</td>
					  		</tr>
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
		$(".toggle_menu").toggle();
	});

	function toggleMenu(menu_id) {
		$(".toggle_menu_" + menu_id).toggle();
	}
</script>
</body>
</html>