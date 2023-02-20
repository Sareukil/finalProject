 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>마이페이지/개인정보변경</title>
<!--   <base href=""> -->
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/member/myPage.css'/>">
<c:import url="/WEB-INF/views/headerFooter/topLink.jsp" />
<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>

<script type="text/javascript">
	const list = document.querySelector('.list');
	const listScrollWidth = list.scrollWidth;
	const listClientWidth = list.clientWidth;
	// 이벤트마다 갱신될 값
	let startY = 0;
	let nowY = 0;
	let endY = 0;
	let listY = 0;


	const getClientY = (e) => {
	const isTouches = e.touches ? true : false;
	return isTouches ? e.touches[0].clientY : e.clientY;
	};

	const getTranslateY = () => {
	return parseInt(getComputedStyle(list).transform.split(/[^\-0-9]+/g)[5]);
	};

	const setTranslateY = (y) => {
	list.style.transform = `translateY(${y}px)`;
	};
	const bindEvents = () => {
	list.addEventListener('mousedown', onScrollStart);
	list.addEventListener('touchstart', onScrollStart);
	list.addEventListener('click', onClick);
	};
	bindEvents();

	const onScrollStart = (e) => {
  	startY = getClientY(e);
	window.addEventListener('mousemove', onScrollMove);
	window.addEventListener('touchmove', onScrollMove);
	window.addEventListener('mouseup', onScrollEnd);
	window.addEventListener('touchend', onScrollEnd);
	};
	const onScrollMove = (e) => {
	nowY = getClientY(e);
	setTranslateY(listY + nowY - startY);
	};

	const onScrollEnd = (e) => {
	endY = getClientY(e);
	listY = getTranslateY();
	if (listY > 0) {
		setTranslateY(0);
		list.style.transition = `all 0.3s ease`;
		listY = 0;
	} else if (listY < listClientWidth - listScrollWidth) {
		setTranslateY(listClientWidth - listScrollWidth);
		list.style.transition = `all 0.3s ease`;
		listY = listClientWidth - listScrollWidth;
	}

	window.removeEventListener('mousedown', onScrollStart);
	window.removeEventListener('touchstart', onScrollStart);
	window.removeEventListener('mousemove', onScrollMove);
	window.removeEventListener('touchmove', onScrollMove);
	window.removeEventListener('mouseup', onScrollEnd);
	window.removeEventListener('touchend', onScrollEnd);
	window.removeEventListener('click', onClick);

	setTimeout(() => {
		bindEvents();
		list.style.transition = '';
	}, 300);
	};
	const onClick = (e) => {
	if (startY - endY !== 0) {
		e.preventDefault();
	}
	};
	window.scrollTo(0, 0);
	 $(document).ready(function(){

		$(".saveExerciseList").click(function() {
  		$("html, body").animate({ scrollTop: 0 }, "slow");
  		return false;
	 })
		
});
</script>
</head>

<body>
	<div class="pageSize">
		<!-- 헤더 -->
		<c:import url="/WEB-INF/views/headerFooter/header.jsp" />




		<!-- 마이페이지 메뉴 -->
			<nav class="myPage-nav">
				<div class="myPage-nav-container">
					<img src="<c:url value='/image/user.png'/>" class="myPage-userImg">
					<div class="myPage-Inf">마이페이지</div>
						
						<div class="button-box">
						<input class="myPage-button" type="button" value="나의 개인정보"onClick="location.href='<c:url value='myPage'/>'">
						<input class="myPage-button" type="button" value="비밀번호 변경"onClick="location.href='<c:url value='memPw'/>'">
						<input class="myPage-button" type="button" value="나의 찜목록" onClick="location.href='<c:url value='likes'/>'">
					</div>
			</div>

		</nav>

		<!-- 나의 찜 목록 -->
		<section class="myPage-main">
			<div class="myPage-main-container">
				<div class="myPage-main-container-header">
					<h3>나의 찜 목록</h3>
					<hr>
					<div class="saveListDiv">
						<div class="saveExerciseList"><div class=SE_text>운동</div>
							<ul class="list">
								<c:forEach var='exList' items="${exList}">
								<li>
									<div class="exListCreateDate">${exList.routineCreateDate}</div>
									<div class="exListImgName">
										<img src="<c:url value='/image/${exList.routineNo}.png'/>">
										<div class="exListName">${exList.routineName}</div>
									</div>
								</li>
								</c:forEach>
							</ul>

						</div>
						
						<div class="saveSupplementsList"><div class=SE_text>영양제</div>
							<ul class="list">
								<c:forEach var='spList' items="${spList}">
								<li >
									
									<div class="spListImgName">
										<div class="supplementsCreateDate">${spList.spmCreateDate}</div>
										 <img src="<c:url value='/image/${spList.spmImg}'/>">
										<div class="supplementsName">${spList.spmName}</div>
										
									</div>
								</li>
								</c:forEach>
								
							</ul>

						</div>
					</div>
					
				</div>
			</div>
	



	</section>
	
	

	</div>









	<!-- footer -->


</body>

<footer>
	<div class="pageSize">
		<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />

	</div>
</footer>