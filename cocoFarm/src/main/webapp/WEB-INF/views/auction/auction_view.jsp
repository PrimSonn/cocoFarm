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
        	if(${view.writter_idx} == ${sessionScope.idx}){
        		alert("자신의 경매글에는 입찰하실수 없습니다.")
        	} else{
        	var popupX = (window.screen.width / 2) - (570 / 2);

        	var popupY= (window.screen.height /2) - (500 / 2);
        	
        	console.log(document.getElementById("price_sale").value);
            // window.name = "부모창 이름"; 
            window.name = "parentForm";
            // window.open("open할 window", "자식창 이름", "팝업창 옵션");
            openWin = window.open("/auction/bidPopup.do?highest_bid="+${view.highest_bid}
            +"&start_price="+${view.start_price}
            +"&title="+'${view.title }'
            +"&name="+'${view.name}'
            +"&idx="+'${view.idx}',
                    "childForm",
                    'width=570, height=350, left='+ popupX + ', top='+ popupY + ', screenX='+ popupX + ', screenY= '+ popupY);    
//             openWin.document.getElementById("cInput").value = document.getElementById("price_sale").value;
//             openWin.document.getElementById("cInput").value;
        	}
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
	).append(
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

<!--detail부분 header ver2부분  -->
<jsp:include page="/WEB-INF/views/tile/head/detailhead.jsp" flush="false"/>



	<div class="container">
		<div class="nav_map">
			<span><strong><a href="">메인</a></strong></span><span>></span><span><a
				href="">농산물</a></span><span>></span><span>채소/과일</span><span>></span><span>현재상품</span>
		</div>
		<div class="detail_body" style="height: 570px;">
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
									<p class="price_tem"><fmt:formatNumber type="number" value="${view.start_price }"/></p>
									원
								</dd>
								<dt>현재 입찰가</dt>
								<dd>
									<p class="price_sale"><input type="hidden" id="price_sale" value="${view.highest_bid }"/><fmt:formatNumber type="number" value="${view.highest_bid }"/></p>
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
							

						</div>
					</dd>
				</dl>


				<button class="buy_button" id="bid_btn" style="cursor: pointer; margin-left: 100px;" onclick="openChild()">
					<span>입찰하기</span>
				</button>
			</div>
			
		</div>
			<div class="bidderList" style="margin:auto; ">
			
			
			<h1 style="font-size: 15px; font-weight: bold; margin-left: 50px;">상위 입찰 목록</h1>
			<h1 style="margin-left: 50px;">(상위 입찰은 5명까지 표시됩니다.)</h1><br>
			
			<table style="line-height:1.8; 2px solid #e7e7e7; width:1000px; margin:auto; text-align: center; margin-bottom: 40px; border-collapse: collapse;">
			<thead style="background: #e7e7e7;">
				<tr>
				<th style="border-left: 1px solid #e7e7e7; border-bottom: 1px solid #e7e7e7; border-top: 1px solid #e7e7e7; border-right: 2px solid #ffffff; ">입찰자</th>
				<th style="border-bottom: 1px solid #e7e7e7; border-top: 1px solid #e7e7e7; border-right: 2px solid #ffffff;" >입찰금</th>
				<th style="border-top: 1px solid #e7e7e7; border-right: 1px solid #e7e7e7">입찰시각</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${!empty bidderList }">
				<c:forEach items="${bidderList }" var="bidderList">
				<tr>
				<td style="border: 1px solid #e7e7e7">${bidderList.name }</td>
				<td style="border: 1px solid #e7e7e7"><fmt:formatNumber type="number" value="${bidderList.amount }"/>원</td>
				<td style="border: 1px solid #e7e7e7">${bidderList.bid_time }</td>
				</tr>
				</c:forEach>
				</c:if>
			<c:if test="${empty bidderList }">
			<tr>
			<td colspan="3" style="border: 1px solid #e7e7e7"> 아직 입찰자가 존재하지 않습니다. </td>
			</tr>
			</c:if>
			</tbody>
			</table>
			</div>
		
		<div class="item_info">
		<a>상품 문의
		
		<span class='open_icon' style="cursor: pointer;">열기</span></a>
		<!-- 		문의하기 -->
		<div >
			<div>
			<ul style="list-style: none; margin: 0; padding: 0;">
			<li style="margin: 0 0 0 0; padding: 0 0 0 0; border: 0; float: left;">
			<textarea class="autosize" onkeydown="resize(this)" onkeyup="resize(this)" style="margin-top: 20px; margin-left:50px; width: 950px; resize: none;"
			 id="commentContent"></textarea>
			 </li>
			 <li style="margin:25px 18px 36px 25px; margin-left:25px; padding: 0 0 0 0; border: 0; float: left;">
			<button id="btnCommInsert" class="" style="width: 50px; height: 30px;">입력</button>
			</li>
			</ul>
		</div>	<!-- 댓글 입력 end -->
			<div class="">
			<c:if test="${!empty inquireList }">
			<table class="inquireTb" style="border: 1px solid; margin:auto; width: 1005px; border-collapse: collapse;" >
<thead style="line-height: 2;">
<tr>
	<th style="border: 1px solid; width: 40px;">글 번호</th>
	<th style="border: 1px solid; width: 70px;">글쓴이 이름</th>	
	<th style="border: 1px solid; width: 500px;">내용</th>
	<th style="border: 1px solid; width: 60px;">글쓴시간</th>
</tr>
</thead>
<tbody>
<c:forEach items="${inquireList }" var="inquireList" varStatus="status">
<tr style="line-height: 3;" >
	<td align="center" style=" border: 1px solid;">${status.count }</td>
	<td align="center" style=" border: 1px solid;">${inquireList.name }</td>
	<td align="left" style=" border: 1px solid; line-height: 1.8;">${inquireList.content }</td>
	<td align="center" >${inquireList.written_time }</td>
</tr>
<tr style="line-height: 5;">
<td></td>
<td><img alt="화살표" src="/auction_img/arrow.png" style="width: 30px; height: 30px; vertical-align: middle; padding-left: 30px;"></td>
<td colspan="2" align="left" style="line-height: 1.8; height: 55px;">

<c:choose>
	<c:when test="${empty inquireList.answer }">
<!-- 답글이 비어있을 때 보임 -->
		<c:choose>
		<c:when test="${sessionScope.type eq 2 && view.writter_idx eq sessionScope.idx}">
<!-- 사업자 계정인지 검사 -->
<!-- 경매글 작성자인지 검사 -->
<!-- 사업자계정에 경매글의 주인이면 보이는곳 -->
			<div>
			<ul style="list-style: none;">
			<li style="margin: 0 0 0 0; float: left;">
			<textarea rows="5" cols="60" style="margin-top: 20px; width: 780px; resize: none;"
			 class="answerContent"></textarea>
			 </li>
			 <li style="margin-left:22px; margin-top:35px; float: left;">
			<button class="btnAnswerInsert" style="width: 50px; height: 30px;">답변</button>
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
</c:if>
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