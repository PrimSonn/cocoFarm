<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
				<div class="border01">
					<h1>프로필 수정</h1>
					<div class="modify_profile">
						
						<div class="account_update">
							<img class="profile" src="/img/profile/${account.thumb_loc }">
							<form action="/mypage/user/updateProfile.do" method="post" enctype="multipart/form-data">
								<input type="file" id="profile" name="profile" /><br>
								<!-- <button class="img_submit">이미지 적용</button> -->
								<button class="profile_btn">프로필 적용</button>
							</form>
						</div>
					</div>
				
					<div class="modify_account">
						<div class="border_save">
							<form action="/mypage/user/updateAccount.do" method="post">
							<input type="hidden" id="idCheck" name="idCheck" value="N" />
							<input type="hidden" name="account_type" value="3" />
							<div class="input_group">
							<label for="id" class="">아이디 : </label>
							<input type="text" id="id" name="id" value="${account.id }" class="id_hold" readonly="readonly"/><br/>
							</div>
							<div class="input_group">
							<label for="pw" class="">비밀번호 수정 : </label>
							<input type="text" id="pw" name="pw" class=" " placeholder="비밀번호 입력해주세요."/><br/>
							</div>
							
							<div class="input_group">
							<label for="pwCheck" class=" ">비밀번호 수정 확인 : </label>
							<input type="text" id="pwCheck" name="pwCheck" class=""  placeholder="비밀번호 수정 확인"/><br/>
							</div>
							
							<div class="input_group">
							<label for="name" class=" ">이름 : </label>
							<input type="text" id="name" name="name" value="${account.name }" class=""/><br/>
							</div>
							
							<div class="input_group">
							<label for="email" class=" ">이메일 : </label>
							<input type="text" id="email" name="email" value="${account.email }" class=""/><br/>
							</div>
							
							<div class="input_group">
							<label for="phone" class=" ">전화번호 : </label>
							<input type="text" id="phone" name="phone" value="${account.phone}" class=""/><br/>
							</div>
							
							<div class="input_group input_address">
							<label for="postnum" class="postnum">주소 : </label>
							<input type="text" id="postnum" name="postnum" value="${account.postnum }" readonly="readonly" class=" "/>
							<button type="button" onclick="call_postcode();" class="button_postnum">우편번호 찾기</button><br/>
							<input type="text" id="addr" name="addr" value="${account.addr }" readonly="readonly" class=" "/>
							<input type="text" id="detailed_addr" name="detailed_addr" value="${account.detailed_addr}" class=" "/><br/>
							</div>
							<div class="center">
							<input type="submit" id="updateBtn" class="" value="수정 하기" />
							</div>
							</form>
						</div>
					</div>
				</div>
			
	

</body>
</html>