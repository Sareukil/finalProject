<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
   
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>건강알리미</title>
		<c:import url="/WEB-INF/views/headerFooter/topLink.jsp" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/jquery-ui.min.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/healthcare/healthcare.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/healthcare/state.css'/>">
		<link rel="stylesheet" type="text/css" href="<c:url value='/css/healthcare/calendar.css'/>">
		<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>
		<script src="<c:url value='/js/jquery-ui.min.js'/>"></script>
		<c:if test="${not empty sessionScope.sid }">
		<script src="<c:url value='/js/healthcare/healthcareInput.js'/>"></script>
		<script src="<c:url value='/js/healthcare/healthcareGraph.js'/>"></script>
		<script src="<c:url value='/js/healthcare/healthcareList.js'/>"></script>
		<script src="<c:url value='/js/healthcare/healthCalendar.js'/>"></script>
		<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
		<script type="text/javascript">

			function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode;
			if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
				return false;
			// Textbox value       
			var _value = event.srcElement.value;       
			// 소수점(.)이 두번 이상 나오지 못하게
			var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
			if (_pattern0.test(_value)) {
				if (charCode == 46) {
					return false;
				}
			}
			// 1000 이하의 숫자만 입력가능
			var _pattern1 = /^\d{3}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
			if (_pattern1.test(_value)) {
				if (charCode != 46) {
					alert("1000 이하의 숫자만 입력가능합니다");
					return false;
				}
			}
			// 소수점 첫째자리까지만 입력가능
			var _pattern2 = /^\d*[.]\d{1}$/; // 현재 value값이 소수점 첫째자리 숫자이면 더이상 입력 불가
			if (_pattern2.test(_value)) {
				alert("소수점 첫째자리까지만 입력가능합니다.");
				return false;
			}     
			return true;
			}
		</script>
		</c:if>
	</head>
	<body>
		<div id="wrap">
			<c:import url="/WEB-INF/views/headerFooter/header.jsp" />
			<div id="healthcareBN">
				<p>
					건강알리미
				</p>
				<p><당신의 건강을 알려주세요.></p>
			</div>
			<c:if test="${empty sessionScope.sid }">
				<div class="emptySid">
					<div>로그인을 해야 사용이 가능합니다.</div>
					<a href="<c:url value='/member/loginForm'/>" class="loginPage"><로그인 창으로 이동></a>
				</div>
			</c:if>

			<!-- 로그인 성공 후 보여줄 메뉴 항목 -->
			<c:if test="${not empty sessionScope.sid }">
				
			<div id="state">
				<div id="stateDiv1">
					<form id="stateFormH">
						
						<div id="heightDiv">
								<p id="heightName">키</p>
								<input class="HInput" type="text" value="${voList[0].hcdValue}cm" onkeypress="return isNumberKey(event)" placeholder="ex)180.0" readonly/>
								<input id="HSubmitBT" class="formHBt" type="submit" value="입력" disabled/>
								<input id="cancelHBt" class="formHBt" type="button" value="취소"/>
						</div>
					</form>
					
					<div id="todayDiv">
						<p id="todayDivName">오늘의 운동</p>
						<ul id="todayList">
						</ul>
					</div>
				</div>
				<div id="stateDiv2">
					<div id="weightDiv" class="stateDiv2Item">
						
						<div class="lineCSS">
							<p class="name2">체중</p>
							
							<button id="wInputDiv" class="IDHiddenBT">입력</button>
						</div>
						
						<p id="weightText" class="value2">${voList[1].hcdValue}kg</p>
						<div class="wInputDiv">
							<hr class="inputHrW"/>
							<form id="stateFormW" class="stateForm">
								<input id="weightInput" class="inputForm" type="text" onkeypress="return isNumberKey(event)" placeholder="숫자입력 예)180.0"/>
								<input id="wSubmitBT" class="formBt" type="submit" value="입력"/>
							</form>
						</div>
						<div id="wStateValue" class="stateValue">체중을 입력하세요.</div>
					</div>
					<div id="BMIDiv" class="stateDiv2Item">
						<div class="lineCSS">
							<p class="name2">BMI</p>
							<button style="visibility: hidden;">입력</button>
						</div>
						
						
						<p id="BMIText" class="value2"></p>
						<div id="BMIStateValue" class="stateValue">키를 먼저 입력하세요.</div>
					</div>
					<div id="BloodSDiv" class="stateDiv2Item">
						<div class="lineCSS">
							<p class="name2">혈당</p>
							
							<button id="BSInputDiv" class="IDHiddenBT">입력</button>
						</div>
						
						<p id="BSText" class="value2">${voList[2].hcdValue}mg/dL</p>
						<p id="BSHelp">8시간 이상 공복 후 측정</p>
						<div class="BSInputDiv">
							<hr class="inputHrBS"/>
							<form id="stateFormBS" class="stateForm">
								<input id="bloodSInput" class="inputForm" type="text" onkeypress="return isNumberKey(event)" placeholder="숫자입력 예)180.0" />
								<input class="formBt" type="submit" value="입력">
							</form>
						</div>
						<div id="BSStateValue" class="stateValue">혈당을 입력하세요.</div>
					</div>
					<div id="BloodPDiv" class="stateDiv2Item">
						<div class="lineCSS">
							<p class="name2">혈압</p>
							
							<button id="BPInputDiv" class="IDHiddenBT">입력</button>
						</div>
						<div class="valueLineCSS">
							<p class="BPvalueName">수축기혈압</p>
							<p class="BPvalueName">-</p>
							<p class="BPvalueName">이완기혈압</p>
						</div>
						<div class="valueLineCSS">
							<p id="BloodPValue1" class="value3">${voList[3].hcdValue}</p>
							<p class="value3">-</p>
							<p id="BloodPValue2" class="value3">${voList[4].hcdValue}</p>
						</div>
						<div class="BPInputDiv">
							<hr class="inputHrBP"/>
							<form id="stateFormBF" class="stateForm2">
								<div class="stateFormDiv">
									<input id="bloodPInput1" class="inputFormBP" type="text" onkeypress="return isNumberKey(event)" placeholder="수축기(예:120)" />
									<p class="BPvalueBar">-</p>
									<input id="bloodPInput2" class="inputFormBP" type="text" onkeypress="return isNumberKey(event)" placeholder="이완기(예:75)" />
								</div>
								<div id="inputBtDiv">
									<input class="formBt" type="submit" value="입력">
								</div>
							</form>
						</div>
						<div id="BPStateValue" class="stateValue">혈압을 입력하세요.</div>
					</div>
				</div>
			</div>
				<div class="divName">
					<hr class="healHr"/>
				</div>
				<article id="graph1" class="graph">
					<div id="graphWeight" class="graphDiv">
						<div id="imgHiddenDiv1" class="imgHiddenDiv">
							<img src="<c:url value='/image/healthcare/weight.png'/>">
							<p>체중</p>
						</div>
						<div id="graphWeightHiddenDiv" class="graphHiddenDiv">
							<img class="graphImg" src="<c:url value='/image/healthcare/weight.png'/>">
							<p id="graphName1" class="graphName">체중</p>
							<hr id="healHr1" class="healHr"/>
							<div id="graphSize1" class="graphSize">
								<canvas id="graphMath1" class="graphMath" ></canvas>
							</div>
						</div>
					</div>

					<div id="graphBMI" class="graphDiv">
						<div id="imgHiddenDiv2" class="imgHiddenDiv">
							<img src="<c:url value='/image/healthcare/bmi.png'/>">
							<p>체질량지수</p>
						</div>
						<div id="graphBMIHiddenDiv" class="graphHiddenDiv">
							<img class="graphImg" src="<c:url value='/image/healthcare/bmi.png'/>">
							<p id="graphName2" class="graphName">체질량지수</p>
							<hr id="healHr2" class="healHr"/>
							<div id="graphSize2" class="graphSize">
								<canvas id="graphMath2" class="graphMath"></canvas>
							</div>
						</div>
					</div>
					<div id="graphBloodPressure" class="graphDiv">
						<div id="imgHiddenDiv3" class="imgHiddenDiv">
							<img src="<c:url value='/image/healthcare/blood.png'/>">
							<p>혈압</p>
						</div>
						<div id="graphBloodPressureHiddenDiv" class="graphHiddenDiv">
							<img class="graphImg" src="<c:url value='/image/healthcare/blood.png'/>">
							<p id="graphName3" class="graphName">혈압</p>
							<hr id="healHr3" class="healHr"/>
							<div id="graphSize3" class="graphSize">
								<canvas id="graphMath3" class="graphMath"></canvas>
							</div>
						</div>
					</div>
					<div id="graphBloodSugar" class="graphDiv">
						<div id="imgHiddenDiv4" class="imgHiddenDiv">
							<img src="<c:url value='/image/healthcare/sugarblood.png'/>">
							<p>혈당</p>
						</div>
						<div id="graphBloodSugarHiddenDiv" class="graphHiddenDiv">
							<img class="graphImg" src="<c:url value='/image/healthcare/sugarblood.png'/>">
							<p id="graphName4" class="graphName">혈당</p>
							<hr id="healHr4" class="healHr"/>
							<div id="graphSize4" class="graphSize">
								<canvas id="graphMath4" class="graphMath"></canvas>
							</div>
						</div>
					</div>
				</article>
				<div class="calendar">
					<div id="calendarDiv">
						<table>
							<thead>
								<tr><th colspan='2'><p id="prevMonth"><</p></th><th id="year-mouth" colspan='3'></th><th  colspan='2'><p id="nextMonth">></p></th></tr>
								<tr>
									<th id="sunday" class="dayWeek">일</th>
									<th class="dayWeek">월</th>
									<th class="dayWeek">화</th>
									<th class="dayWeek">수</th>
									<th class="dayWeek">목</th>
									<th class="dayWeek">금</th>
									<th id="saturday" class="dayWeek">토</th>
								</tr>
							</thead>
							<tbody id="dateBody">

							</tbody>
						</table>
					</div>
					<div id="calendarItemList">
						<div id="calendarListDate">오늘</div>
						<div id="itemListName">
							<div id="topItemBt" class="itemBt"></div>
							<div id="topItemName" class="itemTopName">운동이름</div>
							<div id="topItemTime" class="itemTopTime">운동시간</div>
							<div id="topItemRoutine" class="itemTopRoutine">운동루틴</div>
						</div>
						<div id="listItem">
							<ul class="listItemUl">
							</ul>
						</div>
					</div>
					
				</div>
				<div id="exerciseRecommend">
					<div id="topExerciseMenu">
						<form>
							<input class="radioBt" type="radio" name='choice' value="save" checked/>찜
							<input class="radioBt" type="radio" name='choice' value="recommend"/>추천
						</form>
						<div id="exerciseTag">
						</div>
							
					</div>
					<div id="exerciseList">
						<div id="listBt">
							<div class="trigger triggerUp">
								<img class="slideImg" src="<c:url value='/image/healthcare/up.png'/>">
							</div>
							<div class="trigger triggerDown">
								<img class="slideImg" src="<c:url value='/image/healthcare/down.png'/>">
							</div>
						</div>
						<div class="exerciseListSlide">
							<div class="viewport">
								<ul class="slideList">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
				<br>
			</section>
		</c:if>
			<c:import url="/WEB-INF/views/headerFooter/footer.jsp" />
		</div>
	</body>
</html>

<!--<li class="slide">
	<div class="slideListDivView">
		<div class="listItemName">name</div>
		<div class="listItemType">type</div>
		<div class="listItemBtDiv">
			<button class="listItemInputBt">운동예약</button>
			<button class="listItemRemoveBt">삭제</button>
		</div>
	</div>
	<div class="slideListDivInput">
		<form id="listSubmitForm" class="listSubmitForm">
			<div class="datepicker">
				<input type="text" class="routineDate" name="trip-start">
				<input type="time" class="routineTime" name="routineTime" required>
			</div>
			<input type="text" id="routineInput" name="routineInput" placeholder="운동루틴을 입력하세요.">
			<input type="submit" id="routineInputBt" class="routineInputBt" value="예약">
			<input type="button" id="routineCancelBt" class="routineCancelBt" value="취소">
		</form>
		<div class="exRoutine">
			<div class="exRoutineNameDiv">
				<p class="exRoutineText">운동루틴 ex)</p>
			</div>
			<div class="exRoutineTextDiv">
			</div>
		</div>
	</div>
</li>-->