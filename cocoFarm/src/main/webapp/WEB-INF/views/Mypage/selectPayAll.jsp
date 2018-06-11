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
	<table style="border: 1px solid;">
		<thead>
			<tr>
				<th>번호</th>
				<th>결제번호</th>
				<th>결제 계정 번호</th>
				<th>가격</th>
				<th>결제자 이름</th>
				<th>결제코드번호</th>
				<th>주영수증 상태코드</th>
				<th>환불대상영수증번호</th>
				<th>결제시간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${mainReceiptList }" var="mainReceipt">
				<tr>
					<td>${mainReceipt.idx }</td>
					<td>${mainReceipt.payment_code }</td>
					<td>${mainReceipt.buyer_idx }</td>
					<td>${mainReceipt.money_amount }</td>
					<td>${mainReceipt.paid_name }</td>
					<td>${mainReceipt.paid_code }</td>
					<td>${mainReceipt.state_code }</td>
					<td>${mainReceipt.refund_of }</td>
					<td><fmt:formatDate value="${mainReceipt.contract_time }" /></td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>
	<br>
</div>

</body>
</html>