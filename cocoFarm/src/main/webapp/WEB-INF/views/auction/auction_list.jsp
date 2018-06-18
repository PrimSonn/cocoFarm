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
<!--main부분 header 부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mainhead.jsp" flush="false"/>



	<div class="container">
	<div id="view_auction">
	<c:forEach items="${list }" var="i" varStatus="status">
	<div class="aution_group">
	<div class="aution01_img">
		
		<a href="/auction/auction_view.do?idx=${i.idx }">
		<img alt="" src="/auction_img/${i.item_img}" style="width:280px;">
		</a>
		<div class="num">경매상품</div>
<%-- 		<div class="num_01">${i.idx}</div> --%>
		<div class="semo"></div>
	</div>
	
	<div class="aution01_listinfo">
	<ul class="aution01_red">
	<li style="font-weight: bold;">경매 종료까지</li>
			<li><p class="timer_test_${status.count }"></p></li>
			<li></li>
	</ul>
	
	<p class="title_aution01"><span>${i.title}</span></p>
	<div class="auction_body">
	<p><span>[경매 등록자]${i.name}</span></p>
	<p><font color="red" style="font-weight: bold;"><span>현재 입찰가 </span>${i.highest_bid }원</font></p>
	<p><span>경매 시작가 </span>${i.start_price }원</p>
	<p class=""><span><fmt:formatDate value="${i.time_window }" pattern="yyyy년 MM월 dd일 " /><fmt:formatDate value="${i.time_window }" pattern="aa HH:mm 종료" /></span></p>
	</div>
	</div>
	
	
	<a href="/auction/auction_view.do?idx=${i.idx }"><div class="btn_auctionbuy">입찰 참여</div></a>
	</div>
	<script type="text/javascript">timediff('${i.time_window}','${i.systime}','${status.count}');</script>
	</c:forEach>
	</div>
	
	
<%-- 	<c:set var="path" value="<%= request.getSession().getServletContext().getRealPath("upload") %>"></c:set> --%>
	
	
	<table style="margin: 0 auto; position: relative;">
	<tbody>
	
	
	
	<%-- 
	
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
			<li>오라클 현재시간 : ${i.systime }</li>
			<li>경매종료일자 : ${i.time_window }</li>
			<li>${i.time_window }-${i.systime }</li>
			
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
	</c:forEach> --%>
	</tbody>
	</table>
	
	<div class="pageing_num">
		<jsp:include page="/WEB-INF/views/auction/paging.jsp" />
		<%-- <jsp:include page="../util/paging.jsp" /> --%>
	</div>
	
	</div>
	

<!--main부분 foot ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/footer/mainfoot.jsp" flush="false"/>
		




</body>
</html>