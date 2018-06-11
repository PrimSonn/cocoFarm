<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/message.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">

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

</head>
<body>
<div id="mypageheader">
	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<li><a href="#">고객</a></li>
			<li><a href="#">사업자</a></li>
			<li><a href="#">관리자</a></li>
		</ul>
		
		<ul class="left_list">
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/login/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="/login/join.do">회원가입</a></li>
			</c:if>
			<li><a id="alarm" href="#">알림</a></li>	
			<li><a href="/mypage/message.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
			<div class="logo"><a href="/main/cocomain.do"><img src="/img/main/logo_color.png" alt="코코팜 로고"></a></div>
			<div class="search"><input type="text" placeholder="농산물 검색하기"><button class="search_icon"></button> </div>
		</div>
		<div class="mypage_box">
			<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle">
					<c:if test="${sessionScope.type eq 1 }"><h2>관리자</h2></c:if>
					<c:if test="${sessionScope.type eq 2 }"><h2>판매자 회원</h2></c:if> 
					<c:if test="${sessionScope.type eq 3 }"><h2>일반 회원</h2></c:if>
					<h1>마이페이지</h1></div>
					<div class="mypageimg"><img class="profile" src="/img/profile/${account.thumb_loc }"></div>
					<div class="mypagewho"><span><strong>김환민</strong>님&nbsp</span>hwanmin0121</div>
					<div class="mail_box"><a href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
				</div>
				<div class="mypage_navbody">
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					<ul>
						<li><a href="/mypage/user/updateAccount.do">개인정보 수정</a></li>
						<li><a href="/mypage/license.do">판매자 등록</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="#">장바구니 조회</a></li>
						<li><a href="/mypage/deleteAcc.do">회원 탈퇴</a></li>
					</ul>
					<c:if test="${sessionScope.type ne 3}">
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					<ul>
						<li><a href="#">판매등록하기</a></li>
						<li><a href="#">판매상품 조회/수정</a></li>
						<li><a href="#">판매 결제 내역 조회 </a></li>
						<li><a href="#">판매 결제 배송 승인</a></li>
					</ul>
					</c:if>
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매</p>
					<ul>
						<li><a href="#">경매등록하기</a></li>
						<li><a href="#">경매 상품 조회하기</a></li>
					</ul>
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">고객센터</p>
					<ul>
						<li><a href="/mypage/writeInquiry.do">관리자에게 문의하기</a></li>
					</ul>
				</div>
			</div>
			
			<div class="mypage_updateAccount">
				<div class="messageForm">
					<div>
					   <table>
					      <thead>
					         <tr>
					            <th>제목</th>
					            <c:if test="${messageCate eq 1 }">
					               <th>보낸사람</th>
					            </c:if>
					            <c:if test="${messageCate eq 2 }">
					               <th>받은사람</th>
					            </c:if>
					            <c:if test="${messageCate eq 1 }">
					               <th>보낸날짜</th>
					            </c:if>
					            <c:if test="${messageCate eq 2 }">
					               <th>받은날짜</th>
					            </c:if>
					         </tr>
					      </thead>
					      <tbody>
					         <tr>
					            <td>${message.title }</td>
					            <c:if test="${messageCate eq 1 }">
					               <td>${sender }</td>
					            </c:if>
					            <c:if test="${messageCate eq 2 }">
					               <td>${receiver }</td>
					            </c:if>
					            <td>${message.written_time }</td>
					         </tr>
					         <tr>
					         	<th colspan="3" style="text-align: center;">내용</th>
					         </tr>
					         <tr>
					         	<td colspan="3" style="text-align: center;">${message.content }</td>
					         </tr>
					      </tbody>
					   </table>
					   <a href="/mypage/message.do"><button>목록</button></a>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>	

</body>
</html>