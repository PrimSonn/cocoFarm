<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/sellerstyle.css">

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	$(".save_button").click(function() {
		submitContents($(this));
	});
});	
</script>
</head>
<body>
<!--main부분 header 부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mainhead.jsp" flush="false"/>

<!--body부분 시작  -->
<div id="view_seller">
	<div class="container">
		<div class="seller_part">
		<c:forEach items="${seller}" var="data" varStatus="status">
			<c:choose>
				<c:when test="${status.count%5==0}">
					<div class="prodisplay_last">
						
						<a href="/sellerDetail.do?idx=${data.idx}"><img class="img_click" height="210px" alt="${data.title}사진" src="/proimg/${data.faceImg}" style="overflow: hidden;"></a>
						<div class="pro_info">
						<span class="pro_title">${data.title}</span>
						<span class="pro_price"><fmt:formatNumber value="${data.min_price}" pattern="#,###"/>원</span> 
						<span class="pro_origin">${data.origin}</span>
						
						</div>
					</div>
				</c:when> 
				<c:otherwise>
					<div class="prodisplay">
						<a href="/sellerDetail.do?idx=${data.idx}"><img class="img_click" height="210px" alt="${data.title}사진" src="/proimg/${data.faceImg}"></a>
						<div class="pro_info">
						<span class="pro_title">${data.title}</span>
						<span class="pro_price"><fmt:formatNumber value="${data.min_price}" pattern="#,###"/>원</span> 
						<span class="pro_origin">${data.origin}</span>
				
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
	</div>
</div>

<!--main부분 foot ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/footer/mainfoot.jsp" flush="false"/>
		


</body>
</html>