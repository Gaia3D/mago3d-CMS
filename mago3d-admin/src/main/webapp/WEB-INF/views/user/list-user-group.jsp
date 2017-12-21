<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link type="text/css" rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link type="text/css" rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link type="text/css" rel="stylesheet" href="/css/${lang}/style.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/font-awesome.min.css" />	
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXJ.min.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXButton.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXInput.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXSelect.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXTree.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXJ.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXInput.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXModal.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXSelect.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXTree.js"></script>
	<script type="text/javascript" src="/js/${lang}/userGroupTree.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
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
						<div class="content-header row">
							<h3 class="content-title u-pull-left"><spring:message code='user.group.usergroup'/> (<a href="#" onclick="reloadUserGroupCache();"><spring:message code='user.group.cache.update'/></a>)</h3>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='user.group.check.mark'/></div>
						</div>
						<div class="row">
							<div class="one-third column">
								<div id="AXTreeTarget" class="tree"></div>
								<button type="button" class="btn btn-success btn-sm" onclick="addTree(); return false;"><spring:message code='user.group.add'/></button>
								<button type="button" class="btn btn-warning btn-sm" onclick="addChildTree(); return false;"><spring:message code='user.group.add.submenu'/></button>
								<button type="button" class="btn btn-danger btn-sm" onclick="delTree(); return false;"><spring:message code='user.group.select.delete'/></button>
