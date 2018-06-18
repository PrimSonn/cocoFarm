<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
$(document).ready(function(){
	<c:if test="${sessionScope.idx ne null }">
	$.ajax({
		type : "POST",
	   url : "/mypage/user/mes_arl.do",
	   dataType : "json",
	   async: false,
		success : function(data) {
			$("#alarm").after("<span>"+data.alarmCnt+"</span>");
		},
	   error : function(e) {
	   }
	});
	</c:if>
});

function submit() {
	<c:if test="${sessionScope.idx eq null}">
	alert("로그인이 필요합니다.");
	</c:if>
	<c:if test="${sessionScope.idx ne null}">
	console.log(333);
	location.href="/mypageIntro.do";
	</c:if>
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
</style>

<div id="TOP_BTN_BOX"><a id="MOVE_TOP_BTN" href="#">TOP</a></div>

<div id="header_detail">
	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<c:choose>
				<c:when test="${sessionScope.type==3}">
					<li class="choose_color3">고 객</li>
					<li>판매자</li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==2}">
					<li>고 객</li>
					<li class="choose_color2">판매자</li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==1}">
					<li>고 객</li>
					<li>판매자</li>
					<li class="choose_color1">관리자</li>
				</c:when>
				<c:otherwise>
					<li>고 객</li>
					<li>판매자</li>
					<li>관리자</li>
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
			<c:if test="${sessionScope.idx eq null }">
			<li><a href="/mypageIntro.do" id="alarm">알림</a></li>	
			</c:if>
			<c:if test="${sessionScope.idx ne null }">
			
			<li><a href="/mypageIntro.do">마이페이지</a></li>	
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a style="cursor:pointer" onclick="javascript:alert('로그인이 필요합니다.');return false;"">마이페이지</a></li>	
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
	</div>
</div>