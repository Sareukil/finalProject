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

	<div id="wrap-routine">
			<div id="wrap-container">
					<div class="routine-image">
							<a id="kaka" href="<c:url value='/exercise/detailRoutineInfo/${vo.routineNo}'/>">
							<img src="<c:url value='/image/${vo.routineNo}.jpg'/>"></a>
					</div>
					<div class="routine-info">
							<h2>${vo.routineName}</h2>
							<p> 운동정보 : ${vo.routineInfo }</p>
							<p> 주의사항 : ${vo.routineWarn }</p>
							<p> 추천 영양제 : ${vo.recSupplements }</p>
							<p> 기구사용법 : ${vo.useMachine }</p>
							<p> 기간별 루틴 : ${vo.routineDate }</p>
							<p> 같이하면 좋은 운동 : ${vo.recExercise }</p>
							
					</div>
			
			</div>
	
	</div>


	<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
</body>
</html>