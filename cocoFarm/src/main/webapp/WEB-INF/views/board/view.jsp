<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

</head><body>

<div class="container">

<h1>농부 스토리 상세 페이지</h1>
<hr>

글번호 : ${view.acc_idx }<br>
글제목 : ${view.title }<br>
본문 : ${view.content }<br>
작성일 : <fmt:formatDate value="${view.written_date }"
	   pattern="yy-MM-dd HH:mm:ss" /><br>
조회수 : ${view.hit }<br>

첨부파일: 
${boardFile.original_filename }<br>
${boardFile.stored_filename }<br>
${boardFile.upload_date }<br>
${boardFile.acc_idx }<br>

<img src="/img/todays_farmer_upload/${boardFile.stored_filename }">

<div class="text-center">	
	<a href="/board/list.do"><img src="/img/notice/list.gif" width="82" height="31" alt="목록보기"></a>
		
	<a href="/board/update.do?acc_idx=${view.acc_idx }"><button>수정</button></a>
	<a href="/board/delete.do?acc_idx=${view.acc_idx }"><button>삭제</button></a>
		
</div>

</div> <!-- container End -->

</body></html>