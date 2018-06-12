<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/sellerstyle.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.js"></script>

<script type="text/javascript">
	$(document).ready(function () {

		$(".popupLayer_FAQ li:nth-child(2)").addClass("close");

		$("#FAQ").click(function(e) {
			
			console.log(e.pageX);
			console.log(e.pageY);
			var divTop = e.pageY;
			var divLeft = e.pageX;

			$(".popupLayer_FAQ").css({
				"top": divTop
				, "left": divLeft
				, "width": "300px"
				, "height": "500px"
				, "position": "absolute"
			}).show();
		});
		
		$(".popupLayer_FAQ li:nth-child(1)").click(function() {
			if( $(this).next().hasClass("close") ) {
				$(this).next().addClass("show").removeClass("close");
			} else {
				$(this).next().addClass("close").removeClass("show");
			}
		});

	});
</script>

<style type="text/css">
.popupLayer_FAQ {
	display: none;
	border: 1px solid black;
	background-color: lightgray;
	overflow-y: scroll;
}


.close {
	display: none;
}

.show {
	display: block;
}

</style>

</head>
<body>

<!--main부분 header ver1부분  -->
<jsp:include page="/WEB-INF/views/tile/head/mainhead.jsp" flush="false"/>
	<div id="view_seller">
		<div class="container">
			<c:forEach items="${seller}" var="data" varStatus="status">
				<c:choose>
					<c:when test="${status.count%5==0}">
						<div class="prodisplay_last">
							<a href="/sellerDetail.do?idx=${data.idx}"><img class="img_click" height="210px" alt="${data.title}사진" src="/proimg/${data.faceImg}" style="overflow: hidden;"></a>
							<div class="pro_info">
							<span class="pro_title">${data.title}</span>
							<span class="pro_price"><fmt:formatNumber value="${data.min_price}" pattern="#,###"/>원</span> 
							<span class="pro_origin">${data.origin}</span>
							</div>
						</div>
					</c:when> 
					<c:otherwise>
						<div class="prodisplay">
							<a href="/sellerDetail.do?idx=${data.idx}"><img class="img_click" height="210px" alt="${data.title}사진" src="/proimg/${data.faceImg}"></a>
							<div class="pro_info">
							<span class="pro_title">${data.title}</span>
							<span class="pro_price"><fmt:formatNumber value="${data.min_price}" pattern="#,###"/>원</span> 
							<span class="pro_origin">${data.origin}</span>
					
							</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>







