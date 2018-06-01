<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>판매 상품 조회</title>
<link rel="stylesheet" type="text/css" href="/css/board.css">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

</head>
<body>
<div class="mypage_update">
	<div class="border">
		<h1>농산물 판매 상품 조회 </h1>
		
		<div class="border_save">
		
		<table align="center">
			<tr class="tr_back">
				<th class="th_idx">번호</th>
				<th class="th_option">옵션명</th>
				<th class="th_amount">판매 수량</th>
				<th class="th_price">가격</th>
				<th class="th_update"></th>
			</tr>
			
<!-- 						<tr class="tr_back"	align="center"> -->
<%-- 							<td>${list.idx }</td> --%>
<%-- 							<td>${list.optionName }</td> --%>
<%-- 							<td>${list.startAmount }</td> --%>
<%-- 							<td>${list.price }원</td> --%>
<%-- 							<td><a href="/product/update.do?idx=${list.idx }">수정</a>&nbsp;&nbsp; --%>
<!-- 									<a href="#">삭제</a></td> -->
<!-- 						</tr> -->
			
			<c:forEach items="${list }" var="i">
			<tr class="tr_back"	align="center">
				<td>${i.idx }</td>
				<td>${i.optionName }</td>
				<td>${i.startAmount }</td>
				<td>${i.price }원</td>
				<td><button onclick="location.href='/product/update.do?idx=${i.idx }'" class="td_update">수정</a></td>
			</tr>
			</c:forEach>
		</table>
		
		<jsp:include page="/WEB-INF/views/util/paging.jsp" />
		
		</div>
	</div>
</div>

</body>
</html>

