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
/*메세지 클릭시 */

$(document).ready(function() {

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
	
});

</script>
<!-- 
<style type="text/css">
#alarm::after {
	background-color: green;
    color: white;
    font-weight: bold;
	content: '${alarmCnt }';
	padding: 2px;
	margin: 2px;
	border-radius: 10px;
}
</style>

 -->


</head>
<body>
<div id="mypageheader">

<!--Mypage부분 header ver3부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mypagehead.jsp" flush="false"/>

	<div class="container">
		<!--Mypage부분  검색 로고부분 -->
		<jsp:include page="/WEB-INF/views/tile/head/mypageSearch.jsp" flush="false"/>

		<div class="mypage_box">
			<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle01"><h2>관리자</h2><h1>마이페이지</h1></div>
					<div class="mypageimg"><img src="/img/profile/${account.thumb_loc}" ></div>
					<div class="mypagewho"><span><strong>${sessionScope.name}</strong>님&nbsp;</span>환영합니다.</div>
					<div class="mail_box"><a class="nav-link" href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >1:1 문의함 확인</a></div>
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">회원 정보 관리</p>
					
					<ul>
						<li class="nav-link"><a href="/mypage/licenseList.do">사업자 등록 조회/승인</a></li>
						<li></li>
						<li class="nav-link"><a href="/mypage/wholeAcc.do">전체 회원 조회</a></li>
						<li class="nav-link"><a href="/mypage/delWholeAcc.do">탈퇴 회원 조회</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매 상품 관리</p>
					
					<ul>
						
						<li class="nav-link"><a href="/product/cart.do">회원 결제내역 조회</a></li>
					</ul>
					
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매 상품 관리</p>
					<ul>
						<!-- <li><a href="#">경매등록하기</a></li> -->
						<li><a href="#">회원 결제내역 조회</a></li>
					</ul>
					
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">사이트관리</p>
					<ul>
						<li class="nav-link"><a href="/banner/write.do">배너 광고 관리</a></li>
						<li class="nav-link"><a href="/notice/write.do">공지사항 글 등록</a></li>
						<li class="nav-link"><a href="/board/write.do">농부스토리 글등록</a></li>
					</ul>
				</div>
			</div>
			
<div class="mypage_page01">
	<div class="mypage_updateAccount">
				<div class="messageForm">
					<h1>1:1 문의함</h1>
					<select id="messageCate" name="messageCate">
					   <option value="1" <c:if test="${param.messageCate=='1' }">selected</c:if>>받은쪽지함</option>
					   <option value="2" <c:if test="${param.messageCate=='2' }">selected</c:if>>보낸쪽지함</option>
					</select>
<!-- 					<button id="sendMessageBtn">쪽지 보내기</button> -->
				</div>
			
				<div id="messageBox"></div>
			</div>
</div>

			</div>
	</div>
</div>	
</body>
</html>

