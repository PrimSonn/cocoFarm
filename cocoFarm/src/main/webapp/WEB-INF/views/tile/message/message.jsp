<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div class="mypage_updateAccount">
				<div class="messageForm">
					<h1>쪽지함</h1>
					<select id="messageCate" name="messageCate">
					   <option value="1" <c:if test="${param.messageCate=='1' }">selected</c:if>>받은쪽지함</option>
					   <option value="2" <c:if test="${param.messageCate=='2' }">selected</c:if>>보낸쪽지함</option>
					</select>
<!-- 					<button id="sendMessageBtn">쪽지 보내기</button> -->
				</div>
			
				<div id="messageBox"></div>
</div>