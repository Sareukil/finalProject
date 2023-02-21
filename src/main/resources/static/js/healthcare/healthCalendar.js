$(document).ready(function(){
    
    let date = new Date();
    let year = date.getFullYear();
    let mouth = date.getMonth() + 1;
    let day = date.getDate();
    let mouthStr = "";
    let mouthInt = Number(mouth);
    if(mouthInt < 10){
        mouthStr = "0"+mouth;
    }
    let dateResult = year + '-' + mouthStr +'-' + day;

    topTodayList(dateResult);
    renderCalendar(date);
    dateMyListAjax(date.getFullYear(), date.getMonth()+1, date.getDate());
    $('#prevMonth').on('click',function(){
        date.setDate(1);
        date.setMonth(date.getMonth() - 1);
        renderCalendar(date);
    })

    $('#nextMonth').on('click',function(){
        date.setDate(1);
        date.setMonth(date.getMonth() + 1);
        renderCalendar(date);
    })
/* 정적이여서 안됨
   $('#dateBody tr #dayTD').on('mouseover',function(){
        $(this).css('background-color','#adadad');
        $(this).css('opacity','0.3');
    
   })


   $('#dateBody tr #dayTD').on('mouseout',function(){
        $(this).css('background-color','initial');
        $(this).css('opacity','1');
   })*/
   //동적으로 생성된 요소는 동적이벤트 처리
    $(document).on('mouseover','#dateBody tr #dayTD',function(){
        $(this).css('background-color','#e1d8f9');
        $(this).css('opacity','0.3');
    })

    $(document).on('mouseout','#dateBody tr #dayTD',function(){
        $(this).css('background-color','initial');
        $(this).css('opacity','1');
    })
    $(document).on('click','#dateBody tr td',function(){
        $('#dateBody tr td #dayId').css('background-color','initial');
        $('#dateBody tr td #today').css('background-color','#fdca63c2');
        $(this).children('p').css('background-color','#ffb7b7');
        let strDate = $('#year-mouth').html().split(" ");
        let year = strDate[0].split("년");
        let mouth = strDate[1].split("월");
        let day = $(this).children('p').html();
        
        dateMyListAjax(year[0], mouth[0], day)
    })
    dateListAjax("save");
   $("input[name='choice']").change(function(){	
	    let radioValue = $(this).val();
        if(radioValue === "save"){
            $('#exerciseTag').css('visibility','hidden');
            dateListAjax();
        }
        else{
            $('#exerciseTag').css('visibility','visible');
            tagItem();
            let item = $('.tagItem').get();
            let arrItem = [];
            for(let i=0; i<item.length; i++){
                arrItem[i] = item[i].innerHTML;
            }
            recommendListAjax(arrItem);
        }
        
    });
    $(document).on('click','.listItemInputBt',function(){
        let thisId = $(this).attr('id');
        $('#slideListDiv'+thisId).css('height','200px');
        $('#slideListDiv'+thisId).css('visibility','visible');
        $('#slideListDiv'+thisId).children().children().css('height','40px');
        $('#slideListDiv'+thisId).children().children().css('visibility','visible');
        $('#datepicker'+thisId).children().css('height','40px');
        $('#datepicker'+thisId).children().css('visibility','visible');
        $('#exRoutineText'+thisId).css('visibility','visible');
        $('#slideListDiv'+thisId).css('transition-duration','500ms');
        $('#slideListDiv'+thisId).children().children().css('transition-duration','500ms');
   })
   
   $(document).on('click','.routineCancelBt',function(){
        let thisId = $(this).attr('id');
        $('#slideListDiv'+thisId).css('height','0px');
        $('#slideListDiv'+thisId).children().children().css('height','0px');
        $('#slideListDiv'+thisId).children().children().css('visibility','hidden');
        $('#datepicker'+thisId).children().css('height','0px');
        $('#datepicker'+thisId).children().css('visibility','hidden');
        $('#exRoutineText'+thisId).css('height','0px');
        $('#exRoutineText'+thisId).css('visibility','hidden');
        $('#slideListDiv'+thisId).css('visibility','hidden');
        $('#slideListDiv'+thisId).css('transition-duration','500ms');
        $('#slideListDiv'+thisId).children().children().css('transition-duration','500ms');
    })
    $(document).on('submit','.listSubmitForm',function(){
        event.preventDefault();
        let thisId = $(this).attr('id');
        let dateResult = true;
        let date = $('#date'+thisId).val();
        let time = $('#time'+thisId).val();
        let routineNo = $('#routineNo'+thisId).val();
        let dateTime = date + " " + time +":00";
        let routineStr = $('#routineText'+thisId).val();
	    try {
	    let dateRegex = /([0-2][0-9]{3})-([0-1][0-9])-([0-3][0-9]) ([0-5][0-9]):([0-5][0-9]):([0-5][0-9])(([\-\+]([0-1][0-9])\:00))?/; 
	    dateResult = dateRegex.test(dateTime);
        } catch (err) {
            
        }
        if(dateResult && routineStr !=""){
            dateMyListCreateAjax(dateTime, routineStr,routineNo);
            let thisId = $(this).attr('id');
            $('#slideListDiv'+thisId).css('height','0px');
            $('#slideListDiv'+thisId).children().children().css('height','0px');
            $('#slideListDiv'+thisId).children().children().css('visibility','hidden');
            $('#datepicker'+thisId).children().css('height','0px');
            $('#datepicker'+thisId).children().css('visibility','hidden');
            $('#exRoutineText'+thisId).css('height','0px');
            $('#exRoutineText'+thisId).css('visibility','hidden');
            $('#slideListDiv'+thisId).css('visibility','hidden');
            $('#slideListDiv'+thisId).css('transition-duration','500ms');
            $('#slideListDiv'+thisId).children().children().css('transition-duration','500ms');

            let boolDate = date.split('-');
            let todayBool = new Date();
            let todayBoolYear = todayBool.getFullYear();
            let todayBoolMonth = todayBool.getMonth() + 1;
            let todayBoolDate = todayBool.getDate();
            if(boolDate[0] == Number(todayBoolYear)&& boolDate[1] == Number(todayBoolMonth) && boolDate[2] == Number(todayBoolDate)){
                    
                let html = "";
                html+='<li id="topListNo'+routineNo+'">';
                html+='<div>'+time+'</div>';
                html+='<div>'+routineStr+'</div>';
                html+='<div id="topMyListCk'+routineNo + '" style="color: rgb(100 100 100);">X</div>';
                html+='</li>';
                
                $('#todayList').append(html);
            }
            $('#date'+thisId).val("");
            $('#time'+thisId).val("");
            $('#routineText'+thisId).val("");
        }
        else if(!dateResult){
            alert("날짜를 입력하세요.");
        }
        else if(routineStr ==""){
            alert("루틴을 입력하세요.");
        }
        
    })

    $(document).on('click','.listItemRemoveBt',function(){
        let thisId = $(this).attr('id');
        let elNo = thisId.split('num')[1];
        dateListDeleteAjax(elNo)
        $('li').remove('#li'+thisId);
    })
    $(document).on('click','.routineItemBt',function(){
        let itemNo = $(this).children('#itemNo').attr('value');
        let ckNum = $(this).children('#ckNum').attr('value');
        let changeNum;
        if(ckNum == 0){
            changeNum =1;
        }
        else{
            changeNum =0;
        }
        myListCheck(itemNo, changeNum);
    })

    $(document).on('click','.myListDeleteBt',function(){
        let myListNoStr = $(this).attr('id');
        let myListNo = myListNoStr.split("listItem");
        myListDeleteAjax(myListNo[1]);
    })
    

});

