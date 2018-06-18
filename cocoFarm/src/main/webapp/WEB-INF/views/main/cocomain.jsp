<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/sellerstyle.css">
<link rel="stylesheet" type="text/css" href="/css/farmstory.css">

<!-- 가로 화면 전환 위한 css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/css/swiper.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/css/swiper.min.css"> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/js/swiper.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.3.3/js/swiper.min.js"></script>
<!-- 가로 화면 전환 위한 css end-->


<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">

	$(document).ready(function () {
		/* 	
		//내용 넣어주기
		<c:forEach items="${farm}" var="i" varStatus="status">
		var oriText = '${i.content}';
		var newText = oriText.replace(/<(\/p|p)([^>]*)>/gi,"");
		console.log(newText);
		$("#farm${status.count}").text(newText);
		</c:forEach>
		
 */
		$(".popupLayer_FAQ li:nth-child(2)").addClass("close");

		$("#FAQ").click(function(e) {
			
			console.log(e.pageX);
			console.log(e.pageY);
			var divTop = e.pageY;
			var divLeft = e.pageX;

			$(".popupLayer_FAQ").css({
				"top": divTop
				, "left": divLeft
				, "width": "300px"
				, "height": "500px"
				, "position": "absolute"
			}).show();
		});
		
		$(".Q").click(function() {
			$(this).toggleClass("open");
			
			if( $(this).next().hasClass("close") ) {
				$(this).next().addClass("show").removeClass("close");
			} else {
				$(this).next().addClass("close").removeClass("show");
			}
		});

	});
</script>

<style type="text/css">
.popupLayer_FAQ {
	display: none;
	margin: 20px auto;
	width: 1000px;
	height: 700px;
}
.popupLayer_FAQ h1{
	font-size: 18px;
	font-weight: bold;
	text-align: center;
	margin: 20px;
}
.popupLayer_FAQ ul {
	margin: 20px;
	border-top: 1px solid #a4a4a4;
	border-bottom: 1px solid #a4a4a4;
}
.popupLayer_FAQ li {
	list-style: none;
	padding: 10px;
	border-bottom: 1px solid #cecece;
}
.Q::before {
    content: ">";
    color: green;
    font-weight: bold;
    display: inline;
    vertical-align: middle;
    padding: 5px 5px;
}

.Q.open::before {
	content: "∨";
	color: green;
    font-weight: bold;
    display: inline;
    vertical-align: middle;
    padding: 5px 5px;
}

.close {
	display: none;
}

.show {
	display: block;
    background-color: #efefef;
}

/* 가로슬라이드 style start*/
.swiper-container {

      width: 100%;
      height: 300px;
}
.swiper-slide {
      
      /* Center slide text vertically */
   /* 
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
       */
}

/* 가로슬라이드 style end*/
</style>

</head>
<body>


<div class="background_img">
	<div class="img_one"><img src="/img/backgroundimg/back01.png" ></div>
	<div class="img_two"><img src="/img/backgroundimg/back02.png" ></div>
	<div class="img_three"><img src="/img/backgroundimg/back03.png" ></div>
	</div>
