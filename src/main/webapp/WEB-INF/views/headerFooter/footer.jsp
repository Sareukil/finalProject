<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--footer 코드 입니다.-->
<footer>
	<div id="footerImgBox">
	</div>
	<div id="footerLeftBox">
		<div id="footerABox"><a href="#" id="footerAO">개인정보처리방침</a><hr/><a href="#" id="footerAT">후원 상담</a></div>
		<div class="footerLeftBoxDiv">서울특별시 서초구  전화번호:02-1111-2222  대표자 : 박정훈</div>
		<div class="footerLeftBoxDiv">사업자등록번호 : 000-00-00000</div>
		<div class="footerLeftBoxDiv">COPYRIGHT © 2023 나도 젊어봤다. ALL RIGHTS RESERVED. CREATED BY 이조판서</div>
	</div>
	<hr id="footerHr"/>
	<div id="footerRightBox">
		<div>
			<div id="callNumber">02-1234-5678</div>
			<div id="callDate">후원 문의 평일 09:00 - 18:00</div>
		</div>
		<img src="<c:url value='/image/footer/footercall.png'/>">
	</div>


</footer>