<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">
function closeLayer( obj ) {
	$(obj).parent().parent().hide();
}
var idx;
$(function(){
	$('.imgSelect').click(function(e) {
		var divTop = e.pageY - 150;
		var divLeft = e.pageX - 400;
		idx = $(this).data("idx");
		$('.popupLayer').css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute"
		}).show();
	});
});

$("#writeMessageBtn").click(function(e){
	popupOpen();
});
function popupOpen(){
	var url= "/mypage/writeMessage.do?msgTo=" + idx;    //팝업창 페이지 URL
	var winWidth = 400;
    var winHeight = 500;
    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
	window.open(url,"",popupOption);
}

function messageView( idx, messageCate ) {
// 	idx = 메세지 idx 번호임.
	console.log("no = " + idx);
	console.log("o = " + messageCate);
	
	var $form = $("<form>").attr({
		method:"post"
		, action:"/mypage/messageView.do"
	});
	var $input1 = $("<input>").attr({
		type:"hidden"
		, name:"idx"
		, value:idx
	});
	
	var $input2 = $("<input>").attr({
		type:"hidden"
		, name:"messageCate"
		, value:messageCate
	});
	
	$form.append( $input1 ).appendTo( $(document.body) );
	$form.append( $input2 ).appendTo( $(document.body) );
	
	$form.submit();
}

$("#btnDelete").click(function() {
	var messageCate = ${messageCate };
	
	// 선택된 체크박스
	var $checkboxes
	 = $("input:checkbox[name='checkRow']:checked");

	var map = $checkboxes.map(function() {
		return $(this).val();
	});
	var names = map.get().join(",");
	console.log("names : " + names);

	console.log( map );	// 맵
	console.log( map.get() );	// 맵->배열
	console.log( "array tostring : " + map.get().join(",") ); // toString
	
	// 전송 폼
	var $form = $("<form>")
		.attr("action", "/mypage/delMessageList.do")
		.attr("method", "post")
		.append(
			$("<input>")
				.attr("type", "hidden")
				.attr("name", "names")
				.attr("value", names)
			
		)
		.append(
			$("<input>")
				.attr("type", "hidden")
				.attr("name", "messageCate")
				.attr("value", messageCate)	
		);
	$(document.body).append($form);
	$form.submit();

});
</script>
<div>
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="checkAll" /></th>
				<th>제목</th>
				<c:if test="${messageCate eq 1 }">
					<th>보낸사람</th>
				</c:if>
				<c:if test="${messageCate eq 2 }">
					<th>받은사람</th>
				</c:if>
				<c:if test="${messageCate eq 1 }">
					<th>보낸날짜</th>
				</c:if>
				<c:if test="${messageCate eq 2 }">
					<th>받은날짜</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${messageList }" var="message">
			<tr>
				<td><input type="checkbox" id="check${message.idx }"name="checkRow" value="${message.idx }" />${message.idx }</td>
				<td><a href="#" onclick="messageView(${message.idx }, ${messageCate });">${message.title }</a></td>
				<c:if test="${messageCate eq 1 }">
					<td><a class="imgSelect" data-idx="${message.sender_idx }">${message.sender }</a></td>
				</c:if>
				<c:if test="${messageCate eq 2 }">
					<td><a class="imgSelect" data-idx="${message.receiver_idx }">${message.receiver }</a></td>
				</c:if>
				<td><fmt:formatDate value="${message.written_time }" pattern="yyyy-MM-dd"/>​</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<br>
	<button id="btnDelete">삭제</button>
	<br>
	<jsp:include page="/WEB-INF/views/util/messagePaging.jsp" />
	
</div>

<div class="popupLayer">
	<a id="writeMessageBtn">쪽지 보내기</a><br>
	<div>
		<a onClick="closeLayer(this)" style="cursor:pointer;" title="닫기">취소</a>
	</div>
</div>
