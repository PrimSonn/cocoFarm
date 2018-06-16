<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
	<table class="message_table" style="table-layout:fixed; word-break:break-all; text-align:center; border-bottom:1px solid #ddd;">
		<thead>
			<tr>
				<th class="message_th">판매자 이름</th>
				<th class="message_th">판매글 제목</th>
				<th class="message_th">구매자 이름</th>
				<th class="message_th">구매한 옵션</th>
				<th class="message_th">옵션 수량</th>
				<th class="message_th">옵션 단위</th>
				<th class="message_th">옵션 단가</th>
				<th class="message_th">총결제금액</th>
				<th class="message_th">결제 시간</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${adminPaynee }" var="adminPaynee">
			<tr>
				<td class="message_td">${adminPaynee.seller }</td>
				<td class="message_td">${adminPaynee.sale_title }</td>
				<td class="message_td">${adminPaynee.buyer }</td>
				<td class="message_td">${adminPaynee.name }</td>
				<td class="message_td">${adminPaynee.amount }</td>
				<td class="message_td">${adminPaynee.unit }</td>
				<td class="message_td">${adminPaynee.price }</td>
				<td class="message_td">${adminPaynee.money_amount }</td>
				<td class="message_td"><fmt:formatDate value="${adminPaynee.contract_time }" pattern="yyyy-MM-dd"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<br>
	<br>

</div>

</body>
</html>