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
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">




	$(document).ready(function () {
		$('.auction_listpart').slick();
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
		
		$(".popupLayer_FAQ li:nth-child(1)").click(function() {
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
	border: 1px solid black;
	background-color: lightgray;
	overflow-y: scroll;
}


.close {
	display: none;
}

.show {
	display: block;
}

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
	
	
			<div class="farm_part">
			<div class="container">
				
				<div class="farm_part_magin">
					
					<ul class="head_title">
						<li class="title"><div class="title_icon"></div>종료 임박 경매</li>
						<li class="plus_btn">+ 더보기</li>
					</ul>
					
					<div class="auction_listpart">
					
					<c:forEach items="${auction}" var="auction" varStatus="status">
							<div class="farm_board_board farm_board_last">
								<p class="farm_boardtitle">${auction.title}</p>
								<div class="bar"></div>
								<img alt="" src="/img/profile/${auction.item_img}" style="height:100px;">
								<p class="farm_name">${auction.name}</p>
								<p class="quo_img"></p>
								<div class="farm_boardcontent"><a href="/board/view.do?acc_idx=${auction.idx }">${auction.idx}</a></div> 
							</div>
					</c:forEach>
					</div>
				</div>
			</div>
			</div>
			
			
			
			
			<div class="farm_part">
			<div class="container">
				
				<div class="farm_part_magin">
					
					<ul class="head_title">
						<li class="title"><div class="title_icon"></div>오늘의 농부 스토리</li>
						<li class="plus_btn">+ 더보기</li>
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
						<li class="plus_btn">+ 더보기</li>
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
		
		

	
</body>
</html>