<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	
	$("#btnDeleteAcc").click(function() {
// 		console.log("idx = " + '${sessionScope.idx }' );
// 		console.log("pw = " + document.getElementById("#pw").val());
		var password = $("#pw").val();
		console.log("패스워드 확인 : "+password);
		
		console.log('${sessionScope.idx}');
		$.ajax({
			type:"POST"
			, url: "/mypage/deleteAccProc.do"
			, dataType:"json"
// 			, contentType:"application/json; charset=utf-8"
			, data: {
				idx: '${sessionScope.idx}',
				pw: password
			}
			, success: function(res) {
				if( res.check == true ) {
					alert("회원탈퇴가 완료되었습니다.");
					window.opener.location.href="/main/cocomain.do"
					self.close();
				} 
				else if( res.check == false ) {
					alert("회원탈퇴가 실패하셨습니다.")
					self.close();
				}
			}
			, error: function(res) {
				console.log(res.responseText)
				alert("회원탈퇴 에러!");
			}
		});
	});
	
});

</script>


<title>Insert title here</title>
</head>
<body>

<h2>회원탈퇴</h2><br>
<p>회원탈퇴를 위해 비밀번호를 입력하세요</p><br>
<input type="password" id="pw" name="pw" size="20px"><br><br>
<button id="btnDeleteAcc" name="btnDeleteAcc">탈퇴</button>
<button onclick="self.close();" >닫기</button>


</body>
</html>