<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
Enumeration attrs =  request.getAttributeNames();
while(attrs.hasMoreElements()){
	Object key = attrs.nextElement();
	%>key: <%=key.toString()%><br><%
	%><%=request.getAttribute(key.toString()).toString()%><%
	%><hr><%
}
%>

</body>
</html>