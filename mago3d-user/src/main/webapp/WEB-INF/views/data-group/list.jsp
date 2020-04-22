<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 그룹 | NDTP</title>
	<link rel="shortcut icon" href="/images/favicon.ico?cacheVersion=${contentCacheVersion}">
	<link rel="stylesheet" href="/externlib/cesium/Widgets/widgets.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/user-style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/${lang}/style.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css"/>
	<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
	<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/layouts/header.jsp" %>

<div id="wrap">
	<!-- S: NAVWRAP -->
	<div class="navWrap">
	 	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %> 
	</div>
	<!-- E: NAVWRAP -->
	
	<div class="container" style="float:left; width: calc(100% - 78px);">
		<div style="padding: 20px 20px 0px 10px; font-size: 18px;">3D 업로딩 데이터 자동 변환</div>
		<div class="tabs" >
			<ul class="tab">
				<li id="tabDataGroupList"><a href="/data-group/list">데이터 그룹</a></li>
				<li id="tabDataGroupInput"><a href="/data-group/input">데이터 그룹 등록</a></li>
				<li id="tabUploadDataInput"><a href="/upload-data/input">업로딩 데이터</a></li>
			   	<li id="tabUploadDataList"><a href="/upload-data/list">업로딩 데이터 목록</a></li>
			  	<li id="tabConverterList"><a href="/converter/list">업로딩 데이터 변환 목록</a></li>
			  	<li id="tabDataList"><a href="/data/list">데이터 목록</a></li>
			  	<li id="tabDataLogList"><a href="/data-log/list">데이터 변경 이력</a></li>
			</ul>
		</div>
		<div style="height: 30px;"></div>
		<div class="list">
			<div class="list-header row">
				<div class="list-desc u-pull-left">
					<div class="button-group">
						<a href="#" onclick="openAll(); return false;" class="button">펼치기</a>
						<a href="#" onclick="closeAll(); return false;" class="button">접기</a>
						<!-- <a href="/layer/tree" class="button">그룹 수정/등록</a> -->
					</div>
				</div>
			</div>
			<table class="list-table scope-col">
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-name" />
				<col class="col-toggle" />
				<col class="col-functions" />
				<col class="col-functions" />
				<col class="col-functions" />
				<col class="col-functions" />
				<col class="col-date" />
				<thead>
					<tr>
						<th scope="col">그룹명</th>
	                    <th scope="col">그룹 Key</th>
	                    <th scope="col">공유 유형</th>
	                    <th scope="col">사용 여부</th>
	                    <th scope="col">데이터 건수</th>
	                    <th scope="col">순서</th>
	                    <th scope="col">수정</th>
	                    <th scope="col">삭제</th>
	                    <th scope="col">등록일</th>
					</tr>
				</thead>
				<tbody>
<c:if test="${empty dataGroupList }">
					<tr>
						<td colspan="9" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
					</tr>
