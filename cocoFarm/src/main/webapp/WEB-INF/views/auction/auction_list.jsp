<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/auctionstyle.css">
<script type="text/javascript">
function timediff(time_window,systime,status){
	 var T1 = new Date(time_window);
	 var T2 = new Date(systime);
	console.log(T1);
	console.log(T2);
	var T3 = (new Date(T1 - T2))/1000;
	var day = Math.floor(T3/(60*60*24));
	var time = Math.floor((T3%(60*60*24))/(60*60));
	var minute = Math.floor(((T3%(60*60*24))%(60*60))/60);
	var second = Math.floor(((T3%(60*60*24))%(60*60))%60);
	console.log(T3/1000.0);
	console.log(day);
	console.log(time);
	console.log(minute);
	console.log(second);
	console.log("===============");
	var ptag_check = ".timer_test_"+status;
	var data = day+"일"+time+"시간"+minute+"분"+second+"초 남았음";
	
	console.log(ptag_check);
	console.log(data);
	
// 		document.getElementById("ptag_check").val() = data;
// 	document.getElementById("ptag_check").setAttribute("value", data);
// 	$(ptag_check).val(day+"일"+time+"시간"+minute+"분"+second+"초 남았음");
	$(ptag_check).text(day+"일"+time+"시간"+minute+"분"+second+"초 남았음");
// 	$(".timer_test_2").text(day+"일"+time+"시간"+minute+"분"+second+"초 남았음");
		
	
}
</script>
</head>

<body>
<div id="header">

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
		<div id="header_nav">
			<ul class="nav">
				<li><a href="#">농수산물</a></li>
				<li><a href="#">경매</a></li>
				<li><a href="#">농부 스토리</a></li>	
				<li><a href="#">자주 묻는 질문</a></li>	
				<li><a href="#">공지사항</a></li>
				<li><a href="#">회사소개</a></li>
			</ul>
		</div>
		
		<div id="header_footimg">
			<div class="scarecrow"></div>
			<div class="calligraphy"></div>
		</div>
	
	</div>
	<div id="bottom_vimg"></div>
</div>	

<div id="view_auction">
	<div class="container">
	<br>
	
	<table style="margin: 0 auto; position: relative;">
	<tbody>
<%-- 	<c:set var="path" value="<%= request.getSession().getServletContext().getRealPath("upload") %>"></c:set> --%>
	
	<c:forEach items="${list }" var="i" varStatus="status">
	
<!-- 	<tr onclick="document.location.href='링크.htm'"> -->
	<tr style="cursor: pointer;" onclick="location.href='/auction/auction_view.do?idx=${i.idx}'">
		<td style="border:solid 1px; width:150px; height:150px; cursor: "><img alt="상품사진" src="/auction_img/${i.item_img }"  style="max-width: 100%; height: auto;"></td>
		<td style="border:solid 1px; width:400px; height:150px;">
			<ul>
				<li>경매 제목 : ${i.title }</li>
				<li>경매 등록자 : ${i.id }</li>
			</ul>
		</td>
		<td style="border:solid 1px; width:200px; height:150px;">
			<ul>
				<li>최고 입찰가 :${i.highest_bid }</li>
				<li>경매 시작가 :${i.start_price }</li>
				<li>입찰 최소 단위 : </li>
			</ul>
		</td>
		<td style="border:solid 1px; width:200px; height:150px;">
			<ul>
<%-- 			<li>오라클 현재시간 : ${i.systime }</li> --%>
<%-- 			<li>경매종료일자 : ${i.time_window }</li> --%>
<%-- 			<li>${i.time_window }-${i.systime }</li> --%>
			
			<li style="font-weight: bold;">경매 종료일자</li>
			<li><fmt:formatDate value="${i.time_window }" pattern="yyyy년 MM월 dd일 " /></li>
			<li><fmt:formatDate value="${i.time_window }" pattern="aa HH:mm 종료" /></li><br>
			
			<li style="font-weight: bold;">경매 종료까지</li>
			<li><p class="timer_test_${status.count }"></p></li>
			<li></li>
			</ul>
			</td>
	</tr>
	<script type="text/javascript">timediff('${i.time_window}','${i.systime}','${status.count}');</script>
	</c:forEach>
	</tbody>
	</table>
	
	<div class="pageing_num">
		<jsp:include page="/WEB-INF/views/auction/paging.jsp" />
		<%-- <jsp:include page="../util/paging.jsp" /> --%>
	</div>
	
	</div>
	

</div>



</body>
</html>