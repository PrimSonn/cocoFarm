<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div id="header_detail">
	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<li><a href="#">고객</a></li>
			<li><a href="#">사업자</a></li>
			<li><a href="#">관리자</a></li>
		</ul>
		
		<ul class="left_list">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="/login/join.do">회원가입</a></li>
			<li><a href="#">알림</a></li>	
			<li><a href="/product/insert.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<!--2018년 5월 25일 hwanmin 추가   -->
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
				<li><a href="#">자주 묻는 질문</a></li>	
				<li><a href="/notice/list.do">공지사항</a></li>
				<li><a href="#">회사소개</a></li>
			</ul>
		</div>
	</div>
</div>