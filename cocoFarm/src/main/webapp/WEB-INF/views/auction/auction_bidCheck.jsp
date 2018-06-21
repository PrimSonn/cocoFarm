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
<link rel="stylesheet" type="text/css" href="/css/board.css">

<!-- 아임포트 -->
<script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>

<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript">

/* 숫자만 입력 시키게 하는것 */
function onlyNumber(obj){
	val=obj.value;
	re=/[^0-9]/gi;
	obj.value=val.replace(re,"");
}

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
											location.href="/mypageIntro.do";
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
	
	/* 장바구니 옵션 변경 버튼 */
	$("#messageCate").change(function() {

		var messageCate = $(this).val();
		$.ajax({
			type : "POST",
			url : "/mypage/readMessage.do",
			dataType : "html",
			data : {
				messageCate : messageCate
				 , curPage: '${curPage }'
			},
			success : function(res) {
// 				alert("성공");
				$("#messageBox").html(res);
			}
		});
	});

	$("#messageCate").trigger("change");
	
	$("#sendMessageBtn").click(function(e){
		popupOpen();
	});
	function popupOpen(){
		var url= "/mypage/writeMessage.do";    //팝업창 페이지 URL
		var winWidth = 400;
	    var winHeight = 500;
	    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
		window.open(url,"",popupOption);
	}
	
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
	
	/* 글자수 제한  */
	var textCountLimit = 15;
	var textCountLimit2 = 40;
	$('textarea[name=optionName]').keyup(function() {
	     // 텍스트영역의 길이를 체크
	     var textLength = $(this).val().length;
	
	     // 입력된 텍스트 길이를 #textCount 에 업데이트 해줌
	     $('#textCount').text(textLength);
	      
	     // 제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼만 자르고 텍스트영역에 넣음
	     if (textLength > textCountLimit) {
	         $(this).val($(this).val().substr(0, textCountLimit));
	     }
	});

	$(".save_button").click(function() {
		if($(".category option:selected").val()==0) {
		  alert("카테고리를 선택해주세요.");
		  return false;
		} else if($.trim($("#title").val())=="") {
		  alert("제목을 입력해주세요.");
		  return false;
		} else if($("textarea[name=optionName]").val()==""){
		  alert("옵션을 입력해주세요.");
		  return false;
		} else if($("textarea[name=startAmount]").val()==""){
	    alert("판매수량을 입력해주세요.");
	    return false;
		} else if($("textarea[name=unit]").val()==""){
      alert("단위를 입력해주세요.");
      return false;
		} else if($("textarea[name=price]").val()==""){
      alert("판매가격을 입력해주세요.");
      return false;
		}
		// 옵션 여러 개 보내기 기능 구현할 때 json 형식으로 담아봄
// 		var option = {
// 			optionName: $("textarea[name=optionName]").val(),
// 			startAmount: $("textarea[name=startAmount]").val(),
// 			unit: $("textarea[name=unit]").val(),
// 			price: $("textarea[name=price]").val()
// 		};
// 		alert(option.optionName);
		submitContents($(this));
	});
	
});

function optionSelect(sVal) {
	var str = ""
	for(var i=0; i<sVal; i++) {
		str += '<ul>'
			+'<li><p>옵션제목 </p><textarea name="saleOptions[' + i + '].optionName" placeholder="15자 이내에 글자" style="resize:none" rows="1" cols="30"></textarea></li>'
			+'<li><p>총판매수량 </p><textarea name="saleOptions[' + i + '].startAmount" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="15"></textarea>개</li>'	
			+'<li><p>단위 </p><textarea name="saleOptions[' + i + '].unit" style="resize:none" placeholder="ex) kg" rows="1" cols="5"></textarea></li>'	
			+'<li><p>단위당가격 </p><textarea name="saleOptions[' + i + '].price" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="14"></textarea>원</li>'
			+'</ul>';
	}
	document.getElementById("option_boby").innerHTML = str;
	
	// 옵션 개수 선택 할 때 다른 방법이 있을까 하다가 생각해본 것. 되진 않음!
// 	$("#option_body1").show();
// 	$("#option_body3").hide();
// 	$("#option_body3").hide();
	
// 	if (sVal == "2") {
// 		$("#option_body2").show();
// 	} else if (sVal == "3") {
// 		$("#option_body3").show();
// 	}
}

// 네이버 스마트에디터를 사용하는 방법
function submitContents(elClickedObj) {
    // 에디터의 내용이 textarea에 적용된다.
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

    try {
      elClickedObj.form.submit();
    } catch(e) {}
}

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
			<!--Mypage부분  판매자 인트로부분 -->
			<jsp:include page="/WEB-INF/views/tile/mypage/userIntro.jsp" flush="false"/>
				
			
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
						<tr><td colspan="8" style="text-align: center;">유효 입찰 항목이 존재하지 않습니다.</td></tr>
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