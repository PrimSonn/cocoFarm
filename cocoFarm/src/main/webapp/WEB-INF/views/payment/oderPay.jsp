<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/oderstyle.css">


<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>
<!--우편번호 주소 검색 관련  -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>


<!--아임 포트 결제   -->
<script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
			
<script type="text/javascript">
/*총 가격 초기화  */
var allsum=0;
/* 총수량 초기화 */
var allamount=0;
var option={}
var optionlist=new Array();

$(document).ready(function() {
	
	<c:forEach items="${pro}" var="pro_data" varStatus="status1">
	var sumcon=[];
	var amountcon=[];
	var sum${status1.count}=0;
	var allamount${status1.count}=0;
	var allsum${status1.count}=0;// 가격초기화
	<c:forEach items="${opt}" var="data" varStatus="status">
	
	console.log("idx111111 : " + ${data.idx});
	console.log("price11111 : " + ${amount.get(status.index)});
	//console.log("amount : " + ${amount});
	//console.log("amount11 : " + ${amount.get(status.index)});
	//list 만들기 
		option = new Object();
		option.idx=${data.idx};//상품 번호 idx
		option.proAmount=${amount.get(status.index)};//상품 양
		optionlist.push(option);// 옵션 리스트에 넣기  여기까지는 list에 넣는거여서 컨트롤러에서 중요하게됨
		
		var option_num${status.index}=Number(${data.idx});//옵션 idx를 넣기
		var option${status.index}=Number(${data.price});	// 상품 가격
		var amount${status.index}=Number(${amount.get(status.index)}); //상품 양 
		sum${status1.count}=(option${status.index})*(amount${status.index}); //sum0번에는 1개 옵션의 수량 *금액 나오고
		allsum${status1.count}+=Number(sum${status1.count});//한개의 글에 총 금액 
		allamount${status1.count}+=amount${status.index};//객체로 양 넣는거  list에 넣는거여서 컨트롤러에서 중요하게됨
		</c:forEach>
		
		sumcon.push(allsum${status1.count});
		amountcon.push(allamount${status1.count});
	</c:forEach>
	
	
	
	
	
	//합산 금액 배열로 만든거 
	<c:set var="sumcon" value="sumcon"/> 
	console.log(${pro.size()});
	
	/*총 수량 갯수  */
	<c:set var="amountcon" value="amountcon"/>
	console.log("!!!!!"+${pro.size()});
	/*금액 합계금액  */
	console.log(${opt.size()});
	console.log("배열"+${sumcon}.length);
	for(var i=0; i<${pro.size()} ;i++){
		$(".product_orderpay"+i).text(${sumcon}[i]);
	} ;
	
	for(var i=0; i<${pro.size()} ;i++){
		$(".product_amount"+i).text(${amountcon}[i]);
	} ;
	
	/*총 가격 합산  */
	for(var i=0; i<${sumcon}.length ;i++){
		allsum+=Number(sumcon[i]);
	};
	
	/*총 수량 갯수 아직 안쓰고 있음*/
	for(var i=0; i<${amountcon}.length ;i++){ 
		allamount+=Number(amountcon[i]);
	};
	
	console.log("총수량"+allamount);
	console.log("총가격"+allsum);
	<c:set var="allsum" value="allsum"/>
	<c:set var="allamount" value="allamount"/>
	
	
	//날짜 변수 만들기 
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 
	
	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 
	
	//오늘 날짜 
	var today=year+month+day;
	
	//주문번호  날짜+글번호+
	 var unit_num= Math.floor(Math.random() * 100) + 1;
	 //각자 상담 코드 넣어야됨 + 고객 sesson + 상품idx 
	 //우리 주분 번호 +고객 sesson 
	 var oder_num=today+unit_num+1541;
	<c:set var="today" value="today"/>
	<c:set var="oder_num" value="oder_num"/>
	
	
	// iamport 변수 초기화
	var IMP = window.IMP;
	IMP.init('imp97619342');	// 가맹점 식별코드
	
	//
	
	//콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	
	$(".price_sum_num").text(comma(${allsum}));
	$(".sum_total").text(comma(${allsum}));
	// 결제 모듈 불러오기
	
	
	$("#pay").click(function() {
		/*수령인 */
		var mem_name =$(".mem_name").val();
		/*수령장소  */
		var mem_deliver=$(".mem_deliver").val();
		
		//핸드폰번호
		var phone_a=$(".phone_a").val();
		var phone_b=$(".phone_b").val();
		var phone_c=$(".phone_c").val();
		
		//우편번호
		var postcodify_postcode5=$(".postcodify_postcode5").val();
	
		//상세 주소 
		var postcodify_address=$(".postcodify_address").val();
		
		//상세 주소 
		var postcodify_details=$(".postcodify_details").val();
		
		//배송 메모
		var deliver_memo=$(".deliver_memo").val();
		
		
		//각각의 idx = ${data.idx} // saleOptions[${status.index}].proAmount
		//각각의 수량 amount= amount${status.index}
		
		console.log("배송지명"+mem_name);
		console.log("배송지" +mem_deliver);
		console.log("배송지" +mem_deliver);
		requestPayment();
	});
});
	
