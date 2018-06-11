<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>

<head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#cancel").click(function(){
	alert("입찰 취소");
	window.close();
});

$("#bidding").click(function(){
	$form = $("<form>").attr({
		action: "/auction/auctionBid.do",
		method: "post"
	}).append(
		$("<input>").attr({
			type:"hidden",
			name:"auction_idx",
			value:"${bid.idx }"
		})
	).append(
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
<body>
경매 품목 : ${bid.title }<br>
판매자 : ${bid.name }<br>
경매 시작가 : ${bid.start_price }<br>
현재 입찰가 : ${bid.highest_bid }<br>

입찰금액 : <input type="text" id="amount"/><br>
<input type="button" id="bidding" value="입찰하기" />
<input type="button" id="cancel" value="취소"/>
</body>
</html>