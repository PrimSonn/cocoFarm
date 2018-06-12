<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${product.title }</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/sellerstyle.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">
var test =0;
<c:forEach items="${option}" var="data" varStatus="status">
	var sttr${status.count} = '<div id="one${status.count}" class="detail_cnt">'
	+'<p class="option_name">${data.optionName}</p>'
	+'<a class="button_minus" style="font-size:35px;">-</a>'
	+'<input type="text" name="saleOptions[${status.index}].proAmount" class="pronum_text" id="tt" value="1" onkeyup="onlyNumber(this)">'
	+'<input type="hidden" name="saleOptions[${status.index}].idx" value="${data.idx}">'
	+'<a class="button_plus">+</a>'
	+'<p class="indiv_option_price"><strong class="num_option_price" data-unit="${data.price}"><fmt:formatNumber value="${data.price}" pattern="#,###"/></strong>원</p>'
	+'<span class="delete_option"><img class="optionImg${status.count}" src="/img/main/delete_icon.PNG"></span>'
	+'</div>';
	var price_pro${status.count} = ${data.price};
</c:forEach>

var bla = $('.pronum_text').val();
var price = 0;
var num=1;
var sum=0;

$(document).ready(function() {
	
	//콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}

	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}


	if (typeof price_pro1 == 'undefined') {
		console.log(333);
	}else if (typeof price_pro2 == 'undefined'){
		  var min_price=Math.min(price_pro1);
	}else if (typeof price_pro3 == 'undefined'){
		var min_price=Math.min(price_pro1,price_pro2);
	}else{
		var min_price=Math.min(price_pro1,price_pro2,price_pro3);
	}
	console.log(min_price); 
	$(".price_tem").text(comma(min_price));
	$(".price_sale").text(comma(min_price));
	
	
	$("#detail_option").on("click", "img.optionImg3", function() {
		console.log($('.proselect_option option[value=3]').val());
		$('.proselect_option option[value=3]').removeClass('off').addClass('on');
		$(this).parent().parent().remove();
		price=0;
		 reselect();
		calcPrice();
	});
	
	$("#detail_option").on("click", "img.optionImg2", function() {
		console.log($('.proselect_option option[value=2]').val());
		$('.proselect_option option[value=2]').removeClass('off').addClass('on');
		$(this).parent().parent().remove();
		console.log($(".num_option_price").parent().find(".num_option_price").text());
		price=0;
		reselect();
		calcPrice();
	});
	
	$("#detail_option").on("click", "img.optionImg1", function() {
				console.log($('.proselect_option option[value=1]').val());
				/* $('.proselect_option option[value=1]').val())=="1") */
		$('.proselect_option option[value=1]').removeClass('off').addClass('on');
		$(this).parent().parent().remove();
		console.log($(".num_option_price").parent().find(".num_option_price").text());
		price=0;
		reselect();
		calcPrice();
	});
		
		/* $(".proselect_option").on("change", function(){ */
	
		/*   $(".pronum_text").on("keypress",function() {
 			 console.log( "Handler for .keypress() called." );
		}); */
		 
		/*  $(".pronum_text").on("change",".button_minus", function(){
		
		var text_num=Number($(this).parent().find(".pronum_text").val());
		var original_price=$(this).parent().find(".num_option_price").data("unit");
		$(this).parent().find(".num_option_price").text(original_price*num);
		price=0;
		calcPrice();
		});  */
			
			
	$(".proselect_option").on('change', function() {
		
		 if($(".proselect_option option:selected").hasClass("off")==true){
			 alert("이미 선택한 옵션입니다.");
			 price=0;
			 num=1;
			 return;
		}
		 
		 if(this.value=="1"){
			 price=0;
			 num=1;
			 $("#detail_option").append(sttr1);
		}else if(this.value=="2"){
			price=0;
			num=1;
			$("#detail_option").append(sttr2);
			/* document.getElementById("detail_option").innerHTML+=sttr2; */
		}else if(this.value=="3"){
			price=0;
			num=1;
			$("#detail_option").append(sttr3);
			/* document.getElementById("detail_option").innerHTML+=sttr3; */
		}else{
			price=0;
			num=1;
		}
		
		 
		if($(".proselect_option option:selected" ).val()!=0){
		$(".proselect_option option:selected" ).removeClass('on').addClass('off');
		}
		console.log($(".num_option_price").parent().find(".num_option_price").text());
		calcPrice();
		
	});
	
		
	/*플러스 버튼 눌렀을때  */
	$("#detail_option").on("click", ".button_plus", function() {
		if(Number($(this).parent().find(".pronum_text").val())==99){
			return;
		}	
		
		var num=Number($(this).parent().find(".pronum_text").val())+1;
		var text_num=Number($(this).parent().find(".pronum_text").val(num));
		
		var original_price=Number($(this).parent().find(".num_option_price").data("unit"));
		
		console.log(original_price);
		$(this).parent().find(".num_option_price").text(comma(original_price*num));
		
		price=0;
		calcPrice();
		
	});

	/*마이너스 버튼 눌렀을때 */
	$("#detail_option").on("click",".button_minus", function() {
		if(Number($(this).parent().find(".pronum_text").val())==1){
			return;
		}
		var num=Number($(this).parent().find(".pronum_text").val())-1;
		var text_num=Number($(this).parent().find(".pronum_text").val(num));
		
		var original_price=$(this).parent().find(".num_option_price").data("unit");
		$(this).parent().find(".num_option_price").text(comma(original_price*num));
		price=0;
		calcPrice();
	});
		
	/* 상품 정보 눌렀을때   */
	$('.open_icon').on('click', function() {
		if($(this).parent().parent().hasClass("info_open")==true) {
			$(this).parent().parent().removeClass('info_open');
			$(this).text("열기");
		} else {
			$(this).parent().parent().addClass("info_open");
			$(this).text("닫기");
		}
	});
		
	/* 구매하기 버튼 눌렀을대 써밋 */
	
	
	
		<c:if test="${sessionScope.idx eq null}">
		$(".buy_button").click(function() {
			if($(".proselect_option option:selected").val()==0) {
				  alert("카테고리를 선택해주세요.");
				  return false;
				} else {
					alert("로그인 해주세요.");
				}
			
			
			
		});
		</c:if>
		<c:if test="${sessionScope.idx ne null}">
		$(".buy_button").click(function() {
			if($(".proselect_option option:selected").val()==0) {
				  alert("상품 옵션을 선택해주세요.");
				  return false;
				} else {
					$(".option_form").attr("action", "/orderpay.do");
					$(".option_form").submit(); 
				}
		});
		</c:if>
		
			
		/* 
		$(".buy_button").click(function() {
		
		$(".option_form").attr("action", "/orderpay.do");
		$(".option_form").submit();
		 */
	
		
	
	});
		
	/* 장바구니 버튼 눌렀을 때 */
	$(".addcart_button").click(function() {
		$(".option_form").attr("action", "/product/cart.do");
		$(".option_form").submit();
	});
	
	
	
