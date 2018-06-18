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
<link rel="stylesheet" type="text/css" href="/css/board.css">

<script type="text/javascript">
/* 상품 후기 열기 눌렀을 때, 상품평 등록 버튼 눌렀을 때 */
function viewComment() {
	var productIdx = ${product.idx };
	
	var arr = new Array();
	var obj = new Object();
	
	var cont = $("#commentContent").val();
	if(cont === "") {
		arr.push(null);
	} else {
// 		obj.saleIdx = ${product.idx };
// 		obj.title = "${product.title }";
		obj.content = cont;
		arr.push(obj);
	}
	
	$.ajax({
		type: "POST"
			, url: "/product/viewComment.do"
			, dataType: "json"
			, data: {
				sale_idx: productIdx
				, insertComm: JSON.stringify(arr)
			}
			, success: function(data) {
				var result = data;
				var str = "";
				$.each(result, function(idx, val) {
					str += '<span class="wrap_profile">'
						+	'<span class="comm_accName">'+ result[idx].acc_name +'</span></span>'
						+ '<br/><span class="comm_starImg">'+ result[idx].score+'</span>점'
						+ '<div class="wrap_cont"><span class="txt_prod">${product.title }</span>'
						+ '<p class="desc_cmt"><span><span class="comm_content">'+ result[idx].content +'</span></span></p>'
						+ '</div>';
				});
				document.getElementById("comment_items").innerHTML = str;
			}
	});
}
</script>
</head>
<body>

<div>
   <table class="message_table01" style="table-layout:fixed; word-break:break-all; text-align:center; border-bottom:1px solid #ddd;" >
      <colgroup>
					<col width="100px">
					<col width="100px">
					<col width="120px">
					<col width="50px">
					<%-- <col width="50"> --%>
					<col width="120px">
					<col width="110">
					<col width="110">	
		</colgroup>
      <thead>
      	
      		<div class="comment_cmt">
		<!-- 상품 후기 등록 -->
		<div class="form-inline text-cefnter" id="commentList">
		
			<input type="text" size="7" class="form-control"
				id="commentWriter"
				value="${sessionScope.name }" readonly="readonly"/>
			<textarea rows="3" cols="60"
				class="form-control" id="commentContent"></textarea>
			
		</div>
		
		<div class="cmt_cont" id="comment_items">
		</div>
     
         <tr style="border-bottom:1px solid #ddd;">
            <th class="message_num">주문번호</th> <!--주문번호  -->
            <th class="message_th">판매자 이름</th>
            <th class="message_th">구매한 옵션</th>
            <th class="message_th">수량</th>
            <th class="message_th">판매글 제목</th>
            <th class="message_th">옵션 단가</th>
            <!-- <th class="message_th">옵션 단위</th> -->
            
            <th class="message_th">총결제금액</th>
            <th class="message_th" style="width: 100px;">결제 시간</th>
            <th class="message_th">상품평</th>
         </tr>
      </thead>
      <tbody>
      <c:forEach items="${paynee }" var="paynee">
         <tr>
         	<td class="message_td">${paynee.idx}</td>
         	<td class="message_td">${paynee.seller }</td>
        	<td class="message_td">${paynee.name }</td> <!--구매한 옵션  -->
           <td class="message_td">${paynee.amount }</td> <!--수량  -->
           <td class="message_td">${paynee.sale_title }</td><!--판매글제목 -->
           <td class="message_td">${paynee.price }</td>
            
            <%-- <td class="message_td">${paynee.unit }</td> --%>
            
            <td class="message_td">${paynee.money_amount }</td>
            <td class="message_td"><fmt:formatDate value="${paynee.contract_time }" pattern="yyyy-MM-dd"/></td>
         		<td class="message_td">
         			<button class="insertComm_button"	onclick="viewComment();">등록</button></td>
         			
         </tr>
      </c:forEach>
      </tbody>
   </table>
   <br>
   <br>

</div>

</body>
</html>