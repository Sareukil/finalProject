/**
 *  supplement.js
 */
 
 /*
$(document).ready(function(){
 $('.flex a').click(function(){
            let index = $(this).index();
            index++;
            $('.flex a').removeClass('active');
            $(this).addClass('active');
            
            $('.content').removeClass('on');
            $('#contents'+index).addClass('on');
        })
});
*/

 
 $(document).ready(function(){

  $(".sidebar-menu > li.have-children a").on("click", function(i){
    if( ! $(this).parent().hasClass("active") ){
      $(".sidebar-menu li ul").slideUp();
      $(this).next().slideToggle();
      $(".sidebar-menu li").removeClass("active");
      $(this).parent().addClass("active");
    }
    else{
      $(this).next().slideToggle();
      $(".sidebar-menu li").removeClass("active");
        }
    });
});
 
 /*
 $('#likeBt').click(function(){
        event.preventDefault();
 		
 		// 서버에 전송하고 결과 받아서 처리
 		$.ajax({
 			type:"post",
 			url:"/spm/spmDetail/like",
 			data: {"spmName":$('#spmName').val()},
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
  */
 
 
 
 
 
 
 
 
 
 
 
 
 
 