<%@page import="cocoFarm.dto.Account"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>cocoFarmMain</title>
<script>
function deleteId(idx){
	
	var form = document.createElement('form').attr({action:"deleteAccount", method:"post"});
	var idxInput = document.createElement('input').attr({type:"hidden" , name: "idx" , value: idx});
	
	form.appendChild(idxInput);
	document.body.appendChild(form);
	
	form.submit();
}
</script>
</head>
<body>
<div>
<h5>your Account.Idx: <%=request.getSession().getAttribute("idx")%></h5>
<hr>
<%
List<Account> accList = (List)request.getAttribute("accountList");
if(accList!=null&&accList.size()>0){
		%>
		<table border='1'>
			<thead>
				<tr>
					<th>IDX</th>
					<th>ID</th>
					<th>PW</th>
					<th>regDate</th>
				</tr>
			</thead>
			<tbody>
		<%
	for(Account acc: accList){
				%><tr>
						<th><%=acc.getIdx()%></th>
						<th><%=acc.getId()%></th>
						<th><%=acc.getPw()%></th>
						<th><%=acc.getRegDate()%></th>
						<td>
							<button data-idx="${data.idx}">edit</button>
							<button onclick="deleteId(<%=acc.getIdx()%>);">delete</button>
						</td>
				</tr><%
	}
		%>
			</tbody>
		</table>
		<%
}else{//if no accList
	%><h4>NoListFound</h4><%
}%>
<br>
<a href="/cocoFarm/Sign/Out">signOut</a>
</div>
</body>
</html>