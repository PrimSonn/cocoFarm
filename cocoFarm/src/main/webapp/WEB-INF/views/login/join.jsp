<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">

<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>


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
    
    $(document).ready(function() {
    	$('#phone').keyup(function () { 
    	    this.value = this.value.replace(/[^0-9]/g,'');
    	});
    	
    	
    	$("#idCheckBtn").click(function() {
    		if( !$("#id").val() ) {
    			alert("아이디를 입력해주세요");
    			return false;
    		}
    		
    		$.ajax({
    			type:"post"
    			, url:"/login/idCheck.do"
    			, data:{id: $("#id").val()}
    			, dataType:"json"
    			, success:function(res) {
    				console.log("ajax 성공");
    				
    				if( res.result == false ) {
    					alert("아이디 사용 가능");
    					$("#idCheck").val("Y");
    				} else {
    					alert("아이디 사용 불가");
    					$("#idCheck").val("N");
    					$("#id").val("");
    					$("#id").focus();
    				}
    			}
    			, error:function() {
    				console.log("ajax 실패");
    			}
    		});
    	});
    	
    	
    	$("#joinBtn").click(function() {
	   		// 비밀번호 확인
    		if( !pwCheck() ) {
    			alert("비밀번호가 다릅니다");
    			return false;
    		}
	   		
    		if( !$("#id").val() ) {
    			alert("아이디를 입력해주세요");
    			return false;
    		}

    		if( $("#idCheck").val() == 'N' ) {
    			alert("아이디 중복검사를 해주세요");
    			return false;
    		}

    		if( !$("#pw").val() ) {
    			alert("비밀번호를 입력해주세요");
    			return false;
    		}

    		if( !$("#name").val() ) {
    			alert("이름을 입력해주세요");
    			return false;
    		}

    		if( !$("#email").val() ) {
    			alert("이메일을 입력해주세요");
    			return false;
    		}

    		if( !$("#phone").val() ) {
    			alert("전화번호를 입력해주세요");
    			return false;
    		}

    		if( !$("#postnum").val() ) {
    			alert("우편번호찾기를 먼저해주세요");
    			return false;
    		}

    		if( !$("#detailed_addr").val() ) {
    			alert("상세주소를 입력해주세요");
    			return false;
    		}
    	});
    });
    
	// 비밀번호 확인 검사 함수
	function pwCheck() {
		var pw = $("#pw").val();
		var pwCheck = $("#pwCheck").val();
		
		if( pw == pwCheck )
			return true;
		else
			return false;
	}

</script>

</head>
<body>
<div id="loginheader">

<!--Mypage부분 header ver3부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mypagehead.jsp" flush="false"/>

	<div class="container">
		<!--Mypage부분  검색 로고부분 -->
		<jsp:include page="/WEB-INF/views/tile/head/mypageSearch.jsp" flush="false"/>
		
		<div class="join_box">
			<div class="join_boxtit">
				<h1>코코팜 회원가입에 오신것을 환영합니다.</h1>
				<br>
				<form action="/login/join.do" method="post" class="form-horizontal">
				<input type="hidden" id="idCheck" name="idCheck" value="N" />
			
				<div class="form-group">
					<label for="id" class="control-label col-xs-2">아이디 : </label>
					<div class="col-xs-8"><input type="text" id="id" name="id" placeholder="아이디 입력" class="form-control"/></div>
					<div class="col-xs-2"><button type="button" id="idCheckBtn" class="btn">중복체크</button></div>
				</div>
				<div class="form-group">
					<label for="pw" class="control-label col-xs-2">비밀번호 : </label>
					<div class="col-xs-8"><input type="text" id="pw" name="pw" placeholder="비밀번호 입력" class="form-control"/></div>
				</div>
				<div class="form-group">
					<label for="pwCheck" class="control-label col-xs-2">비밀번호 확인 : </label>
					<div class="col-xs-8"><input type="text" id="pwCheck" name="pwCheck" placeholder="비밀번호 확인" class="form-control"/></div>
				</div>
				<div class="form-group">
					<label for="name" class="control-label col-xs-2">이름 : </label>
					<div class="col-xs-8"><input type="text" id="name" name="name" placeholder="이름 입력" class="form-control"/></div>
				</div>
				<div class="form-group">
					<label for="email" class="control-label col-xs-2">이메일 : </label>
					<div class="col-xs-8"><input type="text" id="email" name="email" placeholder="이메일 입력" class="form-control"/></div>
				</div>
				<div class="form-group">
					<label for="phone" class="control-label col-xs-2">전화번호 : </label>
					<div class="col-xs-8"><input type="text" id="phone" name="phone" placeholder="'-'를 제외한 전화번호 입력" class="form-control"/></div>
				</div>
				<div class="form-group">
					<label for="postnum" class="control-label col-xs-2">주소 : </label>
					<div class="col-xs-8">
						<input type="text" id="postnum" name="postnum" placeholder="우편번호" readonly="readonly" class="form-control"/>
					</div>
					<div class="col-xs-2"><button type="button" onclick="call_postcode();" class="btn">우편번호 찾기</button></div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-2"></label>
					<div class="col-xs-4">
					<input type="text" id="addr" name="addr" placeholder="주소" readonly="readonly" class="form-control"/>
					</div>
					<div class="col-xs-4">
					<input type="text" id="detailed_addr" name="detailed_addr" placeholder="상세주소" class="form-control"/>
					</div>
				</div>
				<input type="submit" id="joinBtn" class="btn btn-primary center-block" onkeypress="if(event.keyCode==13) {$('#joinBtn').click()}" value="회원가입 하기" />
				</form>
			</div>
	
		</div>
	
	</div>	
</div>

</body>
</html>