<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  	
<script type="text/javascript">
$(document).ready(function(){
	$(".slide_img").hide();
	$(".slide_img").first().show();

	setInterval(function(){
		console.log('test');
		$(".slide_img").eq(1).show();
		$("#slider").append($(".slide_img").first());
	   $(".slide_img").last().hide("slide", { direction: "left" }, 1000);
	}, 3000);
	
	<c:if test="${sessionScope.idx ne null}">
	$.ajax({
		type : "POST",
	   url : "/mypage/user/mes_arl.do",
	   dataType : "json",
	   async: false,
		success : function(data) {
			$("#alarm").after("<span>"+data.alarmCnt+"</span>");
		},
	   error : function(e) {
		   //alert("실패"); 
	   }
	});
	</c:if>
	
});
	
	function submit(){
		alert("로그인이 필요합니다.");
	}

	$(function() {
	    $(window).scroll(function() {
	        if ($(this).scrollTop() > 500) {
	            $('#MOVE_TOP_BTN').fadeIn();
	        } else {
	            $('#MOVE_TOP_BTN').fadeOut();
	        }
	    });
	    
	    $("#MOVE_TOP_BTN").click(function() {
	        $('html, body').animate({
	            scrollTop : 0
	        }, 400);
	        return false;
	    });
	});
</script>

<style type="text/css">
a#MOVE_TOP_BTN {
    position: fixed;
    right: 5%;
    bottom: 500px;
    display: none;
    z-index: 999;
}
.slide_img {
 	width: 100%; 
	height: 560px;
	position: absolute;
}
</style>

<div id="TOP_BTN_BOX"><a id="MOVE_TOP_BTN" href="#">TOP</a></div>

<div id="header">
<div id="slider" style="overflow: hidden; margin: 0 auto;">
<img alt="배경" src="/img/backgroundimg/mainbackground_01.jpg" class="slide_img" >
<img alt="배경" src="/img/backgroundimg/bono1.jpg" class="slide_img" >
<img alt="배경" src="/img/backgroundimg/bono2.jpg" class="slide_img" >
<img alt="배경" src="/img/backgroundimg/images.jpg" class="slide_img" >
</div>
	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<c:choose>
				<c:when test="${sessionScope.type==3}">
					<li class="choose_color3">고 객</li>
					<li>사업자</li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==2}">
					<li>고 객</li>
					<li class="choose_color2">판매자</li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==1}">
					<li>고 객</li>
					<li>사업자</li>
					<li class="choose_color1">관리자</li>
				</c:when>
				<c:otherwise>
					<li>고 객</li>
					<li>사업자</li>
					<li>사업자</li>
				</c:otherwise>
			</c:choose>
		</ul>
		
		<ul class="left_list">
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/login/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="/login/join.do">회원가입</a></li>
			</c:if>
			
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/mypageIntro.do" id="alarm">알림</a></li>	
			</c:if>
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/mypageIntro.do">마이페이지</a></li>	
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a style="cursor:pointer" onclick="javascript:alert('로그인이 필요합니다.');return false;">마이페이지</a></li>	
			</c:if>
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><a href="/main/cocomain.do"><img src="/img/main/logo_color.png" alt="코코팜 로고"></a></div>
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

				<li><a href="/auction/auction_list.do">경매</a></li>
				<li><a href="/board/list.do">농부 스토리</a></li>	
				<li><a href="/main/faq.do" id="FAQ">자주 묻는 질문</a></li>	
				<li><a href="/notice/list.do">공지사항</a></li>
				<li><a href="/companyinfo.do">회사소개</a></li>
			</ul>
		</div>
		
		<div id="header_footimg">
			<div class="scarecrow"></div>
			<div class="calligraphy"></div>
		</div>
	
	</div>
	<div id="bottom_vimg"></div>
</div>	