<!--main부분 header ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mainhead.jsp" flush="false"/>
	
			<div class="container">
			<div class="auction_part">
					<ul class="head_title">
						<li class="title"><div class="title_icon"></div>종료 임박 경매</li>
						<li class="plus_btn"><a href="/auction/auction_list.do">+ 더보기</a></li>
					</ul>
					
					<div class="swiper-container">
						<div class="swiper-wrapper">
								
					<c:forEach items="${auction}" var="auction" varStatus="status">
							<div class="swiper-slide">
							<div class="auction_img">
							<div class="time"><div class="time_icon"></div><p>마감 임박<p></div>
							<a href="/auction/auction_view.do?idx=${auction.idx }">
							<img alt="" src="/img/auction_img/${auction.item_img}" style="width:280px;">
							</a>
							</div>
							<a href="/auction/auction_view.do?idx=${auction.idx }">
							<div class="aution_info">
									
									<p class="auction_timer"><fmt:formatDate value="${auction.time_window }" pattern="yyyy년 MM월 dd일 " />
									<fmt:formatDate value="${auction.time_window}" pattern="aa HH:mm 종료" /></p>
		
									<p class="auction_protitle">[경매 상품명]&nbsp&nbsp${auction.title}</p>
									<p><span>경매 시작가</span>${auction.start_price}원</p>
									<p class="auction_maxprice"><span>최고 입찰가</span><label class="maxprice_red">${auction.highest_bid}</label>원</p>
									
							</div>
							</a>
							<div class="account_info">
								<p class="account_title">경매 판매자 정보</p>
								<p class="account_img"><img alt="" src="/img/profile/${auction.thumb_loc}" style="height:100px;"></p>
								<div class="account_body">
								<p><span>사업자 등록 번호 </span>${auction.business_license_code}</p>
								<p><span>대표자 이름 </span>${auction.corporation_name}</p>
								<p><span>사업 주소</span>${auction.business_addr}</p>
								<p><span>업태 종류</span>${auction.business_category}</p>
								<p><span>판매자 이름</span>${auction.acc_name}</p>
								</div>
							</div>
							
							</div>
					</c:forEach>
					</div>
					<div class="swiper-button-next btnmove"></div>
    				<div class="swiper-button-prev"></div>
					</div>
			</div>
			</div>
			
			
			
			<div class="farm_part">
			<div class="container">
				
				<div class="farm_part_magin">
					
					<ul class="head_title">
						<li class="title"><div class="title_icon"></div>오늘의 농부 스토리</li>
						<li class="plus_btn"><a href="/board/list.do">+ 더보기</a></li>
					</ul>
					
					<div class="farm_listpart">
					
					<c:forEach items="${farm}" var="i" varStatus="status">
						<c:choose>
							<c:when test="${status.count%3==0}">
							<div class="farm_board_board farm_board_last">
								<p class="farm_boardtitle">${i.title}</p>
								<div class="bar"></div>
								<img alt="" src="/img/profile/${i.thumb_loc}" style="height:100px;">
								<p class="farm_name">${i.name}</p>
								<p class="quo_img"></p>
								<div class="farm_boardcontent"><a href="/board/view.do?acc_idx=${i.acc_idx }">${i.content}</a></div> 
							</div>
	
							</c:when> 
							<c:otherwise>
							<div class="farm_board_board">
								<p class="farm_boardtitle">${i.title}</p>
								<div class="bar"></div>
								<img alt="" src="/img/profile/${i.thumb_loc}" style="height:100px;">
								<p class="farm_name">${i.name}</p>
								<p class="quo_img"></p>
								<div class="farm_boardcontent"><a href="/board/view.do?acc_idx=${i.acc_idx }">${i.content}</a></div> 
							</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</div>
				</div>
			</div>
			</div>

		<div class="container">
			<div class="pro_part">
			<ul class="head_title">
						<li class="title"><div class="title_icon"></div>최근 입고된 농수산물</li>
						<li class="plus_btn"><a href="/seller.do">+ 더보기</a></li>
					</ul>
			
			<c:forEach items="${seller}" var="data" varStatus="status">
				<c:choose>
					<c:when test="${status.count%5==0}">
						<div class="prodisplay_last">
							<a href="/sellerDetail.do?idx=${data.idx}"><img class="img_click" height="210px" alt="${data.title}사진" src="/proimg/${data.faceImg}" style="overflow: hidden;"></a>
							<div class="pro_info">
							<span class="pro_title">${data.title}</span>
							<span class="pro_price"><fmt:formatNumber value="${data.min_price}" pattern="#,###"/>원</span> 
							<span class="pro_origin">${data.origin}</span>
							</div>
						</div>
					</c:when> 
					<c:otherwise>
						<div class="prodisplay">
							<a href="/sellerDetail.do?idx=${data.idx}"><img class="img_click" height="210px" alt="${data.title}사진" src="/proimg/${data.faceImg}"></a>
							<div class="pro_info">
							<span class="pro_title">${data.title}</span>
							<span class="pro_price"><fmt:formatNumber value="${data.min_price}" pattern="#,###"/>원</span> 
							<span class="pro_origin">${data.origin}</span>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</div>
		</div>
<!--main부분 foot ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/footer/mainfoot.jsp" flush="false"/>
		

<script>
    var swiper = new Swiper('.swiper-container', {
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
 </script>

	
</body>
</html>