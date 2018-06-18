<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">
$(document).ready(function() {

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
	
	$(".btnCancel").click(function() {
// 		auction idx확인까진 끝
		console.log($(this).parent().find(".auctionidx").val());
		console.log($(this).parent().find(".auctionstate").val());
// 		var checkok = confirm("경매 글을  삭제 하시겠습니까?");
		
		if($(this).parent().find(".auctionstate").val()==1){
			var checkok=confirm("진행중인 경매 글을  삭제 하시겠습니까?");
			if(checkok==true){
			$form = $("<form>").attr({
				action: "/auction/auction_cancel.do",
				method: "POST"
			}).append(
				$("<input>").attr({
					type:"hidden",
					name:"idx",
					value:$(this).parent().find(".auctionidx").val()
				})
			);
			$(document.body).append($form);
			$form.submit();
			alert("경매가 삭제되었습니다.");
			}else if(checkok==false){
				alert("경매 삭제 진행이 중단되었습니다.");
			}
		}else if($(this).parent().find(".auctionstate").val()==6){
			var checkok=confirm("낙찰자가 존재합니다. 글을  삭제 하시겠습니까?");
			if(checkok==true){
			$form = $("<form>").attr({
				action: "/auction/auction_cancel.do",
				method: "POST"
			}).append(
				$("<input>").attr({
					type:"hidden",
					name:"idx",
					value:$(this).parent().find(".auctionidx").val()
				})
			);
			$(document.body).append($form);
			$form.submit();
			alert("경매가 삭제되었습니다.");
			}else if(checkok==false){
				alert("경매 삭제 진행이 중단되었습니다.")
			}
		}
		});
	
});
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
					<h1>경매 등록 상품 조회</h1>
					<div class="border_save">
					
					<table style="border-collapse: collapse; border:2px solid; border-color: #9e9e9e;">
					<thead>
						<tr>
						<th style="width:30px; border:1px solid; border-color: #9e9e9e;">번호</th>
						<th style="width:200px; border:1px solid; border-color: #9e9e9e;">등록 품목</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">경매 시작가</th>
						<th style="width:120px; border:1px solid; border-color: #9e9e9e;">현재 입찰가</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">등록 일자</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">종료 일자</th>
						<th style="width:100px; border:1px solid; border-color: #9e9e9e;">경매 상태</th>
						<th style="width:80px; border:1px solid; border-color: #9e9e9e;">경매 취소</th>
						</tr>
					</thead>
					
					<tbody>
						<c:if test="${empty auctionList}">
								<tr><td colspan="7" style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e; text-align: center;">등록하신 경매상품이 존재하지 않습니다.</td></tr>
						</c:if>
						<c:forEach items="${auctionList}" var="auctionList" varStatus="status">
						<tr>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${status.count}</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">${auctionList.title }</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><fmt:formatNumber type="number" value="${auctionList.start_price }"/> 원</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="red" style="font-weight: bold;"><fmt:formatNumber type="number" value="${auctionList.highest_bid }"/> 원</font><br>(+<fmt:formatNumber type="number" value="${auctionList.highest_bid - auctionList.start_price}"/>원)</td>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><fmt:formatDate value="${auctionList.reg_time }" pattern="yyyy-MM-dd"/><br><fmt:formatDate value="${auctionList.reg_time }" pattern="aa HH:mm"/></td>							
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><fmt:formatDate value="${auctionList.time_window }" pattern="yyyy-MM-dd"/><br><fmt:formatDate value="${auctionList.time_window }" pattern="aa HH:mm"/></td>							
							<c:if test="${auctionList.state_code == 1}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="black" style="font-weight: bold;">진행중</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 2}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="red" style="font-weight: bold;">경매 취소</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 4}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="orange" style="font-weight: bold;">경매 만료(입찰자 없음)</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 5}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="blue" style="font-weight: bold;">낙찰 완료(입금 대기)</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 6}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="green" style="font-weight: bold;">차등 낙찰진행중</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 7}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="red" style="font-weight: bold;">경매 만료(낙찰자 거래 거부)</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 8}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="red" style="font-weight: bold;">경매 취소(경매자 취소)</font></td>
							</c:if>
							<c:if test="${auctionList.state_code == 9}">
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;"><font color="blue" style="font-weight: bold;">낙찰 완료(거래 완료)</font></td>
							</c:if>
							<td style="padding: 1px; border:1px solid; text-align: center; border-color: #9e9e9e;">
							<input class="auctionidx" type="hidden" value="${auctionList.idx }">
							<input class="auctionstate" type="hidden" value="${auctionList.state_code }">
							<c:choose>
							<c:when test="${auctionList.state_code==1 || auctionList.state_code==6}">
							<button class="btnCancel" style="cursor: pointer; margin-top: 1px;" >삭제</button>
							</c:when>
							<c:otherwise>
							-
							</c:otherwise>
							</c:choose>
							</td>
						</tr>
						</c:forEach>
					</tbody>
					
					</table>
					
					</div>
				</div>
				
			</div>
			
		</div>
		
	</div>
	
</div>

</body>
</html>