/* 상품평 등록 눌렀을 때 */
function insertComment() {
	var saleIdx = ${product.idx };
	var commScore = 5;
	var commTitle = "제목";
	var content = $("#commentContent").val();
	var commentList = [saleIdx, commScore, commTitle, content];
	console.log(commentList);
	
	var arr = new Array();
	var obj = new Object();
	
	obj.saleIdx = ${product.idx };
	obj.content = $("#commentContent").val();
	arr.push(obj);
	
	$.ajax({
		type: "POST"
		, url: "/product/insertComment.do"
		, dataType: "json"
		, data: {
			comment: JSON.stringify(arr)

		}
		,success: function(data) {
			console.log("success data: " + data);
		}
	});
}
		
/* 숫자만 입력 시키게 하는것 */
function onlyNumber(obj) {
    val=obj.value;
    re=/[^0-9]/gi;
    obj.value=val.replace(re,"");
}
	
/*옵션 합산 계산  */
function calcPrice() {
	$("#detail_option .num_option_price").each(function(idx) {
		price += Number($(this).text().replace(/,/g, ''));
	});
	
	$(".left_price em").text(price);
	console.log(price);	
}

/*선택창 옵션으로 올리기  */
function reselect() {
	$(".proselect_option option:eq(0)").prop("selected", true);
}

