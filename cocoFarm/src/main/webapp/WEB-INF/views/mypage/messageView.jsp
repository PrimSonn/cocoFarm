<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="message_center">
	<div class="ajax_message_table">
		<div class="color_menu"></div>
		<h1>${message.title }</h1>
			
		
		
		
		<c:if test="${messageCate eq 1 }">
		
		<div class="table_list">
			<label>보낸사람</label>
			<p>${sender }</p>
		
		</div>
		<div class="table_list">
			<label>보낸날짜</label>
			<p>${message.written_time }</p>
		</div>	
		
		</c:if>
		
		
		<c:if test="${messageCate eq 2 }">
		<div class="table_list">
			<label>받은사람</label>
			<p>${receiver }</p>
		</div>
		<div class="table_list">
			<label>받은날짜</label>
			<p>${message.written_time }</p>
		</div>	
		
		</c:if>
		
		
		
	<div class="table_list">
			<label>내용</label>
			<p class="content_mess">${message.content }</p>
			
	</div>	
		
	</div>
	<div class="close_btn">
		<a onClick="closeLayer(this)" style="cursor:pointer;" title="닫기">x</a>
	</div>
</div>