<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/paynee.css">


</head>
<body>

<div>
   <table class="message_table" style="border: 1px solid;">
      <thead>
      	<caption>결제 내역</caption>
      		<colgroup>
					<col width="100px">
					<col width="50">
					<col width="120">
					<col width="90">
					<%-- <col width="50"> --%>
					<col width="50">
					<col width="110">
					<col width="110">	
			</colgroup>
      
      
      
      
      
         <tr>
            <th class="message_num">주문번호</th> <!--주문번호  -->
            <th class="message_th">판매자 이름</th>
    
            <th class="message_th">구매한 옵션</th>
            <th class="message_th">옵션 수량</th>
            <!-- <th class="message_th">옵션 단위</th> -->
            <th class="message_th">옵션 단가</th>
            <th class="message_th">총결제금액</th>
            <th class="message_th">결제 시간</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach items="${paynee }" var="paynee">
         <tr>
         	<td class="message_td">${paynee.idx}</td>
            <td class="message_td">${paynee.sale_title }</td>
            <td class="message_td">${paynee.seller }</td>
            
            <td class="message_td">${paynee.name }</td>
            <td class="message_td">${paynee.amount }</td>
            <%-- <td class="message_td">${paynee.unit }</td> --%>
            <td class="message_td">${paynee.price }</td>
            <td class="message_td">${paynee.money_amount }</td>
            <td class="message_td">${paynee.contract_time }</td>
         </tr>
      </c:forEach>
      </tbody>
   </table>
   <br>
   <br>

</div>

</body>
</html>