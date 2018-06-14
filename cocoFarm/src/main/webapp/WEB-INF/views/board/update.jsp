<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코코팜 농부게시판 수정페이지 입니다.</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/farmstory.css">

<!-- Jquery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>


<!-- Naver SmartEditor -->
<script type="text/javascript"
 src="/resources/smarteditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.
function submitContents(elClickedObj) {
    // 에디터의 내용이 textarea에 적용된다.
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

    try {
        elClickedObj.form.submit();
    } catch(e) {}
}


$(document).ready(function() {
	$("#btnUpdate").click(function() {
		submitContents($(this));
		
		alert("공지사항 수정 완료");
	
	});		
	
	$("#title").focus();

	$("#cancel").click(function() {
		history.back(-1);
	});

	
});

</script>

</head>
<body>
<!--detail부분 header ver2부분  -->
<jsp:include page="/WEB-INF/views/tile/head/detailhead.jsp" flush="false"/>

<div class="container">
<div class="magin_top_title">
	<ul class="head_title">
		<li class="title"><div class="title_icon"></div>농부 스토리 수정 게시판</li>
	</ul>

</div>
<form action="/board/update.do" method="post">
	<input type="hidden" name="acc_idx" value="${view.acc_idx }" />
	
	<div class="form-group form_title_text">
		<label for="title">제 목</label>
		<input type="text" id="title" name="title" class="form-control" value="${view.title }"/>
	</div>
	
	<div class="form-group">
		<label for="content">내 용</label>
		<div class="text_magin_auto">
		<textarea class="form_write_textarea"rows="10" id="content" name="content">${view.content }</textarea>
		</div>
	</div>
	

	<div class="form_btn_center">
		<button class="btn btn-primary" id="btnUpdate">수정</button>
		<input class="btn btn-danger" type="reset" id="cancel" value="취소" />
	</div>
	
</form>

</div>

<!-- <textarea> 태그 아래쪽에 스마트에디터 초기화코드 삽입 -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "content",
    sSkinURI: "/resources/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    htParams : {
    	bUseToolbar: true, // 툴바 사용여부
    	bUseVerticalResizer: false, //입력창 크기 조절바
    	bUseModeChanger: true //모드 탭
    }
});
</script>

</body></html>