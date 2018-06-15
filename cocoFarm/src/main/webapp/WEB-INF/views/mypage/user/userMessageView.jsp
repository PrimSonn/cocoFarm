<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>장바구니 조회</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<link rel="stylesheet" type="text/css" href="/css/message.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소 API -->
<script type="text/javascript">
$(document).ready(function() {	
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
	
});
</script>

<script>
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

function cartItems() {
// 	var size = ${optionView };
}

$(document).ready(function() {
	
	/* 장바구니 옵션 변경 버튼 */
	$.ajax({
		type: "POST"
		, url: "/product/cart.do"
		, data: {
			// 장바구니 상품
		}
		, dataType: "json"
		, success: function(data) {
			
		}
	})
	
});
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
		<table >
			<tr>
				<th>제목</th>
				<td>${message.title }</td>
			</tr>
			
			<c:if test="${messageCate eq 1 }">
			<tr>
				<th>보낸사람</th>
				<td>${sender }</td>
			</tr>
			<tr>
				<th>보낸날짜</th>
				<td>${message.written_time }</td>
			</tr>
			</c:if>
			
			<c:if test="${messageCate eq 2 }">
			<tr>
				<th>받은사람</th>
				<td>${receiver }</td>
			</tr>
			<tr>
				<th>받은날짜</th>
				<td>${message.written_time }</td>
			</tr>
			</c:if>
			
			<tr>
				<th>내용</th>
				<td>${message.content }</td>
			</tr>
		</table>
	<div>
		<a onClick="closeLayer(this)" style="cursor:pointer;" title="닫기">취소</a>
	</div>
		
		
		
			</div>
		</div>
	</div>	
</div>
</body>
</html>