<!-- 								<button type="button" class="btn btn-success btn-sm" onclick="updateTree(); return false;">수정</button> -->
								<button type="button" class="btn btn-warning btn-sm" onclick="moveUpTree(); return false;"><spring:message code='user.group.up'/></button>
								<button type="button" class="btn btn-danger btn-sm" onclick="moveDownTree(); return false;"><spring:message code='user.group.down'/></button>
							</div>
							<div class="two-third column">
								<div class="node">
									<div class="info">
										<form name="userGroupForm" id="userGroupForm" method="post" onsubmit="return false;">
											<input type="hidden" id="writeMode" name="writeMode" value="" />
											<input type="hidden" id="user_group_id" name="user_group_id" value="" />
											<input type="hidden" id="parent" name="parent" value="" />
											<input type="hidden" id="depth" name="depth" value="" /> 
											<input type="hidden" id="view_order" name="view_order" value="1" />
											<input type="hidden" id="update_type" name="update_type" value="" />
										<table class="input-table scope-row">
											<col class="col-label" />
											<col class="col-input" />
											<tr>
												<th class="col-label" scope="row">
													<label for="group_name"><spring:message code='user.group.name'/></label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="group_name" name="group_name" value="" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="group_key"><spring:message code='user.group.user.group.en'/></label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="group_key" name="group_key" value="" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<span><spring:message code='user.group.use.not'/></span>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input radio-set">
													<input type="radio" id="use_y" name="use_yn" value="Y" />
													<label for="use_y"><spring:message code='user.group.use'/></label>
													<input type="radio" id="use_n" name="use_yn" value="N" />
													<label for="use_n"><spring:message code='user.group.stop'/></label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="description"><spring:message code='user.group.description'/></label></th>
												<td class="col-input"><input type="text" id="description" name="description" value="" class="l"/></td>
											</tr>
											<tr>
												<td colspan="2">
													<div class="button-group u-pull-left">
														<input type="submit" value="<spring:message code='user.group.save'/>" onclick="appendTree();"/>
														<input type="reset" value="<spring:message code='user.group.cancel'/>" />
													</div>
													<div class="button-group u-pull-right">
														<a href="#" class="button" onclick="modifyUserGroupRole();"><spring:message code='user.group.control.roll'/></a>
														<a href="#" class="button" onclick="modifyUserGroupMenu();"><spring:message code='user.group.control.menu'/></a>
														<a href="#" class="button" onclick="modifyUserGroupUser();"><spring:message code='user.group.control.user'/></a>
													</div>
												</td>
											</tr>
										</table>
										</form>
									</div>
											
									<div class="tabs">
										<ul>
											<li><a href="#role_tab"><spring:message code='user.group.role'/></a></li>
											<li><a href="#menu_tab"><spring:message code='user.group.menu'/></a></li>
											<li><a href="#user_tab"><spring:message code='user.group.user'/></a></li>
										</ul>
										<div id="role_tab">
											<table class="inner-table scope-col">
												<col class="col-numer" />
												<col class="col-name" />
												<col class="col-key" />
												<col class="col-toggle" />
												<col class="col-desc" />
												<col class="col-date-time" />
												<thead>
													<tr>
														<th scope="col" class="col-number"><spring:message code='user.group.number'/></th>
														<th scope="col" class="col-name"><spring:message code='user.group.role.name'/></th>
														<th scope="col" class="col-key"><spring:message code='user.group.role.key'/></th>
														<th scope="col" class="col-toggle"><spring:message code='user.group.use.not'/></th>
														<th scope="col" class="col-desc"><spring:message code='user.group.description'/></th>
														<th scope="col" class="col-date-time"><spring:message code='user.group.insert.date'/></th>
													</tr>
												</thead>
												<tbody id="role_list">
													<tr>
														<td colspan="6" class="col-none"><spring:message code='user.group.role.insert.not'/></td>
													</tr>
												</tbody>
											</table>
						
											<div id="role_pagination" class="pagination"></div>
										</div>
										
										<div id="menu_tab">
											<table class="inner-table scope-col">
												<col class="col-numer" />
												<col class="col-name" />
												<col class="col-toggle" />
												<col class="col-url" />
												<col class="col-url" />
												<col class="col-desc" />
												<col class="col-desc" />
												<col class="col-date-time" />
												<thead>
													<tr>
														<th scope="col" class="col-number"><spring:message code='user.group.number'/></th>
														<th scope="col" class="col-name"><spring:message code='user.group.role.name'/></th>
														<th scope="col" class="col-toggle"><spring:message code='user.group.use.not'/></th>
														<th scope="col" class="col-url"><spring:message code='user.group.menu.url'/></th>
														<th scope="col" class="col-url"><spring:message code='user.group.menu.image'/></th>
														<th scope="col" class="col-desc"><spring:message code='user.group.menu.image.alt'/></th>
														<th scope="col" class="col-desc"><spring:message code='user.group.description'/></th>
														<th scope="col" class="col-date-time"><spring:message code='user.group.insert.date'/></th>
													</tr>
												</thead>
												<tbody id="menu_list">
													<tr>
														<td colspan="8" class="col-none"><spring:message code='user.group.menu.insert.not'/></td>
													</tr>
												</tbody>
											</table>
											<div id="menu_pagination" class="pagination"></div>
										</div>
										
										<div id="user_tab">
											<table class="inner-table scope-col">
												<col class="col-numer" />
												<col class="col-id" />
												<col class="col-name" />
												<col class="col-email" />
												<col class="col-toggle" />
												<col class="col-date-time" />
												<thead>
													<tr>
														<th scope="col" class="col-number"><spring:message code='user.group.number'/></th>
														<th scope="col" class="col-id"><spring:message code='user.group.id'/></th>
														<th scope="col" class="col-name"><spring:message code='user.group.name'/></th>
														<th scope="col" class="col-email"><spring:message code='user.group.email'/></th>
														<th scope="col" class="col-toggle"><spring:message code='user.group.user.status'/></th>
														<th scope="col" class="col-date-time"><spring:message code='user.group.insert.date'/></th>
													</tr>
												</thead>
												<tbody id="user_list">
													<tr>
														<td colspan="6" class="col-none"><spring:message code='user.group.user.not'/></td>		
													</tr>
												</tbody>
											</table>
											<div id="user_pagination" class="pagination"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<!-- Role 관리 -->	
