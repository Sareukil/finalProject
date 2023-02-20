<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>index 페이지</title>
		<c:import url="/WEB-INF/views/headerFooter/topLink.jsp" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/exercise/exerciseInfo.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/exercise/videoslide.css'/>">
		<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>
		<script src="<c:url value='/js/exercise/exerciseInfo.js'/>"></script>
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
		<div class="wrap">
			<div class="tab">
				<div class="flex">
					<ul class="list">
					<li><a class="panel active">등/가슴</a></li>
					<li><a class="panel">어깨/상체</a></li>
					<li><a class="panel">팔/다리</a></li>
					<li><a class="panel">허리/전신</a></li>
					</ul>
				</div>
			</div>
		<div class="rank_box">
			<div class="rank">
				<p class="weekRank">이번주 등 운동루틴 Top5</p>
				<div class="rank_list">
					<ul>
						
					</ul>
				</div>
			</div>
			<div class="updown"></div>
			<div class="exVideo">
				<p>오늘의 추천 영상</p>
				<div class="exVideo_1">
					<iframe width="760" height="480" src="https://www.youtube.com/embed/I4ovzV-BLDU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
					<p>건강 노인 운동 따라해보기!</p>
				</div>
			</div>
		</div>
		<div class="ListBox">
		<p>운동 루틴 목록</p>
			<div class="itemListBox">
		
				<div class="exItem">
				
				</div>
			</div>
			<div class="itemPageCount">
				
			</div>
		</div>
		<div class="Stretch_common">
		<p>추천 스트레칭 영상(공용)</p>
		</div>
		<article class="exVideoList">
		
						<div class="triggerList trigger-left">
							<img class="slideListImg" src="<c:url value='/image/healthcare/left.png'/>">
						</div>
						
						<div id="listSlider1" class="listSlider">
						
							<div class="viewportList">
							
								<ul class="slidesList-list">
								
								</ul>
							</div>
						</div>
						<div class="triggerList trigger-right">
							<img class="slideListImg" src="<c:url value='/image/healthcare/right.png'/>">
						</div>
					</article>
		
			<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
		</div>
	</body>
</html>