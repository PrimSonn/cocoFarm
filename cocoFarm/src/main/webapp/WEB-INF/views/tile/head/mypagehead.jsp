<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
$(document).ready(function(){
	<c:if test="${sessionScope.idx ne null }">
	$.ajax({
		type : "POST",
	   url : "/mypage/user/mes_arl.do",
	   dataType : "json",
	   async: false,
		success : function(data) {
			$("#alarm").after("<span>"+data.alarmCnt+"</span>");
		},
	   error : function(e) {

	   }
	});
	</c:if>
});

function submit() {
	<c:if test="${sessionScope.idx eq null}">
	alert("로그인이 필요합니다.");
	</c:if>
	<c:if test="${sessionScope.idx ne null}">
	console.log(333);
	location.href="/mypageIntro.do";
	</c:if>
}


</script>
<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<c:choose>
				<c:when test="${sessionScope.type==3}">
					<li class="choose_color3">고 객</li>
					<li>판매자</li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==2}">
					<li>고 객</li>
					<li class="choose_color2">판매자</li>
					<li>관리자</li>
				</c:when>
				<c:when test="${sessionScope.type==1}">
					<li>고 객</li>
					<li>판매자</li>
					<li class="choose_color3">관리자</li>
				</c:when>
				<c:otherwise>
					<li>고 객</li>
					<li>판매자</li>
					<li>관리자</li>
				</c:otherwise>
			</c:choose>
		</ul>
		
		<ul class="left_list">
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/login/logout.do">로그아웃</a></li>
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a href="/login/login.do">로그인</a></li>
			<li><a href="/login/join.do">회원가입</a></li>
			</c:if>
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/mypageIntro.do" id="alarm">알림</a></li>	
			</c:if>
			<c:if test="${sessionScope.idx ne null }">
			<li><a href="/mypageIntro.do">마이페이지</a></li>	
			</c:if>
			<c:if test="${sessionScope.idx eq null }">
			<li><a style="cursor:pointer" onclick="javascript:alert('로그인이 필요합니다.');return false;"">마이페이지</a></li>	
			</c:if>
		</ul>
	</div>
</div>