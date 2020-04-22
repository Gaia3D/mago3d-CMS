<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="civilVoiceListContent" class="contents mar0 pad0 border-none fullHeight">
		<h3 class="h3-heading">시민참여</h3>
		<button type="button" id="civilVoiceInputButton" class="btnTextF float-right" style="margin-top: -30px;" title="의견등록">의견 등록</button>

		<!-- 시민참여 검색 -->
		<form:form id="civilVoiceSearchForm" modelAttribute="civilVoice" method="get" onsubmit="return false;">
		<div class="listSearch search-margin flex-align-center">
			<label for="getCivilVoiceListTitle" class="hiddenTag">검색어 입력</label>
			<input type="text" id="getCivilVoiceListTitle" name="title" maxlength="256" placeholder="검색어를 입력하세요.">
			<button type="button" id="civilVoiceSearch" onClick="getCivilVoiceList();" class="btnTotalSearch" title="검색">검색</button>
		</div>
		</form:form>

		<!-- 시민참여 목록 -->
		<div class="list" style="height:calc(100% - 70px)">
			<div>
				<span><spring:message code='all.d'/> <span id="civilVoiceTotalCount" class="totalCount">0</span> <spring:message code='search.what.count'/></span>
				<span class="float-right"><span id="civilVoiceCurrentPage">0</span> / <span id="civilVoiceLastPage">0</span> <spring:message code='search.page'/></span>
			</div>
			<ul id="civilVoiceList" class="commentWrap marT10 yScroll" style="height:calc(100% - 60px)"></ul>
			<ul id="civilVoicePagination" class="pagination"></ul>
		</div>
</div>
<!-- E: 시민참여 목록 -->
<%@ include file="/WEB-INF/views/civil-voice/detail.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/input.jsp" %>
<%@ include file="/WEB-INF/views/civil-voice/modify.jsp" %>

<script id="templateCivilVoiceList" type="text/x-handlebars-template">
	{{#if civilVoiceList}}
		{{#each civilVoiceList}}
			<li class="comment flex-align-center" data-id="{{civilVoiceId}}" title="상세보기">
				<p class="count" style=""><span class="likes-icon">icon</span>{{#formatNumber commentCount}}{{/formatNumber}}</p>
				<p style="width: 210px;">
					<span class="title">{{title}}</span>
					<span class="id">{{userId}}</span>
				</p>
				<button type="button" class="goto" data-longitude={{longitude}} data-latitude={{latitude}} data-count={{commentCount}} style="width:30px; position: relative; left: 7px;" title="위치보기">위치보기</button>
			</li>
		{{/each}}
	{{else}}
		<li class="none">등록된 글이 없습니다.</li>
	{{/if}}
</script>

<script id="templateCivilVoicePagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
    	<ul class="pagination">
       	 	<li class="ico first" onClick="getCivilVoiceList({{pagination.firstPage}});"></li>
    	{{#if pagination.existPrePage}}
        	<li class="ico forward" onClick="getCivilVoiceList({{pagination.prePageNo}});"></li>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
           		<li class="on"><a href='#'>{{this}}</a></li>
        	{{else}}
         		<li onClick="getCivilVoiceList({{this}});"><a href='#'>{{this}}</a></li>
        	{{/if}}
    	{{/forEachStep}}

    	{{#if pagination.existNextPage}}
        	<li class="ico back" onClick="getCivilVoiceList({{pagination.nextPageNo}});"></li>
    	{{/if}}
        	<li class="ico end" onClick="getCivilVoiceList({{pagination.lastPage}});"></li>
    	</ul>
	{{/if}}
</script>
