$(document).ready(function(){
    let heightM = $('.HInput').val();
    let weightM = $('#weightText').html();
    let bsM = $('#BSText').html();
    let bpM1 = $('#BloodPValue1').html();
    let bpM2 = $('#BloodPValue2').html();
    BMIMatch(heightM, weightM);
    wMatch(weightM);
    BSMatch(bsM);
    BPMatch(bpM1, bpM2);
    // 체중, bmi
    let wAjaxRt = graphWeightAjax();
    let wLabels = [];
    let wMyData = [];
    wLabels = wAjaxRt[0];
    wMyData = wAjaxRt[1];
    
    // 혈당
    let BSReturn =graphBSAjax();
    let BSLabels = BSReturn[0];
    let BSData = BSReturn[1];

    //혈압
    let BPReturn = graphBPAjax();
    let BPLabels = BPReturn[0];
    let BPData1 = BPReturn[1];
    let BPData2 = BPReturn[2];
    $(document).on('click','.HInput',function(){
        $('.HInput').attr('readonly',false);
        $('.HInput').attr('value',"");
        $('#HSubmitBT').attr('disabled',false);
        $('#cancelHBt').css('visibility',"visible");
    })
    $('#cancelHBt').on('click',function(){
        
        $('.HInput').attr('readonly',true);
        $('.HInput').attr('value',heightM);
        $('#HSubmitBT').attr('disabled',true);
        $('#cancelHBt').css('visibility',"hidden");
        
    });

    $('.IDHiddenBT').on('click',function(){
        
        var thisId = $(this).attr("id");
        if($('#'+thisId).html() == "입력"){
            $('#'+thisId).html("취소");
            $('.'+thisId).css('visibility',"visible");
        }
        else{
            $('#'+thisId).html("입력");
            $('.'+thisId).css('visibility',"hidden");
        }
        
        
    });
    $(document).on('submit','#stateFormH',function(){
    //폼이 submit 되지 않도록 기본 기능 중단
       event.preventDefault();
       var hcdValue = $('.HInput').val();
       if(hcdValue == ""){
            alert("키를 입력해야 합니다.");
       }
       else{
        $('.HInput').val(hcdValue+"cm");
        inputAjax(hcdValue,"키");
        $('#cancelHBt').css("visibility","hidden");
        heightM = $('.HInput').val();
        $('.HInput').attr('readonly',true);
        $('.HInput').attr('value',heightM);
        $('#HSubmitBT').attr('disabled',true);
        $('#cancelHBt').css('visibility',"hidden");
        BMIMatch(heightM, weightM);
        let bmiData = graphBMIMatch(wMyData);
        if(weightM == "kg"){

        }
        else{
            if(myChart2 != null){
                myChart2.data.datasets[0].data = bmiData;
                myChart2.update();
            }
            else{
                graphWeightAjax();
            }
            
        }
        
       }
    });
    $('#stateFormW').on('submit', function(){
    //폼이 submit 되지 않도록 기본 기능 중단
       event.preventDefault();
       var hcdValue = $('#weightInput').val();
       if(hcdValue == ""){
            alert("체중을 입력해야 합니다.");
       }
       else{
        $('#weightText').html(hcdValue+"kg");
        inputAjax(hcdValue,"체중");
        $('.wInputDiv').css("visibility","hidden");
        $('#wInputDiv').html("입력");
        $('#weightInput').val("");
        weightM = $('#weightText').html();
        BMIMatch(heightM, weightM);
        wMatch(weightM);
        if(heightM == "cm"){
            alert("키를 입력해주세요.");
        }
        else{
            let wDataSet = graphWMatch(hcdValue,wLabels,wMyData);
            let bmiData = graphBMIMatch(wMyData);
            console.log(bmiData)
            if(myChart1 == null && myChart2 == null){
                graphMath1(wDataSet[0],wDataSet[1])
                graphMath2(wDataSet[0],bmiData)
                //graphWeightAjax();
            }
            else{
                
                
                myChart1.data.labels = wDataSet[0];
                myChart1.data.datasets[0].data = wDataSet[1];
                myChart1.update();
        
                
                myChart2.data.datasets[0].data = bmiData;
                myChart2.update();
            }
            
        }
        
       }
    });
    $('#stateFormBS').on('submit', function(){
    //폼이 submit 되지 않도록 기본 기능 중단
       event.preventDefault();
       var hcdValue = $('#bloodSInput').val();
       if(hcdValue == ""){
            alert("혈당을 입력해야 합니다.");
       }
       else{
        $('#BSText').html(hcdValue+"mg/dL");
        inputAjax(hcdValue,"혈당");
        $('.BSInputDiv').css("visibility","hidden");
        $('#BSInputDiv').html("입력");
        $('#bloodSInput').val("");
        bsM = $('#BSText').html();
        BSMatch(bsM);
        let bsDataSet = graphBSMatch(hcdValue,BSLabels,BSData);
        if(myChart4 != null){
            myChart4.data.labels = bsDataSet[0];
            myChart4.data.datasets[0].data = bsDataSet[1];
            myChart4.update();
        }
        else{
            graphMath4(bsDataSet[0],bsDataSet[1]);
        }
        
       }
    });
    $('#stateFormBF').on('submit', function(){
    //폼이 submit 되지 않도록 기본 기능 중단
       event.preventDefault();
       var hcdValue1 = $('#bloodPInput1').val();
        var hcdValue2 = $('#bloodPInput2').val();
       if(hcdValue1 == "" || hcdValue2 ==""){
            alert("수축기와 이완기혈압을 전부 입력해야 합니다.");
       }
       else{
        $('#BloodPValue1').html(hcdValue1);
        $('#BloodPValue2').html(hcdValue2);
        inputAjax2(hcdValue1,"수축기혈압",hcdValue2,"이완기혈압");
        $('.BPInputDiv').css("visibility","hidden");
        $('#BPInputDiv').html("입력");
        $('#bloodPInput1').val("");
        $('#bloodPInput2').val("");
        bpM1 =  $('#BloodPValue1').html();
        bpM2 =  $('#BloodPValue2').html();
        BPMatch(bpM1, bpM2);

        let bpDataSet = graphBPMatch(hcdValue1,hcdValue2,BPLabels,BPData1,BPData2);
        if(myChart3 !=null){
            myChart3.data.labels = bpDataSet[0];
            myChart3.data.datasets[0].data = bpDataSet[2];
            myChart3.data.datasets[1].data = bpDataSet[1];
            myChart3.update();
        }
        else{
            graphMath3(bpDataSet[0],bpDataSet[2],bpDataSet[1]);
        }
       }
    });
    
    
});

