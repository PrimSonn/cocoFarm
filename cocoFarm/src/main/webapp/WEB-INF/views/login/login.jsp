<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$(".login_box").keypress(function(e){
	       if(e.which == 13)
	           $("#loginBtn").click();
	   });
	$("#loginBtn").click(function(){
		
		
		if(!$("#id").val()){
			alert("아이디를 입력해주세요");
			return false;
		}
		if(!$("#pw").val()){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		$("#loginForm").submit();
	});
});
</script>
</head>
<body>
<div id="loginheader">

<!--Mypage부분 header ver3부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mypagehead.jsp" flush="false"/>

	<div class="container">
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<div class="search">
					<form action="/seller.do" method="post">
						<input type="text" name="search_name" placeholder="농산물 검색하기"><button class="search_icon" style="cursor:pointer">
						</button>
					</form> 
				</div>
		</div>
		<div class="login_box">
			<form id="loginForm" action="/login/login.do" method="post">
			<p>
			<label>사용자 아이디</label><br>
			<input type="text" id="id" name="id" class="login_text" placeholder="아이디를 입력주세요.">
			</p>
			
			<p>
			<label>비밀번호</label><br>
			<input type="password" id="pw" name="pw" class="login_text" placeholder="비밀번호를 입력주세요.">
			</p>
			
			<ul class="log_joinbutton">
				<li class="loginbutton"><a id="loginBtn" href="#">로그인하기</a></li>
				<li class="joinbutton"><a href="/login/join.do">회원가입</a></li>
			</ul>
			<div class="find_idpw"><a href="/login/findIdPw.do">아이디 / 비밀번호를 잊으셨나요?</a></div>
			</form>
	
		</div>
	
	</div>
	
	
</div>	


</body>
</html>