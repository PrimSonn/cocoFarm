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



<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	/* 	
	 //내용 넣어주기
	 <c:forEach items="${farm}" var="i" varStatus="status">
	 var oriText = '${i.content}';
	 var newText = oriText.replace(/<(\/p|p)([^>]*)>/gi,"");
	 console.log(newText);
	 $("#farm${status.count}").text(newText);
	 </c:forEach>
	
	 */
});

// $(function() {
//     $(window).scroll(function() {
//         if ($(this).scrollTop() > 500) {
//             $('#MOVE_TOP_BTN').fadeIn();
//         } else {
//             $('#MOVE_TOP_BTN').fadeOut();
//         }
//     });
    
//     $("#MOVE_TOP_BTN").click(function() {
//         $('html, body').animate({
//             scrollTop : 0
//         }, 400);
//         return false;
//     });
// });
</script>

<!-- <style type="text/css"> --> 
<!-- /* a#MOVE_TOP_BTN { */ -->
<!-- /*     position: fixed; */ -->
<!-- /*     right: 5%; */ -->
<!-- /*     bottom: 500px; */ -->
<!-- /*     display: none; */ -->
<!-- /*     z-index: 999; */ -->
<!-- /* } */ -->
<!-- </style> --> 
</head>
<body>

<!-- <div id="TOP_BTN_BOX"><a id="MOVE_TOP_BTN" href="#">TOP</a></div> -->

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