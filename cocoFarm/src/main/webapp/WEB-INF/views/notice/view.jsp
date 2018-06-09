<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Notice View</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/notice.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 -->
</head>
<body>

<!--detail부분 header ver2부분  -->
<jsp:include page="/WEB-INF/views/tile/head/detailhead.jsp" flush="false"/>

<div class="container">

<h1 class=list_title01>공지사항</h1>


<!-- <img src="/img/notice/list_word.gif" alt="공지사항"><br> -->

<div class="table_board">
	<div class="table_title">
		<p>${view.title }</p>
		</div>
	<div class="table_num_time">
		<span class="no1">작성일 : <fmt:formatDate value="${view.written_date }"
		   pattern="yy-MM-dd HH:mm:ss" />
		</span>
		<span class="no2">글번호 : ${view.idx }
		</span>
	</div>
	<div class="board_content">
		${view.content }
	</div>	   
	   
</div>
<div class="text-center border_button">	
	<a href="/notice/list.do"><img src="/img/notice/list.gif" width="82" height="31" alt="목록보기"></a>
	<c:if test="${sessionScope.type eq 1 }">		
	<a href="/notice/update.do?idx=${view.idx }"><button class="border_update_btn">수정</button></a>
	<a href="/notice/delete.do?idx=${view.idx }"><button class="border_delete_btn">삭제</button></a>
	</c:if>	
</div>

</div> <!-- container End -->

</body></html>