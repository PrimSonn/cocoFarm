<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="mypage_nav">
		<div class="mypage_topbusiness">
			<div class="mypagetitle"><h2>판매자 회원</h2> <h1>마이페이지</h1></div>
			<div class="mypageimg"><img src="/img/profile/${account.thumb_loc}" ></div>
			<div class="mypagewho"><span><strong>${sessionScope.name}</strong>님&nbsp 환영합니다.</span></div>
			<div class="mail_box"><a class="nav-link" href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>		
		</div>
	
		<div class="mypage_navbody">
			
			<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
			
			<ul>
				<li class="nav-link"><a href="/mypage/user/updateAccount.do">개인정보 수정</a></li>
				<li class="nav-link"><a href="/payNee.do">결제 내역 조회</a></li>
				<li><a href="/product/cart.do">장바구니 조회</a></li>
				<li class="nav-link"><a href="/mypage/deleteLicense.do">판매자 등록 삭제</a></li>
				<li class="nav-link"><a href="/mypage/deleteAcc.do">회원 탈퇴</a></li>
				
			</ul>
			
			<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
			
			<ul>
				<li><a href="/product/insert.do">판매등록하기</a></li>
				<li><a href="/product">판매상품 조회/수정</a></li>
				<li class="nav-link"><a href="/payNee.do">판매 결제 내역 조회 </a></li>
			</ul>
			<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매</p>
			<ul>
				<li><a href="/auction/auction_register.do">경매등록하기</a></li>
				<li><a href="/auction/auction_auctionCheck.do">등록 상품 조회하기</a></li>
				<li><a href="/auction/auction_bidCheck.do">입찰 상품 조회하기</a></li>
				<li><a href="/auction/auction_seller_receiptCheck.do">결제 상품 조회하기</a></li>
			</ul>
			
			<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">고객센터</p>
			<ul>
				<li class="nav-link"><a href="/mypage/writeInquiry.do">관리자에게 문의하기</a></li>
			</ul>
			
			
		</div>
	
	</div>