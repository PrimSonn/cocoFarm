<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="/css/message.css">

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
				 , curPage: '${curPage }'
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
	
				<div class="messageForm">
					<h1>쪽지함</h1>
					<select id="messageCate" name="messageCate">
					   <option value="1" <c:if test="${param.messageCate=='1' }">selected</c:if>>받은쪽지함</option>
					   <option value="2" <c:if test="${param.messageCate=='2' }">selected</c:if>>보낸쪽지함</option>
					</select>
				</div>
			
				<div id="messageBox"></div>
	
</html>