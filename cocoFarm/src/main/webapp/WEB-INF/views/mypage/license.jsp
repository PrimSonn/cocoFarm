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

$(document).ready(function() {
	
	$(".license_submit_btn").click(function() {
		console.log($("#business_license_code").val());
		
		 if($("#business_license_code").val()=="") {
		  alert("등록번호를 입력해주세요.");
		  return false;
		 }else{
			 alert("통과"); 
		 }
		
		
		
		
		
		/* if($("#business_license_code input[type=text]").val()==0) {
		  alert("카테고리를 선택해주세요.");
		  return false;
		} else if($.trim($("#title").val())=="") {
		  alert("제목을 입력해주세요.");
		  return false;
		} else if($("textarea[name=optionName]").val()==""){
		  alert("옵션을 입력해주세요.");
		  return false;
		} else if($("textarea[name=startAmount]").val()==""){
	    alert("판매수량을 입력해주세요.");
	    return false;
		} else if($("textarea[name=unit]").val()==""){
	  alert("단위를 입력해주세요.");
	  return false;
		} else if($("textarea[name=price]").val()==""){
	  alert("판매가격을 입력해주세요.");
	  return false;
		} */
		
		/* submitContents($(this)); */
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
<div class="license_page">
<h1>사업자 등록</h1>


<form action="/mypage/license.do" method="post" enctype="multipart/form-data">
	<table>
		<tr>
			<td id="label" for="business_license_code"><label>등록번호 : </label></td>
		 	<td><input type="text" id="business_license_code" name="business_license_code" 
		 	placeholder="' - '없이 입력하세요." size="20px" onkeydown="onlyNumber(this)" maxlength="10" /></td> 
		</tr>
		
		<tr>
			<td id="label" for="business_reg_date"><label>개업연월일(등록일자) : </label></td>
		 	<td><input type="text" id="business_reg_date" name="business_reg_date" placeholder="년/월/일" size="20px" /></td> 
		</tr>
		
		<tr>
			<td id="label" for="corporation_name"><label>법인명(단체명) : </label> </td>
			<td><input type="text" id="corporation_name" name="corporation_name" size="20px" /></td>
		</tr>
		
		<tr>
			<td id="label" for="representative"><label>대표자 : </label></td>
			<td><input type="text" id="representative" name="representative" size="20px" /></td>
		</tr>
		
		<tr>
			<td id="label" for="business_addr"><label>사업장 소재지 : </label></td>
			<td><input type="text" id="business_addr" name="business_addr" placeholder="주소를입력해주세요(시,구,동)" size="30px" /></td>
			<td><input type="text" id="business_detailed_addr" name="business_detailed_addr" placeholder="상세주소" size="30px" /></td>
		</tr>
		
		<tr>
			<td id="label" for="headhquarter_addr"><label>본점 소재지 : </label></td>
			<td><input type="text" id="headhquarter_addr" name="headhquarter_addr" placeholder="주소를입력해주세요(시,구,동)" size="30px" /></td>
			<td><input type="text" id="headhquarter_detailed_addr" name="headhquarter_detailed_addr" placeholder="상세주소" size="30px" /></td>
		</tr>
		
		<tr>
			<td id="label" valign="top"><label>사업의 종류 : </label></td>
			<td><textarea id="business_category" name="business_category" rows="10" cols="34" placeholder="(업태)" style="resize: none;" ></textarea></td>
			<td><textarea id="business_type" name="business_type" rows="10" cols="34" placeholder="(종류)" style="resize: none;" ></textarea></td>
		</tr>
		<tr>
			<td id="label" for="license_img">사업자등록증 이미지 등록 :</td>
			<td><input type="file" id="license_img" name="license_img" /></td>
		</tr>
		
	</table>
	
	
	

	
	<a href="javascript:history.back()">돌아가기</a>
	</form>	
<button class="license_submit_btn">등록하기</button>
</div>
</body>
</html>