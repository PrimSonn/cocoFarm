<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>농산물 판매 상품 등록</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	
<!-- Naver SmartEditor -->
<script type="text/javascript"
 src="/resources/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
/* 숫자만 입력 시키게 하는것 */
function onlyNumber(obj){
	val=obj.value;
	re=/[^0-9]/gi;
	obj.value=val.replace(re,"");
}

/* 글자수 제한  */
$(document).ready(function() {
	
	var textCountLimit = 15;
	var textCountLimit2 = 40;
	$('textarea[name=optionName]').keyup(function() {
	     // 텍스트영역의 길이를 체크
	     var textLength = $(this).val().length;
	
	     // 입력된 텍스트 길이를 #textCount 에 업데이트 해줌
	     $('#textCount').text(textLength);
	      
	     // 제한된 길이보다 입력된 길이가 큰 경우 제한 길이만큼만 자르고 텍스트영역에 넣음
	     if (textLength > textCountLimit) {
	         $(this).val($(this).val().substr(0, textCountLimit));
	     }
	});

	$(".save_button").click(function() {
		if($(".category option:selected").val()==0) {
		  alert("카테고리를 선택해주세요.");
		  return false;
		} else if($.trim($("#title").val())=="") {
		  alert("제목을 입력해주세요.");
		  return false;
		} else if($("textarea[name=optionName]").val()==""){
		  alert("옵션을 입력해주세요.");
		  return false;
		} else if($("textarea[name=startAmount]").val()==""){
	    alert("판매수량을 입력해주세요.");
	    return false;
		} else if($("textarea[name=unit]").val()==""){
      alert("단위를 입력해주세요.");
      return false;
		} else if($("textarea[name=price]").val()==""){
      alert("판매가격을 입력해주세요.");
      return false;
		}
		
		// 옵션 여러 개 보내기 기능 구현할 때 json 형식으로 담아봄
// 		var option = {
// 			optionName: $("textarea[name=optionName]").val(),
// 			startAmount: $("textarea[name=startAmount]").val(),
// 			unit: $("textarea[name=unit]").val(),
// 			price: $("textarea[name=price]").val()
// 		};
// 		alert(option.optionName);
		
		submitContents($(this));
	});
	
});

function optionSelect(sVal) {
	var str = ""
	for(var i=0; i<sVal; i++) {
		str += '<ul>'
			+'<li><p>옵션제목 </p><textarea name="saleOptions[' + i + '].optionName" placeholder="15자 이내에 글자" style="resize:none" rows="1" cols="30"></textarea></li>'
			+'<li><p>총판매수량 </p><textarea name="saleOptions[' + i + '].startAmount" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="15"></textarea>개</li>'	
			+'<li><p>단위 </p><textarea name="saleOptions[' + i + '].unit" style="resize:none" placeholder="ex) kg" rows="1" cols="5"></textarea></li>'	
			+'<li><p>단위당가격 </p><textarea name="saleOptions[' + i + '].price" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="14"></textarea>원</li>'
			+'</ul>';
	}
	document.getElementById("option_boby").innerHTML = str;
	
	// 옵션 개수 선택 할 때 다른 방법이 있을까 하다가 생각해본 것. 되진 않음!
// 	$("#option_body1").show();
// 	$("#option_body3").hide();
// 	$("#option_body3").hide();
	
// 	if (sVal == "2") {
// 		$("#option_body2").show();
// 	} else if (sVal == "3") {
// 		$("#option_body3").show();
// 	}
}