</c:if>								
<c:if test="${!empty dataGroupList }">
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
<c:forEach var="dataGroup" items="${dataGroupList}" varStatus="status">
    <c:if test="${dataGroup.depth eq 1 }">
        <c:set var="depthClass" value="oneDepthClass" />
        <c:set var="paddingLeftValue" value="0px" />
        <c:set var="depthStyleDisplay" value="" />
        <c:set var="ancestorClass" value="" />
        <c:set var="depthParentClass" value="" />
    </c:if>
    <c:if test="${dataGroup.depth eq 2 }">
        <c:set var="depthClass" value="twoDepthClass" />
        <c:set var="paddingLeftValue" value="40px" />
        <c:set var="depthStyleDisplay" value="display: none;" />
        <c:set var="depthParentClass" value="oneDepthParent-${dataGroup.parent }" />
        <c:set var="ancestorClass" value="" />
        <c:set var="ancestorArrowClass" value="ancestorArrow-${dataGroup.ancestor }" />
        <c:set var="ancestorFolderClass" value="ancestorFolder-${dataGroup.ancestor }" />
    </c:if>
    <c:if test="${dataGroup.depth eq 3 }">
        <c:set var="depthClass" value="threeDepthClass" />
        <c:set var="paddingLeftValue" value="80px" />
        <c:set var="depthStyleDisplay" value="display: none;" />
        <c:set var="depthParentClass" value="twoDepthParent-${dataGroup.parent }" />
        <c:set var="ancestorClass" value="" />
        <c:set var="ancestorClass" value="ancestor-${dataGroup.ancestor }" />
        <c:set var="ancestorFolderClass" value="ancestorFolder-${dataGroup.ancestor }" />
    </c:if>
					<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
						<td class="col-key ellipsis" style="max-width: 300px;">
    <c:if test="${dataGroup.depth eq 1 }">
    						<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;"
	                        	onclick="childrenDisplayToggle('${dataGroup.depth}', '${dataGroup.dataGroupId}', '${dataGroup.ancestor}');">
	                            <i id="oneDepthArrow-${dataGroup.dataGroupId }" class="fa fa-caret-right oneArrow" aria-hidden="true"></i>
	                        </span>&nbsp;
	                        <span style="font-size: 1.5em; color: Dodgerblue;">
	                            <i id="oneDepthFolder-${dataGroup.dataGroupId }" class="fa fa-folder oneFolder" aria-hidden="true"></i>
	                        </span>
    </c:if>
    <c:if test="${dataGroup.depth eq 2 }">
    						<span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;" 
	                        	onclick="childrenDisplayToggle('${dataGroup.depth}', '${dataGroup.dataGroupId}', '${dataGroup.ancestor}');">
	                            <i id="twoDepthArrow-${dataGroup.dataGroupId }" class="fa fa-caret-right twoArrow ${ancestorArrowClass }" aria-hidden="true"></i></span>&nbsp;
	                        <span style="font-size: 1.5em; color: Mediumslateblue;">
								<i id="twoDepthFolder-${dataGroup.dataGroupId }" class="fa fa-folder twoFolder ${ancestorFolderClass }" aria-hidden="true"></i>
	                        </span>
    </c:if>
    <c:if test="${dataGroup.depth eq 3 }">
                    		<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;">
                    			<i id="threeDepthFolder-${dataGroup.dataGroupId }" class="fa fa-folder threeFolder ${ancestorFolderClass }" aria-hidden="true"></i>
                    		</span>
    </c:if>

                    					${dataGroup.dataGroupName }
						</td>
						<td class="col-key ellipsis" style="max-width: 120px;">${dataGroup.dataGroupKey }</td>
						<td class="col-type">${dataGroup.sharing }</td>
	                    <td class="col-type">
    <c:if test="${dataGroup.available eq 'true' }">
                    					사용
    </c:if>
    <c:if test="${dataGroup.available eq 'false' }">
                    					미사용
    </c:if>
	                    </td>
	                    <td class="col-count">
	<c:if test="${dataGroup.dataCount gt 0 }">
	                    	<a href="/data/list?dataGroupId=${dataGroup.dataGroupId }" class="linkButton">
	                    	<fmt:formatNumber value="${dataGroup.dataCount}" type="number"/>
	                    	</a>
	</c:if>
	<c:if test="${dataGroup.dataCount eq 0 }">
							<fmt:formatNumber value="${dataGroup.dataCount}" type="number"/>	
	</c:if>
	                    </td>
	                    <td class="col-type">
	                    	<div class="button-group">
	                    		<a href="#" onclick="moveUp('${dataGroup.dataGroupId }', '${dataGroup.viewOrder }'); return false;" 
	                    			class="button" style="text-decoration:none;">위로</a>
								<a href="#" onclick="moveDown('${dataGroup.dataGroupId }', '${dataGroup.viewOrder }'); return false;" 
									class="button" style="text-decoration:none;">아래로</a>
	                    	</div>
	                    </td>
	                    <td class="col-type">
							<a href="/data-group/modify?dataGroupId=${dataGroup.dataGroupId }" class="image-button button-edit">수정</a>
	                    </td>
	                    <td class="col-type">
	<c:if test="${dataGroup.basic eq 'true' }">
							불가(기본)
	</c:if>                    
	<c:if test="${dataGroup.basic ne 'true' }">			
							<a href="/data-group/delete?dataGroupId=${dataGroup.dataGroupId }" onclick="return deleteWarning();" 
								class="image-button button-delete"><spring:message code='delete'/></a>
	</c:if>
	                    </td>
	                    <td class="col-date">
	                    	<fmt:parseDate value="${dataGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
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
<!-- E: WRAP -->

<script type="text/javascript" src="/js/${lang}/common.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/message.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/map-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/js/${lang}/ui-controll.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript">
	$(document).ready(function() {
	});
	
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
	
	// 위로 이동
	var upFlag = true;
	function moveUp(id, viewOrder) {
	    if(upFlag) {
	        upFlag = false;
	        if(viewOrder === "1") {
	            alert("제일 처음 입니다.");
	            upFlag = true;
	            return;
	        }
	        
	        var formData = "updateType=UP";
		    $.ajax({
				url: "/data-groups/view-order/" + id,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						window.location.reload();
						upFlag = true;
						openAll();
					} else {
						if(msg.errorCode === "data.group.view-order.invalid") {
							alert("순서를 변경할 수 없습니다.");
						} else {
							alert(JS_MESSAGE[msg.errorCode]);
						}
						console.log("---- " + msg.message);
						upFlag = true;
					}
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        upFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
	    }
	}
	
	// 아래로 이동
	var downFlag = true;
	function moveDown(id, viewOrder) {
	    if(downFlag) {
	        downFlag = false;
	        var formData = "updateType=DOWN";
		    $.ajax({
				url: "/data-groups/view-order/" + id,
				type: "POST",
				headers: {"X-Requested-With": "XMLHttpRequest"},
		        data: formData,
				success: function(msg){
					if(msg.statusCode <= 200) {
						alert(JS_MESSAGE["update"]);
						window.location.reload();
						downFlag = true;
						openAll();
					} else {
						if(msg.errorCode === "data.group.view-order.invalid") {
							alert("순서를 변경할 수 없습니다.");
						} else {
							alert(JS_MESSAGE[msg.errorCode]);
						}
						console.log("---- " + msg.message);
						downFlag = true;
					}
				},
				error:function(request, status, error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        downFlag = true;
				}
			});
	    } else {
	        alert("진행 중입니다.");
	        return;
	    }
	}
</script>
</body>
</html>