function requestPayment() {
	
	var Main_Rcpt = -1;
	var is_Done = 0;
	
	/*수령인 */
	var mem_name =$(".mem_name").val();
	/*수령장소  */
	var mem_deliver=$(".mem_deliver").val();
	
	/*주소  */
	var postcodify_address=$(".postcodify_address").val();
	
	var postcodify_details=$(".postcodify_details").val();
	/*우편주소  */
	var area=$(".postcodify_postcode5").val();

	var phone_a=$(".phone_a").val();
	var phone_b=$(".phone_b").val();
	var phone_c=$(".phone_c").val();
	
	console.log(optionlist);
	JSON.stringify(optionlist);
	var dff=JSON.stringify(optionlist);
		
	console.log(dff); 
	$.ajax({
	   type : "POST",
	   url : "/paycomple.do",
	   dataType : "json",
	   async: false,
	   data : {
		   optionlist:dff,
		   memname: mem_name
	   },
		success : function(data) {
		console.log('data.MainRcpt: '+data.MainRcpt);
			Main_Rcpt=data.MainRcpt;
			is_Done = data.isDone;
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
				amount : ${allsum}, //결제금액 - 필수항목
				buyer_email : 'iamport@siot.do', //주문자Email - 선택항목
				buyer_name : '${account.name}', //주문자명 - 선택항목
				buyer_tel : phone_a+phone_b+phone_c, //주문자연락처 - 필수항목, 누락되면 PG사전송 시 오류 발생
				buyer_addr :postcodify_address+postcodify_details, //주문자주소 - 선택항목
				buyer_postcode :area, //주문자우편번호 - 선택항목
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
									location.href="/";
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
// 								alert("취소시 에이젝스 성공");
							   },
							   error : function(e) {
								  console.log(e.responseText);
// 								   alert("취소시 에이젝스 실패"); 
							   }
						});
					}
// 					alert(msg);
				});//아임포트 통신 Ajax 완료.
	} else{
		alert('임시저장 실패');
		//임시 영수증 삭제 로직 추가.
	}
}
$(function() {
	$(".address_btn").postcodifyPopUp(); 
});
</script>
</head>
<body>
<!--detail부분 header ver2부분  -->
<jsp:include page="/WEB-INF/views/tile/head/detailhead.jsp" flush="false"/>

