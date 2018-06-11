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
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!-- 주소 API -->
<script type="text/javascript">
function call_postcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postnum').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('addr').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('detailed_addr').focus();
        }
    }).open();
}
</script>

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
			<li><a href="#">마이페이지</a></li>	
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
						<li><a href="#">관리자에게 문의하기</a></li>
					</ul>
				</div>
			</div>
			
			<div class="mypage_updateAccount">
				<div class="border">
					<div class="modify_profile">
						<h1>프로필 수정</h1>
						<div>
							<img class="profile" src="/img/profile/${account.thumb_loc }">
<!-- 							<img class="profile" src="/imgs/profile/지도.jpg_a5d9d675"> -->
							<form action="/mypage/user/updateProfile.do" method="post" enctype="multipart/form-data">
								<input type="file" id="profile" name="profile" /><br>
								<button>프로필 적용</button>
							</form>
						</div>
					</div>
				
					<div class="modify_account">
						<h1>회원정보 수정</h1>
						<div class="border_save">
							<form action="/mypage/user/updateAccount.do" method="post">
							<input type="hidden" id="idCheck" name="idCheck" value="N" />
							<input type="hidden" name="account_type" value="3" />
						
							<label for="id" class="">아이디 : </label>
							<input type="text" id="id" name="id" value="${account.id }" class="" readonly="readonly"/><br/>
							
							<label for="pw" class=" ">비밀번호 수정 : </label>
							<input type="text" id="pw" name="pw" class=" "/><br/>
							<label for="pwCheck" class=" ">비밀번호 수정 확인 : </label>
							<input type="text" id="pwCheck" name="pwCheck" class=" "/><br/>
							
							<label for="name" class=" ">이름 : </label>
							<input type="text" id="name" name="name" value="${account.name }" class=" "/><br/>
							
							<label for="email" class=" ">이메일 : </label>
							<input type="text" id="email" name="email" value="${account.email }" class=" "/><br/>
							
							<label for="phone" class=" ">전화번호 : </label>
							<input type="text" id="phone" name="phone" value="${account.phone }" class=" "/><br/>
							
							<label for="postnum" class=" ">주소 : </label>
							<input type="text" id="postnum" name="postnum" value="${account.postnum }" readonly="readonly" class=" "/>
							<button type="button" onclick="call_postcode();" class="">우편번호 찾기</button><br/>
							
							<input type="text" id="addr" name="addr" value="${account.addr }" readonly="readonly" class=" "/>
							<input type="text" id="detailed_addr" name="detailed_addr" value="${account.detailed_addr }" class=" "/><br/>
							<input type="submit" id="updateBtn" class="" value="수정 하기" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	

</body>
</html>