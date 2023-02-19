/**
 * 
 */
 
 $(document).ready(function(){
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
	 })
});