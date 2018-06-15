<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

function deleteLicense( idx ) {
	alert("삭제를 진행하시겠습니까.")
	console.log("idx = " + idx);
	
	var $form = $("<form>").attr({
		method:"post"
		, action:"/mypage/deleteLicense.do"
	});
	var $input = $("<input>").attr({
		type:"hidden"
		, name:"acc_idx"
		, value:idx
	});
	
	$form.append( $input ).appendTo( $(document.body) );
	
	$form.submit();
}

</script>

<title>Insert title here</title>
</head>
<body>
<div class="del_license">
<h1>사업자등록 삭제</h1>

<div class="del_license_center">
<button class="del_btn"onclick="deleteLicense(${sessionScope.idx });">사업자등록증 삭제</button>
</div>
</div>
</body>
</html>