function wMatch(weight){
    if(weight !=null){
        $('#wStateValue').css('visibility','hidden');
    }
    else{
        $('#wStateValue').css('visibility','visible');
    }
};

function BMIMatch(height, weight){
    if(height === "cm" || (height === "cm" && weight === "kg")){
        $('#BMIText').html("%");
        $('#BMIStateValue').html("키를 입력하세요.");
    }
    else if(weight === "kg"){
        $('#BMIStateValue').html("체중을 입력하세요.");
        $('#BMIText').html("%");
    }
    else{
        let heightStr = height.split('cm',1);
        let weightStr = weight.split('kg',1);
        let heightM = parseFloat(heightStr) /100;
        let weightM = parseFloat(weightStr);
        let bmiM = weightM/(heightM * heightM);
        let bmiRound = Math.round(bmiM * 10)/10;
        $('#BMIText').html(bmiRound+"%");
        if(bmiRound < 20){
            $('#BMIStateValue').html("저체중");
            $('#BMIStateValue').css('background-color','#4c91f9')
        }
        else if(bmiRound >= 20 && bmiRound <=24){
            $('#BMIStateValue').html("정상");
            $('#BMIStateValue').css('background-color','#67f94c')
        }
        else if(bmiRound >= 25 && bmiRound <=29){
            $('#BMIStateValue').html("과체중");
            $('#BMIStateValue').css('background-color','#f9a44c')
        }
        else{
            $('#BMIStateValue').html("비만");
            $('#BMIStateValue').css('background-color','#f94c4c')
        }
    };
}
    function BSMatch(bsM){
        if(bsM != "mg/dL"){
            let bsStr = bsM.split('mg/dL',1);
            let bsMF = parseFloat(bsStr);
            if(bsMF < 100){
                $('#BSStateValue').html("정상");
                $('#BSStateValue').css('background-color','#4c91f9')
            }
            else if(bsMF >= 100 && bsMF <=125){
                $('#BSStateValue').html("공복혈당장애");
                $('#BSStateValue').css('background-color','#67f94c')
            }
            else{
                $('#BSStateValue').html("당뇨병");
                $('#BSStateValue').css('background-color','#f9a44c')
            }
        }
       
    };

    function BPMatch(bpM1, bpM2){
        if(bpM1 !="" && bpM2 !=""){
            let bpMF1 = parseFloat(bpM1);
            let bpMF2 = parseFloat(bpM2);
    
            if(bpMF1 < 120 && bpMF2 < 80){
                $('#BPStateValue').html("정상");
                $('#BPStateValue').css('background-color','#f9a44c')
            }
            else if((bpMF1 >= 120 && bpMF1 <= 129) && (bpMF2 < 80)){
                $('#BPStateValue').html("주의혈압");
                $('#BPStateValue').css('background-color','#67f94c')
            }
            else if((bpMF1 >= 130 && bpMF1 <= 139) || (bpMF2 >=80 && bpMF2 <= 89)){
                $('#BPStateValue').html("고혈압 전 단계");
                $('#BPStateValue').css('background-color','#67f94c')
            }
            else if((bpMF1 >= 140 && bpMF1 <= 159) || (bpMF2 >=90 && bpMF2 <= 99)){
                $('#BPStateValue').html("고혈압 1기");
                $('#BPStateValue').css('background-color','#67f94c')
            }
            else if(bpMF1 >= 160  || bpMF2 >=100 ){
                $('#BPStateValue').html("고혈압 2기");
                $('#BPStateValue').css('background-color','#67f94c')
            }
            else if(bpMF1 >= 140 && bpMF2 < 90){
                $('#BPStateValue').html("수축기단독고혈압");
                $('#BPStateValue').css('background-color','#67f94c')
            }
            else{
    
            }
        }
        
    };

    function inputAjax(hcdValue, hcdName){
        $.ajax({
            type:"post",
            url:"/healthcare/healthInput",
            data: {"hcdValue":hcdValue,
                    "hcdName":hcdName},
            dataType:'text',
            success:function(result){
            
            },
            error:function(){
                alert("실패");
            }
        }); // ajax 종료 	
    };

    function inputAjax2(hcdValue1, hcdName1,hcdValue2, hcdName2){
        $.ajax({
            type:"post",
            url:"/healthcare/healthInput2",
            data: {"hcdValue1":hcdValue1,
                    "hcdName1":hcdName1,
                    "hcdValue2":hcdValue2,
                    "hcdName2":hcdName2},
            dataType:'text',
            success:function(result){
            
            },
            error:function(){
                alert("실패");
            }
        }); // ajax 종료 	
    };
    let myChart1;
    function graphMath1(labels,myData){
        let ctx1 =document.getElementById("graphMath1").getContext("2d");
        
        myChart1 = new Chart(ctx1, {
            type: 'bar',
            data: {
            labels: labels,
            datasets: [{
                label: "체중",
                data: myData,
                backgroundColor: [
                    "rgba(54, 162, 235, 0.6)"
                ],
                borderColor: [
                    "rgba(54, 162, 235, 1)"
                ],
                borderWidth: 1
            }]
            },
            /*빨간색
            background: rgba(255,0,0,0.5);*/
            /*초록색
            background: rgba(0,255,0,1);*/
            /*노란색
            background: rgba(255,255,0,1);*/
            options: {
                plugins:{
                legend: {
                    display: false
                },
                tooltip: {
                backgroundColor: 'rgba(255,0,0,0.5)',
                
                },
                
                },
                scales: {
                
                    y: {
                    min: 40,
                    max: 130,
                    }
                },
                
                maintainAspectRatio :false
            }
        });

    };
    let myChart2;
    function graphMath2(labels,myData){
        let ctx2 = document.getElementById("graphMath2").getContext("2d");
        myChart2 = new Chart(ctx2, {
            type: 'bar',
            data: {
            labels: labels,
            datasets: [{
                label: "BMI",
                data: myData,
                backgroundColor: [
                    "rgba(54, 162, 235, 0.6)"
                ],
                borderColor: [
                    "rgba(54, 162, 235, 1)"
                ],
                borderWidth: 1
            }]
            },
            /*빨간색
            background: rgba(255,0,0,0.5);*/
            /*초록색
            background: rgba(0,255,0,1);*/
            /*노란색
            background: rgba(255,255,0,1);*/
            options: {
                plugins:{
                legend: {
                    display: false
                },
                tooltip: {
                backgroundColor: 'rgba(255,0,0,0.5)',
                
                },
                
                },
                scales: {
                
                    y: {
                    min: 10,
                    max: 30,
                    }
                },
                
                maintainAspectRatio :false
            }
        });

    };
    let myChart3;
    function graphMath3(labels,myData,myData2){

    var ctx3 = document.getElementById("graphMath3").getContext("2d");
    myChart3 = new Chart(ctx3, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
            label: '최저 혈압(이완기)',
            data: myData2,
            backgroundColor: [
                "rgba(54, 162, 235, 0.6)"
            ],
            borderColor: [
                "rgba(54, 162, 235, 1)"
            ],
            borderWidth: 1,
            fill: true
            },
            {
            label: '최고 혈압(수축기)',
            data: myData,
            backgroundColor: [
                "rgba(231, 76, 60, 0.75)"
            ],
            borderColor: [
                "rgba(231, 76, 60, 0.75)"
            ],
            borderWidth: 1,
            fill: true
            }],
            
        },
        
        options: {
            scales: {
                y: {
                    min: 40,
                    max: 130,
                }
            },
            maintainAspectRatio :false
        }
        });
    }

    let myChart4;
    function graphMath4(labels,myData){

    var ctx4 = document.getElementById("graphMath4").getContext("2d");
    myChart4 = new Chart(ctx4, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
            label: "혈당",
            data: myData,
            backgroundColor: [
                "rgba(54, 162, 235, 0.6)"
            ],
            borderColor: [
                "rgba(54, 162, 235, 1)"
            ],
            borderWidth: 1,
            fill: true
            }],
            
        },
        
        options: {
            plugins:{
                legend: {
                    display: false
                }
            },
            x: {
                type: 'time',
                time: {
                    // Luxon format string
                    tooltipFormat: 'DD T'
                },
                title: {
                    display: true,
                    text: 'Date'
                }
                },
            scales: {
                y: {
                    min: 0,
                    max: 400,
                }
            },
            maintainAspectRatio :false
        }
        });
    }
    function dateformat(myDate,num){
    var date = new Date(myDate);
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var hs = date.getHours();
    var mn = date.getMinutes();
    if(num==4){
        return month +"/" + day +"/"+hs+"/"+mn;
    }
    else{
        return month +"월" + day +"일";
    }
    
    }

    function graphWeightAjax(){
        let wLabels =[];
        let wMyData =[];
    $.ajax({
        type:"post",
        url:"/healthcare/weightGraph",
        dataType:'json',
        success:function(result){
        if(result.voList == "noData"){
            
        }
        else{
            $.each(result.voList,function (k,v){
                wLabels.push(dateformat(v.hcdJoinDate,0));
                wMyData.push(v.hcdValue);
            });
            graphMath1(wLabels,wMyData);
            let bmiData = graphBMIMatch(wMyData);
            graphMath2(wLabels,bmiData);
        }
            
            
        },
        error:function(){
        }
    }); // ajax 종료 	
    
    
    return [wLabels,wMyData]
    }
    function graphBPAjax(){
        let BPLabels =[];
        let BPData1 =[];
        let BPData2 = [];
        $.ajax({
            type:"post",
            url:"/healthcare/bloodPGraph",
            dataType:'json',
            success:function(result){
                if(result.voList == "noData"){

                }
                else{
                    $.each(result.voList,function (k,v){
                        BPLabels.push(dateformat(v.hcdJoinDate1,0));
                        BPData1.push(v.hcdValue1);
                        BPData2.push(v.hcdValue2);
                    });
                    graphMath3(BPLabels,BPData1,BPData2);
                }
                
            },
            error:function(){
            }
        }); // ajax 종료 	
        return[BPLabels,BPData1,BPData2]
    }

    function graphBSAjax(){
        let BSLabels = [];
        let BSData = [];
        $.ajax({
            type:"post",
            url:"/healthcare/bloodSGraph",
            dataType:'json',
            success:function(result){
                if(result.voList == "noData"){

                }
                else{
                    $.each(result.voList,function (k,v){
                        BSLabels.push(dateformat(v.hcdJoinDate,4));
                        BSData.push(v.hcdValue);
                    });
                    graphMath4(BSLabels,BSData);
                }
                
            },
            error:function(){
            }
        }); // ajax 종료 	
        return[BSLabels,BSData]
    }
    function graphBMIMatch(wMyData){
            let height = $('.HInput').val();
            
            let heightStr = height.split('cm',1);
            let heightM = parseFloat(heightStr) /100;
            let bmiRound =[];
            for(let i=0; i <wMyData.length; i++){
                let weightM = parseFloat(wMyData[i]);
                let bmiM = weightM/(heightM * heightM);
                bmiRound[i] = Math.round(bmiM * 10)/10;
            }
            return bmiRound;
    }

    function graphWMatch(hcdValue,wLabels,wMyData){
        let date = new Date();
        let label = dateformat(date,1);
        if(wLabels.length < 7){
            wLabels.push(label);
        }
        else{
            wLabels.shift();
            wLabels.push(label);
        }

        if(wMyData.length < 7){
            wMyData.push(hcdValue);
        }
        else{
            wMyData.shift();
            wMyData.push(hcdValue);
        }

        return [wLabels, wMyData];
    }

    function graphBSMatch(hcdValue,BSLabels,BSData){
        let date = new Date();
        let label = dateformat(date,4);
        if(BSLabels.length < 7){
            BSLabels.push(label);
        }
        else{
            BSLabels.shift();
            BSLabels.push(label);
        }

        if(BSData.length < 7){
            BSData.push(hcdValue);
        }
        else{
            BSData.shift();
            BSData.push(hcdValue);
        }

        return [BSLabels, BSData];
    }
    function graphBPMatch(hcdValue1,hcdValue2,BPLabels,BPData1,BPData2){
        let date = new Date();
        let label = dateformat(date,1);
        if(BPLabels.length < 7){
            BPLabels.push(label);
        }
        else{
            BPLabels.shift();
            BPLabels.push(label);
        }

        if(BPData1.length < 7){
            BPData1.push(hcdValue1);
        }
        else{
            BPData1.shift();
            BPData1.push(hcdValue1);
        }

        if(BPData2.length < 7){
            BPData2.push(hcdValue2);
        }
        else{
            BPData2.shift();
            BPData2.push(hcdValue2);
        }

        return [BPLabels, BPData1, BPData2];
    }