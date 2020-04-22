<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul  id="districtSearchResult" class="listDefault">
	<li id="districtList" class="on">
		<p>행정구역<span>총 0 건</span></p>
		<ul id="districtSearchList" class="yScroll">
			<li>
				검색 결과가 없습니다.
			</li>
		</ul>
	</li>
</ul>
<div id="districtPage"></div>
<%@ include file="/WEB-INF/views/search/list.jsp" %>
<%@ include file="/WEB-INF/views/search/pagination.jsp" %>