<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="header">

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
					<li class="choose_color2"><a href="#">사업자</a></li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==1}">
					<li>고 객</li>
					<li>사업자</li>
					<li class="choose_color3">관리자</li>
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
			<li><a href="#">알림</a></li>	
			<li><a href="/mypageIntro.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><a href="/main.do"><img src="/img/main/logo_color.png" alt="코코팜 로고"></a></div>
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
				<li><a href="#">경매</a></li>
				<li><a href="#">농부 스토리</a></li>	
				<li><a href="#" id="FAQ">자주 묻는 질문</a></li>	
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