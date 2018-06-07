<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">
function onlyNumber(obj) {
	$(obj).keyup(function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
}

</script>


<style type="text/css">
#label { 
	text-align: right;
}

</style>



<title>Insert title here</title>
</head>
<body>

<h1>사업자 등록</h1>
<hr>

<form action="/mypage/license.do" method="post" enctype="multipart/form-data">
	<table>
	
		<tr>
			<td id="label" for="business_license_code"><label>등록번호 : </label></td>
		 	<td><input type="text" id="business_license_code" name="business_license_code" 
		 	placeholder="' - '없이 입력하세요." size="20px" onkeydown="onlyNumber(this)" maxlength="10" /></td> 
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label" for="business_reg_date"><label>개업연월일(등록일자) : </label></td>
		 	<td><input type="text" id="business_reg_date" name="business_reg_date" placeholder="년/월/일" size="20px" /></td> 
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label" for="corporation_name"><label>법인명(단체명) : </label> </td>
			<td><input type="text" id="corporation_name" name="corporation_name" size="20px" /></td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label" for="representative"><label>대표자 : </label></td>
			<td><input type="text" id="representative" name="representative" size="20px" /></td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label" for="business_addr"><label>사업장 소재지 : </label></td>
			<td><input type="text" id="business_addr" name="business_addr" placeholder="주소를입력해주세요(시,구,동)" size="30px" /></td>
			<td><input type="text" id="business_detailed_addr" name="business_detailed_addr" placeholder="상세주소" size="30px" /></td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label" for="headquarter_addr"><label>본점 소재지 : </label></td>
			<td><input type="text" id="headquarter_addr" name="headquarter_addr" placeholder="주소를입력해주세요(시,구,동)" size="30px" /></td>
			<td><input type="text" id="headquarter_detailed_addr" name="headquarter_detailed_addr" placeholder="상세주소" size="30px" /></td>
		</tr>
		<tr></tr><tr></tr>
		<tr>
			<td id="label" valign="top"><label>사업의 종류 : </label></td>
			<td><textarea id="business_category" name="business_category" rows="10" cols="32" placeholder="(업태)" style="resize: none;" ></textarea></td>
			<td><textarea id="business_type" name="business_type" rows="10" cols="32" placeholder="(종류)" style="resize: none;" ></textarea></td>
		</tr>
		<tr>
			<td id="label" for="license_img">사업자등록증 이미지 등록 :</td>
			<td><input type="file" id="license_img" name="license_img" /></td>
		</tr>
		
	</table>
	
	<br><br>
	
	<button>등록하기</button>
</form>
	<button><a href="javascript:history.back()">돌아가기</a></button>

</body>
</html>