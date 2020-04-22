<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
	<div class="btnGroup">
		<!-- 사용자 설정 정보 ==> settings.js -->
		<button class="textBtnSub" onClick="turnOnAllLayer(); return false;">전체 켜기</button>
		<button class="textBtnSub" onClick="turnOffAllLayer(); return false;">전체 끄기</button>
		<button class="textBtnSub" onClick="openAllLayerTree(); return false;">펼치기</button>
		<button class="textBtnSub" onClick="closeAllLayerTree(); return false;">접기</button>
		<button class="textBtn" onClick="saveUserLayers(); return false;">저장</button>
	</div>
	<form:form id="layerForm" modelAttribute="userPolicy" style="height: calc(100% - 50px)">
		<form:hidden path="baseLayers"/>
		<ul id="layerTreeList" class="layerList marT10 yScroll" style="height: 100%"></ul>
	</form:form>
<%@include file="/WEB-INF/views/layer/layer-template.jsp"%>