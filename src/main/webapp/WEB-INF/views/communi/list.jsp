<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="board_wrap">
<div class="board_title">
    <strong>커뮤니티</strong>
    <p>자유게시판입니다.</p>
</div>
<div class="btWrap">
    <a href="/community/insertPage" class="on">등록</a>
</div>
  <div class="head3">
		<select id="selectBox" name="selectBox" onchange="if(this.value) location.href=(this.value);">
	          <option>전체글</option>
	          <option value="recommend" id="recommend">내가쓴글</option>
          </select> 
      </div>
<div class="boardListWrap">
    <div class="boardLists">
        <div class="top">
            <div id="topList" class="num">번호</div>
            <div id="topList" class="title">제목</div>
            <div id="topList"class="writer">글쓴이</div>
            <div id="topList" class="date">작성일</div>
            <div id="topList" class="count">조회</div>
        </div>
        <c:forEach var='comList' items="${comList}">
            <div class="boardList">
                <div id="listItem" class="num">${comList.num}</div>
                <div id="listItem" class="title"><a href="/communi/listdetailView">${comList.agName}</a></div>
                <div id="listItem" class="writer">${comList.memId}</div>
                <div id="listItem" class="date">${comList.agDate}</div>
                <div id="listItem" class="count">${comList.agCount}</div>
            </div>
        </c:forEach>
        <div class="boardPage">
            <c:if test="${listMap.pager.curBlock > 1}">
                <a href="#" onclick="list('1')" class="btFirst"><<</a>
            </c:if>
            <c:if test="${listMap.pager.curBlock > 1}">
                <a href="#" onclick="list('${listMap.pager.prevPage}')" class="btPrev"><</a>
            </c:if>
            

            <c:forEach var ="num" begin="1" end = "${listMap.pager.totPage}">
                <a href="javascript : list ('${num}')">${num}</a>
            </c:forEach>
            <c:if test="${map.pager.curBlock <= map.pager.totBlock}">
                <a href="#" onclick="list('${listMap.pager.nextpage}')" class="btNext">></a>
            </c:if>
            <c:if test="${map.pager.curBlock <= map.pager.totBlock}">
                <a href="#" onclick="list('${listMap.pager.totPage}')" class="btLast">>></a>
            </c:if>
            
        </div>
    </div>
    
    
</div>
</div>