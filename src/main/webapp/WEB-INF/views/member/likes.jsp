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
							<ul>
								<c:forEach var='exList' items="${exList}">
								<li>
									<div class="exListCreateDate">${exList.routineCreateDate}</div>
									<div class="exListImgName">
										<img src="<c:url value='/image/${exList.routineNo}.png'/>">
										<div class="exListName">${exList.routineName}</div>
									</div>
								</li>
								<li>
									snfjksaf
								</li>
								<li>
									snfjksaf
								</li>
								<li>
									snfjksaf
								</li>
								</c:forEach>
							</ul>

						</div>
						
						<div class="saveSupplementsList"><div class=SE_text>영양제</div>
							<ul>
								<li>
									snfjksaf
								</li>
								<li>
									snfjksaf
								</li>
								<li>
									snfjksaf
								</li>
							
								<c:forEach var='spList' items="${spList}">
								<li>
									
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