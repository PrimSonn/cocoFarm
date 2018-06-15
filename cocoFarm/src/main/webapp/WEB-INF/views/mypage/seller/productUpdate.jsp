<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>농산물 판매 상품 수정</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/board.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
	
<!-- Naver SmartEditor -->
<script type="text/javascript"
 src="/resources/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

$(document).ready(function() {
	$("#messageCate").change(function() {

		var messageCate = $(this).val();
		$.ajax({
			type : "POST",
			url : "/mypage/readMessage.do",
			dataType : "html",
			data : {
				messageCate : messageCate
				 , curPage: '${curPage }'
			},
			success : function(res) {
// 				alert("성공");
				$("#messageBox").html(res);
			}
		});
	});

	$("#messageCate").trigger("change");
	
	$("#sendMessageBtn").click(function(e){
		popupOpen();
	});
	function popupOpen(){
		var url= "/mypage/writeMessage.do";    //팝업창 페이지 URL
		var winWidth = 400;
	    var winHeight = 500;
	    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
		window.open(url,"",popupOption);
	}
	
	
	
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
	
	
	
	
	
	
	
	
	
	/* 판매옵션 개수 */
	$("select option[value='${optionView.size() }']").attr("SELECTED", true);
	var optionNum = ${optionView.size() };
	optionSelect(optionNum);
	
	/* 글자수 제한  */
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
		submitContents($(this));
	});
});

/* 숫자만 입력 시키게 하는것 */
function onlyNumber(obj){
	val=obj.value;
	re=/[^0-9]/gi;
	obj.value=val.replace(re,"");
}

function optionSelect(sVal) {
	
	// 이 방식으로 하면 ${optionView[0].optionName } 적용이 안돼! 외않되!
	var str = ""
	for(var i=0; i<sVal; i++) {
		str += '<ul>'
			+'<li><p>옵션제목 </p><textarea name="saleOptions[' + i + '].optionName" style="resize:none" rows="1" cols="30" placeholder="15자 이내에 글자">${optionView[0].optionName }</textarea></li>'
			+'<li><p>총판매수량 </p><textarea name="saleOptions[' + i + '].startAmount" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="15"></textarea>개</li>'	
			+'<li><p>단위 </p><textarea name="saleOptions[' + i + '].unit" style="resize:none" placeholder="ex) kg" rows="1" cols="5"></textarea></li>'	
			+'<li><p>단위당가격 </p><textarea name="saleOptions[' + i + '].price" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="14"></textarea>원</li>'
			+'</ul>';
	}
	
	var str1 = '<ul>'
		+'<li><p>옵션제목 </p><textarea name="saleOptions[' + 0 + '].optionName" style="resize:none" rows="1" cols="30" placeholder="15자 이내에 글자">${optionView[0].optionName }</textarea></li>'
		+'<li><p>총판매수량 </p><textarea name="saleOptions[' + 0 + '].startAmount" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="15">${optionView[0].startAmount }</textarea>개</li>'	
		+'<li><p>단위 </p><textarea name="saleOptions[' + 0 + '].unit" style="resize:none" placeholder="ex) kg" rows="1" cols="5">${optionView[0].unit }</textarea></li>'	
		+'<li><p>단위당가격 </p><textarea name="saleOptions[' + 0 + '].price" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="14">${optionView[0].price }</textarea>원</li>'
		+'</ul>';
	
	var str2 = str1 + '<ul>'
		+'<li><p>옵션제목 </p><textarea name="saleOptions[' + 1 + '].optionName" style="resize:none" rows="1" cols="30" placeholder="15자 이내에 글자">${optionView[1].optionName }</textarea></li>'
		+'<li><p>총판매수량 </p><textarea name="saleOptions[' + 1 + '].startAmount" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="15">${optionView[1].startAmount }</textarea>개</li>'	
		+'<li><p>단위 </p><textarea name="saleOptions[' + 1 + '].unit" style="resize:none" placeholder="ex) kg" rows="1" cols="5">${optionView[1].unit }</textarea></li>'	
		+'<li><p>단위당가격 </p><textarea name="saleOptions[' + 1 + '].price" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="14">${optionView[1].price }</textarea>원</li>'
		+'</ul>';
		
	var str3 = str2 + '<ul>'
		+'<li><p>옵션제목 </p><textarea name="saleOptions[' + 2 + '].optionName" style="resize:none" rows="1" cols="30" placeholder="15자 이내에 글자">${optionView[2].optionName }</textarea></li>'
		+'<li><p>총판매수량 </p><textarea name="saleOptions[' + 2 + '].startAmount" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="15">${optionView[2].startAmount }</textarea>개</li>'	
		+'<li><p>단위 </p><textarea name="saleOptions[' + 2 + '].unit" style="resize:none" placeholder="ex) kg" rows="1" cols="5">${optionView[2].unit }</textarea></li>'	
		+'<li><p>단위당가격 </p><textarea name="saleOptions[' + 2 + '].price" style="resize:none" onkeyup="onlyNumber(this)" placeholder="숫자만 입력가능" rows="1" cols="14">${optionView[2].price }</textarea>원</li>'
		+'</ul>';
		
	if(sVal == 1) str = str1;
	else if(sVal == 2) str = str2;
	else if(sVal == 3) str = str3;
		
	document.getElementById("option_boby").innerHTML = str;
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
		<!--Mypage부분  검색 로고부분 -->
		<jsp:include page="/WEB-INF/views/tile/head/mypageSearch.jsp" flush="false"/>
		
		<div class="mypage_box">
			<!--Mypage부분  판매자 인트로부분 -->
			<jsp:include page="/WEB-INF/views/tile/mypage/sellerIntro.jsp" flush="false"/>
			
			
			<div class="mypage_page01">
				<div class="border">
					<h1>농산물 판매 상품 수정 </h1>
					<div class="border_save">
					
					<form action="/product/update.do?idx=${product.idx }" method="post" enctype="multipart/form-data">
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
									style="resize:none;" cols="50" rows="1">${product.title }</textarea></td>
						</tr>
						<tr>
							<th class="td_back4">상품 부가 설명</th>
							<td><textarea id="content" name="content" rows="10" cols="80" >${product.content }</textarea></td>
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
							<td><textarea id="origin" name="origin"
									style="resize:none;" cols="50" rows="1">${product.origin }</textarea></td>
						</tr>
						
						<tr>
							
							<th>제품 선택 옵션</th>
							<td>
							<div class="option_cnt">
								<ul>
									<li>판매 옵션 개수 :</li>
									<li>
										<select id="optionNum" name="optionNum" onchange="optionSelect(this.value);">   
		       						<option value="1" SELECTED >1개</option>
		        					<option value="2" >2개</option>
		        					<option value="3" >3개</option>
		    						</select>
	    						</li>
								</ul>
							</div>
							
							<div id="option_boby">
								<ul>
									<li><p>옵션 제목 </p><textarea name="saleOptions[0].optionName" placeholder="15자 이내에 글자"
																	style="resize:none" rows="1" cols="30"></textarea></li>
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
              	<div><button class="save_button">수정하기</button></div>
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