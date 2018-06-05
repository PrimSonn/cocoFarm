<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board Edit</title>

<!-- Jquery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

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

</head><body>

<div class="container">
<h1>수정 페이지</h1>

<form action="/board/update.do" method="post">
	<input type="hidden" name="acc_idx" value="${view.acc_idx }" />
	
	<div class="form-group">
		<label for="writer">작성자</label>
	</div>
	
	<div class="form-group">
		<label for="title" >제목</label>
		<input type="text" id="title" name="title" class="form-control" value="${view.title }" />
	</div>
	
	<div class="form-group">
		<label for="content">본문</label>
		<textarea rows="10" style="width:100%" id="content" name="content">${view.content }</textarea>
	</div>	

	<div class="text-center">
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