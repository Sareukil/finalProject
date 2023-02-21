<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>성분별 카테고리</title>
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
						<h1>성분별</h1>
					</div>
					<br><hr><br>
					
					<div class="health-wrap" style="margin-top:30px;">
					
						<a href="<c:url value='/spm/spmlisti/omega'/>" class="health-one omega"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">오메가-3</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/tvita'/>" class="health-one tvita"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">종합 비타민</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/lutein'/>" class="health-one lutein"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">루테인</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/mth'/>" class="health-one mth"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">밀크씨쓸&실리마린</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/prov'/>" class="health-one prov"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">프로바이오틱</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/lt'/>" class="health-one lt"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">L-테아닌</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/cvita'/>" class="health-one cvita"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">비타민C</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/dvita'/>" class="health-one dvita"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">비타민D</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/coq'/>" class="health-one coq"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">코큐텐</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/chr'/>" class="health-one chr"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">크로뮴 피콜리네이트</span></div></a>
						
						<a href="<c:url value='/spm/spmlisti/msm'/>" class="health-one msm"><div class="itxt">
						<span class="icon"></span>
						<span class="txt">msm</span></div></a>
						
					</div>
				</div>
			
			
			
			</div>
			</article>
		
		
		
		
		
		
		
		
		
		
		
		
		<div class="pageSize" style="margin-top: 0;">
		<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
		</div>
	</body>
</html>
