<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">


<!-- 아임포트 -->
<script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>




<script type="text/javascript">
$(document).ready(function() {
	var IMP = window.IMP;
	IMP.init('imp97619342');	// 가맹점 식별코드
	
	$(".payBtn").click(function(){
		console.log($(this).parent().parent().find(".auctionidx").val());
		console.log($(this).parent().parent().find(".amount").val());
		$.ajax({
			   type : "POST",
			   url : "/auction/auction_pay.do",
			   dataType : "json",
			   async: false,
			   data : {
				   auction_idx : $(this).parent().parent().find(".auctionidx").val(),
				   amount : $(this).parent().parent().find(".amount").val()
			   },
				success : function(data) {
				console.log('data.MainRcpt: '+data.MainRcpt);
					Main_Rcpt=data.MainRcpt;
					is_Done = data.isDone;
					alert("성공");
			   },
			   error : function(e) {
				  console.log(e.responseText);
				   
				   alert("실패"); 
			   }
			});
			console.log('--------------------');
			console.log('Main_Rcpt: '+Main_Rcpt);
			console.log('is_Done: '+is_Done);
			console.log('--------------------');
			if(is_Done != 0) {
				IMP.request_pay({
						pg : 'danal', //PG사 - 'kakao':카카오페이, 'html5_inicis':이니시스(웹표준결제), 'nice':나이스페이, 'jtnet':제이티넷, 'uplus':LG유플러스, 'danal':다날, 'payco':페이코, 'syrup':시럽페이, 'paypal':페이팔
						pay_method : 'phone', //결제방식 - 'samsung':삼성페이, 'card':신용카드, 'trans':실시간계좌이체, 'vbank':가상계좌, 'phone':휴대폰소액결제
						merchant_uid : Main_Rcpt, //고유주문번호 - random, unique
						name : '주문명:결제테스트', //주문명 - 선택항목, 결제정보 확인을 위한 입력, 16자 이내로 작성
						amount : $(this).parent().parent().find(".amount").val(), //결제금액 - 필수항목
						buyer_email : 'iamport@siot.do', //주문자Email - 선택항목
						buyer_name : '${sessionScope.name}', //주문자명 - 선택항목
						buyer_tel : '010-1234-5678', //주문자연락처 - 필수항목, 누락되면 PG사전송 시 오류 발생
						buyer_addr : '서울특별시 강남구 삼성동', //주문자주소 - 선택항목
						buyer_postcode : '123-456', //주문자우편번호 - 선택항목
						m_redirect_url : 'https://www.yourdomain.com/payments/complete' //모바일결제후 이동페이지 - 선택항목, 모바일에서만 동작
					}, function(rsp) { // callback - 결제 이후 호출됨, 이곳에서 DB에 저장하는 로직을 작성한다
							if ( rsp.success ) { // 결제 성공 로직
								var msg = '결제가 완료되었습니다.';
								msg += '고유ID :' + rsp.imp_uid;
								msg += '상점 거래ID :' + rsp.merchant_uid;
								msg += '결제 금액 :' + rsp.paid_amount;
								msg += '카드 승인번호 :' + rsp.apply_num;
						
								// 결제 완료 처리 로직
								//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
								jQuery.ajax({
											url: "/pay.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
											type: 'POST',
											dataType: 'json',
											async: false,
											data: {
		 									//merchant_uid : rsp.merchant_uid,
											imp_uid : rsp.imp_uid,
											//buyer_name :rsp.buyer_name 
											}
									}).done(function(data) {
										console.log(data);
										//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
										var result = data.result;
										
										if ( result==1 ) {
											var msg = '결제가 완료되었습니다.';
											msg += '\n고유ID : ' + rsp.imp_uid;
											msg += '\n상점 거래ID : ' + rsp.merchant_uid;
											msg += '\n결제 금액 : ' + rsp.paid_amount;
											msg += '\n카드 승인번호 : ' + rsp.apply_num;
											alert(msg);
										}else {
											//[3] 아직 제대로 결제가 되지 않았습니다.
											//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
											alert('result: ' +data.result+ '\n, reason: '+data.reason);
											/* 
											$.ajax({
												   type : "POST",
												   url : "/payfail.do",
												   dataType : "json",
												   async: false,
												   data : {
													   imp_uid : rsp.imp_uid
												   },
													success : function(data) {
													console.log('data.MainRcpt: '+data.MainRcpt);
														Main_Rcpt=data.MainRcpt;
													is_Done = data.isDone;
													alert("취소시 에이젝스 성공");
												   },
												   error : function(e) {
													  console.log(e.responseText);
													   
													   alert("취소시 에이젝스 실패"); 
												   }
												});
											 */
										}
									});
							} else { // 결제 실패 로직
								var msg = '결제에 실패하였습니다.';
								msg += '에러내용 : ' + rsp.error_msg;
								//임시 영수증 삭제 로직 추가.
								$.ajax({
									   type : "POST",
									   url : "/payfail.do",
									   dataType : "json",
									   async: false,
									   data : {
										   target : Main_Rcpt
									   },
										success : function(data) {
										console.log('취소시 에이젝스 성공 - '+'data.MainRcpt: '+data.MainRcpt);
//		 								alert("취소시 에이젝스 성공");
									   },
									   error : function(e) {
										  console.log(e.responseText);
//		 								   alert("취소시 에이젝스 실패"); 
									   }
								});
							}
//		 					alert(msg);
						});//아임포트 통신 Ajax 완료.
			} else{
				alert('임시저장 실패');
				//임시 영수증 삭제 로직 추가.
			}
	});
	
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
					<h1>나의 경매 입찰 현황 목록</h1>
					<div class="border_save">
					
					<table style="border-collapse: collapse; border:2px solid; border-color: #9e9e9e;">
					<thead>
						<tr>
						<th style="width:30px; border:1px solid; border-color: #9e9e9e;">번호</th>
						<th style="width:200px; border:1px solid; border-color: #9e9e9e;">입찰 품목</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">상태</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">입찰가</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">입찰일자</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">경매 종료일자</th>
						<th style="width:80px; border:1px solid; border-color: #9e9e9e;">입찰 취소</th>
						<th style="width:80px; border:1px solid; border-color: #9e9e9e;">결재 하기</th>
						</tr>
					</thead>
					
					<tbody>
					<c:if test="${empty memberBidList}">
						<tr><td colspan="6">유효 입찰 항목이 존재하지 않습니다.</td></tr>
					</c:if>
						<c:forEach items="${memberBidList}" var="memberBidList" varStatus="status">
						
						<tr>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${status.count}</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.title }</td>
							<c:choose>
								<c:when test="${memberBidList.state_code == 1}">
								<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="blue" style="font-weight: bold;">최고입찰</font></td>
								</c:when>
								<c:when test="${memberBidList.state_code == 2}">
								<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="black" style="font-weight: bold;">차등입찰</font></td>
								</c:when>
								<c:when test="${memberBidList.state_code == 3}">
								<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="red" style="font-weight: bold;">낙찰</font></td>
								</c:when>
								<c:when test="${memberBidList.state_code == 4}">
								<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="yellow" style="font-weight: bold;">차등낙찰</font></td>
								</c:when>
							</c:choose>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><fmt:formatNumber type="number" value="${memberBidList.amount }"/>원</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.bid_time }</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${memberBidList.time_window }</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">
							<input class="auctionidx" type="hidden" value="${memberBidList.auction_idx }">
							<input class="amount"  type="hidden" value="${memberBidList.amount }">
							<button class="btnCancel" style="cursor: pointer; margin-top: 1px;" >취소</button>
							</td>
							<c:choose>
								<c:when test="${memberBidList.state_code == 3}">
								<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">
								<button class="payBtn" style="cursor: pointer; margin-top: 1px;">결재</button>
								</td>
								</c:when>
								<c:otherwise>
								<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">-</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<c:if test="${memberBidList.state_code == 3}">
							<td colspan="8" style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">※상위 낙찰 경매의 입찰금 지불기한은 <font color="red" style="font-weight: bold;">" ${memberBidList.payment_due } "</font> 까지 입니다.※</td>
							</c:if>
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