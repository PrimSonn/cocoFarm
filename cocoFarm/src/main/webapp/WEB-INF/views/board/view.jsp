<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/farmstory.css">


<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 -->
</head>
<body>
<!--detail부분 header ver2부분  -->
<jsp:include page="/WEB-INF/views/tile/head/detailhead.jsp" flush="false"/>

<div class="container">
	<div class="magin_top_title">
		<ul class="head_title">
			<li class="title"><div class="title_icon"></div>게시글 상세페이지</li>
		</ul>
	
	</div>
	

	<div class="form-group">
		<label for="title">글 번호</label><input type="text" value="${view.acc_idx }" readonly="readonly" />
		<div class="form_folt_left">
		<label for="title">작성일</label> <fmt:formatDate value="${view.written_date }"
	   pattern="yy-MM-dd HH:mm:ss" />
	  	<label for="title">조회수</label><input type="text" value="${view.hit }" readonly="readonly" />
	  	</div>
	</div>
	<div class="form-group">
		<label for="title">제목</label>
		<input type="text" value="${view.title }" readonly="readonly" class="view_text"/>
	</div>
	
	<div class="form-group">
		<div class="form_context"> ${view.content }</div>
	
	</div>



	<div class="form-group">
	<label for="title">첨부파일</label>
		${boardFile.original_filename }
		${boardFile.stored_filename }
		${boardFile.upload_date }
		${boardFile.acc_idx }
	</div>


<img src="/img/todays_farmer_upload/${boardFile.stored_filename }">

<div class="form_btn_center">	
	<a href="/board/list.do"><img src="/img/notice/list.gif" width="82" height="31" alt="목록보기"></a>
	<a href="/board/update.do?acc_idx=${view.acc_idx }"><button class="btn-primary">수정</button></a>
	<a href="/board/delete.do?acc_idx=${view.acc_idx }"><button class="btn-danger">삭제</button></a>
</div>

</div> <!-- container End -->


<!--main부분 foot ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/footer/mainfoot.jsp" flush="false"/>
		



</body>




</html>