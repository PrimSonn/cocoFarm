<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
$(document).ready(function() {
var message = "${msg}";
var returnUrl = "${url}";
console.log(message);
console.log(returnUrl);
alert(message);
location.href = returnUrl;
});
// document.location.href = returnUrl;
</script>
</body>
</html>