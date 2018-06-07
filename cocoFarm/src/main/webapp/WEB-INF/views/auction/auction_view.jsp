<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/auctionstyle.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>

<!-- Naver SmartEditor -->
<script type="text/javascript"
	src="/resources/smarteditor/js/service/HuskyEZCreator.js"></script>


<script type="text/javascript">

$("#btnCommInsert").click(function() {
	// 게시글 번호.... ${board.boardno }
//		console.log($("#commentWriter").val());
//		console.log($("#commentContent").val());
	
	$form = $("<form>").attr({
		action: "/auction/auction_inquire.do",
		method: "post"
	}).append(
		$("<input>").attr({
			type:"hidden",
			name:"auction_idx",
			value:"${view.idx }"
		})
	).append(
		$("<input>").attr({
			type:"hidden",
			name:"id",
			value:"${sessionScope.id }"
		})
	).append(
		$("<input>").attr({
			type:"hidden",
			name:"commentWriter",
			value:$("#commentWriter").val()
		})
	).append(
		$("<textarea>")
			.attr("name", "content")
			.css("display", "none")
			.text($("#commentContent").val())
	);
	$(document.body).append($form);
	$form.submit();
});



	
</script>


</head>
<body>
	<div id="header_detail">

		<div id="header_top">
			<div class="container">
				<ul class="rigth_list">
					<li><a href="#">고객</a></li>
					<li><a href="#">사업자</a></li>
					<li><a href="#">관리자</a></li>
				</ul>

				<ul class="left_list">
					<li><a href="#">로그인</a></li>
					<li><a href="#">회원가입</a></li>
					<li><a href="#">알림</a></li>
					<li><a href="#">마이페이지</a></li>
				</ul>
			</div>
		</div>
		<div class="container">
			<div id="header_boby">
				<div class="logo">
					<img src="/img/main/logo_color.png" alt="코코팜 로고">
				</div>
				<!--2018년 5월 25일 hwanmin 추가   -->
				<div class="search">
					<form action="/seller.do" method="post">
						<input type="text" name="search_name" placeholder="농산물 검색하기">
						<button class="search_icon" style="cursor: pointer"></button>
					</form>
				</div>

			</div>
			<div id="header_nav">
				<ul class="nav">
					<li><a href="#">농수산물</a></li>
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
			<span><strong><a href="">메인</a></strong></span><span>></span><span><a
				href="">농산물</a></span><span>></span><span>채소/과일</span><span>></span><span>현재상품</span>
		</div>
		<div class="detail_body">
			<div class="pto">
				<img src="/auction_img/${view.item_img }" width="100%">
			</div>
			<div class="detailpro_info">
				<p></p>
				<dl>
					<dt class="detail_title">상품명 : ${view.title }</dt>
					<dd>
						<div class="price_info">
							<dl>
								<dt>경매 시작가</dt>
								<dd>
									<p class="price_tem">${view.start_price }</p>
									원
								</dd>
								<dt>현재 입찰가</dt>
								<dd>
									<p class="price_sale	">${view.highest_bid }</p>
									원
								</dd>

								<dt>판매자</dt>
								<dd>
									<p>${view.id}</p>
								</dd>
							</dl>
						</div>
						<img src="/img/main/detail_banner01.jpg" width="100%">
						<div class="price_info">
							<div class="border_tbbox">
								<dl>

									<dt>배송방법</dt>
									<dd>
										<p>택배</p>
									</dd>
									<dt>배송비결제</dt>
									<dd>
										<p>주문시 결제</p>
									</dd>
									<dt>배송비</dt>
									<dd>
										<p>1800원</p>
										(50,000원 이상 구매 시 무료 / 제주,도서지역 추가 4,000원)
									</dd>
								</dl>
							</div>
							<div class="border_tbbox">
								<dl>
									<dt>원산지</dt>
									<dd>
										<p>경기도 광명시</p>
									</dd>
								</dl>
							</div>

						</div>
					</dd>
				</dl>








				<button class="buy_button">
					<img src="/img/main/buy_icon.png" width="20px;"><span>입찰하기</span>
				</button>
				<button class="buy_button">
					<img src="/img/main/buy_icon.png" width="20px;"><span>입찰취소</span>
				</button>

			</div>
		</div>

		<div style="border: solid 1px black;">
			<span style="border: 1px solid blue;"> 상품 상세설명 :
				${view.content } </span>
		</div>
		<br>
		
<!-- 		문의하기 -->
		<div style="border: 1px solid black;">
			<div>
			<input type="text" size="7" 
				id="commentWriter"
				value="${sessionScope.id }" readonly="readonly"/>
			<textarea rows="3" cols="60"
			 id="commentContent"></textarea>
			<button id="btnCommInsert" class="btn">입력</button>
		</div>	<!-- 댓글 입력 end -->
		
		</div>
	</div>
</body>
</html>