<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>판매 상품 조회</title>

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
					<div class="mypagewho"><span><strong>김환민</strong>님&nbsp</span>hwanmin0121</div>
					<div class="mail_box"><a href="#"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
		
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li><a href="#">개인정보 수정</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="/product/basket.do">장바구니 조회</a></li>
						<li><a href="#">회원 탈퇴</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					
					<ul>
						<li><a href="/product/insert.do">판매등록하기</a></li>
						<li><a href="/product">판매상품 조회/수정</a></li>
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
					<h1>농산물 판매 상품 조회/수정 </h1>
					
					<div class="product_list">
					
					<table align="center">
						<tr class="tr_back">
							<th class="th_idx">번호</th>
							<th class="th_option">옵션명</th>
							<th class="th_amount">판매 수량</th>
							<th class="th_price">가격</th>
							<th class="th_update"></th>
						</tr>
						
<!-- 						<tr class="tr_back"	align="center"> -->
<%-- 							<td>${list.idx }</td> --%>
<%-- 							<td>${list.optionName }</td> --%>
<%-- 							<td>${list.startAmount }</td> --%>
<%-- 							<td>${list.price }원</td> --%>
<%-- 							<td><a href="/product/update.do?idx=${list.idx }">수정</a>&nbsp;&nbsp; --%>
<!-- 									<a href="#">삭제</a></td> -->
<!-- 						</tr> -->
						
						<c:forEach items="${list }" var="i">
						<tr class="tr_back"	align="center">
							<td>${i.idx }</td>
							<td>${i.optionName }</td>
							<td>${i.startAmount }</td>
							<td>${i.price }원</td>
							<td><button onclick="location.href='/product/update.do?idx=${i.idx }&saleIdx=${i.saleIdx }'" class="td_update">수정</button></td>
						</tr>
						</c:forEach>
					</table>
					
					<jsp:include page="/WEB-INF/views/util/paging.jsp" />
					
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	

</body>
</html>

