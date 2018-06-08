<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board List</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		location.href="/board/write.do"
	});
	
	
	$("#btnMain").click(function() {
		location.href="/main"
	});
	
});
</script>

<style type="text/css">
table, th {
	text-align: center;
}
</style>

</head><body>

<div class="container">
<h1>농부 스토리 리스트</h1>
<hr>

<table class="table table-striped table-hover">
<thead>
	<tr>
		<th>번호</th>
		<th></th>		
		<th>제목</th>
		<th></th>		
		<th>작성일</th>
		<th>조회수</th>			
	</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="i">
	<tr>
		<td>${i.acc_idx }</td>
		<td></td>
		<td><a href="/board/view.do?acc_idx=${i.acc_idx }">${i.title }</a></td>
		<td></td>
		<td>
			<fmt:formatDate value="${i.written_date }"
			pattern="yy-MM-dd" />
		</td>
		<td>${i.hit }</td>		
	</tr>	
	
</c:forEach>
</tbody>		
</table>

<button id="btnMain" class="btn pull-left">메인으로</button>
		
<button id="btnWrite" class="btn pull-right">글쓰기</button>


<jsp:include page="/WEB-INF/views/util/board_paging.jsp" />

</div>



</body></html>