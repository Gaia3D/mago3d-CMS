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
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/font-awesome.min.css" />	
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXJ.min.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXButton.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXInput.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXSelect.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXTree.css" />
	<script src="/externlib/${lang}/jquery/jquery.js"></script>
	<script src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
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
							<h3 class="content-title u-pull-left">사용자 그룹 (<a href="#" onclick="reloadUserGroupCache();">캐시갱신</a>)</h3>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						</div>
						<div class="row">
							<div class="one-third column">
								<div id="AXTreeTarget" class="tree"></div>
								<button type="button" class="btn btn-success btn-sm" onclick="addTree(); return false;">추가</button>
								<button type="button" class="btn btn-warning btn-sm" onclick="addChildTree(); return false;">하위메뉴추가</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="delTree(); return false;">선택삭제</button>
								<!-- <button type="button" class="btn btn-success btn-sm" onclick="updateTree(); return false;">수정</button> -->
								<button type="button" class="btn btn-warning btn-sm" onclick="moveUpTree(); return false;">위로</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="moveDownTree(); return false;">아래로</button>
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
													<label for="group_name">그룹명</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="group_name" name="group_name" value="" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="group_key">그룹명(영문)</label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="group_key" name="group_key" value="" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<span>사용여부</span>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input radio-set">
													<input type="radio" id="use_y" name="use_yn" value="Y" />
													<label for="use_y">사용</label>
													<input type="radio" id="use_n" name="use_yn" value="N" />
													<label for="use_n">사용안함</label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="description">설명</label></th>
												<td class="col-input"><input type="text" id="description" name="description" value="" class="l"/></td>
											</tr>
											<tr>
												<td colspan="2">
													<div class="button-group u-pull-left">
														<input type="submit" value="저장" onclick="appendTree();"/>
														<input type="reset" value="취소" />
													</div>
													<div class="button-group u-pull-right">
														<a href="#" class="button" onclick="modifyUserGroupRole();">Role 관리</a>
														<a href="#" class="button" onclick="modifyUserGroupMenu();">메뉴 관리</a>
														<a href="#" class="button" onclick="modifyUserGroupUser();">사용자 관리</a>
													</div>
												</td>
											</tr>
										</table>
										</form>
									</div>
											
									<div class="tabs">
										<ul>
											<li><a href="#role_tab">ROLE</a></li>
											<li><a href="#menu_tab">메뉴</a></li>
											<li><a href="#user_tab">사용자</a></li>
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
														<th scope="col" class="col-number">번호</th>
														<th scope="col" class="col-name">Role명</th>
														<th scope="col" class="col-key">Role Key</th>
														<th scope="col" class="col-toggle">사용여부</th>
														<th scope="col" class="col-desc">설명</th>
														<th scope="col" class="col-date-time">등록일</th>
													</tr>
												</thead>
												<tbody id="role_list">
													<tr>
														<td colspan="6" class="col-none">등록된 Role이 없습니다.</td>
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
														<th scope="col" class="col-number">번호</th>
														<th scope="col" class="col-name">메뉴명</th>
														<th scope="col" class="col-toggle">사용여부</th>
														<th scope="col" class="col-url">Url</th>
														<th scope="col" class="col-url">이미지</th>
														<th scope="col" class="col-desc">이미지 Alt</th>
														<th scope="col" class="col-desc">설명</th>
														<th scope="col" class="col-date-time">등록일</th>
													</tr>
												</thead>
												<tbody id="menu_list">
													<tr>
														<td colspan="8" class="col-none">등록된 Menu가 없습니다.</td>
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
														<th scope="col" class="col-number">번호</th>
														<th scope="col" class="col-id">아이디</th>
														<th scope="col" class="col-name">이름</th>
														<th scope="col" class="col-email">이메일</th>
														<th scope="col" class="col-toggle">회원 상태</th>
														<th scope="col" class="col-date-time">등록일</th>
													</tr>
												</thead>
												<tbody id="user_list">
													<tr>
														<td colspan="6" class="col-none">등록된 사용자가 없습니다.</td>		
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
<div id="role_manager" class="dialog" title="Role 관리">
	<div class="row">
		<!-- 전체 Role -->
		<div id="role_left" class="pool">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title">전체 Role(선택 그룹 제외)</h4>
				</div>
				<div class="u-pull-right">
					<label for="search_except_role_name">Role명</label>
					<input type="search" id="search_except_role_name" name="search_except_role_name" class="m" value="" />
					<input type="button" value="조회" onclick="drawGroupPage('1', 'role_all');" />
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
						<th scope="col" class="col-name">Role명 (Role Key)</th>
						<th scope="col" class="col-toggle" style="min-width: 50px;">사용유무</th>
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
					<h4 class="column-title">등록 Role(선택 그룹)</h4>
				</div>
				<div class="u-pull-right">
					<label for="search_role_name">Role명</label>
					<input type="search" id="search_role_name" name="search_role_name" class="m" value="" />
					<input type="button" value="조회" onclick="drawGroupPage('1', 'role_select');" />
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
						<th scope="col" class="col-name">Role명 (Role Key)</th>
						<th scope="col" class="col-toggle" style="min-width: 50px;">사용유무</th>
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
				<span class="icon-text">등록</span>
			</a>
			<a href="#" id="role_button_delete" class="button color-area-em">
				<span class="icon-glyph glyph-ex"></span>
				<span class="icon-text">삭제</span>
			</a>
		</div>
	</div>