<div id="role_manager" class="dialog" title="<spring:message code='user.group.control.roll'/>">
	<div class="row">
		<!-- 전체 Role -->
		<div id="role_left" class="pool">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title"><spring:message code='user.group.role.all'/></h4>
				</div>
				<div class="u-pull-right">
					<label for="search_except_role_name"><spring:message code='user.group.role.name'/></label>
					<input type="search" id="search_except_role_name" name="search_except_role_name" class="m" value="" />
					<input type="button" value="<spring:message code='user.group.lookup'/>" onclick="drawGroupPage('1', 'role_all');" />
				</div>
				<div id="role_all_list_count" class="list-desc u-pull-left">
				</div>
			</div>
		
			<form id="role_left_form"> 			
			<table class="list-table scope-col">
				<col class="col-checkbox" />
				<col class="col-name" />
				<col class="col-toggle" />
				<thead>
					<tr>
						<th scope="col" class="col-checkbox"><input type="checkbox" id="role_left_check_all" name="role_left_check_all" /></th>
						<th scope="col" class="col-name"><spring:message code='user.group.role.name.key'/></th>
						<th scope="col" class="col-toggle" style="min-width: 50px;"><spring:message code='user.group.use.not'/></th>
					</tr>
				</thead>
				<tbody id="role_all_list">
				</tbody>
			</table>
			<div id="role_all" class="pagination"></div>
			</form>
		</div>
		
		<!-- 사용자 그룹에 등록되어 있는 Role -->
		<div id="role_right" class="chosen">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title"><spring:message code='user.group.role.insert.select.group'/></h4>
				</div>
				<div class="u-pull-right">
					<label for="search_role_name"><spring:message code='user.group.role.name'/></label>
					<input type="search" id="search_role_name" name="search_role_name" class="m" value="" />
					<input type="button" value="<spring:message code='user.group.lookup'/>" onclick="drawGroupPage('1', 'role_select');" />
				</div>
				<div id="role_select_list_count" class="list-desc u-pull-left">
				</div>
			</div>
			
			<form id="role_right_form">
			<table class="list-table scope-col">
				<col class="col-checkbox" />
				<col class="col-name" />
				<col class="col-toggle" />
				<thead>
					<tr>
						<th scope="col" class="col-checkbox"><input type="checkbox" id="role_right_check_all" name="role_right_check_all" /></th>
						<th scope="col" class="col-name"><spring:message code='user.group.role.name.key'/></th>
						<th scope="col" class="col-toggle" style="min-width: 50px;"><spring:message code='user.group.use.not'/></th>
					</tr>
				</thead>
				<tbody id="role_select_list">
				</tbody>
			</table>
			<div id="role_select" class="pagination"></div>
			</form>
		</div>
		<div id="role_center" class="buttons">
			<a href="#" id="role_button_insert" class="button color-area-em">
				<span class="icon-glyph glyph-plus"></span>
				<span class="icon-text"><spring:message code='user.group.role.insert'/></span>
			</a>
			<a href="#" id="role_button_delete" class="button color-area-em">
				<span class="icon-glyph glyph-ex"></span>
				<span class="icon-text"><spring:message code='user.group.role.delete'/></span>
			</a>
		</div>
	</div>
</div>

<!-- 사용자 관리 -->	
<div id="user_manager" class="user_dialog" title="<spring:message code='user.group.control.user'/>">
	<div class="row">
		<!-- 전체 사용자 -->
		<div id="user_left" class="pool">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title"><spring:message code='user.group.user.all.user'/></h4>
				</div>
				<div class="u-pull-right">
					<label for="search_except_user_name"><spring:message code='user.group.id'/></label>
					<input type="search" id="search_except_user_name" name="search_except_user_name" class="m" value="" />
					<input type="button" value="<spring:message code='user.group.lookup'/>" onclick="drawGroupPage('1', 'user_all');" />
				</div>
				<div id="user_all_list_count" class="list-desc u-pull-left">
				</div>
			</div>
		
			<form id="user_left_form"> 			
			<table class="list-table scope-col">
				<col class="col-checkbox" />
				<col class="col-name" />
				<col class="col-toggle" />
				<thead>
					<tr>
						<th scope="col" class="col-checkbox"><input type="checkbox" id="user_left_check_all" name="user_left_check_all" /></th>
						<th scope="col" class="col-name"><spring:message code='user.group.id'/></th>
						<th scope="col" class="col-toggle"><spring:message code='user.group.user.name'/></th>
					</tr>
				</thead>
				<tbody id="user_all_list">
				</tbody>
			</table>
			<div id="user_all" class="pagination"></div>
			</form>
		</div>
		
		<!-- 그룹에 등록되어 있는 사용자 -->
		<div id="user_right" class="chosen">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title"><spring:message code='user.group.user.insert.user'/></h4>
				</div>
				<div class="u-pull-right">
					<label for="search_user_name"><spring:message code='user.group.id'/></label>
					<input type="search" id="search_user_name" name="search_user_name" class="m" value="" />
					<input type="button" value="<spring:message code='user.group.lookup'/>" onclick="drawGroupPage('1', 'user_select');" />
				</div>
				<div id="user_select_list_count" class="list-desc u-pull-left">
				</div>
			</div>
			
			<form id="user_right_form">
			<table class="list-table scope-col">
				<col class="col-checkbox" />
				<col class="col-name" />
				<col class="col-toggle" />
				<thead>
					<tr>
						<th scope="col" class="col-checkbox"><input type="checkbox" id="user_right_check_all" name="user_right_check_all" /></th>
						<th scope="col" class="col-name"><spring:message code='user.group.id'/></th>
						<th scope="col" class="col-toggle"><spring:message code='user.group.user.name'/></th>
					</tr>
				</thead>
				<tbody id="user_select_list">
				</tbody>
			</table>
			<div id="user_select" class="pagination"></div>
			</form>
		</div>
		<div id="role_center" class="buttons">
			<a href="#" id="user_button_insert" class="button color-area-em">
				<span class="icon-glyph glyph-plus"></span>
				<span class="icon-text"><spring:message code='user.group.role.insert'/></span>
			</a>
			<a href="#" id="user_button_delete" class="button color-area-em">
				<span class="icon-glyph glyph-ex"></span>
				<span class="icon-text"><spring:message code='user.group.role.delete'/></span>
			</a>
		</div>
	</div>
