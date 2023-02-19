<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>영양제</title>
		<c:import url="/WEB-INF/views/headerFooter/topLink.jsp" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/supplements/spmNav.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/supplements/spmback.css'/>">
		<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>
		<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/js/spmDetail.js'/>"></script>
		<script src="<c:url value='/js/supplement.js'/>"></script>
	</head>
	<body>
		
		<!-- header -->
		
		<div class="pageSize">
		<c:import url="/WEB-INF/views/headerFooter/header.jsp" />
		</div>
		<!-- spmMenu -->
		
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
			<div class="spmprd" style="margin-top:20px;">
			
<!-- 				<div class="card-warp"> -->
<%-- 					<img src="<c:url value='/images/${spm.spmImg}'/>" width="300" height="300"> --%>
				
<!-- 				</div> -->
			
			
			
			
			
			
			
			
			
			<table width="1280">
					<tr><td rowspan="5" style=" text-align:center;">
					<img src="<c:url value='/images/${spm.spmImg}'/>" width="300" height="300"></td></tr>
					<tr><td>품명 </td><td style=" text-align:center;"> ${spm.spmName }</td></tr>
					<tr><td>상세설명 </td><td style=" text-align:center;">${spm.spmExplain }</td></tr>
					<tr><td>효과 </td><td style=" text-align:center;">${spm.spmEffect } </td></tr>
					<tr><td colspan="2" style=" text-align:center;">
						<c:if test="${empty sessionScope.sid }">
								<button><a href="<c:url value='/member/loginForm' />">로그인</a></button>	
						</c:if>		
					
								<c:if test="${not empty sessionScope.sid }">
									
									<button id="likeBt"  >
									<svg class="heart-icon icon" viewBox="0 0 512 512">
									<rect width="512" height="512" />
									</svg></button>
									<input type="hidden" id="spmName"  value="${spm.spmName }" >
									
									
								</c:if>
								 </td>
					</tr>
				</table>
				<br><br><br>
				<table width="1280">
					<tr><td>※주의사항 : ${spm.spmNotIngred}</td></tr>
					<tr><td style=" text-align:center;"><img src="<c:url value='/images/${spm.spmIngred}'/>" width="500" ></td></tr>
				</table>
				</div>
			</div>
			</article>
		<!-- footer -->
		<div class="pageSize">
		<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
		</div>
	</body>
	<?xml version="1.0" standalone="no"?>
	 <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
    "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
		<svg version="1.1" xmlns="http://www.w3.org/2000/svg">
			<defs>					    
				 <clipPath id="heart-path">				    
				<path fill-rule="evenodd" clip-rule="evenodd" d="M256,512c0,0-256-144.938-256-311.694C0,29.22,240.62,10.145,256,192 c18.467-181.721,256-162.784,256,8.306C512,367.062,256,512,256,512z"/>
			 	</clipPath>
			</defs>
			</svg>
</html>
