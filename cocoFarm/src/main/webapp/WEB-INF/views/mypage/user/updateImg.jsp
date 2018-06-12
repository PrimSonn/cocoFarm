<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소 API -->
<script type="text/javascript">

</script>

</head>
<body>
				<div class="border">
					<h1>프로필 수정</h1>
					<div class="modify_profile">
						<div class="account_update">
							<img class="profile" src="/img/profile/${account.thumb_loc }">
							<form action="/mypage/user/updateProfile.do" method="post" enctype="multipart/form-data">
								<input type="file" id="profile" name="profile" /><br>
								<!-- <button class="img_submit">이미지 적용</button> -->
								<button>프로필 적용</button>
							</form>
						</div>
					</div>
				</div>
			
	

</body>
</html>