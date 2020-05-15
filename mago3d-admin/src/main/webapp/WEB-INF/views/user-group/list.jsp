<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>사용자 그룹 | mago3D</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
    <link rel="stylesheet" href="/css/${lang}/admin-style.css" />
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
						<!-- <div class="filters">
						</div> -->
						<div style="height: 30px;"></div>
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<div class="button-group">
										<a href="#" onclick="openAll(); return false;" class="button">펼치기</a>
										<a href="#" onclick="closeAll(); return false;" class="button">접기</a>
									</div>
								</div>
							</div>
							<table class="list-table scope-col" summary="사용자 그룹 리스트를 트리 형태로 조회 ">
							<caption class="hiddenTag">사용자 그룹</caption>
								<col class="col-name" />
								<col class="col-id" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-date" />
								<thead>
									<tr>
										<th scope="col"><spring:message code='user.group.name'/></th>
					                    <th scope="col">그룹Key</th>
					                    <th scope="col">기본 여부</th>
					                    <th scope="col">사용 여부</th>
					                    <th scope="col">사용자</th>
					                    <th scope="col">메뉴</th>
					                    <th scope="col">Role</th>
					                    <th scope="col">편집</th>
					                    <th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty userGroupList }">
									<tr>
										<td colspan="8" class="col-none"><spring:message code='user.group.empty'/></td>
									</tr>
</c:if>
<c:if test="${!empty userGroupList }">
	<c:set var="paddingLeftValue" value="0" />
    <!-- depth 별 css 제어를 위한 변수 -->
    <c:set var="depthClass" value="" />
    <c:set var="depthStyleDisplay" value="" />
    <!-- 클릭 이벤트 발생시 자손 css 를 제어하기 위한 변수 -->
    <c:set var="ancestorClass" value="" />
    <!-- 클릭 이벤트 발생시 자식 css 를 제어하기 위한 변수 -->
    <c:set var="depthParentClass" value="" />
    <c:set var="ancestorArrowClass" value="" />
    <c:set var="ancestorFolderClass" value="" />
    <c:forEach var="userGroup" items="${userGroupList}" varStatus="status">
        <c:if test="${userGroup.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
            <c:set var="depthStyleDisplay" value="" />
            <c:set var="ancestorClass" value="" />
            <c:set var="depthParentClass" value="" />
        </c:if>
        <c:if test="${userGroup.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="oneDepthParent-${userGroup.parent }" />
            <c:set var="ancestorClass" value="" />
            <c:set var="ancestorArrowClass" value="ancestorArrow-${userGroup.ancestor }" />
            <c:set var="ancestorFolderClass" value="ancestorFolder-${userGroup.ancestor }" />
        </c:if>
        <c:if test="${userGroup.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="twoDepthParent-${userGroup.parent }" />
            <c:set var="ancestorClass" value="ancestor-${userGroup.ancestor }" />
        </c:if>
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
										<td class="col-key ellipsis" style="text-align: left;" nowrap="nowrap">
        <c:if test="${userGroup.depth eq 1 }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"
					                        	onclick="childrenDisplayToggle('${userGroup.depth}', '${userGroup.userGroupId}', '${userGroup.ancestor}');">
					                            <i id="oneDepthArrow-${userGroup.userGroupId }" class="fa fa-caret-right oneArrow" aria-hidden="true"></i>
					                        </span>&nbsp;
					                        <span style="font-size: 1.5em; color: Dodgerblue;">
					                            <i id="oneDepthFolder-${userGroup.userGroupId }" class="fa fa-folder oneFolder" aria-hidden="true"></i>
					                        </span>
        </c:if>
        <c:if test="${userGroup.depth eq 2 }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"
					                        	onclick="childrenDisplayToggle('${userGroup.depth}', '${userGroup.userGroupId}', '${userGroup.ancestor}');">
					                            <i id="twoDepthArrow-${userGroup.userGroupId }" class="fa fa-caret-right twoArrow ${ancestorArrowClass }" aria-hidden="true"></i></span>&nbsp;
					                        <span style="font-size: 1.5em; color: Mediumslateblue;">
					                            <i id="twoDepthFolder-${userGroup.userGroupId }" class="fa fa-folder twoFolder ${ancestorFolderClass }" aria-hidden="true"></i>
					                        </span>
        </c:if>
        <c:if test="${userGroup.depth eq 3 }">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
        </c:if>

                        					${userGroup.userGroupName }
										</td>
										<td class="col-key">${userGroup.userGroupKey }</td>
					                    <td class="col-type">
        <c:if test="${userGroup.basic eq 'true' }">
                        					기본
        </c:if>
        <c:if test="${userGroup.basic eq 'false' }">
                        					선택
        </c:if>
					                    </td>
					                    <td class="col-type">
        <c:if test="${userGroup.available eq 'true' }">
                        					사용
        </c:if>
        <c:if test="${userGroup.available eq 'false' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-type">
					                        <a href="/user/list?searchOption=0&searchWord=user_group_name&searchValue=${userGroup.userGroupName}" class="linkButton">보기</a>
					                    </td>
					                    <td class="col-type">
					                        <a href="/user-group/menu?userGroupId=${userGroup.userGroupId}" class="linkButton">수정</a>
					                    </td>
					                    <td class="col-type">
					                        <a href="/user-group/role?userGroupId=${userGroup.userGroupId}" class="linkButton">수정</a>
					                    </td>
					                    <td class="col-type">
											<a href="/user-group/modify?userGroupId=${userGroup.userGroupId}" class="image-button button-edit"><spring:message code='modified'/></a>&nbsp;&nbsp;
					                    	<a href="/user-group/delete?userGroupId=${userGroup.userGroupId}" onclick="return deleteUserGroupWarning();" class="image-button button-delete"><spring:message code='delete'/></a>
					                    </td>
					                    <td class="col-date">
					                    	<fmt:parseDate value="${userGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
					                    </td>
					                </tr>
    </c:forEach>
