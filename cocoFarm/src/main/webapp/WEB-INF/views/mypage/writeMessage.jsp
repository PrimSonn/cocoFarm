<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/message.css">
</head>
<body>
<div id="writeMessage">
	<form action="/mypage/writeMessage.do" method="post">
		<input type="hidden" id="sender_idx" name="sender_idx" value="${account.idx }" />
		<input type="hidden" id="sender_name" name="sender" value="${account.name }" />

		<input type="hidden" id="receiver_idx" name="receiver_idx" value="${msg.idx }" />
		<label>받는사람</label><input type="text" id="receiver" name="receiver" value="${msg.name }" /><br>

		<label>제목</label><input type="text" id="title" name="title" /><br>
		<label>내용</label><br>
		<textarea id="content" rows="10" cols="50" name="content"></textarea><br>
		
		<button>작성</button>
	</form>
</div>
</body>
</html>