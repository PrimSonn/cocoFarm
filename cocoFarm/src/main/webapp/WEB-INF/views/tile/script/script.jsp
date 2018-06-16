<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
/* 글자수 제한  */
$(document).ready(function() {

	//페이지 첫 진입 시 제목란에 포커스
	$("#title").focus();
	
	$("#btnWrite").click(function() {
	submitContents($(this));
	

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
