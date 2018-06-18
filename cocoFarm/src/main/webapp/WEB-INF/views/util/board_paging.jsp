<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="paging text-center">
	<ul class="pagination">
		<%-- 첫 페이지 버튼 --%>
		<%-- 첫 페이지가 아니면 버튼 노출 --%>
		<c:if test="${paging.curPage ne 1 }">
		<li>
			<a href="/board/list.do?curPage=1" style="width: 40px !important;">
				<span aria-hidden="true">&larr;처음</span>	
			</a>
		</c:if>
		
		<%-- 이전 페이지 버튼 --%>
		<%-- 첫 페이지면 금지 표시 --%>
		<c:if test="${paging.curPage eq 1 }">
		<li class="disabled">
			<a href="/board/list.do?curPage=${paging.curPage }" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			</a>
		</li>
		</c:if>
		<c:if test="${paging.curPage ne 1 }">
		<li>
			<a href="/board/list.do?curPage=${paging.curPage-1 }" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			</a>
		</li>
		</c:if>
		
		<%-- 페이징 번호 버튼 --%>
		<c:forEach begin="${paging.startPage }"
			end="${paging.endPage }"
			var="page">
			
			<%-- 페이지 번호가 현재페이지면 파랑색으로 보이기 --%>
			<c:if test="${paging.curPage eq page }">
			<li class="active">
			</c:if>
			<c:if test="${paging.curPage ne page }">
			<li>
			</c:if>
			<a href="/board/list.do?curPage=${page }">${page }</a>
			</li>
		</c:forEach>
		
		<%-- 다음 페이지 버튼 --%>
		<%-- 마지막 페이지면 금지 표시 --%>
		<c:if test="${paging.curPage eq paging.totalPage }">
		<li class="disabled">
			<a href="/board/list.do?curPage=${paging.curPage }" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
		</li>
		</c:if>
		<c:if test="${paging.curPage ne paging.totalPage }">
		<li>
			<a href="/board/list.do?curPage=${paging.curPage+1 }" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
		</li>
		</c:if>
	</ul>
</div>