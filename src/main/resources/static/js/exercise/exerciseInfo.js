let startPageNum = 1;
let endPageNum = 10;
$(document).ready(function(){
	let index = 1;
	let indexListP = 1;
	
	exerciseRankList(index);
	exerciseItemList(index,indexListP);
	exVideoList(index);
	$('.flex li').click(function(){
		index = $(this).index();
		
		index++;
		$('.flex a').removeClass('active');
		$(this).children('a').addClass('active');

		$('.content').removeClass('on');
		$('#contents'+index).addClass('on');
		exerciseRankList(index);
		exerciseItemList(index,indexListP);
		exVideoList(index);
	})
	$(document).on('click','.itemPageCount a',function(){
		let indexListP = $(this).html()
		exerciseItemList(index,indexListP);
	})

	$(document).on('click','.btPrev',function(){
		exerciseItemList(index,startPageNum-1);
	})

	$(document).on('click','.btNext',function(){
		exerciseItemList(index,endPageNum+1);
	})
$('.triggerList').on('click', function() {
	if ($(this).hasClass('trigger-left')) {

	  var $slideList = $('.slidesList-list .slideList').last()
										   .clone()
										   .css('margin-left','-380px');
	  if(!$('.slidesList-list .slideList').eq(0).is(':animated')) {
		$('.slidesList-list').prepend($slideList);
		$('.slidesList-list .slideList').eq(0).animate({'margin-left':'13px'}, 500, function(){
		  $('.slidesList-list .slideList').last().remove();
		});
	  };
	} else {
	  var $slideList = $('.slidesList-list .slideList').eq(0)
										   .clone();
		$('.slidesList-list .slideList').eq(0).animate({'margin-left':'-380px'}, 500, function(){
		  $('.slidesList-list').append($slideList);
		  $(this).remove();
		});
	};

  });
});

function exerciseRankList(pNum){
	if(pNum == 1){
		$('.weekRank').html("이번주 등 운동루틴 TOP5");
	}
	else if(pNum == 2){
		$('.weekRank').html("이번주 어깨/목 운동루틴 TOP5");
	}
	else if(pNum == 3){
		$('.weekRank').html("이번주 팔/다리 운동루틴 TOP5");
	}
	else if(pNum == 4){
		$('.weekRank').html("이번주 허리 운동루틴 TOP5");
	}
	else{

	}
	
	$.ajax({
        type:"post",
        url:"/exercise/exerciseRankList/"+pNum,
        dataType:'json',
        success:function(result){
			
            $('.rank_list ul').empty();
            let html = "";
			let num = 1;
            $.each(result.exListR, function(k,v){
				console.log(v.routineCount);
				html += '<li>'
				html += '<p>'+num+"위"+'</p>'
                html += '<a href="/exercise/detailViewRoutineInfo/'+v.routineNo+'">'+v.routineName+'</a></li>'
				num++;
            })
            $('.rank_list ul').append(html);
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function exerciseItemList(pNum,num){
	$.ajax({
        type:"post",
        url:"/exercise/exerciseItemList/"+pNum+"/"+num,
        dataType:'json',
        success:function(result){
			
            $('.itemListBox').empty();
			$('.itemPageCount').empty();
            let html = "";
			let pageHtml = "";
			console.log(result.exListI);
            $.each(result.exListI, function(k,v){
				console.log(v);
                html += '<div class="exItem"> ';
				html += '<img class="itemImg" src="../../image/'+v.routineNo+'.png"><div class="itemImgName">';
				html += '<div class="itemText"><p class="textName"><a href="/exercise/detailViewRoutineInfo/'+v.routineNo+'">'+v.routineName+'</a></p>';
				if(v.routineOxy == 1)
					html += '<p>유산소</p>';
				else
					html += '<p>무산소</p>';
				if(v.routineMus == 1)
					html += '<p>근육강화</p>';
				else
					html += '<p>근육이완</p>';
				
				html += '<p>'+"방문자:"+v.routineVisit+'</p>';
				html += '<p>'+"저장:"+v.routineCount+'</p></div>';
				html += '<hr/></div>';
				html += '</div>';

				
            })
			if(result.prev){
				startPageNum = result.startPageNum;
				pageHtml +='<a class="btPrev"><</a>';
			}
			for(let pageNum = result.startPageNum; pageNum <= result.endPageNum; pageNum++){
				if(pageNum != result.select){
					pageHtml +='<a>'+pageNum+'</a>';
				}
				else{
					pageHtml +='<b>'+pageNum+'</b>';
				}
				
			}
			if(result.next){
				endPageNum = result.endPageNum;
				pageHtml +='<a class="btNext">></a>';
			}
			console.log(result.prev);
			console.log(result.startPageNum);
			console.log(result.endPageNum);
			console.log(result.next);
			console.log(result.select);
            $('.itemListBox').append(html);
			$('.itemPageCount').append(pageHtml);
        },
        error:function(){
        }
    }); // ajax 종료 	
}

function exVideoList(pNum){
	$.ajax({
        type:"post",
        url:"/exercise/exVideoList/"+pNum,
        dataType:'json',
        success:function(result){
			
            $('.slidesList-list').empty();
            let html = "";
			
            $.each(result.exVideoList, function(k,v){
				console.log(v.exStretchlink);
                html += '<li class="slideList">';
				html += '<iframe width="380" height="245" src="'+v.exStretchlink+'" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>';
				html += '<p>'+v.exStretchName+'</p>';
				html += '</li>'
            })
            $('.slidesList-list').append(html);
        },
        error:function(){
        }
    }); // ajax 종료 	
}