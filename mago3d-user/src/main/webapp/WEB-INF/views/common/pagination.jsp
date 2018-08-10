<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:if test="${pagination.totalCount > 0}">			
		<div class="pagination">
			<a href="${pagination.uri }?pageNo=${pagination.firstPage }${pagination.searchParameters}" class="first"><span class="icon-glyph glyph-first"></span></a>
	<c:if test="${pagination.existPrePage == 'true' }">
			<a href="${pagination.uri }?pageNo=${pagination.prePageNo }${pagination.searchParameters}" class="prev"><span class="icon-glyph glyph-prev"></span></a>
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
			<a href="${pagination.uri }?pageNo=${pagination.nextPageNo }${pagination.searchParameters}" class="next"><span class="icon-glyph glyph-next"></span></a>
	</c:if>			
			<a href="${pagination.uri }?pageNo=${pagination.lastPage }${pagination.searchParameters}" class="last"><span class="icon-glyph glyph-last"></span></a>
		</div>
</c:if>