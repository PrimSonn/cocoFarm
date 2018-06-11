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
var message = '${msg}';
var returnUrl = '${url}';
var check = ${check};
if(check == 0){
alert(message);
document.location.href = returnUrl;
}else if(check ==1){
alert(message);	
window.close();
}
window.opener.location.reload();
});
// document.location.href = returnUrl;
</script>
</body>
</html>