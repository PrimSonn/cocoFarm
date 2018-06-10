<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디/비밀번호 찾기</title>

<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#findIdBtn").click(function(){		
		if(!$("#name").val()){
			alert("이름을 입력해주세요");
			return false;
		}
		if(!$("#phone1").val()){
			alert("전화번호를 입력해주세요");
			return false;
		}
// 		$("#findIdForm").submit();
		
		$.ajax({
			type:"post"
    			, url:"/login/findId.do"
    			, data:{name: $("#name").val(), phone: $("#phone1").val()}
    			, dataType:"json"
    			, success:function(res) {
    				console.log("ajax 성공");
    				
    				alert("회원님의 아이디는 : "+res.result+" 입니다.");
    			}
    			, error:function() {
    				console.log("ajax 실패");
    			}
		});
	});
	
	$("#findPwBtn").click(function(){		
		if(!$("#id").val()){
			alert("아이디를 입력해주세요");
			return false;
		}
		if(!$("#phone2").val()){
			alert("전화번호를 입력해주세요");
			return false;
		}
// 		$("#findPwForm").submit();
		
		$.ajax({
			type:"post"
    			, url:"/login/findPw.do"
    			, data:{id: $("#id").val(), phone: $("#phone2").val()}
    			, dataType:"json"
    			, success:function(res) {
    				console.log("ajax 성공");
    				
    				alert("회원님의 비밀번호는 : "+res.result+" 입니다.");
    			}
    			, error:function() {
    				console.log("ajax 실패");
    			}
		});
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
		<div class="findIdPw_box">
		<div class="findId_box">
			<form id="findIdForm" action="/login/findId.do" method="post">
			<h1>아이디 찾기</h1>
			<br>
			<p>
			<label>사용자 이름</label><br>
			<input type="text" id="name" name="name" class="login_text" placeholder="이름을 입력주세요.">
			</p>
			
			<p>
			<label>핸드폰 번호</label><br>
			<input type="text" id="phone1" name="phone" class="login_text" placeholder="전화번호를 입력주세요.">
			</p>
			
			<ul class="log_joinbutton">
				<li class="loginbutton"><a id="findIdBtn" href="#">아이디 찾기</a></li>
			</ul>
			</form>
		</div>
		
		<div class="findPw_box">
			<form id="findPwForm" action="/login/findPw.do" method="post">
			<h1>비밀번호 찾기</h1>
			<br>
			<p>
			<label>사용자 아이디</label><br>
			<input type="text" id="id" name="id" class="login_text" placeholder="아이디를 입력주세요.">
			</p>
			<p>
			<label>핸드폰 번호</label><br>
			<input type="text" id="phone2" name="phone" class="login_text" placeholder="전화번호를 입력주세요.">
			</p>
				<ul class="log_joinbutton">
					<li class="loginbutton"><a id="findPwBtn" href="#">비밀번호 찾기</a></li>
				</ul>
			</form>
		</div>
		</div>
	</div>
	
</div>	

</body>
</html>