<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<style>
table a:link {
   color: #666;
   font-weight: bold;
   text-decoration:none;
}
table a:visited {
   color: #999999;
   font-weight:bold;
   text-decoration:none;
}
table a:active,
table a:hover {
   color: #bd5a35;
   text-decoration:underline;
}
table {
   width:600px;
   font-family:Arial, Helvetica, sans-serif;
   color:#666;
   font-size:12px;
   text-shadow: 1px 1px 0px #fff;
   background:#eaebec;
   margin:20px;
   border:#ccc 1px solid;

   -moz-border-radius:3px;
   -webkit-border-radius:3px;
   border-radius:3px;

   -moz-box-shadow: 0 1px 2px #d1d1d1;
   -webkit-box-shadow: 0 1px 2px #d1d1d1;
   box-shadow: 0 1px 2px #d1d1d1;
}
table th {
   padding:21px 25px 22px 25px;
   border-top:1px solid #fafafa;
   border-bottom:1px solid #e0e0e0;

   background: #ededed;
   background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
   background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
}
table th:first-child {
   text-align: left;
   padding-left:20px;
}
table tr:first-child th:first-child {
   -moz-border-radius-topleft:3px;
   -webkit-border-top-left-radius:3px;
   border-top-left-radius:3px;
}
table tr:first-child th:last-child {
   -moz-border-radius-topright:3px;
   -webkit-border-top-right-radius:3px;
   border-top-right-radius:3px;
}
table tr {
   text-align: center;
   padding-left:20px;
}
table td:first-child {
   text-align: left;
   padding-left:20px;
   border-left: 0;
}
table td {
   padding:10px;
   border-top: 1px solid #ffffff;
   border-bottom:1px solid #e0e0e0;
   border-left: 1px solid #e0e0e0;

   background: #fafafa;
   background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
   background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}
table td.second {
  text-align:right;
   padding:18px;
   border-top: 1px solid #ffffff;
   border-bottom:1px solid #e0e0e0;
   border-left: 1px solid #e0e0e0;

   background: #fafafa;
   background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
   background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}
table tr.even td {
   background: #f6f6f6;
   background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
   background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
}
table tr:last-child td {
   border-bottom:0;
}
table tr:last-child td:first-child {
   -moz-border-radius-bottomleft:3px;
   -webkit-border-bottom-left-radius:3px;
   border-bottom-left-radius:3px;
}
table tr:last-child td:last-child {
   -moz-border-radius-bottomright:3px;
   -webkit-border-bottom-right-radius:3px;
   border-bottom-right-radius:3px;
}
table tr:hover td {
   background: #f2f2f2;
   background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
   background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);   
}
</style>


<title>Insert title here</title>
</head>
<body>

<div>
   <table>
      <thead>
         <tr>
            <th>제목</th>
            <c:if test="${messageCate eq 1 }">
               <th>보낸사람</th>
            </c:if>
            <c:if test="${messageCate eq 2 }">
               <th>받은사람</th>
            </c:if>
            <c:if test="${messageCate eq 1 }">
               <th>보낸날짜</th>
            </c:if>
            <c:if test="${messageCate eq 2 }">
               <th>받은날짜</th>
            </c:if>
         </tr>
      </thead>
      <tbody>
         <tr>
            <td>${message.title }</td>
            <c:if test="${messageCate eq 1 }">
               <td>${sender }</td>
            </c:if>
            <c:if test="${messageCate eq 2 }">
               <td>${receiver }</td>
            </c:if>
            <td>${message.written_time }</td>
         </tr>
         <tr>
         	<th colspan="3" style="text-align: center;">내용</th>
         </tr>
         <tr>
         	<td colspan="3" style="text-align: center;">${message.content }</td>
         </tr>
      </tbody>
   </table>
   <a href="/mypage/message.do"><button>목록</button></a>
</div>



</body>
</html>