</script>
</head>
<body>
<div id="header_detail">

<!--Mypage부분 header ver3부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mypagehead.jsp" flush="false"/>

	<div class="container">
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<!--2018년 5월 25일 hwanmin 추가   -->
				<div class="search">
					<form action="/seller.do" method="post">
						<input type="text" name="search_name" placeholder="농산물 검색하기"><button class="search_icon" style="cursor:pointer">
						</button>
					</form> 
				</div>
		
		</div>
		<div id="header_nav">
			<ul class="nav">
				<li><a href="/seller.do">농수산물</a></li>
				<li><a href="#">경매</a></li>
				<li><a href="#">농부 스토리</a></li>	
				<li><a href="#">자주 묻는 질문</a></li>	
				<li><a href="#">공지사항</a></li>
				<li><a href="#">회사소개</a></li>
			</ul>
		</div>
	</div>
</div>
<div class="container">
	<div class="nav_map">
		<span><strong><a href="">메인</a></strong></span><span></span><span><a href="">농산물</a></span><span>></span><span>채소/과일</span><span>></span><span>현재상품</span>
	</div>
	<div class="detail_body">
		<div class="pto">
		<img src="/proimg/${product.faceImg }"  width="100%">
		</div>
		<div class="detailpro_info">
			<p>상품 번호 : 3l30482</p>
			<dl>
				<dt class="detail_title">
					${product.title}
				</dt>
				<dd>
					<div class="price_info">
						<dl>
							<dt>판매가</dt>
							<dd><p class="price_tem">3800</p>원</dd>
							<dt>할인가</dt>
							<dd><p class="price_sale">3800</p>원</dd>

							<dt>판매자</dt>
							<dd><p>${product.name }</p></dd>
						</dl>
					</div>
					<img src="/img/main/detail_banner01.jpg" width="100%">
					<div class="price_info">
						<div class="border_tbbox">
							<dl>
									
									<dt>배송방법</dt>
									<dd><p>택배</p></dd>
									<dt>배송비결제</dt>
									<dd><p>주문시 결제</p></dd>
									<dt>배송비</dt>
									<dd><p>2500원</p>(50,000원 이상 구매 시 무료 / 제주,도서지역 추가 4,000원)</dd>
							</dl>
						</div>
						<div class="border_tbbox">
							<dl>
									<dt>원산지</dt>
									<dd><p>${product.origin}</p></dd>
							</dl>
						</div>
						
						<div class="border_tbbox">
							<dl>
							
									<dt style="line-height: 30px;">옵션</dt>
									<dd style="height: 40px;">
									
									<select class="proselect_option" name="proselect_option">
									<option value="0" SELECTED>옵션선택</option>   
		       						<c:forEach items="${option}" var="data" varStatus="status">
		       						<option class="on" value="${status.count}">${data.optionName } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${data.price}원</option>
		       						</c:forEach></select></dd>	  
		        		
		        	
							</dl>
						</div>
			
					</div>
				</dd>
			</dl>
			
			
			<form class="option_form" action="" method="post">
				<div id="detail_option">
					
				</div>
			</form>
			
			<div class="sum_price">
				<strong>총 상품금액</strong>
	
				<div class="left_price"><p>총 수량 1개</p><fmt:formatNumber value="${sumvar}" pattern="#,###"/><em>0</em><span>원</span>
			</div>
			
			<button class="buy_button"><img src="/img/main/buy_icon.png" width="20px;"><span>구매하기</span></button>
			<button class="addcart_button">장바구니 담기</button>
			<button class="talk_button">판매자에게 쪽지</button>
			
			</div>
		
		</div>
	
	</div>
	
	<div class="item_info">
		<a>상품 후기
			<span class='open_icon'>열기</span>
		</a>
		
		<!-- 상품 후기 등록 -->
		<div class="form-inline text-center">
		
			<input type="text" size="7" class="form-control"
				id="commentWriter"
				value="${sessionScope.name }" readonly="readonly"/>
			<textarea rows="3" cols="60"
				class="form-control" id="commentContent"></textarea>
			
			<button class="insertComm_button"
						onclick="insertComment();">상품평 등록</button>
		</div>
		
		<div class="cont_cmt">
			<ul class="list_cmt">
				<li>
					<div class="cmt_cont">
						<span class="wrap_profile">
