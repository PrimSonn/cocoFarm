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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소 API -->
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
						
						<li class="nav-link"><a href="/product/cart.do">장바구니 조회</a></li>
						<li class="nav-link"><a href="/payNee.do">결제 내역 조회111111 </a></li>
						
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
			<div class="mypage_updateAccount">
				<div class="messageForm">
					<h1>쪽지함</h1>
					<select id="messageCate" name="messageCate">
					   <option value="1" <c:if test="${param.messageCate=='1' }">selected</c:if>>받은쪽지함</option>
					   <option value="2" <c:if test="${param.messageCate=='2' }">selected</c:if>>보낸쪽지함</option>
					</select>
<!-- 					<button id="sendMessageBtn">쪽지 보내기</button> -->
				</div>
			
				<div id="messageBox"></div>
			</div>
	
	
	
		</div>
	</div>
</div>	
</body>
</html>

