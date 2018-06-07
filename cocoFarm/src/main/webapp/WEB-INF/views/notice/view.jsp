<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice View</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style></style>

</head><body>
<div class="container">

<h1>공지사항 페이지</h1>
<hr>

<img src="/img/notice/list_word.gif" alt="공지사항"><br>

글번호 : ${view.idx }<br>
글제목 : ${view.title }<br>
본문 : ${view.content }<br>
작성일 : <fmt:formatDate value="${view.written_date }"
	   pattern="yy-MM-dd HH:mm:ss" /><br>

<div class="text-center">	
	<a href="/notice/list.do"><img src="/img/notice/list.gif" width="82" height="31" alt="목록보기"></a>
	<c:if test="${sessionScope.type eq 1 }">		
	<a href="/notice/update.do?idx=${view.idx }"><button>수정</button></a>
	<a href="/notice/delete.do?idx=${view.idx }"><button>삭제</button></a>
	</c:if>	
</div>

</div> <!-- container End -->

</body></html>