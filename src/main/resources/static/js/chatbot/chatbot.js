/**
 * chatbot.js
 */
 
$(document).ready(function(){
 
    // 웰컴 메시지ㅣ 받기 위해 message 입력 받기 전에
    // 빈 값으로 서버에 전송하고 결과 받음 	
    callAjax(); // 빈 값의 message가 서버로 전송
    
    // 처음 시작시 <audio> 안 보이게
    $('#audio').hide();
    
    
    //////////////////////////////////////////////////////////////////
    // 음성으로 질문하기 
    // (1) 음성 녹음
     //////////////////////////////////////////////////////////////////////////
     const recordBtn = document.getElementById("recordBtn");
     const stopBtn = document.getElementById("stopBtn");
     
     if(navigator.mediaDevices) {
         var constraints = {
             audio:true
         }
         
         let chunks = []; // 녹음 데이터 저장하기 위한 변수
         
         navigator.mediaDevices.getUserMedia(constraints)
             .then(stream => {
                 const mediaRecorder = new MediaRecorder(stream);
                 
                 // [녹음] 버튼 눌렀을 때
                 recordBtn.onclick = () => {
                     mediaRecorder.start(); // 녹음 시작
                     recordBtn.style.background = "#ff00009e"; // [녹음] 버튼 배경색
                     recordBtn.style.color = "black";
                     recordBtn.style.borderColor = "red";
                 }
                 
                 // [정지] 버튼 눌렀을 때
                 stopBtn.onclick = () => {
                     mediaRecorder.stop(); // 녹음 정지
                     recordBtn.style.background = ""; // [녹음] 버튼 배경색 설정한 것 삭제
                     recordBtn.style.color = "";
                     recordBtn.style.borderColor = "";
                 }
                 
                 // chunks에 저장된 녹음 데이터를 audio 양식으로 설정
                 // blob : 녹음 데이터
                 mediaRecorder.onstop = e => {
                     const blob = new Blob(chunks, {
                         'type':'audio/mp3 codecs=opus'
                 });
                 
                 chunks = []; // 초기화 : 초기화하지 않으면 녹음 내용이 누적됨
                 
                 // 녹음 내용을 파일로 저장 시 파일명 랜덤 생성
                 var num  = new Date();
                 const clipName = num.getTime() + "_voiceMsg"; // 파일 이름
                 
                 // 파일 업로드 함수 호출
                 fileUploadFn(blob, clipName); // 음성 파일 데이터, 파일명
                 
               }// mediaRcorder.onstop 끝
               
               // 녹음 시작시킨 상태가 되면 chunks에 녹음 데이터 저장
               mediaRecorder.ondataavailable = e => {
                       chunks.push(e.data);
               }
               
               }).catch(err => {
                       console.log("오류 발생 : " + err);
               });
         
     }  	
     //////////////////////////////////////////////////////////////////////////
     
     // (2) 파일 업로드 
     // 서버에 파일 업로드 하는 함수
     function fileUploadFn(blob, clipName) {
         // 음성 파일을 폼에 추가
         var formData = new FormData();
         formData.append('uploadFile', blob, clipName + ".mp3");
         // name, 데이터, 파일명
         
         // 서버에 전달하고 응답 받음
         $.ajax({
            type:"post",
            url:"/stt",
            enctype:"multipart/form-data",
            processData:false,
            contentType:false,
            data: formData,
            success:function(result){
                // 챗봇 창에 받은 메시지 추가
                $('#chatBox').append('<div class="msgBox send"><span id="in"><span>' +
                                              result + '</span></span></div><br>');
                
                // <input> 태그의 값을 받은 텍스트로 설정
                $('#message').val(result);
                
                // 챗봇에게 전달
                callAjax(); 			
                              
                $('#message').val('');
            },
            error:function(){
                alert("실패");
            },
            complete:function(){
                //alert("작업 완료");
            }
        }); // ajax 종료 	
     }
    

    $('#chatbotForm').on('submit', function(){
        //폼이 submit 되지 않도록 기본 기능 중단
        event.preventDefault();
        
        //message가 빈값인 경우 확인 메시지 출력
        if($('#message').val() == ""){
            alert("질문 입력하세요");
            $('#message').focus();
            return false;
        }
        
        // 챗봇 창에 보낸 메시지 추가
        $('#chatBox').append('<div class="msgBox send"><span id="in"><span>' +
                                              $('#message').val() + '</span></span></div><br>');
        
            callAjax();
        
        $('#message').val(''); // 입력란 비우기
    });// submit 종료
    
    
    function callAjax() {
        // 서버에 전송하고 결과 받아서 처리
        $.ajax({
            type:"post",
            url:"/chatbot3",
            data: {"message": $('#message').val()},
            dataType:'json',
            success:function(result){
                
                //JSON 형식 그대로 반환 받음
               var bubbles = result.bubbles;
               for(var b in bubbles){
                   if(bubbles[b].type == 'text'){ // 기본 답변인 경우
                       /* chatBox에 받은 메시지 추가 */
                           $('#chatBox').append('<div class="msgBox receive"><span id="in"><span><img src="../../image/chatbot/chatbot.png"></span><br><span>' + 
                                                              bubbles[b].data.description +'</span></span></div><br><br>'); 
                                                              
                       // 챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해 TTS 호출									   
                       callAjaxTTS(bubbles[b].data.description);										   
                   }	else if(bubbles[b].type == 'template'){//이미지 답변 또는 멀티링크 답변 시작
                       if(bubbles[b].data.cover.type=="image"){//이미지 이면
                           $("#chatBox").append("<img src='" + bubbles[b].data.cover.data.imageUrl +
                                                                        "' alt='이미지 없음' width='200' height='150'>");
                           if(bubbles[b].data.contentTable == null){
                               $("#chatBox").append
                               ("<a href='"+bubbles[b].data.cover.data.action.data.url+"' target='_blank'>" + 
                                       bubbles[b].data.cover.data.action.data.url+ "</a><br><br>");							
                           } else {
                               $("#chatBox").append("<div class='msgBox receive'><span id='in'><span><img src='../../image/chatbot/chatbot.png'></span><br><span>" + bubbles[b].data.cover.data.description+ "</span></span></div>");	
                               // 챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해 TTS 호출									   
                               callAjaxTTS(bubbles[b].data.cover.data.description);										
                           }
                       } 	else if(bubbles[b].data.cover.type=="text"){//멀티링크 답변이면
                           $("#chatBox").append("<div class='msgBox receive'><span id='in'><span><img src='../../image/chatbot/chatbot.png'></span><br><span>" + bubbles[b].data.cover.data.description+ "</span></span></div>");
                           // 챗봇으로 부터 받은 텍스트 답변을 음성으로 변환하기 위해 TTS 호출									   
                           callAjaxTTS(bubbles[b].data.cover.data.description);	
                       }
                       
                       // 이미지 / 멀티링크 답변 공통 (contentTable 포함)
                       for(var ct in bubbles[b].data.contentTable){
                           var ct_data = bubbles[ct].data.contentTable[ct];
                           for(var ct_d in ct_data){
                               $("#chatBox").append
                               ("<a href='"+ct_data[ct_d].data.data.action.data.url+"' target='_blank'>" + 
                                   ct_data[ct_d].data.data.action.data.url+ "</a><br><br>");
                           }
                       }// contentTable for문 끝
                       $("#chatBox").scrollTop($("#chatBox").prop("scrollHeight"));
                   }//template 끝			
               }//bubbles for문 종료
               
               // 스크롤해서 올리기										   
               $("#chatBox").scrollTop($("#chatBox").prop("scrollHeight"));	 				
                
            },
            error:function(){
                alert("실패");
            }
        }); // ajax 종료 
    }
    
    // 챗봇으로부터 받은 텍스트 답변을 음성으로 변환하기 위해 TTS API 전달
    function callAjaxTTS(msg) {
        $.ajax({
            type:"post",
            url:"/chatbotTTS",
            data: {"message": msg},
            success:function(result){
                // result : 음성 파일명
                $('#audio').attr('src', '/audio/' + result)[0].play();
            },
            error:function(){
                alert("실패");
            }
        }); // ajax 종료 
    }
    
});