<!-- 							<img src="계정이미지" width="32" height="32" class="thumb_g" alt=""> -->
							<span>계정 아이디</span>
						</span>
<!-- 						<span class="별이미지">별점</span> -->
						
						<div class="wrap_cont">
						
<!-- 							<span class="info_score"> -->
<!-- 								<span class="img_kakaofarmer bg_star"> -->
<!-- 									<span class="img_kakaofarmer bar_star" style="width: 100%;">5점</span> -->
<!-- 								</span> -->
<!-- 							</span> -->
							
							<span class="txt_prod">김천 거봉포도 4kg</span>
							
							<p class="desc_cmt">
								<span><span>맛잇엇어요</span></span>
							</p>
						</div>
						
					</div>
				</li>
		
			</ul><a href="/product/93/review" class="btn_all #review_all"><!-- react-text: 59 -->상품평 전체보기<!-- /react-text -->
				<span class="img_kakaofarmer ico_arr"></span></a>
		</div>
		
	</div>
	
	<div class="item_info">
		<a>상품 고시 정보
		
		<span class='open_icon'>열기</span>
	
		</a>
		<table class='tbl_spec'>
		<tbody>
			<tr>
				<th>용 량</th>
				<td>박스당 2kg</td>
			</tr>
			<tr>
				<th>수 량</th>
				<td>상품 상세 이미지 참조</td>
			</tr>
			<tr>
				<th>생산자/수입자</th>
				<td>전북 김제</td>
			</tr>
			<tr>
				<th>제조연월일</th>
				<td>도정년 월일 : 박스에 표기</td>
			</tr>
			<tr>
				<th>유동기한 품질 유지 기한</th>
				<td>상품 특성상 정확한 유통기한을 안내 하기 어려운점 양해 부탁드립니다.</td>
			</tr>
			<tr>
				<th>소비자 상담 관련 전화번호 </th>
				<td>고객센터 070-0000-0000</td>
			</tr>
		</tbody>
		</table>
	</div>
	
	<div class="item_info">
		<a>판매자 정보
		
		<span class='open_icon'>열기</span>
	
		</a>
		<table class='tbl_spec'>
		<tbody>
			<tr>
				<th>사업자 법인명</th>
				<td>${product.corporation_name }</td>
			</tr>
			<tr>
				<th>대표자 이름</th>
				<td>${product.representative}</td>
			</tr>
			<tr>
				<th>사업자 주소</th>
				<td>${product.business_addr}</td>
			</tr>
			<tr>
				<th>사업자 전화번호</th>
				<td>070-0000-0000</td>
			</tr>
			<tr>
				<th>이메일 주소</th>
				<td>dlfj@naver.com</td>
			</tr>
		</tbody>
		</table>
	</div>
	
	<div class="item_info">
		<a>상세 이미지 정보 
			<span class='open_icon'>열기</span>
		</a>
<!-- 		/proimg/201711071833194501xxa.jpg -->
		<img src="/proimg/${product.mainImg }" style="margin-top: 50px; display:block; margin: 0 auto;">
	</div>
</div>
</body>

</html>