</c:if>
								</tbody>
							</table>
						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>

<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	//펼치기
	function openAll() {
	    $(".threeDepthClass").show();
	    $(".twoDepthClass").show();

	    // fa-caret-right
	    // fa-caret-down
	    $(".oneArrow").removeClass("fa-caret-right");
	    $(".oneArrow").addClass("fa-caret-down");
	    $(".twoArrow").removeClass("fa-caret-right");
	    $(".twoArrow").addClass("fa-caret-down");

	    $(".oneFolder").removeClass("fa-folder");
	    $(".oneFolder").addClass("fa-folder-open");
	    $(".twoFolder").removeClass("fa-folder");
	    $(".twoFolder").addClass("fa-folder-open");
	}

	// 접기
	function closeAll() {
	    $(".threeDepthClass").hide();
	    $(".twoDepthClass").hide();

	    $(".oneArrow").removeClass("fa-caret-down");
	    $(".oneArrow").addClass("fa-caret-right");
	    $(".twoArrwo").removeClass("fa-caret-down");
	    $(".twoArrwo").addClass("fa-caret-right");

	    $(".oneFolder").removeClass("fa-folder-open");
	    $(".oneFolder").addClass("fa-folder");
	    $(".twoFolder").removeClass("fa-folder-open");
	    $(".twoFolder").addClass("fa-folder");
	}

	// 화살표 클릭시
	function childrenDisplayToggle(depth, id, ancestor) {
	    if(depth === "1") {
	        if( $(".oneDepthParent-" + id).css("display") === "none" ) {
	            // 접힌 상태
	            $(".oneDepthParent-" + id).show();

	            $("#oneDepthArrow-" + id).removeClass("fa-caret-right");
	            $("#oneDepthArrow-" + id).addClass("fa-caret-down");
	            $("#oneDepthFolder-" + id).removeClass("fa-folder");
	            $("#oneDepthFolder-" + id).addClass("fa-folder-open");

	            $(".ancestorArrow-" + ancestor).removeClass("fa-caret-down");
	            $(".ancestorArrow-" + ancestor).addClass("fa-caret-right");
	            $(".ancestorFolder-" + ancestor).removeClass("fa-folder-open");
	            $(".ancestorFolder-" + ancestor).addClass("fa-folder");
	        } else {
				// 펼친 상태
	            $(".ancestor-" + ancestor).hide();
	            $(".oneDepthParent-" + id).hide();

	        	var clickClass = $("#oneDepthArrow-" + id).attr("class");
	            if(clickClass.indexOf("right") >= 0) {
	            	// 닫힘 상태라 펼침
	            	$("#oneDepthArrow-" + id).removeClass("fa-caret-right");
	            	$("#oneDepthArrow-" + id).addClass("fa-caret-down");
	            	$("#oneDepthFolder-" + id).removeClass("fa-folder");
	            	$("#oneDepthFolder-" + id).addClass("fa-folder-open");
	            } else {
	            	// 펼침 상태라 닫힘
	            	$("#oneDepthArrow-" + id).removeClass("fa-caret-down");
	                $("#oneDepthArrow-" + id).addClass("fa-caret-right");
	                $("#oneDepthFolder-" + id).removeClass("fa-folder-open");
	                $("#oneDepthFolder-" + id).addClass("fa-folder");
	            }

	            $(".ancestorArrow-" + ancestor).removeClass("fa-caret-down");
	            $(".ancestorArrow-" + ancestor).addClass("fa-caret-right");
	            $(".ancestorFolder-" + ancestor).removeClass("fa-folder-open");
	            $(".ancestorFolder-" + ancestor).addClass("fa-folder");
	        }
	    } else if(depth === "2") {
	    	if( $(".twoDepthParent-" + id).css("display") === "none" ) {
	            // 접힌 상태
	            $(".twoDepthParent-" + id).show();

	            $("#twoDepthArrow-" + id).removeClass("fa-caret-right");
	            $("#twoDepthArrow-" + id).addClass("fa-caret-down");
	            $("#twoDepthFolder-" + id).removeClass("fa-folder");
	            $("#twoDepthFolder-" + id).addClass("fa-folder-open");
	        } else {
	            // 펼친 상태
	            $(".twoDepthParent-" + id).hide();

	            var clickClass = $("#twoDepthArrow-" + id).attr("class");
	            if(clickClass.indexOf("right") >= 0) {
	            	// 닫힘 상태라 펼침
	            	$("#twoDepthArrow-" + id).removeClass("fa-caret-right");
	            	$("#twoDepthArrow-" + id).addClass("fa-caret-down");
	            	$("#twoDepthFolder-" + id).removeClass("fa-folder");
	            	$("#twoDepthFolder-" + id).addClass("fa-folder-open");
	            } else {
	            	// 펼침 상태라 닫힘
	            	$("#twoDepthArrow-" + id).removeClass("fa-caret-down");
	                $("#twoDepthArrow-" + id).addClass("fa-caret-right");
	                $("#twoDepthFolder-" + id).removeClass("fa-folder-open");
	                $("#twoDepthFolder-" + id).addClass("fa-folder");
	            }
	        }
	    }
	}

	function deleteUserGroupWarning() {
		if(confirm("삭제 하시겠습니까?\n그룹에 포함된 사용자도 함께 삭제됩니다.")) {
			return true;
		} else {
			return false;
		}
	}
</script>
</body>
</html>