<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- S: 시민참여 의견 -->
<div id="civilVoiceDetailContent" class="contents mar0 pad0 border-none" style="display:none;">
	<div id="civilVoiceView" class="commentView"></div>

	<p class="agreeCount">동의 <span id="civilVoiceCommentTotalCount">0</span> 건</p>
	<form:form id="civilVoiceCommentForm" modelAttribute="civilVoiceComment" method="post" onsubmit="return false;">
		<div class="agreeNew">
			<label for="civilVoiceAgreeInput" class="hiddenTag">동의합니다.</label>
			<input type="text" id="civilVoiceAgreeInput" name="title" placeholder="동의합니다" value="">
			<button id="civilVoiceAgree" onClick="saveCivilVoiceComment();" class="focusAgree" title="동의">동의</button>
		</div>
	</form:form>
	<ul id="civilVoiceComment" class="agreeWrap"></ul>
	<ul id="civilVoiceCommentPagination" class="pagination"></ul>

</div>
<!-- E: 시민참여 의견 -->

<script id="templateCivilVoiceView" type="text/x-handlebars-template">
	<div style="margin-bottom: 15px;">
		<div class="button-group-align marB10" style="display: inline-block;">
			{{#if civilVoice.editable}}
				<button type="button" id="civilVoiceModifyButton" class="btnText left-align reset marR5" title="수정">수정</button>
				<button type="button" class="btnText left-align reset marR5" onClick="return deleteCivilVoice({{civilVoice.civilVoiceId}});" title="삭제">삭제</button>
			{{/if}}
			<button type="button" id="civilVoiceListButton" data-goto="list" class="btnTextF right-align" title="목록">목록</button>
		</div>
		<span class="title"  id="civilVoiceTitle">
			{{civilVoice.title}}
		</span>
	</div>
	<div class="con" id="civilVoiceContents">{{civilVoice.contents}}</div>
</script>

<script id="templateCivilVoiceComment" type="text/x-handlebars-template">
	{{#if civilVoiceCommentList}}
		{{#each civilVoiceCommentList}}
			<li>
				<p class="agree">
					<span class="likes-icon">icon</span>
					{{title}}
					<span class="id">{{userId}}</span>
				</p>
			</li>
		{{/each}}
	{{/if}}
</script>

<script id="templateCivilVoiceCommentPagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
    	<ul class="pagination">
       	 	<li class="ico first" onClick="getCivilVoiceCommentList({{pagination.firstPage}});"></li>
    	{{#if pagination.existPrePage}}
        	<li class="ico forward" onClick="getCivilVoiceCommentList({{pagination.prePageNo}});"></li>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
           		<li class="on"><a href='#'>{{this}}</a></li>
        	{{else}}
         		<li onClick="getCivilVoiceCommentList({{this}});"><a href='#'>{{this}}</a></li>
        	{{/if}}
    	{{/forEachStep}}

    	{{#if pagination.existNextPage}}
        	<li class="ico back" onClick="getCivilVoiceCommentList({{pagination.nextPageNo}});"></li>
    	{{/if}}
        	<li class="ico end" onClick="getCivilVoiceCommentList({{pagination.lastPage}});"></li>
    	</ul>
	{{/if}}
</script>