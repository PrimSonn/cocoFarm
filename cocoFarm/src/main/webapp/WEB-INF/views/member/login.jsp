<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script type="text/javascript">
window.onload = function() {
	document.getElementById("cancel").onclick = function() {
		history.back(-1);
	};
	
	document.getElementById("id").focus();
};
</script>
</head>
<body>

<div class="container">
<h1>로그인</h1>
<hr>
<div>
<form action="/member/login.do" method="post"
	class="form-horizontal">
	
	<div class="form-group">
		<label class="col-xs-2 control-label" for="id">아이디 : </label>
		<div class="col-xs-6">
			<input type="text" class="form-control" 
				id="id" name="id" placeholder="Id"/>
		</div>
	</div>

	<div class="form-group">
		<label class="col-xs-2 control-label" for="pw">패스워드 : </label>
		<div class="col-xs-6">
			<input type="password" class="form-control" 
				id="pw" name="pw" placeholder="Password"/>
		</div>
	</div>
		
	<div class="form-group">
		<div class="col-xs-offset-2 col-xs-10">
			<button class="btn btn-primary">로그인</button>
			<input type="reset" id="cancel"
				class="btn btn-danger" value="취소"/>
		</div>
	</div>
</form>
</div>
</div>

</body>
</html>




