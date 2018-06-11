<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/message.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {

	$("#messageCate").change(function() {

		var messageCate = $(this).val();
		$.ajax({
			type : "POST",
			url : "/mypage/readMessage.do",
			dataType : "html",
			data : {
				messageCate : messageCate
			},
			success : function(res) {
// 				alert("성공");
				$("#messageBox").html(res);
			}
		});
	});

	$("#messageCate").trigger("change");
});

</script>

</head>
<body>
	
		<div id="writeInquiry">
			<h1>1:1 문의</h1>
			<form action="/mypage/writeInquiry.do" method="post">
				<input type="hidden" id="sender_idx" name="sender_idx" value="${account.idx }" />
				<input type="hidden" id="sender_name" name="sender" value="${account.name }" />
				<input type="hidden" id="type_code" name="type_code" value="1" />

				<label>받는사람</label><input type="text" id="receiver" name="receiver" value="관리자" /><br>
				<label>제목</label><input type="text" id="title" name="title" /><br>
				<label>내용</label><br>
				<textarea id="content" rows="10" cols="50" name="content"></textarea>
				<br>

				<button>작성</button>
			</form>
		</div>
	
</body>
</html>
