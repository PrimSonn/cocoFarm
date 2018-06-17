<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css"> 

<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>

<!-- Naver SmartEditor -->
<script type="text/javascript"
 src="/resources/smarteditor/js/service/HuskyEZCreator.js"></script>


<script type="text/javascript">



$(document).ready(function() {
	/*페이지 로드  */
	$(".mypage_navbody").on("click", ".nav-link", function() {
		var page = $(this).children().attr("href");
		console.log(page);
		
		$(".mypage_page01").load(page);
		
		return false;
	});
	
	$(".mail_box").on("click", ".nav-link", function() {
		var page = $(this).attr("href");
		console.log(page);
		
		$(".mypage_page01").load(page);
		
		return false;
	});
	
	

	/* 글자수 제한  */
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



$(document).ready(function() {
	//페이지 첫 진입 시 제목란에 포커스
	$("#title").focus();
	
	$("#btnWrite").click(function() {
		if($('#title').val()==""||$('#content').val()==""||$('#Img_file').val()==""||$('#start_price').val()==""){
			alert("필수 항목을 입력해주세요")
		}else{
		submitContents($(this));
		}
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

//네이버 스마트에디터를 사용하는 방법
 function submitContents(elClickedObj) {
     // 에디터의 내용이 textarea에 적용된다.
     oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

     try {
         elClickedObj.form.submit();
     } catch(e) {}
 }





</script>


</head>
<body>
<div id="mypageheader">
	<!--Mypage부분 header ver3부분  -->
	<jsp:include page="/WEB-INF/views/tile/head/mypagehead.jsp" flush="false"/>
	
	
	<div class="container">
		<!--Mypage부분  검색 로고부분 -->
		<jsp:include page="/WEB-INF/views/tile/head/mypageSearch.jsp" flush="false"/>
	
		<div class="mypage_box">
		
			<!--Mypage부분  판매자 인트로부분 -->
			<jsp:include page="/WEB-INF/views/tile/mypage/sellerIntro.jsp" flush="false"/>
				
			<div class="mypage_page01">
			<div class="mypage_insert">
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
							<td><textarea rows="10" cols="80" id="content02" name="content" ></textarea></td>
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
			        					<option value="4" >테스트용3분</option>
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
						
							<div class="save_group" style="text-align: center;">
								<div class="save_button" style="padding: 3px;"><button id="btnWrite" style="border: hidden;background: transparent;width: 90px;font-weight: bold;font-size: 15px;font-family: 'Jeju Gothic'; cursor: pointer;">상품 등록하기</button></div>
								<div class="re_button" style="padding: 2px;"><a href="/auction/auction_register.do">다시 작성하기</a></div>
							</div>
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