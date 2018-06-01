<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="pg_wrap">
	<ul class="pg_page">
		<%-- 첫 페이지 버튼 --%>
		<%-- 첫 페이지가 아니면 버튼 노출 --%>
		<c:if test="${paging.curPage ne 1 }">
		<li>
			<a href="/product?curPage=1">
				<span class="pg_start">&larr;</span>
			</a>
		</c:if>
		
		<%-- 이전 페이지 버튼 --%>
		<%-- 첫 페이지면 금지 표시 --%>
		<c:if test="${paging.curPage eq 1 }">
		<li class="pg_prev">
			<a href="/product?curPage=${paging.curPage }">
				<span class="pg_prev">&laquo;</span>
			</a>
		</li>
		</c:if>
		<c:if test="${paging.curPage ne 1 }">
		<li>
			<a href="/product?curPage=${paging.curPage-1 }">
				<span class="pg_prev">&laquo;</span>
			</a>
		</li>
		</c:if>
		
		<%-- 페이징 번호 버튼 --%>
		<c:forEach begin="${paging.startPage }"
			end="${paging.endPage }"
			var="page">
			
			<%-- 페이지 번호가 현재페이지면 파랑색으로 보이기 --%>
			<c:if test="${paging.curPage eq page }">
			<li class="pg_current">
			</c:if>
			<c:if test="${paging.curPage ne page }">
			<li>
			</c:if>
			<a href="/product?curPage=${page }">${page }</a>
			</li>
		</c:forEach>
		
		<%-- 다음 페이지 버튼 --%>
		<%-- 마지막 페이지면 금지 표시 --%>
		<c:if test="${paging.curPage eq paging.totalPage }">
		<li class="pg_next">
			<a href="/product?curPage=${paging.curPage }">
				<span class="pg_next">&raquo;</span>
			</a>
		</li>
		</c:if>
		<c:if test="${paging.curPage ne paging.totalPage }">
		<li>
			<a href="/product?curPage=${paging.curPage+1 }">
				<span class="pg_next">&raquo;</span>
			</a>
		</li>
		</c:if>
	</ul>
</div>