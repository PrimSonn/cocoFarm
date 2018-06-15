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
	<h1>쪽지 보내기</h1>
	<form action="/mypage/writeMessage.do" method="post" class="writeMessage_box">
		<input type="hidden" id="sender_idx" name="sender_idx" value="${account.idx }" />
		<input type="hidden" id="sender_name" name="sender" value="${account.name }" />

		<input type="hidden" id="receiver_idx" name="receiver_idx" value="${msg.idx }" />
		<div class="writeMessage_content"><label>받는사람</label><input type="text" id="receiver" name="receiver" readonly="readonly" value="${msg.name }" /></div><br>

		<div class="writeMessage_content"><label>제목</label><input type="text" id="title" name="title" /></div><br>
		
		<div class="writeMessage_content"><label class="labelTop">내용</label>
		<textarea id="content" rows="10" cols="50" name="content"></textarea></div><br>
		
		<div class="btn_wrMess"><button id="btn_writeMessage">작성</button></div>
	</form>
</div>
</body>
</html>