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
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="<c:url value='/js/searchZip.js' />"></script>
<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>

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

			<!-- 나의 개인 정보 -->
			<section class="myPage-main">
				<div class="myPage-main-container">
					<div class="myPage-main-container-header">
						<h3>나의 개인정보</h3>
						<hr>
					</div>
				</div>

				<div class="left_container">
					<div class="container">

						<div class="user_label">회원 이름</div>
						<input type="text" class="user_box" name="memName"
							value="${info.memName }"readonly="readonly">

					</div>


					<div class="container">
						<div class="user_label">회원 아이디</div>
						<input type="text" class="user_box" name="memId"
							value="${info.memId }" readonly="readonly">
					</div>

				

					<div class="container">
						<div class="user_label">회원 닉네임</div>
						<input type="text" class="user_box" name="memNickname"
							value="${info.memNickname }"readonly="readonly">
					</div>

				</div>

				<div class="right_container">

					<div class="container">
						<div class="user_label">회원 전화번호</div>
						<input type="text" class="user_box" name="memHp"
							value="${info.memHp }"readonly="readonly">
					</div>




					<div class="container">
						<div class="user_label">우편번호</div>
						<input type="text" class="user_box" name="memZipcode"
							value="${info.memZipcode }"readonly="readonly">

						<div>
							<input type="button" class="button" id="searchZipBtn"
								name="searchZipBtn" value="우편번호 찾기"readonly="readonly"><br>
						</div>
					</div>
					<div class="container">
						<div class="user_label">주소 입력</div>
						<input type="text" class="user_box" name="memAddress1"
							value="${info.memAddress1 }"readonly="readonly">

					</div>

					<div class="container">
						<div class="user_label">상세주소</div>
						<input type="text" class="user_box" name="memAddress2"
							value="${info.memAddress2 }"readonly="readonly">
					</div>
					
					<a href="<c:url value='/member/memberUpdateForm/'/>" class="button2">회원정보 수정</a><br><br>
					
			
					
				</div>
				




			</section>
		
	


	<!-- footer -->
	

</body>

<footer>
<div class="pageSize">
	<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
	
</div>
</footer>