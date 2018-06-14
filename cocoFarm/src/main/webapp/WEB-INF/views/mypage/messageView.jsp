<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<table>
		<tr>
			<th>제목</th>
			<td>${message.title }</td>
		</tr>
		
		<c:if test="${messageCate eq 1 }">
		<tr>
			<th>보낸사람</th>
			<td>${sender }</td>
		</tr>
		<tr>
			<th>보낸날짜</th>
			<td>${message.written_time }</td>
		</tr>
		</c:if>
		
		<c:if test="${messageCate eq 2 }">
		<tr>
			<th>받은사람</th>
			<td>${receiver }</td>
		</tr>
		<tr>
			<th>받은날짜</th>
			<td>${message.written_time }</td>
		</tr>
		</c:if>
		
		<tr>
			<th>내용</th>
			<td>${message.content }</td>
		</tr>
	</table>
	<div>
		<a onClick="closeLayer(this)" style="cursor:pointer;" title="닫기">취소</a>
	</div>