function renderCalendar(date){
    const viewYear = date.getFullYear();
    const viewMonth = date.getMonth();
    $('#year-mouth').html(viewYear+'년 '+(viewMonth + 1)+'월');

    const prevLast = new Date(viewYear, viewMonth, 0);
    const thisLast = new Date(viewYear, viewMonth + 1, 0);
    
    const PLDay = prevLast.getDay();
    const TLDate = thisLast.getDate();
    var html = '';
    let DateCount = 1;
    const today = new Date();
    for(let i =0; i <6; i++){
        html += '<tr>';
        if(i==0){
            let PLDayC = PLDay + 1;
            if(PLDay !== 6){
                for(let k=0; k< PLDayC; k++){
                    html += '<td id="nullTD">'+'&nbsp;'+'</td>';
                }
            }
            for(let k=1; k<= 7 - PLDayC; k++){
                if (viewMonth === today.getMonth() && 
                    viewYear === today.getFullYear() &&
                    DateCount === today.getDate()){
                        html += '<td id="dayTD"><div id="day'+DateCount+'" class="dayCount"></div><p id="today" class="days">'+DateCount+'</p></td>';
                    }
                    
                else{
                    html += '<td id="dayTD"><div id="day'+DateCount+'" class="dayCount"></div><p id="dayId" class="days">'+DateCount+'</p></td>';
                }
                DateCount++;
            }
            
        }
        else{
            
            for(let k=1; k<= 7; k++){
                if(TLDate < DateCount){
                   html += '<td id="nullTD">'+'&nbsp;'+'</td>';
                    DateCount++;
                }
                else{
                    if (viewMonth === today.getMonth() && 
                    viewYear === today.getFullYear() &&
                    DateCount === today.getDate()){
                        html += '<td id="dayTD"><div id="day'+DateCount+'" class="dayCount"></div><p id="today" class="days">'+DateCount+'</p></td>';
                    }
                    
                else{
                    html += '<td id="dayTD"><div id="day'+DateCount+'" class="dayCount"></div><p id="dayId" class="days">'+DateCount+'</p></td>';
                }
                    DateCount++;
                }
                
            }
        }
        html += '<tr/>';
        
    }
    $('#dateBody').empty();
    $('#dateBody').append(html);

    dateCount(viewYear, viewMonth+1);

}

