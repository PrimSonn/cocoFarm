<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<!-- textarea 자동 크기 조절 -->
<style type="text/css">
textarea.autosize {min-height: 80px;}
</style>

<script type="text/javascript">

// 입찰 팝업 창
var openWin;
        function openChild()
        {
        	console.log(document.getElementById("price_sale").value);
            // window.name = "부모창 이름"; 
            window.name = "parentForm";
            // window.open("open할 window", "자식창 이름", "팝업창 옵션");
            openWin = window.open("/auction/bidPopup.do?highest_bid="+${view.highest_bid}
            +"&start_price="+${view.start_price}
            +"&title="+'${view.title }'
            +"&name="+'${view.name}'
            +"&idx="+'${view.idx}',
                    "", "width=570, height=350, resizable = no, scrollbars = no");    
//             openWin.document.getElementById("cInput").value = document.getElementById("price_sale").value;
//             openWin.document.getElementById("cInput").value;
        }
        



// <!-- textarea 자동 크기 조절 -->
function resize(obj){
	obj.style.height = "1px";
	obj.style.height = (10+obj.scrollHeight)+"px";
}


$(document).ready(function() {
	
$("#btnCommInsert").click(function() {
	// 게시글 번호.... ${board.boardno }
// 		console.log($("#commentWriter").val());
// 		console.log($("#commentContent").val());

// 	console.log("여기 들어감?");
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
			name:"writer_idx",
			value:"${sessionScope.idx}"
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


$(".btnAnswerInsert").click(function() {
// 	console.log($(this).parent().find(".commentIdx").val());
// 	console.log($(this).parent().parent().find(".answerContent").val());
	$form = $("<form>").attr({
		action: "/auction/auction_answer.do",
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
			name:"idx",
			value:$(this).parent().find(".commentIdx").val()
		})
	)
// 	.append(
// 		$("<textarea>").attr({
// 			type:"hidden",
// 			name:"answer",
// 			value:$(this).parent().parent().find(".answerContent").val()
// 		})
// 		);
	.append(
		$("<textarea>")
			.attr("name", "answer")
			.css("display", "none")
			.text($(this).parent().parent().find(".answerContent").val())
	);
	$(document.body).append($form);
	$form.submit();
});


$('.open_icon').on('click', function(){
	if($(this).parent().parent().hasClass("info_open")==true){
		$(this).parent().parent().removeClass('info_open');
		$(this).text("열기");
	}else{
		$(this).parent().parent().addClass("info_open");
		$(this).text("닫기");
	}
});

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
									<p class="price_sale"><input type="hidden" id="price_sale" value="${view.highest_bid }"/> ${view.highest_bid }</p>
									원
								</dd>

								<dt>판매자</dt>
								<dd>
									<p>${view.name}</p>
								</dd>
							</dl>
						</div>
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


				<button class="buy_button" id="bid_btn" style="cursor: pointer;" onclick="openChild()">
					<span>입찰하기</span>
				</button>
				<button class="buy_button" id="bid_cancel_btn" style="cursor: pointer;">
					<span>입찰취소</span>
				</button>

			</div>
		</div>
		
		<div class="item_info">
		<a>상품 문의
		
		<span class='open_icon' style="cursor: pointer;">열기</span></a>
		<!-- 		문의하기 -->
		<div >
			<div>
			<ul style="list-style: none; margin: 0; padding: 0;">
			<li style="margin: 0 0 0 0; padding: 0 0 0 0; border: 0; float: left;">
			<input type="text" size="7" 
				id="commentWriter"
				value="${sessionScope.id }" readonly="readonly"/>
			
			<textarea class="autosize" onkeydown="resize(this)" onkeyup="resize(this)" style="margin-top: 20px; width: 950px; resize: none;"
			 id="commentContent"></textarea>
			 </li>
			 <li style="margin:25px 18px 36px 25px; margin-left:25px; padding: 0 0 0 0; border: 0; float: left;">
			<button id="btnCommInsert" class="" style="width: 50px; height: 30px;">입력</button>
			</li>
			</ul>
		</div>	<!-- 댓글 입력 end -->
			<div class="">
			<table class="inquireTb" style="border: 1px solid; margin-left: 55px; width: 1005px; border-collapse: collapse;" >
<thead style="line-height: 2;">
<tr>
	<th style="border: 1px solid; width: 40px">글 번호</th>
	<th style="border: 1px solid; width: 70px;">글쓴이 이름</th>	
	<th style="border: 1px solid; width: 500px;">내용</th>
	<th style="border: 1px solid; width: 60px;">글쓴시간</th>
</tr>
</thead>
<tbody>
<c:forEach items="${inquireList }" var="inquireList" varStatus="status">
<tr data-commentno="${inquireList.idx }" style="line-height: 3;" >
	<td align="center" style="padding: 0 0 0 0; border: 1px solid;">${status.count }</td>
	<td align="center" style="padding: 0 0 0 0; border: 1px solid;">${inquireList.name }</td>
	<td align="left" style="padding: 0 0 0 0; border: 1px solid; line-height: 1.8;">${inquireList.content }</td>
	<td align="center" style="padding: 0 0 0 0; border: 1px solid;">
		<p><fmt:formatDate value="${inquireList.written_time }"
			pattern="yy-MM-dd" /></p>
		<p><fmt:formatDate value="${inquireList.written_time }"
			pattern="HH:mm:ss" /></p>
	</td>
</tr>
<tr style="line-height: 5;">
<td></td>
<td><img alt="화살표" src="/auction_img/arrow.png" style="width: 30px; height: 30px; vertical-align: middle; padding-left: 30px;"></td>
<td colspan="3" align="left" style="line-height: 1.8; height: 55px;">

<c:choose>
	<c:when test="${empty inquireList.answer }">
<!-- 답글이 비어있을 때 보임 -->
		<c:choose>
		<c:when test="${sessionScope.type eq 2 && view.id eq sessionScope.id}">
<!-- 사업자 계정인지 검사 -->
<!-- 경매글 작성자인지 검사 -->
<!-- 사업자계정에 경매글의 주인이면 보이는곳 -->
			<div>
			<ul style="list-style: none; margin: 0; padding: 0;">
			<li style="margin: 0 0 0 0; padding: 0 0 0 0; border: 0; float: left;">
			<textarea rows="5" cols="60" style="margin-top: 20px; width: 900px"
			 class="answerContent"></textarea>
			 </li>
			 <li style="margin:25px 18px 36px 25px; margin-left:25px; padding: 0 0 0 0; border: 0; float: left;">
			<button class="btnAnswerInsert" class="" style="width: 50px; height: 30px;">답변</button>
			 <input class="commentIdx" type="hidden" value="${inquireList.idx }"/>
			</li>
			</ul>
		</div>	<!-- 댓글 입력 end -->
	</c:when>
	<c:otherwise> <span class="notanswer" style="padding-left: 20px;"> 아직 답변이 등록되지 않았습니다.</span></c:otherwise>
			</c:choose>
			</c:when>

			
	<c:when test="${!empty inquireList.answer }">
	<span class="answer" style="padding-left: 20px;">
	<!-- 답글이 있으면 답글보이는곳 -->
	${inquireList.answer }
	</span>
	</c:when>
			
		</c:choose>

	
</td>
</tr>
</c:forEach>
</tbody>
</table>	<!-- 댓글 리스트 end -->
			</div>
		</div>
		
		
		</div>

		<div class="item_info">
		<a>판매자 정보
		
		<span class='open_icon' style="cursor: pointer;">열기</span>
	
		</a>
		<table class='tbl_spec'>
		<tbody>
			<tr>
				<th>사업자 법인명</th>
				<td></td>
			</tr>
			<tr>
				<th>대표자 이름</th>
				<td></td>
			</tr>
			<tr>
				<th>사업자 주소</th>
				<td></td>
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
			<a>상품 상세설명 <span class='open_icon' style="cursor: pointer;">열기</span>

			</a>
		<div style="padding-left: 20px;">
			<span > 
			
				${view.content } </span>
		</div>
	</div>
		<br>
		

	</div>
</body>
</html>