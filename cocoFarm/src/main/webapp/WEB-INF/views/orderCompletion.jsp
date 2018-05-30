<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
주문 완료
<br/>
주문 아이템
<ul>
	<c:forEach var="item" items="${orderCommand.orderItems}">
	<li>${item.itemId} / ${item.number} / ${item.remark}</li>
	</c:forEach>
</ul>
배송지: ${orderCommand.address}
</body>
</html>