<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/paynee.css">

<script type="text/javascript">
/* 상품평 등록 버튼 눌렀을 때 */
$(".insertComm_button").click(function() {
	var receipt_idx = $(this).parent().parent().find("#receipt_idx").text();
	
	var arr = new Array();
	var obj = new Object();
	
	var cont = $("#commentContent").val();
	
	if(cont === "") {
		arr.push(null);
	} else {
		obj.main_recpt_idx = $(this).val();
		obj.content = cont;
		arr.push(obj);
	}
	
	$.ajax({
		type: "POST"
			, url: "/product/insertComment.do"
			, dataType: "json"
			, data: {
				receiptIdx: receipt_idx
				, insertComm: JSON.stringify(arr)
			}
			, success: function(data) {
				alert("상품평이 등록되었습니다.");
				$("#commentContent").val("");
			}
	});

});
</script>
</head>
<body>

<div class="comment_insert">
	<div class="comment_cmt">
		<div>상품 후기 작성</div><br>
		<!-- 상품 후기 등록 -->
		<div class="form-inline text-cefnter" id="commentList">
		
			<input type="text" size="7" class="form-control"
				id="commentWriter"
				value="${sessionScope.name }" readonly="readonly"/>
			<textarea rows="3" cols="60"
				class="form-control" id="commentContent"></textarea>
			
		</div>
	</div>
</div>

<div>
   <table class="message_table01" style="table-layout:fixed; word-break:break-all; text-align:center; border-bottom:1px solid #ddd;" >
      <colgroup>
					<col width="100px">
					<col width="100px">
					<col width="200px">
					<col width="50px">
<%-- 					<col width="200px"> --%>
					<col width="90px">
					<col width="100px">
					<col width="110px">
					<col width="70px">
		</colgroup>
      <thead>
      
      
         <tr style="border-bottom:1px solid #ddd;">
            <th class="message_num">주문번호</th> <!--주문번호  -->
            <th class="message_th">판매자 이름</th>
            <th class="message_th">구매한 옵션</th>
            <th class="message_th">수량</th>
<!--             <th class="message_th">판매글 제목</th> -->
            <th class="message_th">옵션 단가</th>
            <!-- <th class="message_th">옵션 단위</th> -->
            <th class="message_th">총결제금액</th>
            <th class="message_th" style="width: 100px;">결제 시간</th>
            <th class="message_th">상품평</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach items="${paynee }" var="paynee">
				<tr class="message">
         	<td class="message_td" id="receipt_idx">${paynee.idx}</td>
         	<td class="message_td">${paynee.seller }</td>
        	<td class="message_td" id="product_title">${paynee.name }</td> <!--구매한 옵션  -->
					<td class="message_td">${paynee.amount }</td> <!--수량  -->
<%--           <td class="message_td">${paynee.sale_title }</td> <!--판매글제목 --> --%>
          <td class="message_td">${paynee.price }</td>
            
            <%-- <td class="message_td">${paynee.unit }</td> --%>
            
          <td class="message_td">${paynee.money_amount }</td>
          <td class="message_td"><fmt:formatDate value="${paynee.contract_time }" pattern="yyyy-MM-dd"/></td>
         	<td class="message_td">
         		<button class="insertComm_button"	value="${paynee.main_recpt_idx }">등록</button></td>
         </tr>
      </c:forEach>
      </tbody>
   </table>
   <br>
   <br>

</div>

</body>
</html>