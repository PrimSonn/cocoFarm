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


<div>
	<table  style="table-layout:fixed; word-break:break-all; text-align:center; border-bottom:1px solid #ddd;">
		  <colgroup>
					<col width="80px"><!--이름  -->
					<col width="90px"><!--ID  -->
					<col width="100px"><!--이메일  -->
					<col width="80px"><!--폰번호  -->
					<col width="150px"><!--주소  -->
					<col width="100px"><!--상세주소  -->
					<col width="60px"><!--계정타입 -->
					<col width="130px">	<!--계정등록일 -->
		</colgroup>
      <thead>
	
		<thead>
			<tr>
				<th>이름</th>
				<th>ID</th>
				<th>Email</th>
				<th>Phone</th>
				<!-- <th>우편번호</th> -->
				<th>주소</th>
				<th>상세주소</th>
				<th>계정타입</th>
				<th>계정등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${delWholeAccList }" var="delAccList">
				<tr>
					<td>${delAccList.name }</td>
					<td>${delAccList.id }</td>
					<td>${delAccList.email }</td>
					<td>${delAccList.phone }</td>
					<%-- <td>${delAccList.postnum }</td> --%>
					<td>${delAccList.addr }</td>
					<td>${delAccList.detailed_addr }</td>
					<td>${delAccList.account_type }</td>
					<td><fmt:formatDate value="${delAccList.reg_date }" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>
	<br>
	<jsp:include page="/WEB-INF/views/util/delWholeAcc_paging.jsp" />
</div>


</body>
</html>