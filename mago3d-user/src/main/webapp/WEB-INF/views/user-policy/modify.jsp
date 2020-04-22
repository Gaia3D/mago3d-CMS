<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<div class="userPolicyContentWrap">
<form:form id="userPolicy" modelAttribute="userPolicy" method="post" onsubmit="return false;">
<form:hidden path="userPolicyId"/>
<div class="userPolicyContent">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">시작 위치</h3>
		<button type="button" id="findStartPoint" class="btnTextF right-align">선택</button>
	</div>
	<div class="userPolicyContentDetail">
		<div class="form-group form-group-policy">
			<label for="initLongitude">경도</label>
			<form:input type="text" id="initLongitude" path="initLongitude" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="initLatitude">위도</label>
			<form:input type="text" id="initLatitude" path="initLatitude" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="initAltitude">높이</label>
			<form:input type="text" id="initAltitude" path="initAltitude" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="initDuration">이동 속도</label>
			<form:input type="text" id="initDuration" path="initDuration" size="15" />초
		</div>
	</div>
</div>
<div class="userPolicyContent">
	<h3 class="h3-heading marB10">FOV (Field Of View)</h3>
	<div class="userPolicyContentDetail">
		<div class="form-group form-group-policy">
			<label for="initfieldOfView">각도</label>
			<form:input type="text" id="initfieldOfView" path="initDefaultFov" size="14" />M
		</div>
	</div>
</div>
<div class="userPolicyContent">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">LOD (Level Of Detail)</h3>
		<button type="button" id="changeLodButton" class="btnTextF right-align">적용</button>
	</div>
	<div class="userPolicyContentDetail">
		<div class="form-group form-group-policy">
			<label for="geoLod0">LOD0</label>
			<form:input type="text" id="geoLod0" path="lod0" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="geoLod1">LOD1</label>
			<form:input type="text" id="geoLod1" path="lod1" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="geoLod2">LOD2</label>
			<form:input type="text" id="geoLod2" path="lod2" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="geoLod3">LOD3</label>
			<form:input type="text" id="geoLod3" path="lod3" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="geoLod4">LOD4</label>
			<form:input type="text" id="geoLod4" path="lod4" size="15" />M
		</div>
		<div class="form-group form-group-policy">
			<label for="geoLod5">LOD5</label>
			<form:input type="text" id="geoLod5" path="lod5" size="15" />M
		</div>
	</div>
</div>
<div class="userPolicyContent">
	<div class="button-group-align marB10">
		<h3 class="h3-heading">SSAO</h3>
		<button type="button" id="changeSsaoButton" class="btnTextF right-align">적용</button>
	</div>
	<div class="userPolicyContentDetail">
		<div class="form-group form-group-policy">
			<label for="ssaoRadius">그림자 반경</label>
			<form:input type="text" id="ssaoRadius" path="ssaoRadius" size="15" />M
		</div>
	</div>
</div>
<button class="focusA btn-full" title="저장" onclick="update();">저장</button>
</form:form>
</div>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
});

var updateUserPolicyFlag = true;
function update() {
	if(updateUserPolicyFlag) {
		updateUserPolicyFlag = false;
		var url = "/user-policy/update";
		var formData = $("#userPolicy").serialize();
		$.ajax({
			url: url,
			type: "POST",
			headers: {"X-Requested-With": "XMLHttpRequest"},
			data: formData,
			dataType: "json",
			success: function(msg) {
				if(msg.statusCode <= 200) {
					alert("저장 되었습니다.");
				} else {
					alert(msg.message);
					console.log("---- " + msg.message);
				}
				updateUserPolicyFlag = true;
			},
	        error: function(request, status, error) {
	        	alert(JS_MESSAGE["ajax.error.message"]);
	        	updateUserPolicyFlag = true;
	        }
		});
	} else {
		alert("진행 중입니다.");
		return;
	}
}
</script>