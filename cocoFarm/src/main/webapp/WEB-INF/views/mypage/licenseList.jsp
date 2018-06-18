<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

function licenseView(idx) {
	
	var page = "/mypage/licenseView.do?idx="+idx;
	   $(".mypage_page01").load(page);
// 	var $form = $("<form>").attr({
// 		method:"post"
// 		, action:"/mypage/licenseView.do"
// 	});
// 	var $input = $("<input>").attr({
// 		type:"hidden"
// 		, name:"idx"
// 		, value:idx
// 	});
// 	$form.append( $input ).appendTo( $(document.body) );
	
// 	$form.submit();
	
}

</script>


<title>Insert title here</title>
</head>
<body>

<div>
	<table style="table-layout:fixed; word-break:break-all; text-align:center; border-bottom:1px solid #ddd;">
		<colgroup>
					<col width="120px">
					<col width="200px">
					<col width="200px">
					<col width="130px">
					<col width="130px">
	
		</colgroup>
		
	
		<thead>
			<tr>
				<th>이름</th>
				<th>법인명</th>
				<th>등록번호</th>
				<th>대표자</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${licenseList }" var="licenseList">
				<tr>
					<td>${licenseList.name }</td>
					<td>${licenseList.corporation_name }</td>
					<td><a href="#" onclick="licenseView(${licenseList.idx });">${licenseList.business_license_code }</a></td>
					<td>${licenseList.representative }</td>
					<td><fmt:formatDate value="${licenseList.info_reg_date }" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	
	</table>

</div>

</body>
</html>