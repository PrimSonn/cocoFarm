<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cocoFarmSignIn</title>
</head>
<body>
<div>
	<h3>SignIn</h3>
	<br>
	<hr>
				<!-- ************** 예시로 남겨둔 파일. 지우고 시작할 것.************** -->
	
	<form action='In'method='post'>
		<label for='id'>ID: <input type="text"name='id'></label><br>
		<label for='pw'>PW: <input type="text"name='pw'><br></label>
		<input type='submit'value='signIn'>
	</form>
	<hr>
	<a href="/cocoFarm/Door">Door</a><br>
</div>
</body>
</html>