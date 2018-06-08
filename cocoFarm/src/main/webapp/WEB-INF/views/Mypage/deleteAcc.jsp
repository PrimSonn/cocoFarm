<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">


function windowOpen() {
	console.log("idx = " + ${sessionScope.idx } );
	var url = "/mypage/deleteAccNewWindow.do";
	window.open(url, '회원탈퇴', 'width=450px, height=350px, toolbar=no, menubar=no, scrollbars=no, resizable=no');
}

</script>


<title>Insert title here</title>
</head>
<body>

<h1>회원탈퇴</h1>
<hr>

<h2>회원 탈퇴</h2><br>
<p>회원 탈퇴를 원하시면 탈퇴 버튼을 누르세요.</p><br>
<button id="deleteAcc" name="deleteAcc" onclick="windowOpen();">탈퇴</button>
<a href="/mypage/mypage.do"><button>취소</button></a>

</body>
</html>