function dateCount(viewYear, viewMonth){
    
    let mouthStr = "" + viewMonth;
    let mouthInt = Number(mouthStr);
    if(mouthInt < 10 && mouthStr != ("0"+mouthStr)){
        mouthStr = "0"+mouthStr;
    }
    let dateTime = viewYear+'-'+mouthStr;
    $.ajax({
        type:"post",
        url:"/healthcare/dateCount",
        data: {"date":dateTime,},
        dataType:'json',
        success:function(result){
            
            $.each(result.dateCountList, function(k,v){
                let dayStr ="";
                let dayInt = Number(v.myDate);
                if(dayInt < 10){
                    dayStr = v.myDate.split("0");
                    $('#day'+dayStr[1]).html(v.count);
                    
                }
                else{
                    $('#day'+v.myDate).html(v.count);
                }
            })

        },
        error:function(){
        }
    }); // ajax 종료 	
    
}

function dateMyListAjax(year, mouth, day){
    let dateStr = new Date();
    if(dateStr.getFullYear() == year && (dateStr.getMonth()+1) == mouth && dateStr.getDate() == day){
        $('#calendarListDate').html("오늘");
    }
    else{
        let clickDate = year+'년 '+mouth +'월 '+ day + '일';
        $('#calendarListDate').html(clickDate);
    }
    let mouthInt = Number(mouth);
    if(mouthInt < 10 && mouth != ("0"+mouth)){
        mouth = "0"+mouth;
    }

    let dayInt = Number(day);
    if(dayInt < 10 && day != ("0"+day)){
        day = "0"+day;
        
    }
    let dateTime = year+'-'+mouth +'-'+ day;
    $.ajax({
        type:"post",
        url:"/healthcare/calendarMyList",
        data: {"date":dateTime,},
        dataType:'json',
        success:function(result){
            $('.listItemUl').empty();
            let html = "";
            $.each(result.myList, function(k,v){
                html+='<li id="listItemLi'+v.elMyNo+'" class="listItemLi">';
                html+='  <div id="myListCk' +v.elMyNo+ '" class="routineItemBt">';
                if(v.routineCK === 0){
                    html+='    <input id="itemNo" type="hidden" value="'+v.elMyNo+'"><input id="ckNum" type="hidden" value="'+v.routineCK+'"><img src="/image/healthcare/checkX.png">';
                }
                else{
                    html+='    <input id="itemNo" type="hidden" value="'+v.elMyNo+'"><input id="ckNum" type="hidden" value="'+v.routineCK+'"><img src="/image/healthcare/checkO.png">';
                }
                
                html+='  </div>';
                html+='  <div id="routineItemName" class="itemName"><a href="/exercise/detailViewRoutineInfo/'+v.routineNo+'">'+v.routineName+'</a></div>';
                html+='  <div id="routineItemTime" class="itemTime">'+timeMyListText(v.myRoutineDate)+'</div>';
                html+='  <div id="routineItemRoutine" class="itemRoutine">'+v.myRoutine+'<button id="listItem'+v.elMyNo+'" class="myListDeleteBt">삭제</button></div>';
                html+='</li>';
            })
            $('.listItemUl').append(html);
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function timeMyListText(dateStr){
    let routineDate = new Date(dateStr);
    let theH = routineDate.getHours();
    let theM = routineDate.getMinutes();
    let result = '';

    if(theH > 11){
        theH -=12;
        result +='오후 ' + theH + '시 ' + theM +'분';
    }
    else{
        result +='오전 ' + theH + '시 ' + theM +'분';
    }
    return result;
}
function recommendListAjax(arr){
    $.ajax({
        type:"post",
        url:"/healthcare/exerciseRecommendList",
        data: {"arrItem":arr},
        dataType:'json',
        traditional:true,
        success:function(result){
            $('.slideList').empty();
            let html = "";
            $.each(result.aList, function(k,v){
                html+='<li class="slide">';
                html+='<input id="routineNo'+v.routineNo+'" type="hidden" value="'+v.routineNo+'">';
                html+='  <div class="slideListDivView">';
                html+='    <div class="listItemName"><a href="/exercise/detailViewRoutineInfo/'+v.routineNo+'">'+v.routineName+ '</a></div>';
                html+='    <div class="listItemType">'+ v.routineCategory+ '</div>';
                html+='    <div class="listItemBtDiv">';
                html+='      <button id="'+v.routineNo+'" class="listItemInputBt">운동예약</button>';
                html+='      </div></div>';
                html+='  <div id="slideListDiv'+v.routineNo+'" class="slideListDivInput">';
                html+='    <form id="'+v.routineNo+'" class="listSubmitForm">';
                html+='      <div id="datepicker'+v.routineNo+'" class="datepicker">';
                html+='        <input type="text" id="date'+v.routineNo+'" class="routineDate" name="trip-start">';
                html+='        <input type="time" id="time'+v.routineNo+'" class="routineTime" name="routineTime" required>';
                html+='      </div><input type="text" id="routineText'+v.routineNo+'" class="routineInput" name="routineInput" placeholder="운동루틴을 입력하세요.">';
                html+='        <input type="submit" id="'+v.routineNo+'"  class="routineInputBt" value="예약">';
                html+='        <input type="button" id="'+v.routineNo+'"  class="routineCancelBt" value="취소">';
                html+='    </form><div class="exRoutine">';
                html+='         <div class="exRoutineNameDiv">';
                html+='           <p id="exRoutineText'+v.routineNo+'" class="exRoutineText">운동루틴 ex)</p></div>';
                html+='         <div class="exRoutineTextDiv">';
                html+='           <p id="exRoutineText'+v.routineNo+'" class="exRoutineText">'+v.recExercise1+'</p>';
                html+='           <p id="exRoutineText'+v.routineNo+'" class="exRoutineText">'+v.recExercise2+'</p>';
                html+='           <p id="exRoutineText'+v.routineNo+'" class="exRoutineText">'+v.recExercise3+'</p>';
                html+='    </div></div></div></li>';
            });
            $('.slideList').append(html);
            $(".ui-datepicker-trigger").remove();
            $(".routineDate").removeClass('hasDatepicker').datepicker({
                dateFormat: 'yy-mm-dd', //달력 날짜 형태
                inline: true,
                showOtherMonths: true,
                showOn:"button",
                buttonImage:"../../image/healthcare/calendarIcon.png",
                buttonImageOnly:true,
                showMonthAfterYear: true,
                monthNames: [ '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12' ],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                showButtonPanel: true
            });
            //초기값을 오늘 날짜로 설정해줘야 합니다.
       $('.datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        
        },
        error:function(){
        }
    }); // ajax 종료 	
}
function dateListAjax(){

    $.ajax({
        type:"post",
        url:"/healthcare/exerciseMyList",
        dataType:'json',
        success:function(result){
            $('.slideList').empty();
            let html = "";
            $.each(result.aList, function(k,v){
                html+='<li id="linum' +v.elNo+ '" class="slide">';
                html+='<input id="routineNonum'+v.elNo+'" type="hidden" value="'+v.routineNo+'">';
                html+='  <div class="slideListDivView">';
                html+='    <div class="listItemName"><a href="/exercise/detailViewRoutineInfo/'+v.routineNo+'">'+v.routineName+ '</a></div>';
                html+='    <div class="listItemType">'+ v.routineCategory+ '</div>';
                html+='    <div class="listItemBtDiv">';
                html+='      <button id="num'+v.elNo+'" class="listItemInputBt">운동예약</button>';
                html+='      <button id="num'+v.elNo+'" class="listItemRemoveBt">삭제</button></div></div>';
                html+='  <div id="slideListDivnum'+v.elNo+'" class="slideListDivInput">';
                html+='    <form id="num'+v.elNo+'" class="listSubmitForm">';
                html+='      <div id="datepickernum'+v.elNo+'" class="datepicker">';
                html+='        <input type="text" id="datenum'+v.elNo+'" class="routineDate" name="trip-start">';
                html+='        <input type="time" id="timenum'+v.elNo+'" class="routineTime" name="routineTime" required>';
                html+='      </div><input type="text" id="routineTextnum'+v.elNo+'" class="routineInput" name="routineInput" placeholder="운동루틴을 입력하세요.">';
                html+='        <input type="submit" id="num'+v.elNo+'"  class="routineInputBt" value="예약">';
                html+='        <input type="button" id="num'+v.elNo+'"  class="routineCancelBt" value="취소">';
                html+='    </form><div class="exRoutine">';
                html+='         <div class="exRoutineNameDiv">';
                html+='           <p id="exRoutineTextnum'+v.elNo+'" class="exRoutineText">운동루틴 ex)</p></div>';
                html+='         <div class="exRoutineTextDiv">';
                html+='           <p id="exRoutineTextnum'+v.elNo+'" class="exRoutineText">'+v.recExercise1+'</p>';
                html+='           <p id="exRoutineTextnum'+v.elNo+'" class="exRoutineText">'+v.recExercise2+'</p>';
                html+='           <p id="exRoutineTextnum'+v.elNo+'" class="exRoutineText">'+v.recExercise3+'</p>';
                html+='    </div></div></div></li>';
            });
            $('.slideList').append(html);
            $(".ui-datepicker-trigger").remove();
            $(".routineDate").removeClass('hasDatepicker').datepicker({
                dateFormat: 'yy-mm-dd', //달력 날짜 형태
                inline: true,
                showOtherMonths: true,
                showOn:"button",
                buttonImage:"../../image/healthcare/calendarIcon.png",
                buttonImageOnly:true,
                showMonthAfterYear: true,
                monthNames: [ '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12' ],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                showButtonPanel: true
            });
            //초기값을 오늘 날짜로 설정해줘야 합니다.
       $('.datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
        },
        error:function(){
        }
        
    }); // ajax 종료 	
}

function dateMyListCreateAjax(date, routine, routineNo){
    let thisDate = date.split(' ')[0];
    let thisDateArr = thisDate.split('-');
    let thisYear = thisDateArr[0];
    let thisMonth = thisDateArr[1];
    let thisDay = thisDateArr[2];
    let myListDate;
    let myListYear;
    let myListMonth;
    let myListDay;

    let CountDay = Number(thisDay);;
    let Count = Number($('#day'+CountDay).html())

    let calendarStr = $('#year-mouth').html();
    let calendarDate = calendarStr.split(" ");
    let calendarYear = calendarDate[0].split("년")[0];
    let calendarMonth = calendarDate[1].split("월")[0];
    let cMouthInt = Number(calendarMonth);
        if(cMouthInt < 10){
            calendarMonth = "0"+calendarMonth;
        }
    if($('#calendarListDate').html() == "오늘"){
        myListDate = new Date();
        myListYear = myListDate.getFullYear();
        myListMonth = myListDate.getMonth() +1;
        myListDay = myListDate.getDate();
    }
    else{
        let dateStr = $('#calendarListDate').html();
        myListDate = dateStr.split(" ");
        myListYear = myListDate[0].split("년")[0];
        myListMonth = myListDate[1].split("월")[0];
        myListDay = myListDate[2].split("일")[0];
        let mouthInt = Number(myListMonth);
        if(mouthInt < 10){
            myListMonth = "0"+myListMonth;
        }

        let dayInt = Number(myListDay);
        if(dayInt < 10){
            myListDay = "0"+myListDay;
            
        }
    }
    
    $.ajax({
        type:"post",
        url:"/healthcare/createMyList",
        data: {"date":date,
                "routine":routine,
                "routineNo":routineNo},
        dataType:'text',
        success:function(result){
            if(thisYear == myListYear && thisMonth == myListMonth && thisDay == myListDay){
                dateMyListAjax(thisYear, thisMonth, thisDay);
                
            }
            if(thisYear == calendarYear && thisMonth == calendarMonth){
                if(Count == ""){
                    $('#day'+CountDay).html(1);
                }
                else{
                    $('#day'+CountDay).html(Count + 1);
                }
                
            }
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function dateListDeleteAjax(elNo){
    
    $.ajax({
        type:"post",
        url:"/healthcare/deleteList",
        data: {"elNo":elNo},
        dataType:'text',
        success:function(result){
            
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function tagItem(){
    $('#exerciseTag').empty();
    let html ='';
    let bmiValue = $('#BMIStateValue').html();
    if(bmiValue === "저체중"){
        html += '<p class="tagItem">저체중</p>'
    }
    else if(bmiValue === "과체중"){
        html += '<p class="tagItem">과체중</p>'
    }
    else if(bmiValue === "비만"){
        html += '<p class="tagItem">비만</p>'
    }
    else{
        html += '<p class="tagItem">체중 정상</p>'
    }

    let bsValue = $('#BSStateValue').html();
    if(bsValue === "공복혈당장애"){
        html += '<p class="tagItem">공복혈당장애</p>'
    }
    else if(bsValue === "당뇨병"){
        html += '<p class="tagItem">당뇨병</p>'
    }
    else{
        html += '<p class="tagItem">당뇨 정상</p>'
    }

    let bpValue = $('#BPStateValue').html();
    if(bpValue === "주의혈압"){
        html += '<p class="tagItem">주의혈압</p>'
    }
    else if(bpValue === "고혈압 전 단계"){
        html += '<p class="tagItem">고혈압 전 단계</p>'
    }
    else if(bpValue === "고혈압 1기"){
        html += '<p class="tagItem">고혈압 1기</p>'
    }
    else if(bpValue === "고혈압 2기"){
        html += '<p class="tagItem">고혈압 2기</p>'
    }
    else if(bpValue === "수축기단독고혈압"){
        html += '<p class="tagItem">수축기단독고혈압</p>'
    }
    else{
        html += '<p class="tagItem">혈압 정상</p>'
    }
    $('#exerciseTag').append(html);
    
}

function topTodayList(date){
    
    $.ajax({
        type:"post",
        url:"/healthcare/topTodayList",
        data: {"date":date},
        dataType:'json',
        success:function(result){
            $('#todayList').empty();
            let html = "";
            $.each(result.todayList, function(k,v){
                console.log(v.myTime)
                html+='<li id="topListNo'+v.elMyNo+'">';
                html+='<div>'+v.myTime+'</div>';
                html+='<div>'+v.myRoutine+'</div>';
                if(v.routineCK === 0){
                    html+='<div id="topMyListCk'+v.elMyNo + '" style="color: rgb(100 100 100);">X</div>';
                }
                else{
                    html+='<div id="topMyListCk'+v.elMyNo + '" style="color: rgb(91, 125, 238);">O</div>';
                }
                html+='</li>';
            })
            $('#todayList').append(html);
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function myListCheck(itemNo, changeNum){
    
    $.ajax({
        type:"post",
        url:"/healthcare/myListItemCheck",
        data: {"itemNo":itemNo,
                "changeNum":changeNum},
        dataType:'text',
        success:function(result){
            if(result === "success"){
                let toDay = $('#calendarListDate').html();
                if(changeNum === 1){
                    $('#myListCk'+itemNo).children('#ckNum').attr('value',1)
                    $('#myListCk'+itemNo).children('img').attr('src','/image/healthcare/checkO.png')

                    
                    if(toDay == "오늘"){
                        $('#topMyListCk'+itemNo).html('O');
                        $('#topMyListCk'+itemNo).css('color','rgb(91, 125, 238)');
                    }
                }
                else{
                    $('#myListCk'+itemNo).children('#ckNum').attr('value',0)
                    $('#myListCk'+itemNo).children('img').attr('src','/image/healthcare/checkX.png')
                    if(toDay == "오늘"){
                        $('#topMyListCk'+itemNo).html('X');
                        $('#topMyListCk'+itemNo).css('color','rgb(100 100 100)');
                    }
                }
            }
            else{

            }
           
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function myListDeleteAjax(elMyNo){
    let dateStr;
    let dayStr;
    let day;
    let dayCount;
    
    if($('#calendarListDate').html() == "오늘"){
        dateStr = new Date();
        dayStr = dateStr.getDate();
        dayCount = Number($('#day'+dayStr).html());
        if(dayCount ==1){
            $('#day'+dayStr).html("");
        }
        else{
            $('#day'+dayStr).html(dayCount-1);
        }
    }
    else{
        dateStr = $('#calendarListDate').html().split(" ");
        dayStr = dateStr[2].split("일");
        day = dayStr[0];
        dayCount = Number($('#day'+day).html());
        if(dayCount ==1){
            $('#day'+day).html("");
        }
        else{
            $('#day'+day).html(dayCount-1);
        }
    }
    $.ajax({
        type:"post",
        url:"/healthcare/deleteMyList",
        data: {"elMyNo":elMyNo},
        dataType:'text',
        success:function(result){
            $('#listItemLi'+elMyNo).remove();
            $('#topListNo'+elMyNo).remove();

        },
        error:function(){
        }
    }); // ajax 종료 	
}