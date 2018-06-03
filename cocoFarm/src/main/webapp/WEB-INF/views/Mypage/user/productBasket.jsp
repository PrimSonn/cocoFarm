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

</head>
<body>
<div id="mypageheader">

	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<li><a href="#">고객</a></li>
			<li><a href="#">사업자</a></li>
			<li><a href="#">관리자</a></li>
		</ul>
		
		<ul class="left_list">
			<li><a href="#">로그인</a></li>
			<li><a href="#">회원가입</a></li>
			<li><a href="#">알림</a></li>	
			<li><a href="#">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
			<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
			<div class="search"><input type="text" placeholder="농산물 검색하기"><button class="search_icon"></button> </div>
		</div>
		<div class="mypage_box">
			<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle"><h2>판매자 회원</h2> <h1>마이페이지</h1></div>
					<div class="mypageimg"><img src="/img/mypage/1344.png" ></div>
					<div class="mypagewho"><span><strong>김환민</strong>님&nbsp;</span>hwanmin0121</div>
					<div class="mail_box"><a href="#"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
		
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li><a href="#">개인정보 수정</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="#">장바구니 조회</a></li>
						<li><a href="#">회원 탈퇴</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					
					<ul>
						<li class="nav-link"><a href="/product/insert.do">판매등록하기</a></li>
						<li class="nav-link"><a href="/product">판매상품 조회/수정</a></li>
						<li><a href="#">판매 결제 내역 조회 </a></li>
						<li><a href="#">판매 결제 배송 승인</a></li>
					</ul>
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매</p>
					<ul>
						<li><a href="#">경매등록하기</a></li>
						<li><a href="#">경매 상품 조회하기</a></li>
					</ul>
					
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">고객센터</p>
					<ul>
						<li><a href="#">관리자에게 문의하기</a></li>
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
			
			<tr class="tr_back"	align="center">
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
				<td>2,500원</td>
			</tr>
			
			<tr class="tr_back"	align="center">
				<td class="td_checkbox"><input type="checkbox" id="chk_basket" name="chk_basket"></td>
				<td>
					<img src="//img1.daumcdn.net/thumb/C500x500.q75/?scode=farmer&fname=http%3A%2F%2Ft1.daumcdn.net%2Fkakaofarmer%2Fimages%2F2017-09-13%2Fd0dec3bc1c8248f39457849e7700f097.jpg" align="left" width="140px" height="140px" />
					<div class="td_productName">김천 거봉포도 4kg</div><br>
					<div class="td_optionName">옵션1</div>
					<div class="td_optionName">옵션2</div>
					<div class="td_optionName">옵션3</div>
					<div style="float: right;"><button class="td_update">옵션 변경</button></div>
				</td>
				<td>39,900원</td>
				<td>무료</td>
			</tr>
			
			<tr class="tr_back"	align="center">
				<td class="td_checkbox"><input type="checkbox" id="chk_basket" name="chk_basket"></td>
				<td>
					<img src=//img1.daumcdn.net/thumb/C500x500.q75/?scode=farmer&fname=http%3A%2F%2Ft1.daumcdn.net%2Fkakaofarmer%2Fimages%2F2018-05-29%2F88430634ff4f429ca0c2d4f4a7dca337.jpg  align="left" width="140px" height="140px" />
					<div class="td_productName">고령 멜론 4종 혼합세트</div><br>
					<div class="td_optionName">옵션1</div>
					<div style="float: right;"><button class="td_update">옵션 변경</button></div>
				</td>
				<td>29,900원</td>
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