// 네이버 스마트에디터를 사용하는 방법
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
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<div class="search"><input type="text" placeholder="농산물 검색하기"><button class="search_icon"></button> </div>
		</div>
		<div class="mypage_box">
			<div class="mypage_nav">
				<div class="mypage_topbusiness">
					<div class="mypagetitle"><h2>판매자 회원</h2> <h1>마이페이지</h1></div>
					<div class="mypageimg"><img src="/img/mypage/1344.png" ></div>
					<div class="mypagewho"><span><strong>${sessionScope.name }</strong>님&nbsp</span></div>
					<div class="mail_box"><a href="#"><img src="/img/mypage/mypageicon/mess.png" alt="쪽지" >쪽지함 확인</a></div>
				</div>
			
				<div class="mypage_navbody">
					
					<p class="navtitle_01"><img alt="" src="/img/mypage/mypageicon/mypage_info.png">개인정보 관리</p>
					
					<ul>
						<li><a href="#">개인정보 수정</a></li>
						<li><a href="#">결제 내역 조회</a></li>
						<li><a href="/product/cart.do">장바구니 조회</a></li>
						<li><a href="#">회원 탈퇴</a></li>
					</ul>
					
					<p class="navtitle_02"><img alt="" src="/img/mypage/mypageicon/mypage_sale.png">판매관리</p>
					
					<ul>
						<li><a href="/product/insert.do">판매등록하기</a></li>
						<li><a href="/product">판매상품 조회/수정</a></li>
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
					<h1>농산물 판매 상품 등록 </h1>
					<div class="border_save">
					
					<form action="/product/insert.do" id="insert" method="post" enctype="multipart/form-data">
						<table>
						<tr>
							<th class="td_back1">상품 카테고리</th>
							<td>
								<SELECT class="category" name="category" SIZE=1>
        					<OPTION VALUE=0 disabled="disabled" SELECTED>농작물 카테고리를 선택해주세요.</OPTION>
       						<OPTION VALUE=1>과일/채소</OPTION>
        					<OPTION VALUE=2>축산/수산</OPTION>
        					<OPTION VALUE=3>가공식품</OPTION>
		    				</SELECT>
	    				</td>
						</tr>
						<tr>
							<th class="td_back1">상품 제목</th>
							<td><textarea id="title" name="title"
									style="resize:none;" cols="50" rows="1"
									placeholder="ex)&nbsp곡성 무농약 아로니아 1kg (냉동과)"></textarea></td>
						</tr>
						<tr>
							<th class="td_back4">상품 부가 설명</th>
							<td><textarea id="content" name="content" rows="10" cols="80" ></textarea></td>
							<!-- <td><textarea style="resize:none;" placeholder="ex)제철과입니다." name="title" cols="50" rows="5"></textarea></td> -->
						</tr>
						<tr>
							<th class="td_back1">대표이미지 등록하기</th>
							<td><input type="file" id="faceImg" name="upload"></td>
						</tr>
						<tr>
							<th class="td_back1">상세 설명 이미지 등록</th>
							<td><input type="file" id="mainImg" name="upload"></td>
						</tr>
						<tr>
							<th class="td_back1">원산지</th>
							<td><textarea id="origin" name="origin" style="resize:none;" placeholder="ex)&nbsp경기도 광명시 광명동" cols="50" rows="1"></textarea></td>
						</tr>
						
						<tr>
							
							<th>제품 선택 옵션</th>
							<td>
							<div class="option_cnt">
								<ul>
									<li>판매 옵션 개수 :</li>
									<li>
										<select name="option" onchange="optionSelect(this.value);">   
		       						<option value="1" SELECTED>1개</option>
		        					<option value="2" >2개</option>
		        					<option value="3" >3개</option>
		    						</select>
	    						</li>
								</ul>
							</div>
							
							<div id="option_boby">
								<ul>
									<li><p>옵션 제목 </p><textarea name="saleOptions[0].optionName" placeholder="15자 이내에 글자"
																	style="resize:none" rows="1" cols="30"></textarea> </li>
									<li><p>총 판매 수량 </p><textarea name="saleOptions[0].startAmount" placeholder="숫자만 입력가능"
																	style="resize:none" onkeyup="onlyNumber(this)" rows="1" cols="15"></textarea>개</li>	
									<li><p>단위 </p><textarea name="saleOptions[0].unit" placeholder="ex) kg"
																	style="resize:none" rows="1" cols="5"></textarea></li>	
									<li><p>단위당 가격 </p><textarea name="saleOptions[0].price" placeholder="숫자만 입력가능"
																	style="resize:none" onkeyup="onlyNumber(this)" rows="1" cols="14"></textarea>원</li>
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
              	<div><button class="save_button">등록하기</button></div>
                <div><button class="re_button">취소하기</button></div>
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