<div class="container">
	<div class="odberheader">
		<h1>주문/결제</h1>
		<div class="nav_map">
		<span><a href="">장바구니</a>
		</span>
		<span>></span>
		<span><strong style="font-weight:600;"><a href="">주문/결제</a></strong></span>
		<span>></span>
		<span>완료</span>
		</div>
	</div>
	<div class="oder_content">
		<div class="product_area">
			<table cellspacing="0" class="tb_product">
				<caption>주문내역</caption>
				<colgroup>
					<col width="500">
					<col width="135">
					<col width="120">
					<col width="90">
					<col width="110">
					<col width="110">	
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="product">상품정보</th>
						<th scope="col">판매자</th>
						<th scope="col">배송비</th>
						<th scope="col">수량</th>
						<th scope="col" class="">할인</th>
						<th scope="col" class="">주문금액</th>
					</tr>
				</thead>
				<tbody>
				
				<c:forEach items="${pro}" var="pro_data" varStatus="status1">					
					<tr>
						<td class="product_info">
							<a href="" >
							<img src="/proimg/${pro_data.faceImg}" style="width: 92px">
							</a>
							<div class="product_dsc">
								<strong class="product_bn">[법인명]${pro_data.corporation_name}</strong>
								<a href="#" class="product_name">
									<strong>[${today}]${pro_data.title}</strong>
								</a>
								<div class="option">
									<span class="option_icon">옵션</span>
									
									<c:forEach items="${opt}" var="data" varStatus="status">
									<ul>
										
										<li>${data.idx}/ ${data.optionName}/수량 ${amount.get(status.index)}개/${data.price}</li>
										<!--사용자 선택 옵션 -->
										<li><input type="hidden" name="saleOptions[${status.index}].idx" value="${data.idx}" ></li>
										<!--사용자 선택  수량  -->
										<li><input type="hidden" name="saleOptions[${status.index}].proAmount" value="${amount.get(status.index)}" ></li>
									</ul>
									</c:forEach>
									
								</div>
							</div>
						</td>
						<td>
						<a class="who_parmer" href="">${pro_data.name}</a>
						</td>
						<td>
						<span class="img_deliver_icon"></span>
						<span class="sum_deliver">무료</span>
						</td>
						<td>
						<em class="product_amount${status1.index}">48,000</em>
						</td>
						<td>
						-
						</td>
						<td>
						<em class="product_orderpay${status1.index}">48,000</em>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>	<!--end product_area -->
		<div class="deliver_userarea">
			
			<div class="deliver_info">
				<h1>배송지 정보</h1>	
				<div class="deliver_check">
					<span class="reap">
					배송지선택
					</span>
					<input type="radio"  class="radio_r1" name="deliver_radio" value="1"/><label for="r1">신규 배송지</label>
					<input type="radio"  class="radio_r1" name="deliver_radio" value="2" checked="checked"/><label for="r2">${account.name}</label>
				</div>
				<div class="delive_reci new_reci">
					<span class="reap ">
					수령인
					</span>
					<input type="text" class="mem_name" value="" placeholder="수령인을 입력해주세요."> 
				</div>
				<div class="delive_reci">
					<span class="reap">
					배송지명
					</span>
					<input type="text" class="mem_deliver" value="" placeholder="배송지명을 입력해주세요"> 
				</div>
				<div class="delive_reci">
					<div class="cellphone_group">
					<span class="reap">
					연락처
					</span>
					<input type="text" class="phone_a" value="" placeholder="010"> -
					<input type="text" class="phone_b" value="" placeholder="0000"> -
					<input type="text" class="phone_c" value="" placeholder="0000"> 
					</div>
				</div>
				<div class="delive_reci deli_address">
					<span class="reap">
					배송지 주소
					</span>
					<div class="deliver_option">
					<input type="text" class="postcodify_postcode5" value="" > <button class="address_btn">우편번호</button><br />
						<div class="addr_detail">
							<input type="text" name="" class="postcodify_address" value="" />
							상세주소 :<input type="text" name="" class="postcodify_details" value="" />
						</div>
					</div>
				</div>	
				<div class="delive_reci">
					<span class="reap">
					배송 메모
					</span>
					<input type="text" class="deliver_memo" value="" placeholder="필요한 배송 사항 메모" > 
				</div>	
				<p class="extra_info">
				<span class="ico_ext"></span><strong>2016년 8월 1일부터는 5자리 우편번호 사용이 의무화</strong>됩니다.
				<br>도로명주소+5자리 우편번호로 등록하셔서 코코팜 이용에 불편함이 없도록 하시길 바랍니다.</p>
            	<p class="extra_info">
				<span class="ico_ext"></span>도서산간 지역의 경우 추후 수령 시 추가 배송비가 과금될 수 있습니다.</p>
			</div>
			<div class="price_sum">
				<h1>결제 금액</h1>
				<div class="price_group">
				<span class="price_sum_num"></span><p class="unit">원</p>
				</div>
				<ul class="price_list">
					<li><strong>총 상품금액</strong><p>(+)<em class="sum_total"></em>원</p></li>
					<li><strong>배송비</strong><p>(+) <em>0</em>원</p></li>
				</ul>
			<button id="pay">결제하기</button>
			<!-- <button id="pay11" name="pay11">통신하기</button> -->
			</div>
		</div>
	</div>
</div>
</body>
</html>