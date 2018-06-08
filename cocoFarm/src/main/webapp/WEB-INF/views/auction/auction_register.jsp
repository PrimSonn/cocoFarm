<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>

<!-- Naver SmartEditor -->
<script type="text/javascript"
 src="/resources/smarteditor/js/service/HuskyEZCreator.js"></script>


<script type="text/javascript">


/* 글자수 제한  */
$(document).ready(function() {
	var textCountLimit = 15;
	var textCountLimit2=40;
    $('textarea[name=editor]').keyup(function() {
        // 텍스트영역의 길이를 체크
        var textLength = $(this).val().length;
 
        // 입력된 텍스트 길이를 #textCount 에 업데이트 해줌
        $('#textCount').text(textLength);
         
        // 제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼만 자르고 텍스트영역에 넣음
        if (textLength > textCountLimit) {
            $(this).val($(this).val().substr(0, textCountLimit));
        }
    });
});


function submitContents(elClickedObj) {
    // 에디터의 내용이 textarea에 적용된다.
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

    try {
        elClickedObj.form.submit();
    } catch(e) {}
}

$(document).ready(function() {
	//페이지 첫 진입 시 제목란에 포커스
	$("#title").focus();
	
	$("#btnWrite").click(function() {
		submitContents($(this));
	});
});



/*숫자 입력 금액 한글로 변환 스크립트*/
 function fn_change_hangul_money(txt_id)
      {
			//숫자 외 입력 제어
	 		val=txt_id.value;
	   		re=/[^0-9]/gi;
	   		txt_id.value=val.replace(re,"");
	   		
	   		//1 ~ 9 한글 표시
			var arrNumberWord = new Array("","일","이","삼","사","오","육","칠","팔","구");
			// 10, 100, 100 자리수 한글 표시
			var arrDigitWord = new  Array("","십","백","천");
			// 만단위 한글 표시
			var arrManWord = new  Array("","만","억", "조");
			
			//입력받은 수의 값과 길이 변수 저장
            var num_value = txt_id.value;
            var num_length = num_value.length;

			//입력받은 값이 숫자인지 판별
            if(isNaN(num_value) == true)
                  return;

 

            var han_value = "";
            var man_count = 0;      // 만단위 0이 아닌 금액 카운트.

 

            for(i=0; i < num_value.length; i++)
            {
                  // 1단위의 문자로 표시.. (0은 제외)
                  var strTextWord = arrNumberWord[num_value.charAt(i)];

                  // 0이 아닌경우만, 십/백/천 표시
                  if(strTextWord != "")
                  {
                        man_count++;
                        strTextWord += arrDigitWord[(num_length - (i+1)) % 4];
                  }

                  // 만단위마다 표시 (0인경우에도 만단위는 표시한다)
                  if(man_count != 0 && (num_length - (i+1)) % 4 == 0)
                  {
                        man_count = 0;
                        strTextWord = strTextWord + arrManWord[(num_length - (i+1)) / 4];
                  }

                  han_value += strTextWord;
            }

            if(num_value != 0)
                  han_value = han_value + " 원";
 
// 			console.log(han_value);
            document.getElementById('start_price_han').innerText ="("+han_value+")";
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
			<li><a href="#">로그인</a></li>
			<li><a href="#">회원가입</a></li>
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
					<div class="mypagetitle"><h2>판매자 회원</h2> <h1>마이페이지</h1></div>
					<div class="mypageimg"><img src="/img/mypage/1344.png" ></div>
					<div class="mypagewho"><span><strong>김환민</strong>님&nbsp</span>hwanmin0121</div>
					<div class="mail_box"><a href="#"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
		
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li><a href="#">개인정보 수정</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="#">장바구니 조회</a></li>
						<li><a href="#">회원 탈퇴</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					
					<ul>
						<li><a href="#">판매등록하기</a></li>
						<li><a href="#">판매상품 조회/수정</a></li>
						<li><a href="#">판매 결제 내역 조회 </a></li>
						<li><a href="#">판매 결제 배송 승인</a></li>
					</ul>
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
			
			<div class="mypage_page01">
				<div class="border">
					<h1>농산물 경매 상품 등록 </h1>
					<div class="border_save">
					<form action="/auction/auction_register.do" method="POST" enctype="multipart/form-data">
						<table>
						<tr>
							<th class="td_back2">상품 제목</th>
							<td><textarea style="resize:none;" placeholder="ex)&nbsp곡성 무농약 아로니아 1kg (냉동과)" name="title" cols="50" rows="1"></textarea></td>
						</tr>
						<tr>
							<th class="td_back4">상품 부가 설명</th>
							<td><textarea rows="10" cols="80" id="content" name="content" ></textarea></td>
							<!-- <td><textarea style="resize:none;" placeholder="ex)제철과입니다." name="title" cols="50" rows="5"></textarea></td> -->
						</tr>
						<tr>
							<th class="td_back2">대표이미지 등록하기</th>
							<td><input type="file" id="Img_file" name="Img_file"></td>
						</tr>
						
						<tr>
							<th class="td_back2">경매 시작가</th>
							<td>
							<input type="text" id="start_price" name="start_price"  onkeyup="fn_change_hangul_money(this);"/>
							<span id="start_price_han"></span>
							</td>
						</tr>
						<tr>
							<th class="td_back2">경매 기간 선택</th>
							<td>
							<div class="option_cnt">
								<ul>
									<li>총 경매 일 수(등록날짜 기준) : &nbsp</li>
									<li>
										<select id="time_window_code" name="time_window_code">   
			       						<option value="1" SELECTED>3일</option>
			        					<option value="2" >7일</option>
			        					<option value="3" >28일</option>
			    						</select>
		    						</li>
								</ul>
							</div>
							</td>
						</tr>
						
						
						
						</table>
						
						<script type="text/javascript">
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "content",
							    sSkinURI: "/resources/smarteditor/SmartEditor2Skin.html",
							    fCreator: "createSEditor2",
							    htParams : {
							    	bUseToolbar: false, // 툴바 사용여부
							    	bUseVerticalResizer: false, //입력창 크기 조절바
							    	bUseModeChanger: false, //모드 탭
							    	
							    }
							});
						</script>
						
							<div class="save_group">
								<div class="save_button"><button id="btnWrite" style="border: hidden; background: transparent;">상품 등록하기</button></div>
								<div class="re_button"><a href="#">다시 작성하기</a></div>
							</div>
							</form>
						
						</div>
			
			
				</div>
			
			
			
			
			
			</div>
			
			
			
			
		</div>
	
	</div>
	
	
</div>	


</body>
</html>