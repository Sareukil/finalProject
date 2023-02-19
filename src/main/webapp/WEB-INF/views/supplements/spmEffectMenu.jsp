<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>건강고민별 카테고리</title>
		<c:import url="/WEB-INF/views/headerFooter/topLink.jsp" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/supplements/spmNav.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/supplements/spmback.css'/>">
		<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>
		<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/js/supplement.js'/>"></script>
	</head>
	<body>
		<div class="pageSize">
		<c:import url="/WEB-INF/views/headerFooter/header.jsp" />
		</div>
		
		<div class="subtitle">
			<h1>영양 더하기</h1>
			<h2>나에게 필요한 영양을 채워주세요</h2>
		</div>
		
		<article class="spm-Main">
		
		<div class="spmMenu">
		
			<div id="left">
				<ul class="sidebar-menu">
				    <li><span class="nav-section-title"></span></li>
				    <li ><a href="<c:url value='/spm/listSupplement'/>"><span class="fa fa-university"></span>전체 영양제</a></li>
				    <li class="have-children"><a href="#"><span class="fa fa-tags"></span>영양제 카테고리</a>
				      <ul>
				        <li><a  href="<c:url value='/spm/condition'/>" >성분별</a></li>
				        <li><a href="<c:url value='/spm/effect'/>" >건강고민별</a></li>
				      </ul>
				    </li>
				  </ul>
			</div>
			
			<div class="spmprd">
				<div class="totalSpm" style="margin-top:20px; color:black; font-size:25px;">
						<h1>건강고민별</h1>
					</div>
					<br><hr><br>
					
					<div class="health-wrap" style="margin-top:30px;">
					
						<a href="<c:url value='/spm/spmlist/eye'/>" class="health-one eye"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">눈 건강</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/fat'/>" class="health-one fat"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">체지방</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/blood'/>" class="health-one blood"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">혈액 & 혈액순환</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/liver'/>" class="health-one liver"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">간 건강</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/gut'/>" class="health-one gut"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">장 건강</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/stress'/>" class="health-one stress"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">스트레스 & 수면</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/imm'/>" class="health-one imm"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">면역 기능</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/bone'/>" class="health-one bone"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">뼈 건강</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/aging'/>" class="health-one aging"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">노화 & 항산화</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/bp'/>" class="health-one bp"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">혈압</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/bs'/>" class="health-one bs"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">혈당</span></div></a>
						
						<a href="<c:url value='/spm/spmlist/joint'/>" class="health-one joint"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">관절 건강</span></div></a>
						
					</div>
				</div>
			</div>
			</article>
		
		

		
		<div class="pageSize" style="margin-top: 0;">
		<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
		</div>
	</body>
</html>