</div>
<script type="text/javascript">
		var USER_GROUP_TREE_DATA = null;
    $(document).ready(function() {
    	getAjaxUserGroupList();
    	fnObj.pageStart.delay(0.1);
		$( ".tabs" ).tabs();
	});
    
    // 등록 가능한 Role 전체 선택 
	$("#role_left_check_all").click(function() {
		$(':checkbox[name=role_all_id]').prop('checked', this.checked);
	});
    // 등록된 Role 전체 선택 
	$("#role_right_check_all").click(function() {
		$(':checkbox[name=role_select_id]').prop('checked', this.checked);
	});
	// 등록 가능한 사용자 전체 선택 
	$("#user_left_check_all").click(function() {
		$(':checkbox[name=user_all_id]').prop('checked', this.checked);
	});
    // 등록된 사용자 전체 선택 
	$("#user_right_check_all").click(function() {
		$(':checkbox[name=user_select_id]').prop('checked', this.checked);
	});
	
	var roleDialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 700,
		width: 1000,
		modal: true,
		resizable: false
	});
	var userDialog = $( ".user_dialog" ).dialog({
		autoOpen: false,
		height: 700,
		width: 1000,
		modal: true,
		resizable: false
	});
	
	// 전체 Role 검색, enter key 
	$("#search_except_role_name").keydown(function (key) {
	    if (key.keyCode == 13) {
			drawGroupPage('1', 'role_all');
	    }
	});
	// 등록 Role 검색, enter key
	$("#search_role_name").keydown(function (key) {
	    if (key.keyCode == 13) {
			drawGroupPage('1', 'role_select');
	    }
	});
	// 전체 사용자 검색, enter key 
	$("#search_except_user_name").keydown(function (key) {
	    if (key.keyCode == 13) {
			drawGroupPage('1', 'user_all');
	    }
	});
	// 등록 사용자 검색, enter key
	$("#search_user_name").keydown(function (key) {
	    if (key.keyCode == 13) {
			drawGroupPage('1', 'user_select');
	    }
	});
	
	// Role 관리 팝업
    function modifyUserGroupRole() {
    	if ($("#user_group_id").val() == "") {
    		alert(JS_MESSAGE["user.group.select"]);
    		return;
    	}
    	if ($("#depth").val() == "" || parseInt($("#depth").val()) < 1) {
    		alert(JS_MESSAGE["user.group.role.top.not.insert"]);
    		return;
    	}
    	
    	roleDialog.dialog( "open" );
    	// 사용자 그룹 전체 Role 에서 선택한 사용자 그룹에 등록된 Role 을 제외한 Role 목록
    	ajaxListExceptUserGroupRoleForUpdate(1);
    	// 선택한 사용자 그룹에 등록된 Role 목록
    	ajaxListUserGroupRoleForUpdate(1);
	}
 	// 메뉴 관리
    function modifyUserGroupMenu() {
 		alert(JS_MESSAGE["commingsoon"]);
 	}
 	// 사용자 관리
    function modifyUserGroupUser() {
    	if ($("#user_group_id").val() == "") {
    		alert(JS_MESSAGE["user.group.select"] );
    		return;
    	}
    	if ($("#depth").val() == "" || parseInt($("#depth").val()) < 1) {
    		alert(JS_MESSAGE["user.group.top.not.insert"]);
    		return;
    	}
    	userDialog.dialog( "open" );
    	// 선택한 사용자 그룹에 등록된 User 목록
    	ajaxListUserGroupUserByGroupId(1);
    	// 사용자 그룹 전체 User 에서 선택한 사용자 그룹에 등록된 User 을 제외한 User 목록
    	ajaxListExceptUserGroupUserByGroupId(1);
	}
	
	// Role 등록
    $("#role_button_insert").click(function() {
    	$("#role_left_check_all").prop("checked",  false);
    	ajaxInsertUserGroupRole();
    });
 	// 사용자 등록
    $("#user_button_insert").click(function() {
    	$("#user_left_check_all").prop("checked",  false);
    	ajaxInsertUserGroupUser();
    });
	// Role 제거
    $("#role_button_delete").click(function() {
    	$("#role_right_check_all").prop("checked",  false);
    	ajaxDeleteUserGroupRole();
    });
 	// 사용자 제거
    $("#user_button_delete").click(function() {
    	$("#user_right_check_all").prop("checked",  false);
    	ajaxDeleteUserGroupUser();
    });
	
	// 사용자 그룹 등록된 Role 목록
    function ajaxListUserGroupRole(pageNo) {
    	$.ajax({
    		url: "/role/ajax-list-user-group-role.do",
    		data: { user_group_id : $("#user_group_id").val(), pageNo : pageNo },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				drawListUserGroupRole(msg.listUserGroupRole, msg.pagination);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
 	// 사용자 그룹 등록된 사용자 목록
    function ajaxListUserGroupUser(pageNo) {
 		$.ajax({
    		url: "/user/ajax-list-user-group-user.do",
    		data: { user_group_id : $("#user_group_id").val(), pageNo : pageNo },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == "success") {
    				drawListUserGroupUser(msg.pagination, msg.userList);
				} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error) {
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	// 사용자 그룹 전체 Role 에서 선택한 사용자 그룹에 등록된 Role 을 제외한 Role 목록
	function ajaxListExceptUserGroupRoleForUpdate(pageNo) {
 		var search_except_role_name = $("#search_except_role_name").val();
 		if(search_except_role_name != null && search_except_role_name != "") {
 			search_except_role_name = encodeURIComponent(search_except_role_name);
 		}
		$("#role_all_list").empty();
    	$.ajax({
    		url: "/role/ajax-list-except-user-group-role-for-update.do",
    		data: { user_group_id : $("#user_group_id").val(), pageNo : pageNo, search_except_role_name : search_except_role_name },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == 'success') {
    				drawListUserGroupRoleForUpdate(msg.listExceptUserGroupRoleByGroupId, msg.pagination, "role_all");
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	// 선택한 사용자 그룹에 등록된 Role 목록
	function ajaxListUserGroupRoleForUpdate(pageNo) {
 		var search_role_name = $("#search_role_name").val();
 		if(search_role_name != null && search_role_name != "") {
 			search_role_name = encodeURIComponent(search_role_name);
 		}
    	$("#role_select_list").empty();
    	$.ajax({
    		url: "/role/ajax-list-user-group-role-for-update.do",
    		data: { user_group_id : $("#user_group_id").val(), pageNo : pageNo, search_role_name : search_role_name },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == 'success') {
    				drawListUserGroupRoleForUpdate(msg.listUserGroupRole, msg.pagination, "role_select");
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	// 사용자 그룹 전체 User 에서 선택한 사용자 그룹에 등록된 User 를 제외한 User 목록
	function ajaxListExceptUserGroupUserByGroupId(pageNo) {
 		var search_except_user_name = $("#search_except_user_name").val();
 		if(search_except_user_name != null && search_except_user_name != "") {
 			search_except_user_name = encodeURIComponent(search_except_user_name);
 		}
 		$("#user_all_list").empty();
    	$.ajax({
    		url: "/user/ajax-list-except-user-group-user-by-group-id.do",
    		data: { user_group_id : $("#user_group_id").val(), pageNo : pageNo, search_except_user_name : search_except_user_name },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == 'success') {
    				drawListUserGroupUserByGroupId(msg.pagination, msg.userList, "user_all");
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
	// 선택한 사용자 그룹에 등록된 User 목록
	function ajaxListUserGroupUserByGroupId(pageNo) {
 		var search_user_name = $("#search_user_name").val();
 		if(search_user_name != null && search_user_name != "") {
 			search_user_name = encodeURIComponent(search_user_name);
 		}
 		$("#user_select_list").empty();
    	$.ajax({
    		url: "/user/ajax-list-user-group-user-by-group-id.do",
    		data: { user_group_id : $("#user_group_id").val(), pageNo : pageNo, search_user_name : search_user_name },
    		type: "POST",
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if (msg.result == 'success') {
    				drawListUserGroupUserByGroupId(msg.pagination, msg.userList, "user_select");
    			} else {
    				alert(JS_MESSAGE[msg.result]);
    			}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
    // 사용자 그룹내 Role 추가
    function ajaxInsertUserGroupRole() {
    	var user_group_id = $("#user_group_id").val()
    	if (user_group_id == "") {
    		alert(JS_MESSAGE["user.group.not.group.id"]);
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=role_all_id]"));
    	if (!status) {
			alert(JS_MESSAGE["user.group.not.select"]);
			return;
		}
    	var param = $("#role_left_form").serialize() + "&user_group_id=" + user_group_id;
    	$.ajax({
    		url: "/role/ajax-insert-user-group-role.do",
    		type: "POST",
    		data: param,
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if(msg.result == "success") {
					alert(JS_MESSAGE["update"]);
					ajaxListUserGroupRole(1);
					ajaxListUserGroupRoleForUpdate(1);
			    	ajaxListExceptUserGroupRoleForUpdate(1);
				}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
 	// 사용자 그룹내 사용자 추가
    function ajaxInsertUserGroupUser() {
    	var user_group_id = $("#user_group_id").val()
    	if (user_group_id == "") {
    		alert(JS_MESSAGE["user.group.not.group.id"]);
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=user_all_id]"));
    	if (!status) {
			alert(JS_MESSAGE["user.group.not.select"]);
			return;
		}
    	var param = $("#user_left_form").serialize() + "&user_group_id=" + user_group_id;
    	$.ajax({
    		url: "/user/ajax-insert-user-group-user.do",
    		type: "POST",
    		data: param,
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if(msg.result == "success") {
					alert(JS_MESSAGE["update"]);
					ajaxListUserGroupUser(1);
					ajaxListUserGroupUserByGroupId(1);
			    	ajaxListExceptUserGroupUserByGroupId(1);
				}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
    
    // 사용자 그룹내 Role 삭제
    function ajaxDeleteUserGroupRole() {
    	var user_group_id = $("#user_group_id").val()
    	if (user_group_id == "") {
    		alert(JS_MESSAGE["user.group.not.group.id"]);
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=role_select_id]"));
    	if (!status) {
			alert(JS_MESSAGE["user.group.not.select"]);
			return;
		}
    	var param = $("#role_right_form").serialize() + "&user_group_id=" + user_group_id;
    	$.ajax({
    		url: "/role/ajax-delete-user-group-role.do",
    		type: "POST",
    		data: param,
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if(msg.result == "success") {
    				alert(JS_MESSAGE["delete"]);
					ajaxListUserGroupRole(1);
			    	ajaxListUserGroupRoleForUpdate(1);
					ajaxListExceptUserGroupRoleForUpdate(1);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
 	// 사용자 그룹내 사용자 삭제
    function ajaxDeleteUserGroupUser() {
    	var user_group_id = $("#user_group_id").val()
    	if (user_group_id == "") {
    		alert(JS_MESSAGE["user.group.not.group.id"]);
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=user_select_id]"));
    	if (!status) {
			alert(JS_MESSAGE["user.group.not.select"]);
			return;
		}
    	var param = $("#user_right_form").serialize() + "&user_group_id=" + user_group_id;
    	$.ajax({
    		url: "/user/ajax-delete-user-group-user.do",
    		type: "POST",
    		data: param,
    		cache: false,
    		async:false,
    		dataType: "json",
    		success: function(msg){
    			if(msg.result == "success") {
    				alert(JS_MESSAGE["delete"]);
					ajaxListUserGroupUser(1);
					ajaxListUserGroupUserByGroupId(1);
			    	ajaxListExceptUserGroupUserByGroupId(1);
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
    		},
    		error:function(request,status,error){
    			alert(JS_MESSAGE["ajax.error.message"]);
    		}
    	});
    }
    
    // 체크박스 선택여부 
    function checkedStatus(element) {
		var returnVal = true;
		var checkStatusVal = 0;
		
		$.each(element, function(index) {			
			if (element[index].checked == true) {
				checkStatusVal++;
			}
		});
		
		if (checkStatusVal == 0) {
			returnVal = false;
		}		
		return returnVal; 
	}
    
 	// 캐시 갱신
    var cacheFlag = true;
	function reloadUserGroupCache() {
		if(cacheFlag) {
			cacheFlag = false;
			var info = "service_name=userGroup";
			$.ajax({
				url: "/common/ajax-reload-config-cache.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					cacheFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
			        cacheFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// Role 관리 팝업 목록
	function drawListUserGroupRoleForUpdate(JsonData, pagination, type) {
		var listUserGroupRole = JsonData;
		var content = "";
		if (listUserGroupRole != null && listUserGroupRole.length > 0) {
			for(i=0; i<listUserGroupRole.length; i++ ) {
				var userGroupRole = null;
				userGroupRole = listUserGroupRole[i];
				content += 	"<tr>"
						+		"<td class=\"col-checkbox\"><input type=\"checkbox\" id=\"role_id_" + userGroupRole.role_id + "\" name=\"" + type + "_id\" value=\"" + userGroupRole.role_id + "\" /></td>"
						+ 		"<td class=\"col-name\">" + userGroupRole.role_name + "(" + userGroupRole.role_key + ")</td>"
						+ 		"<td class=\"col-toggle\">" + userGroupRole.viewUseYn + "</td>"
						+ 	"</tr>";
			}
		} else {
			content += 	"<tr>"
				+		"<td colspan=\"3\" class=\"col-none\"><spring:message code='user.group.user.not'/></td>"
				+	"</tr>";
		}
		$("#" + type + "_list").empty();
		$("#" + type + "_list").html(content);
		$("#" + type + "_list_count").empty();
		$("#" + type + "_list_count").html("<spring:message code='user.group.all.count'/> <em>" + pagination.totalCount + "</em><spring:message code='user.group.all.count.key'/>");
		
		drawPage(pagination, type, type);
	}
	
	// 사용자 관리 팝업 목록
	function drawListUserGroupUserByGroupId(pagination, userList, type) {
		var userList = userList;
		var content = "";
		if (userList != null && userList.length > 0) {
			for(i=0; i<userList.length; i++ ) {
				var userInfo = null;
				userInfo = userList[i];
				content			+= 	"<tr>"
								+		"<td class=\"col-checkbox\"><input type=\"checkbox\" id=\"user_id_" + userInfo.user_id + "\" name=\"" + type + "_id\" value=\"" + userInfo.user_id + "\" /></td>"
								+ 		"<td class=\"col-name\">" + userInfo.user_id + "</td>"
								+ 		"<td class=\"col-toggle\">" + userInfo.user_name + "</td>"
								+ 	"</tr>";
			}
		} else {
			content += 	"<tr>"
					+		"<td colspan=\"3\" class=\"col-none\"><spring:message code='user.group.user.not'/></td>"
					+	"</tr>";
		}
		
		$("#" + type + "_list").empty();
		$("#" + type + "_list").html(content);
		$("#" + type + "_list_count").empty();
		$("#" + type + "_list_count").html("<spring:message code='user.group.all.count'/> <em>" + pagination.totalCount + "</em><spring:message code='user.group.all.count.key'/>");
		
		drawPage(pagination, type, type);
	}
	
	// 선택 그룹 Role 목록
	function drawListUserGroupRole(jsonData, pagination) {
		var listUserGroupRole = jsonData;
		var content = "";
		if (listUserGroupRole != null && listUserGroupRole.length > 0) {
			for(i=0; i<listUserGroupRole.length; i++ ) {
				var userGroupRole = null;
				userGroupRole = listUserGroupRole[i];
				content += 	"<tr>"
						+		"<td class=\"col-number\">" + (i + 1) + "</td>"
						+ 		"<td class=\"col-name\">" + userGroupRole.role_name + "</td>"
						+ 		"<td class=\"col-key\">" + userGroupRole.role_key + "</td>"
						+ 		"<td class=\"col-toggle\">" + userGroupRole.viewUseYn + "</td>"
						+ 		"<td class=\"col-desc\">" + userGroupRole.description + "</td>"
						+ 		"<td class=\"col-date-time\">" + userGroupRole.viewInsertDate + "</td>"
						+ 	"</tr>";
			}
		} else {
			content += 	"<tr>"
					+		"<td colspan=\"6\" class=\"col-none\"><spring:message code='user.group.role.insert.not'/></td>"
					+	"</tr>";
		}
		$("#role_list").empty();
		$("#role_list").html(content);
		$("#role_select_list_count").empty();
		$("#role_select_list_count").html("<spring:message code='user.group.all.count'/> <em>" + pagination.totalCount + "</em><spring:message code='user.group.all.count.key'/>");
		drawPage(pagination, "role_list", "role_pagination");
	}
	
	// 선택 그룹 User 목록
	function drawListUserGroupUser(pagination, jsonData) {
		var userList = jsonData;
		var content = "";
		if (userList != null && userList.length > 0) {
			for(i=0; i<userList.length; i++ ) {
				var userInfo = null;
				userInfo = userList[i];
				content += 	"<tr>"
						+		"<td class=\"col-number\">" + (i + 1) + "</td>"
						+ 		"<td class=\"col-id\">" + userInfo.user_id + "</td>"
						+ 		"<td class=\"col-name\">" + userInfo.user_name + "</td>"
						+ 		"<td class=\"col-email\">" + userInfo.email + "</td>"
						+ 		"<td class=\"col-toggle\">" + userInfo.status + "</td>"
						+ 		"<td  class=\"col-date-time\">" + userInfo.insert_date + "</td>"
						+ 	"</tr>";
			}
		} else {
			content += 	"<tr>"
					+		"<td colspan=\"6\" class=\"col-none\"><spring:message code='user.group.user.not'/></td>"
					+	"</tr>";
		}
		$("#user_list").empty();
		$("#user_list").html(content);
		$("#user_select_list_count").empty();
		$("#user_select_list_count").html("<spring:message code='user.group.all.count'/> <em>" + pagination.totalCount + "</em><spring:message code='user.group.all.count.key'/>");
		drawPage(pagination, "user_list", "user_pagination");
	}
	
 	function drawGroupPage(page, group) {
 		if(group == "role_all") {
 			ajaxListExceptUserGroupRoleForUpdate(page);
 		} else if(group == "role_select") {
 			ajaxListUserGroupRoleForUpdate(page);
 		} else if(group == "role_list") {
 			ajaxListUserGroupRole(page);
 		} else if(group == "user_all") {
 			ajaxListExceptUserGroupUserByGroupId(page);
 		} else if(group == "user_select") {
 			ajaxListUserGroupUserByGroupId(page);
		} else if(group == "user_list") {
 			ajaxListUserGroupUser(page);
		}
 	}
 	
 	function drawParent(type) {
 		$("#" + type + "_list").empty();						
		$("#" + type + "_pagination").empty();
		
		var colspan = "6";
		if(type == "role") colspan = "6";
		else if(type == "menu") colspan = "8";
		else if(type == "user") colspan = "6";
		var content = "";
		content += 	"<tr>"
				+		"<td colspan=\"" + colspan + "\" class=\"col-none\"><spring:message code='user.list.group.no.top'/></td>"
				+	"</tr>";
		$("#" + type + "_list").html(content);
 	}
</script>
</body>
</html>