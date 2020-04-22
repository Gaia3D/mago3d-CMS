<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${pagination.totalCount > 0}">			
		<div class="pagination">
			<a href="${pagination.uri }?pageNo=${pagination.firstPage }${pagination.searchParameters}" class="first icon-glyph glyph-first"><span class="hiddenTag">처음으로</span></a>
	<c:if test="${pagination.existPrePage == 'true' }">
			<a href="${pagination.uri }?pageNo=${pagination.prePageNo }${pagination.searchParameters}" class="prev icon-glyph glyph-prev"><span class="hiddenTag">이전</span></a>
	</c:if>
					
	<c:forEach var="pageIndex" begin="${pagination.startPage }" end="${pagination.endPage }" step="1">
		<c:if test="${pageIndex == pagination.pageNo }">
			<a href="#" class="current-page">${pageIndex }</a>
		</c:if>
		<c:if test="${pageIndex != pagination.pageNo }">
			<a href="${pagination.uri }?pageNo=${pageIndex }${pagination.searchParameters}">${pageIndex }</a>
		</c:if>
	</c:forEach>
	
	<c:if test="${pagination.existNextPage == 'true' }">
			<a href="${pagination.uri }?pageNo=${pagination.nextPageNo }${pagination.searchParameters}" class="next icon-glyph glyph-next"><span class="hiddenTag">다음</span></a>
	</c:if>			
			<a href="${pagination.uri }?pageNo=${pagination.lastPage }${pagination.searchParameters}" class="last icon-glyph glyph-last"><span class="hiddenTag">마지막으로</span></a>
		</div>
</c:if>