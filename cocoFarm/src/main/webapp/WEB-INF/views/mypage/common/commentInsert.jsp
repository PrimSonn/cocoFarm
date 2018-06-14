<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

</script>
</head>
<body>
<!-- 상품 후기 등록 -->
		<div class="form-inline text-cefnter" id="commentList">
		
			<input type="text" size="7" class="form-control"
				id="commentWriter"
				value="${sessionScope.name }" readonly="readonly"/>
			<textarea rows="3" cols="60"
				class="form-control" id="commentContent"></textarea>
			
			<button class="insertComm_button"
						onclick="insertComment();">상품평 등록</button>
		</div>
		
		<div class="cont_cmt">
			<ul class="list_cmt">
				<li>
					<div class="cmt_cont">
						<span class="wrap_profile">
<!-- 							<img src="계정이미지" width="32" height="32" class="thumb_g" alt=""> -->
							<span class="comm_accName">계정 아이디</span>
						</span>
						<br/><span class="comm_starImg"></span>점
						
						<div class="wrap_cont">
						
<!-- 							<span class="info_score"> -->
<!-- 								<span class="img_kakaofarmer bg_star"> -->
<!-- 									<span class="img_kakaofarmer bar_star" style="width: 100%;">5점</span> -->
<!-- 								</span> -->
<!-- 							</span> -->
							
							<span class="txt_prod">${product.title }</span>
							
							<p class="desc_cmt">
								<span><span class="comm_content"></span></span>
							</p>
						</div>
						
					</div>
				</li>
		
			</ul><a href="/product/93/review" class="btn_all #review_all"><!-- react-text: 59 -->상품평 전체보기<!-- /react-text -->
				<span class="img_kakaofarmer ico_arr"></span></a>
		</div>
</body>
</html>