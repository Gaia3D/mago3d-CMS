<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="gnbWrap" style="z-index: 100;">
	<!-- S: 통합검색 -->
	<div class="totalSearch">
		<label for="fullTextSearch" class="hiddenTag">통합검색</label>
		<input type="text" id="fullTextSearch" name="fullTextSearch" placeholder="검색어를 입력하세요.">
		<button type="button" id="fullTextSearchButton" title="검색" class="btnTotalSearch">검색</button>
	</div>
	<!-- S: 화면행정구역 -->
	<div class="district" >
		<p id="viewDistrictName"></p>
	</div>
	<!-- S: 행정구역 레이어 -->
	<div class="districtWrap" style="display:none;">
		<div class="districtLayer">
			<ul id="sdoList">
				<li class="on">전체</li>
			</ul>
			<ul id="sggList">
				<li class="on">전체</li>
			</ul>
			<ul id="emdList">
				<li class="on">전체</li>
			</ul>
		</div>
		<div class="districtBtn">
			<button type="button" class="focusB" id="districtFlyButton">이동</button>
			<button type="button" class="basicB" id="districtCancleButton">취소</button>
		</div>
	</div>
	<!-- E: 행정구역 레이어 -->
</div>