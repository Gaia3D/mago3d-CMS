<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- S: 시민참여 의견 등록 -->
<div id="civilVoiceInputContent" class="contents mar0 pad0 border-none" style="display:none;">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">시민참여 의견등록</h3>
		<button type="button" id="civilVoiceCancleButton" data-goto="list" class="btnText right-align reset" title="취소">취소</button>
	</div>

	<form:form id="civilVoiceForm" modelAttribute="civilVoice" method="post" onsubmit="return false;">
		<ul class="commentNew">
			<li>
				<label for="civilVoiceTitle">제목 <span style="color: red;">*</span></label>
				<input type="text" id="civilVoiceTitle" name="title" style="width:91%;" maxlength="256">
				<!-- <p class="info"><span>256</span>자 / 256자 이내</p> -->
 				<p class="info" style="margin-right: 15px;">256자 이내</p>
			</li>
			<li>
				<label for="civilVoiceLongitude">위치 <span style="color: red;">*</span></label>
				<input type="text" id="civilVoiceLongitude" name="longitude" style="width:30%;">
				<label for="civilVoiceLatitude" class="hiddenTag">위치(위도)</label>
				<input type="text" id="civilVoiceLatitude" name="latitude" style="width:30%;">
				<button type="button" id="civilVoiceLocation" onClick="civilVoice.getGeographicCoord();" class="basicA" title="위치지정">위치지정</button>
			</li>
			<li>
				<label for="contents">내용 <span style="color: red;">*</span></label>
				<textarea id="contents" name="contents" cols="47" rows="10" style="width:96%;"></textarea>
			</li>
			<li class="form-group button-group-center">
				<button id="civilVoiceCreateButton" onClick="saveCivilVoice();" class="btnTextF" title="등록" style="width: 200px;">등록</button>
				<!-- <button id="civilVoiceCancleButton" class="focusC" title="취소">취소</button> -->
			</li>
		</ul>
	</form:form>
</div>
<!-- E: 시민참여 의견 등록 -->
