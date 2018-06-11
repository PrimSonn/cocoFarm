<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">

</head>
<body>
<div id="loginheader">

	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<li><a href="#">고객</a></li>
			<li><a href="#">사업자</a></li>
			<li><a href="#">관리자</a></li>
		</ul>
		
		<ul class="left_list">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="#">회원가입</a></li>
			<li><a href="#">알림</a></li>	
			<li><a href="/mypage/message.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<div class="search"><input type="text" placeholder="농산물 검색하기"><button class="search_icon"></button> </div>
		</div>
		<div class="login_box">
			<p>
			<label>사용자 아이디</label><br>
			<input type="text" class="login_text" placeholder="아이디를 입력주세요.">
			</p>
			
			<p>
			<label>비밀번호</label><br>
			<input type="text" class="login_text" placeholder="비밀번호를 입력주세요.">
			</p>
			
			<ul class="log_joinbutton">
				<li class="loginbutton"><a href="#">로그인하기</a></li>
				<li class="joinbutton"><a href="#">회원가입</a></li>
			</ul>
			
			<div class="find_idpw"><a href="#">아이디 / 비밀번호를 잊으셨나요?</a></div>
	
		</div>
	
	</div>
	
	
</div>	


</body>
</html>