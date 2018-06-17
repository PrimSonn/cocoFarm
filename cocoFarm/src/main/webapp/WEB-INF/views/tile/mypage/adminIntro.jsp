<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle01"><h2>관리자</h2><h1>마이페이지</h1></div>
					<div class="mypageimg"><img src="/img/profile/${account.thumb_loc}" ></div>
					<div class="mypagewho"><span><strong>${sessionScope.name}</strong>님&nbsp;</span>환영합니다.</div>
					<div class="mail_box"><a class="nav-link" href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >1:1 문의함 확인</a></div>
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">회원 정보 관리</p>
					
					<ul>
						<li class="nav-link"><a href="/mypage/licenseList.do">사업자 등록 조회/승인</a></li>
						<li></li>
						<li class="nav-link"><a href="/mypage/wholeAcc.do">전체 회원 조회</a></li>
						<li class="nav-link"><a href="/mypage/delWholeAcc.do">탈퇴 회원 조회</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매 상품 관리</p>
					
					<ul>
						
						<li class="nav-link"><a href="/mypage/adminPaynee.do">회원 결제내역 조회</a></li>
					</ul>
					
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매 상품 관리</p>
					<ul>
						<!-- <li><a href="#">경매등록하기</a></li> -->
						<li><a href="/mypage/admin/admin_auctionCheck.do">전체 상품 조회</a></li>
						<li><a href="/mypage/admin/admin_auctionReceiptCheck.do">결제 내역 조회</a></li>
					</ul>
					
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">사이트관리</p>
					<ul>
						<!-- <li class="nav-link"><a href="/banner/write.do">배너 광고 관리</a></li> -->
						<li class="nav-link"><a href="/notice/write.do">공지사항 글 등록</a></li>
						<!-- <li class="nav-link"><a href="/board/write.do">농부스토리 글등록</a></li> -->
					</ul>
				</div>
			</div>