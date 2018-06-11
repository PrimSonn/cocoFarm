<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>장바구니 조회</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
$(document).ready(function() {	
	$(".mypage_navbody").on("click", ".nav-link", function() {
		var page = $(this).children().attr("href");
		console.log(page);
		
		$(".mypage_page01").load(page);
		
		return false;
	});
	
	$(".mail_box").on("click", ".nav-link", function() {
		var page = $(this).attr("href");
		console.log(page);
		
		$(".mypage_page01").load(page);
		
		return false;
	});
	
});
</script>



<script>





(function() {
	var tableEl = document.querySelector('.tr_cartItem');
	var mainHtml = tableEl.innerHTML;
	var routerMap = {
		'' : function() {
			tableEl.innerHTML = mainHtml;
		}
	}
	
	function otherwise() {
		tableEl.innerHTML =
	    'Not Found';
	}

})

function cartItems() {
// 	var size = ${optionView };
}

$(document).ready(function() {
	
	/* 장바구니 옵션 변경 버튼 */
	$.ajax({
		type: "POST"
		, url: "/product/cart.do"
		, data: {
			// 장바구니 상품
		}
		, dataType: "json"
		, success: function(data) {
			
		}
	})
	
});


</script>

</head>
<body>
<div id="mypageheader">

<!--Mypage부분 header ver3부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mypagehead.jsp" flush="false"/>

	<div class="container">
		<!--Mypage부분  검색 로고부분 -->
		<jsp:include page="/WEB-INF/views/tile/head/mypageSearch.jsp" flush="false"/>

		<div class="mypage_box">
			<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle03"><h2>일반 회원</h2><h1>마이페이지</h1></div>
					<div class="mypageimg"><img src="/img/profile/${account.thumb_loc}" ></div>
					<div class="mypagewho"><span><strong>${sessionScope.name}</strong>님&nbsp;</span>환영합니다.</div>
					<div class="mail_box"><a class="nav-link" href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li class="nav-link"><a href="/mypage/user/updateAccount.do">개인정보 수정</a></li>
						<li class="nav-link"><a href="/mypage/deleteAcc.do">회원 탈퇴</a></li>
						<li class="nav-link"><a href="/mypage/license.do">사업자 등록하기</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">상품보기</p>
					
					<ul>
						
						<li><a href="/product/basket.do">장바구니 조회</a></li>
						<li><a href="#">결제 내역 조회 </a></li>
						
					</ul>
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매</p>
					<ul>
						<!-- <li><a href="#">경매등록하기</a></li> -->
						<li><a href="#">경매 상품 조회하기</a></li>
					</ul>
					
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">고객센터</p>
					<ul>
						<li class="nav-link"><a href="/mypage/writeInquiry.do">관리자에게 문의하기</a></li>
					</ul>
					
				</div>
			
			</div>
			
<div class="mypage_page01">
	<div class="border">
		<h1>장바구니 조회 </h1>
		
		<div class="product_list">
		
		<table align="center">
			<tr class="tr_back">
				<th class="th_checkbox"><input type="checkbox" id="chk_all" name="chk_all"></th>
				<th class="th_inform">상품정보</th>
				<th class="th_price">상품금액</th>
				<th class="th_delivery">배송비</th>
			</tr>
			
			<tr class="tr_back" id="tr_cartItem"	align="center">
				<td class="td_checkbox"><input type="checkbox" id="chk_basket" name="chk_basket"></td>
				<td>
					<div>
					<img src="http://img1.daumcdn.net/thumb/C500x500.q75/?scode=farmer&fname=http%3A%2F%2Ft1.daumcdn.net%2Fkakaofarmer%2Fimages%2F2018-06-01%2F71d3322e2b354009b318d5d8b2388e71.jpg" align="left" width="140px" height="140px" />
					<div class="td_productName">경주 체리 2kg</div></div><br>
					<div class="td_optionName">옵션1</div>
					<div class="td_optionName">옵션2</div>
					<div style="float: right;"><button class="td_update">옵션 변경</button></div>
				</td>
				<td>41,900원</td>
				<td>무료</td>
			</tr>
			
		
			<tr class="tr_back"	align="center">
				<th><input type="checkbox" id="chk_all" name="chk_all"></th>
				<th style="text-align: left;"><button class="basket_delete">삭제</button></th>
				<th></th>
				<th></th>
			</tr>
		</table>
		<div class="warning">카트에 담긴 상품은 최대 30일까지 보관되며 종료되거나 매진될 경우 자동으로 삭제됩니다.</div>
		
		</div>
		
		<table class="payment_amount">
			<tr class="tr_payment">
				<td class="name_price">총 주문금액</td>
				<td class="name_price" id="border_payment">총 상품금액</td>
				<td class="real_price" id="border_payment">19,900원</td>
			</tr>
			<tr class="tr_payment">
				<td id="border_payment" style="width: 440px;"></td>
				<td class="name_price" id="border_payment">배송비</td>
				<td class="real_price" id="border_payment">2,500원</td>
			</tr>
		</table>
		
		<table class="payment_amount">
			<tr class="tr_payment">
				<td class="name_total" id="border_payment">결제 예상금액</td>
				<td id="border_payment"></td>
				<td class="real_total" id="border_payment">22,400원</td>
			</tr>
		</table>
		
		<div class="save_group">
			<button class="return">쇼핑 계속하기</button>
			<button class="purchase">구매하기</button>
		</div>
		
	</div>
</div>

			</div>
	</div>
</div>	
</body>
</html>

