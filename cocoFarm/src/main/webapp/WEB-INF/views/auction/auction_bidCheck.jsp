<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>




<script type="text/javascript">
$(document).ready(function() {
	$(".btnCancel").click(function() {
// 		auction idx확인까진 끝
		console.log($(this).parent().find(".auctionidx").val());
		console.log($(this).parent().find(".amount").val());
		var checkok = confirm("입찰을 취소하시겠습니까?")
		if(checkok==true){
		$form = $("<form>").attr({
			action: "/auction/auction_bidCancel.do",
			method: "GET"
		}).append(
			$("<input>").attr({
				type:"hidden",
				name:"amount",
				value:$(this).parent().find(".amount").val()
			})
		).append(
			$("<input>").attr({
				type:"hidden",
				name:"auction_idx",
				value:$(this).parent().find(".auctionidx").val()
			})
		);
		$(document.body).append($form);
		$form.submit();
		}else if(checkok==false){
			alert("입찰 취소 진행이 중단되었습니다.")
		}
	});
	
});
</script>




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
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/login/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="/login/join.do">회원가입</a></li>
			</c:if>
			<li><a href="#">알림</a></li>	
			<li><a href="/mypage/mypage.do">마이페이지</a></li>	
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
					<div class="mypagetitle">
					<c:if test="${sessionScope.type eq 1 }"><h2>관리자</h2></c:if>
					<c:if test="${sessionScope.type eq 2 }"><h2>판매자 회원</h2></c:if> 
					<c:if test="${sessionScope.type eq 3 }"><h2>일반 회원</h2></c:if>
					<h1>마이페이지</h1></div>
					<div class="mypageimg"><img class="profile" src="/img/profile/${account.thumb_loc }"></div>
					<div class="mypagewho"><span><strong>김환민</strong>님&nbsp</span>hwanmin0121</div>
					<div class="mail_box"><a href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
		
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li><a href="/mypage/user/updateAccount.do">개인정보 수정</a></li>
						<li><a href="/mypage/license.do">판매자 등록</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="#">장바구니 조회</a></li>
						<li><a href="/mypage/deleteAcc.do">회원 탈퇴</a></li>
					</ul>
					
					<c:if test="${sessionScope.type eq 2 or sessionScope.type eq 1 }">
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					<ul>
						<li><a href="#">판매등록하기</a></li>
						<li><a href="#">판매상품 조회/수정</a></li>
						<li><a href="#">판매 결제 내역 조회 </a></li>
						<li><a href="#">판매 결제 배송 승인</a></li>
					</ul>
					</c:if>
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매</p>
					<ul>
						<li><a href="#">입찰 상품 조회하기</a></li>
						<li><a href="#">낙찰 상품 조회하기</a></li>
					</ul>
					
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">고객센터</p>
					<ul>
						<li><a href="#">관리자에게 문의하기</a></li>
					</ul>
					
					
				</div>
			
			
			
			
			</div>
			
			<div class="mypage_page01">
				<div class="border">
					<h1>나의 경매 입찰 목록</h1>
					<div class="border_save">
					
					<table style="border-collapse: collapse; border:2px solid; border-color: #9e9e9e;">
					<thead>
						<tr>
						<th style="width:30px; border:1px solid; border-color: #9e9e9e;">번호</th>
						<th style="width:300px; border:1px solid; border-color: #9e9e9e;">입찰 품목</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">입찰가</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">입찰일자</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">경매 종료일자</th>
						<th style="width:80px; border:1px solid; border-color: #9e9e9e;">입찰 취소</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach items="${memberBidList}" var="memberBidList" varStatus="status">
						<tr>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${status.count}</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.title }</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.amount } 원</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.bid_time }</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.time_window }</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">
							<input class="auctionidx" type="hidden" value="${memberBidList.auction_idx }">
							<input class="amount"  type="hidden" value="${memberBidList.amount }">
							<button class="btnCancel" style="cursor: pointer; margin-top: 1px;" >취소</button>
							</td>
						</tr>
						</c:forEach>
					</tbody>
					</table>
					
						

					</div>
			
			
				</div>
			
			
			
			
			
			</div>
			
			
			
			
		</div>
	
	</div>
	
	
</div>	


</body>
</html>