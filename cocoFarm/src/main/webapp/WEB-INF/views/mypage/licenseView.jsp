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


$(document).ready(function () {
	$("#btnOk").click(function () {
		
		var acc_idx = ${licenseView.acc_idx };
		console.log("idx" + acc_idx);
		
		// 전송 폼
		var $form = $("<form>")
			.attr("action", "/mypage/licenseOk.do")
			.attr("method", "post")
			.append(
				$("<input>")
					.attr("type", "hidden")
					.attr("name", "acc_idx")
					.attr("value", acc_idx)
				
			);
		$(document.body).append($form);
		$form.submit();
		
	});
	
	$("#btnNo").click(function () {
			
			var acc_idx = ${licenseView.acc_idx };
			console.log("idx" + acc_idx);
			
			// 전송 폼
			var $form = $("<form>")
				.attr("action", "/mypage/licenseNo.do")
				.attr("method", "post")
				.append(
					$("<input>")
						.attr("type", "hidden")
						.attr("name", "acc_idx")
						.attr("value", acc_idx)
					
				);
			$(document.body).append($form);
			$form.submit();
			
		});
	
});


</script>


<style type="text/css">
#label { 
	text-align: right;
}

</style>
<title>Insert title here</title>
</head>
<body>

<div>
	<h1>사업자 등록</h1>
<hr>

	<table>
	
		<tr>
			<td id="label"><label>등록일자 : </label></td>
		 	<td><fmt:formatDate value="${licenseView.info_reg_date }" pattern="yyyy-MM-dd"/></td> 
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>등록번호 : </label></td>
		 	<td>${licenseView.business_license_code }</td> 
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>개업연월일(등록일자) : </label></td>
		 	<td>${licenseView.business_reg_date }</td> 
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>법인명(단체명) : </label> </td>
			<td>${licenseView.corporation_name }</td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>대표자 : </label></td>
			<td>${licenseView.representative }</td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>사업장 소재지 : </label></td>
			<td>${licenseView.business_addr }&nbsp;${licenseView.business_detailed_addr }</td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>본점 소재지 : </label></td>
			<td>${licenseView.headhquarter_addr }&nbsp;${licenseView.headhquarter_detailed_addr }</td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label"><label>사업의 종류 : </label></td>
			<td>업태 - ${licenseView.business_category }</td>
			<td>종류 - ${licenseView.business_type }</td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label">사업자등록증 이미지 :</td>
			<td><img src="/img/licenseimg/${licenseView.license_storedName }" style="width: 200px; height: 200px;"></td>
		</tr>
		
	</table>
	
	<br><br>
	<button id="btnOk">승인</button>
	
	<button id="btnNo">거절</button>
	
</div>

</body>
</html>