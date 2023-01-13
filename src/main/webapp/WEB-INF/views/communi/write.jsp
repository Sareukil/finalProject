<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="<c:url value='/js/communi/write.js' />"></script>


<div class="board_wrap">
    <div class="board_title">
        <strong>커뮤니티</strong>
        <p>자유게시판입니다.</p>
    </div>

   <c:if test="${mode eq 'insertPage'}">
    <form class="formBox">
    <div class="board_write_wrap">
        <div class="board_write">
           <div class="title">
                    <p>제목</p>
                    <input class="agName" type="text" name="agName" placeholder="제목 입력">
                </div>
                <div class="info">
                        <p>글쓴이</p>
                        <p class="agMemId">${memId}</p>
                </div>
                <div class="agTextBox">
                    <textarea class="agText" placeholder="내용 입력"></textarea>
                </div>
                
            </div>
            <div class="agBtInsert">
                <input class="agInsertBt" type="submit" value="저장">
                <a class="agCancel" href="/community/list/${num=1}">취소</a>
            </div>
            </div>
            </form>                
   </c:if>

</div>