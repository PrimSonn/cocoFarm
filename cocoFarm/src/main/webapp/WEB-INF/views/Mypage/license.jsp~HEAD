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
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">
function onlyNumber(obj) {
	$(obj).keyup(function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
}
</script>

<style type="text/css">
#label { 
	text-align: right;
}

</style>

</head>
<body>
<div id="mypageheader">

	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<li><a href="#">고객</a></li>
			<li><a href="#">사업자</a></li>
			<li><a href="#">관리자</a></li>
		</ul>
		
		<ul class="left_list">
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/login/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="/login/join.do">회원가입</a></li>
			</c:if>
			<li><a href="#">알림</a></li>	
			<li><a href="/mypage/message.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<div class="search"><input type="text" placeholder="농산물 검색하기"><button class="search_icon"></button> </div>
		</div>
		<div class="mypage_box">
			<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle">
					<c:if test="${sessionScope.type eq 1 }"><h2>관리자</h2></c:if>
					<c:if test="${sessionScope.type eq 2 }"><h2>판매자 회원</h2></c:if> 
					<c:if test="${sessionScope.type eq 3 }"><h2>일반 회원</h2></c:if>
					<h1>마이페이지</h1></div>
					<div class="mypageimg"><img class="profile" src="/img/profile/${account.thumb_loc }"></div>
					<div class="mypagewho"><span><strong>김환민</strong>님&nbsp</span>hwanmin0121</div>
					<div class="mail_box"><a href="/mypage/message.do"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
		
				</div>
			
				<div class="mypage_navbody">
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li><a href="/mypage/user/updateAccount.do">개인정보 수정</a></li>
						<li><a href="/mypage/license.do">판매자 등록</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="#">장바구니 조회</a></li>
						<li><a href="/mypage/deleteAcc.do">회원 탈퇴</a></li>
					</ul>
					
					<c:if test="${sessionScope.type ne 3 }">
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					<ul>
						<li><a href="#">판매등록하기</a></li>
						<li><a href="#">판매상품 조회/수정</a></li>
						<li><a href="#">판매 결제 내역 조회 </a></li>
						<li><a href="#">판매 결제 배송 승인</a></li>
					</ul>
					</c:if>
					<p class="navtitle_03"><img alt="" src="/img/mypage/mypageicon/mypage_aution.png">경매</p>
					<ul>
						<li><a href="#">경매등록하기</a></li>
						<li><a href="#">경매 상품 조회하기</a></li>
					</ul>
					
					<p class="navtitle_04"><img alt="" src="/img/mypage/mypageicon/mypage_service.png">고객센터</p>
					<ul>
						<li><a href="/mypage/writeInquiry.do">관리자에게 문의하기</a></li>
					</ul>
				</div>
			</div>
			
			<div class="mypage_license">
				<div class="license_box">
					<h1>사업자 등록</h1>
					<br>
					
					<form action="/mypage/license.do" method="post" enctype="multipart/form-data">
						<table>
							<tr>
								<td id="label" for="business_license_code"><label>등록번호 : </label></td>
							 	<td><input type="text" id="business_license_code" name="business_license_code" 
							 	placeholder="' - '없이 입력하세요." size="20px" onkeydown="onlyNumber(this)" maxlength="10" /></td> 
							</tr>
							<tr></tr><tr></tr>
							<tr>
								<td id="label" for="business_reg_date"><label>개업연월일(등록일자) : </label></td>
							 	<td><input type="text" id="business_reg_date" name="business_reg_date" placeholder="년/월/일" size="20px" /></td> 
							</tr>
							<tr></tr><tr></tr>
							<tr>
								<td id="label" for="corporation_name"><label>법인명(단체명) : </label> </td>
								<td><input type="text" id="corporation_name" name="corporation_name" size="20px" /></td>
							</tr>
							<tr></tr><tr></tr>
							<tr>
								<td id="label" for="representative"><label>대표자 : </label></td>
								<td><input type="text" id="representative" name="representative" size="20px" /></td>
							</tr>
							<tr></tr><tr></tr>
							<tr>
								<td id="label" for="business_addr"><label>사업장 소재지 : </label></td>
								<td><input type="text" id="business_addr" name="business_addr" placeholder="주소를입력해주세요(시,구,동)" size="30px" /></td>
								<td><input type="text" id="business_detailed_addr" name="business_detailed_addr" placeholder="상세주소" size="30px" /></td>
							</tr>
							<tr></tr><tr></tr>
							<tr>
								<td id="label" for="headquarter_addr"><label>본점 소재지 : </label></td>
								<td><input type="text" id="headquarter_addr" name="headquarter_addr" placeholder="주소를입력해주세요(시,구,동)" size="30px" /></td>
								<td><input type="text" id="headquarter_detailed_addr" name="headquarter_detailed_addr" placeholder="상세주소" size="30px" /></td>
							</tr>
							<tr></tr><tr></tr>
							<tr>
								<td id="label" valign="top"><label>사업의 종류 : </label></td>
								<td><textarea id="business_category" name="business_category" rows="10" cols="32" placeholder="(업태)" style="resize: none;" ></textarea></td>
								<td><textarea id="business_type" name="business_type" rows="10" cols="32" placeholder="(종류)" style="resize: none;" ></textarea></td>
							</tr>
							<tr>
								<td id="label" for="license_img">사업자등록증 이미지 등록 :</td>
								<td><input type="file" id="license_img" name="license_img" /></td>
							</tr>
						</table>
						
						<br><br>
						<button>등록하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>	

</body>
</html>