<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Board List</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/farmstory.css">


<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 -->
<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		location.href="/board/write.do"
	});
	
	
	$("#btnMain").click(function() {
		location.href="/main"
	});
	
});
</script>
</head>

<body>
<!--main부분 header ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mainhead.jsp" flush="false"/>

<div class="container">
	<div class="farmstory_head">
		<ul class="head_title">
			<li class="title"><div class="title_icon"></div>오늘의 농부 스토리</li>
			
			
			<c:if test="${sessionScope.type==2}">
			<li class="plus_btn"><button id="btnWrite" class="btn pull-right" style="cursor: pointer;">글쓰기</button></li>		
			</c:if>
			
		</ul>
						
		
		<div class="farm_listpart">
			<c:forEach items="${farm}" var="i" varStatus="status">
				<c:choose>
					<c:when test="${status.count%3==0}">
						<div class="farm_board_board farm_board_last">
							<p class="farm_boardtitle">${i.title}</p>
							<div class="bar"></div>
							<img alt="" src="/img/profile/${i.thumb_loc}" style="width:100px;height:100px;">
							<p class="farm_name">${i.name}</p>
							<p class="quo_img"></p>
							<div class="farm_boardcontent"><a href="/board/view.do?acc_idx=${i.acc_idx }">${i.content}</a></div> 
						</div>
					</c:when> 
					<c:otherwise>
					<div class="farm_board_board">
						<p class="farm_boardtitle">${i.title}</p>
						<div class="bar"></div>
						<img alt="" src="/img/profile/${i.thumb_loc}" style="width:100px;height:100px;">
						<p class="farm_name">${i.name}</p>
						<p class="quo_img"></p>
						<div class="farm_boardcontent"><a href="/board/view.do?acc_idx=${i.acc_idx }">${i.content}</a></div> 
					</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	
	
		<div class="page">
			<jsp:include page="/WEB-INF/views/util/board_paging.jsp" />
		</div>
	</div>
</div>

<!--main부분 foot ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/footer/mainfoot.jsp" flush="false"/>
		
</body>
</html>