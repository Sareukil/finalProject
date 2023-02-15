$(document).ready(function(){
    $('.flex1 a').click(function(){
        let index = $(this).index();
        index++;
        $('.flex1 a').removeClass('active');
        $(this).addClass('active');

        $('.content1').removeClass('on');
        $('#contents1_'+index).addClass('on');
    })
        


    $('#likeBt').click(function(){
        event.preventDefault();
 		
 		// 서버에 전송하고 결과 받아서 처리
 		$.ajax({
 			type:"post",
 			url:"/exercise/detailViewRoutineInfo/like",
 			data: {"routineNo":$('#routineNo').val()},
 			dataType:'text',
 			success:function(result){
                if(result == "success"){
                    alert("저장되었습니다.");
                }
                else{
                    alert("이미 저장되어있습니다.")
                }
 			},
 			error:function(){
 				alert("실패");
 			}
 		}); // ajax 종료 	
    })
    
});
