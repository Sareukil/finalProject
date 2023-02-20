<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index 페이지</title>
<c:import url="/WEB-INF/views/headerFooter/topLink.jsp" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/exercise/detailRoutineInfo.css'/>">
<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>
<script src="<c:url value='/js/exercise/detailRoutineInfo.js'/>"></script>
</head>
<body>
	<div class="pageSize">
		<!--header.jsp 에서 html가지고 오는 코드 자세한 내용은 headerFooter 파일에서-->
		<c:import url="/WEB-INF/views/headerFooter/header.jsp" />
		<!--footer.jsp 에서 html가지고 오는 코드 자세한 내용은 headerFooter 파일에서-->

	</div>
<section class="bgTop bgSub5 pc">
	<div class="slogan">
		<p class="a">운동정보</p>
		<p class="b">부위별 추천 운동과 루틴을 통한 건강 관리!</p>
	</div>
</section>
	<div id="wrap-routine">
		<div id="wrap-container">
			
			<div class="routine-info">
				<div class="box-image">
						<img src="<c:url value='/image/${routine.routineNo}.png'/>">
				</div>
				<div class="detail-routine">
					<h2>#${routine.routineName}&nbsp&nbsp<button id="likeBt" class="like">찜하기</button></h2> 
					<input id="routineNo" type="hidden" value="${routine.routineNo}">
					<p>운동정보 : ${routine.routineInfo }</p>
					<p>카테고리 : ${routine.routineCategory }</p>
					<p>주의사항 : ${routine.routineWarn }</p>
					<p>추천 영양제 : ${routine.recSupplements }</p>
				</div>
				<div class="Like">
				<!-- 작은 메뉴상자 -->
					<!-- 회원 이름 -->
					<!-- 마이페이지 버튼 -->
					<!-- 찜한 운동 -->
				</div>
			</div>
			


					<div class="tab">
						<div class="flex1">
							<a href="#" class="panel1 active">운동방법</a> 
							<a href="#" class="panel1">기간별 루틴</a> 
							<a href="#" class="panel1">다른 운동</a>
						</div>
					</div>
					<article>

						<div id="contents1_1" class="content1 on">
							<h3>운동방법 : </h3>
							${routine.useMachine}
							<div class="useVideo">
							<iframe width="560" height="380" src="${routine.useVideo}" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
							</div>
						</div>
						<div id="contents1_2" class="content1">
							<h3>기간별 추천루틴</h3>
							<p>${routine.routineDate }</p>
							<p>이후는 본인이 가능한 만큼만 횟수를 천천히 늘려가며 진행해주세요</p>
						</div>
						<div id="contents1_3" class="content1">
							<h3>다른 추천 운동</h3>
							<form>
								<input type="submit" id="recExercise1" class="routineBtn"
									value="#${routine.recExercise1}"
									formaction="/exercise/detailViewRoutineInfo/${rootList[0].routineNo}/>">
								<input type="submit" id="recExercise1-1" class="routineBtn"
									value="#${routine.recExercise2}"
									formaction="/exercise/detailViewRoutineInfo/${rootList[1].routineNo}">
									<input type="submit" id="recExercise1-2" class="routineBtn"
									value="#${routine.recExercise3}"
									formaction="/exercise/detailViewRoutineInfo/${rootList[2].routineNo}">

							</form>
						</div>
					</article>
				</div>
					
				</div>

	<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
</body>
</html>