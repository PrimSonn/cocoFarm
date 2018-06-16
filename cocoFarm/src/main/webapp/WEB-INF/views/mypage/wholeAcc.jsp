<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


<!-- 전체회원정보조회 -->
<!-- 탈퇴회원조회 -->
<!-- 판매자 등록 신청 조회 및 승인 -->
<!-- 공지사항 글 등록 -->
<!-- 오늘의 농부 글 등록 -->
<div>
	<table style="table-layout:fixed; word-break:break-all; text-align:center; border-bottom:1px solid #ddd; font-size:12px;">
		<colgroup>
					<col width="70px"><!--이름  -->
					<col width="70px"><!--ID  -->
					<col width="80px"><!--이메일  -->
					<col width="80px"><!--폰번호  -->
					<col width="140px"><!--주소  -->
					<col width="90px"><!--상세주소  -->
					<col width="50px"><!--계정타입 -->
					<col width="110px">	<!--계정등록일 -->
		</colgroup>
		
		
		
		
		
		
		
		<thead>
			<tr>
				<th>이름</th>
				<th>ID</th>
				<th>Email</th>
				<th>Phone</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>상세주소</th>
				<th>계정타입</th>
				<th>계정등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${wholeAccList }" var="accList">
				<tr>
					<td>${accList.name }</td>
					<td>${accList.id }</td>
					<td>${accList.email }</td>
					<td>${accList.phone }</td>
					<td>${accList.postnum }</td>
					<td>${accList.addr }</td>
					<td>${accList.detailed_addr }</td>
					<td>${accList.account_type }</td>
					<td><fmt:formatDate value="${accList.reg_date }" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>
	<br>
	<jsp:include page="/WEB-INF/views/util/wholeAcc_paging.jsp" />
</div>


</body>
</html>