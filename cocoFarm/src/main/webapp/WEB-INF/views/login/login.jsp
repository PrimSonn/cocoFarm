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
			<li><a href="#">알림</a></li>	
			<li><a href="/mypage/message.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><a href="/cocomain.do"><img src="/img/main/logo_color.png" alt="코코팜 로고"></a></div>
				<div class="search"><input type="text" placeholder="농산물 검색하기"><button class="search_icon"></button> </div>
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