</div>

<!-- 사용자 관리 -->	
<div id="user_manager" class="user_dialog" title="사용자 관리">
	<div class="row">
		<!-- 전체 사용자 -->
		<div id="user_left" class="pool">
			<div class="list-header row">
				<div class="u-pull-left">
					<h4 class="column-title">전체 사용자(선택 그룹 제외)</h4>
				</div>
				<div class="u-pull-right">
					<label for="search_except_user_name">아이디</label>
					<input type="search" id="search_except_user_name" name="search_except_user_name" class="m" value="" />
					<input type="button" value="조회" onclick="drawGroupPage('1', 'user_all');" />
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
						<th scope="col" class="col-name">아이디</th>
						<th scope="col" class="col-toggle">이름</th>
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
					<h4 class="column-title">등록 사용자(선택 그룹)</h4>
				</div>
				<div class="u-pull-right">
					<label for="search_user_name">아이디</label>
					<input type="search" id="search_user_name" name="search_user_name" class="m" value="" />
					<input type="button" value="조회" onclick="drawGroupPage('1', 'user_select');" />
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
						<th scope="col" class="col-name">아이디</th>
						<th scope="col" class="col-toggle">이름</th>
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
				<span class="icon-text">등록</span>
			</a>
			<a href="#" id="user_button_delete" class="button color-area-em">
				<span class="icon-glyph glyph-ex"></span>
				<span class="icon-text">삭제</span>
			</a>
		</div>
	</div>
</div>
<script type="text/javascript">
		var USER_GROUP_TREE_DATA = null;
    $(document).ready(function() {
    	getAjaxUserGroupList();
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
    		alert("사용자 그룹을 선택해 주세요.");
    		return;
    	}
    	if ($("#depth").val() == "" || parseInt($("#depth").val()) < 1) {
    		alert("최상위 그룹에는 Role을 등록할 수 없습니다.");
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
 		alert("준비중입니다.");
 	}
 	// 사용자 관리
    function modifyUserGroupUser() {
    	if ($("#user_group_id").val() == "") {
    		alert("사용자 그룹을 선택해 주세요.");
    		return;
    	}
    	if ($("#depth").val() == "" || parseInt($("#depth").val()) < 1) {
    		alert("최상위 그룹에는 사용자를 등록할 수 없습니다.");
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
    		alert("그룹 아이디가 없습니다.");
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=role_all_id]"));
    	if (!status) {
			alert("선택된 항목이 없습니다.");
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
    		alert("그룹 아이디가 없습니다.");
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=user_all_id]"));
    	if (!status) {
			alert("선택된 항목이 없습니다.");
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
    		alert("그룹 아이디가 없습니다.");
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=role_select_id]"));
    	if (!status) {
			alert("선택된 항목이 없습니다.");
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
    		alert("그룹 아이디가 없습니다.");
    		return;
    	}
    	var status = checkedStatus($(":checkbox[name=user_select_id]"));
    	if (!status) {
			alert("선택된 항목이 없습니다.");
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
				+		"<td colspan=\"3\" class=\"col-none\">등록된 Role 이 없습니다.</td>"
				+	"</tr>";
		}
		$("#" + type + "_list").empty();
		$("#" + type + "_list").html(content);
		$("#" + type + "_list_count").empty();
		$("#" + type + "_list_count").html("총건수: <em>" + pagination.totalCount + "</em>건");
		
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
					+		"<td colspan=\"3\" class=\"col-none\">등록된 사용자가 없습니다.</td>"
					+	"</tr>";
		}
		
		$("#" + type + "_list").empty();
		$("#" + type + "_list").html(content);
		$("#" + type + "_list_count").empty();
		$("#" + type + "_list_count").html("총건수: <em>" + pagination.totalCount + "</em>건");
		
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
					+		"<td colspan=\"6\" class=\"col-none\">등록된 Role이 없습니다.</td>"
					+	"</tr>";
		}
		$("#role_list").empty();
		$("#role_list").html(content);
		$("#role_select_list_count").empty();
		$("#role_select_list_count").html("총건수: <em>" + pagination.totalCount + "</em>건");
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
					+		"<td colspan=\"6\" class=\"col-none\">등록된 사용자가 없습니다.</td>"
					+	"</tr>";
		}
		$("#user_list").empty();
		$("#user_list").html(content);
		$("#user_select_list_count").empty();
		$("#user_select_list_count").html("총건수: <em>" + pagination.totalCount + "</em>건");
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
				+		"<td colspan=\"" + colspan + "\" class=\"col-none\">최상위 그룹에는 등록할 수 없습니다.</td>"
				+	"</tr>";
		$("#" + type + "_list").html(content);
 	}
</script>
</body>
</html>