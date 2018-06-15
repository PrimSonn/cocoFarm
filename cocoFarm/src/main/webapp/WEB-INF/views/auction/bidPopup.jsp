<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE>
<html>

<head>
<style type="text/css">
body{
    background: url(/auction_img/popupbackground.jpg) no-repeat center center fixed; 
    -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;
}

</style>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#cancel").click(function(){
	alert("입찰 진행 취소 하셨습니다.");
	window.close();
});

$("#bidding").click(function(){
	$form = $("<form>").attr({
		action: "/auction/auctionBid.do",
		method: "post"
	})
	.append(
		$("<input>").attr({
			type:"hidden",
			name:"auction_idx",
			value:"${bid.idx }"
		})
	)
	.append(
		$("<input>").attr({
			type:"hidden",
			name:"highest_bid",
			value:"${bid.highest_bid }"
		})
	)
	.append(
		$("<input>").attr({
			type:"hidden",
			name:"start_price",
			value:"${bid.start_price }"
		})
	)
	.append(
		$("<input>").attr({
			type:"hidden",
			name:"title",
			value:"${bid.title }"
		})
	)
	.append(
		$("<input>").attr({
			type:"hidden",
			name:"name",
			value:"${bid.name }"
		})
	)
	.append(
		$("<input>").attr({
			type:"hidden",
			name:"amount",
			value:$("#amount").val()
		})
	);
	$(document.body).append($form);
	$form.submit();
// 	window.close();
// 	window.opener.location.reload();
});
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body >
	<div>
		<div style="margin-top: 40px;">
			<table style="margin: auto; border-collapse: collapse; line-height: 1.7;">
				<thead>
					<tr>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					
					<tr style="background: #ffffff">
						<td style="border: 2px solid black;">경매 품목 :</td>
						<td style="border: 2px solid black;">${bid.title }</td>
					</tr>
					<tr style="background: #ffffff">
						<td style="border: 2px solid black;">판매자 :</td>
						<td style="border: 2px solid black;">${bid.name }</td>
					</tr>
					<tr style="background: #ffffff">
						<td style="border: 2px solid black;">경매 시작가 :</td>
						<td style="border: 2px solid black;">${bid.start_price }</td>
					</tr>
					<tr style="background: #ffffff">
						<td style="border: 2px solid black;">현재 입찰가 :</td>
						<td style="border: 2px solid black;">${bid.highest_bid }</td>
					</tr>
					<tr height="30px"><td></td><td></td></tr>
					<tr style="background: #ffffff">
						<td colspan="2" style="border: 2px solid black;">입찰금액 : <input type="text" id="amount" autofocus="autofocus" placeholder="금액을 입력하세요" style="margin-bottom: 4px;"/></td> 
						
					</tr>
					<tr style="background: #ffffff"><td colspan="2" style="border: 2px solid black;">
						<c:set var="rawPosCost" value="${bid.highest_bid+bid.highest_bid*0.1}"/>
						(현재 최소 입찰 가능 가격은 <fmt:formatNumber value="${rawPosCost+(1-(rawPosCost%1))%1}" type="number" />원  입니다.)
						
						</td>
					</tr>
				</tbody>
			</table>
		<div style="text-align: center; margin-top: 38px;">
			<input type="button" id="bidding" value="입찰하기" /> 
			<input type="button" id="cancel" value="취소" />
		</div>
		</div>
	</div>
</body>
</html>