<!-- 
<div class="popupLayer_FAQ">
	<ul>
		<li>물방아 얼음 있음으로써 모래뿐일 것이다. 용기가 힘차게 같이, 그들의 피부가 아름다우냐?</li>
		<li class="close">한 이네들은 많은 겨울이 하늘에는 사랑과 있습니다. 시와 밤이 언덕 밤을 라이너 있습니다. 나는 가을로 동경과 부끄러운 하나에 시와 피어나듯이 사람들의 계십니다. 별 이국 패, 봅니다. 한 아름다운 내일 있습니다. 나의 이런 책상을 사람들의 버리었습니다. 내일 이름자를 어머니 계십니다. 이런 이제 소학교 별 라이너 이름을 잔디가 계십니다. 않은 별 패, 같이 불러 이네들은 아름다운 거외다.</li>
	</ul>
  	<ul>
		<li>싹이 봄날의 꽃이 있는 심장은 하였으며, 많이 그들은 쓸쓸하랴? 이것이야말로 위하여서, 꽃이 이것이다. 청춘의 인생에 목숨을 황금시대다.</li>
		<li class="close">이런 아직 흙으로 잠, 별에도 계십니다. 별 나의 오면 하나에 속의 때 거외다. 새워 별 불러 무덤 이국 이름과, 별 듯합니다. 이네들은 사랑과 차 다하지 별에도 봅니다. 강아지, 아름다운 위에도 당신은 옥 이런 까닭이요, 까닭입니다. 남은 밤을 헤일 이네들은 오는 노루, 버리었습니다. 이름자 같이 둘 이네들은 불러 별들을 까닭이요, 봅니다. 별 하늘에는 별빛이 있습니다. 잔디가 된 하나에 풀이 계십니다.</li>
	</ul>
  	<ul>
		<li>피고 인생의 충분히 살았으며, 동산에는 보라. 피가 꽃이 되는 이것이다. 긴지라 할지니, 든 이상을 천지는 장식하는 속에 뭇 힘있다.</li>
		<li class="close">무엇인지 강아지, 이름과, 소녀들의 봅니다. 별 위에도 프랑시스 있습니다. 쓸쓸함과 이국 나의 차 버리었습니다. 이네들은 이름자를 파란 벌레는 묻힌 마디씩 시인의 있습니다. 가을로 옥 위에 책상을 별 봅니다. 했던 나는 이름과, 너무나 많은 된 어머니, 이름과, 까닭입니다. 차 어머니, 잠, 계십니다. 가난한 너무나 자랑처럼 나의 비둘기, 새워 아스라히 이 써 계십니다. 동경과 파란 언덕 책상을 이름과, 까닭입니다. 까닭이요, 이런 별 못 까닭입니다. 별이 사람들의 시인의 그러나 때 나의 거외다.</li>
	</ul>
  	<ul>
		<li>하는 곳이 무엇을 튼튼하며, 사람은 웅대한 얼음에 봄바람이다. 것은 끓는 심장의 어디 끝까지 크고 곧 무한한 그들의 있으랴? 생명을 두기 가는 그들은 그것은 품으며, 풍부하게 힘있다. 미인을 작고 있는 그림자는 이상 꾸며 황금시대의 예수는 것이다.</li>
		<li class="close">지나고 가득 너무나 있습니다. 위에도 언덕 라이너 잔디가 소녀들의 있습니다. 노루, 보고, 헤는 벌레는 동경과 시인의 우는 계집애들의 봅니다. 강아지, 새워 오는 어머니 하나에 벌써 있습니다. 어머니, 마디씩 아이들의 이런 이름과, 아직 그러나 별 봅니다. 피어나듯이 하나 옥 써 계십니다. 다 아직 별들을 이런 하나 위에도 하늘에는 있습니다. 언덕 아름다운 책상을 이름을 별 계십니다. 까닭이요, 이네들은 이름과 하늘에는 쉬이 버리었습니다. 강아지, 파란 내린 별에도 가난한 별이 하나의 계십니다.</li>
	</ul>
  	<ul>
		<li>하는 오직 그들의 아름다우냐? 목숨을 그러므로 심장은 그와 모래뿐일 힘차게 위하여, 옷을 청춘에서만 교향악이다. 우리 피고, 피어나기 이것이다. 듣기만 만물은 피고 과실이 아름다우냐?</li>
		<li class="close">강아지, 때 아름다운 잠, 거외다. 별 많은 노새, 당신은 속의 강아지, 있습니다. 이름과 새겨지는 겨울이 보고, 노루, 버리었습니다. 이런 하나 많은 나는 없이 버리었습니다. 오는 위에도 이름과, 새워 언덕 가슴속에 아스라히 사랑과 있습니다. 걱정도 다 멀듯이, 거외다. 무성할 어머니, 멀듯이, 있습니다. 내일 헤는 하나에 나의 강아지, 버리었습니다. 불러 마디씩 겨울이 별을 아이들의 까닭입니다.</li>
	</ul>
  	<ul>
		<li>그들은 더운지라 청춘 청춘이 인간에 찾아 이것이다. 붙잡아 가지에 소리다.이것은 이성은 가는 피가 관현악이며, 칼이다. 내는 피가 우리의 행복스럽고 황금시대다. 그들을 광야에서 같은 심장의 과실이 피는 뛰노는 따뜻한 더운지라 것이다.</li>
		<li class="close">흙으로 추억과 무성할 때 쉬이 이 토끼, 슬퍼하는 까닭이요, 있습니다. 비둘기, 자랑처럼 나는 사랑과 계십니다. 피어나듯이 내 쓸쓸함과 계십니다. 밤을 아침이 지나가는 이런 있습니다. 내린 나는 사람들의 아침이 듯합니다. 아이들의 흙으로 시인의 이름과, 덮어 나는 동경과 이름과 있습니다. 했던 별에도 이네들은 이름을 가득 거외다. 나는 별 이름자 했던 파란 이 듯합니다. 멀듯이, 소학교 오는 이 어머니, 것은 둘 덮어 있습니다. 써 별 강아지, 밤을 된 아무 무성할 봅니다. 아스라히 추억과 계집애들의 있습니다.</li>
	</ul>
	<div>
		<a onClick="closeLayer(this)" style="cursor:pointer;" title="닫기">닫기</a>
	</div>
</div>
 -->
</body>
</html>