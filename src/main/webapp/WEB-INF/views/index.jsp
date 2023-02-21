<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>index 페이지</title>

<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/index.css'/>">
<script src="<c:url value='/js/jquery-3.6.1.min.js'/>"></script>
<script src="<c:url value='/js/index.js'/>"></script>

<!-- 카카오 지도 스타일 -->
<c:import url="/WEB-INF/views/chatbot/chatModal.jsp" />

</head>
<body>
<div class="chatBotDiv">
			<a data-toggle="modal" data-target="#modal" role="button"
				class="btn btn-big openmodale"><img class="chatbot_img" src="<c:url value='/image/chatBot.png'/>" id="chatBot"></a>
		</div>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script>
		console.clear();
		let box = $('body')
		let boxHeight = box.height();
		let boxOffsetTop = box.offset().top;
		let quickMenu = $('.chatBotDiv');
		let quickMenuHeight = quickMenu.height();
		const DURATION = 1000;

		$(window).resize(function(){
		    boxHeight = box.height();
		    boxOffsetTop = box.offset().top;
		    quickMenuHeight = quickMenu.height();
		    // console.log('resize!');
		})

		$(window).scroll(function() {
		    let scrollTop = $(this).scrollTop();
		    let point;
		    let endPoint = boxHeight - quickMenuHeight;
		    if ( scrollTop < boxOffsetTop ) {
		        point = 0;
		    } else if ( scrollTop > endPoint ) {
		        point = endPoint;
		    } else {
		        point = scrollTop - boxOffsetTop; // 따라다니는 영역에서 우측 최상단에 위치
		    }
		    quickMenu.stop().animate({top: point}, DURATION);
		});


		</script>


	<div class="image1">
		<div class="main_text">나도 젊어 봤다</div>
		<div class="sub_text">오늘보다 더 나은 내일을 위해</div>



		<!-- 로그인 전 -->
		<c:if test="${empty sessionScope.sid }">
			<div class="member_button">
				<input type="button" class="button"
					onClick="location.href='<c:url value='/member/joinForm'/>'"
					value="회원가입"> <input type="button" class="button"
					onClick="location.href='<c:url value='/member/loginForm'/>'"
					value="로그인">
			</div>
		</c:if>

		<!-- 로그인 후 -->
		<c:if test="${not empty sessionScope.sid }">
			<div class="user_logIn_img">
				<img src="<c:url value='/image/user.png'/>" class="userImg">
			</div>

			<div class="user_logIn_name">
				<a id="headerMenuA" class="headerUserId">${sessionScope.sid}님</a>
			</div>

			<div class="user_logIn_button">
				<input type="button" class="button"
					onClick="location.href='<c:url value='/member/myPage'/>'"
					value="마이페이지"> <input type="button" class="button"
					onClick="location.href='<c:url value='/member/logout'/>'"
					value="로그아웃">
			</div>





		</c:if>

		<div class="text">아래로 스크롤 해주세요!</div>

		
	</div>

	<div class="menu">
		<div class="menu_text">Contents</div>

		<div class="right_menu_box">

			<div class="button_box_top">
				<input type="button" class="box1" value="운동"
					onClick="location.href='<c:url value='/exercise/exerciseInfo'/>'">
				<input type="button" class="box2" value="영양제"
					onClick="location.href='<c:url value='/spm/listSupplement'/>'">
			</div>

			<div class="button_box_bottom">
				<input type="button" class="box3" value="건강 알리미"
					onClick="location.href='<c:url value='/community/healthcare'/>'">
				<input type="button" class="box4" value="커뮤니티"
					onClick="location.href='<c:url value='/community/list/${num=1}'/>'">

			</div>

			
		</div>
	</div>

	<div class="image2"></div>
	<div class="map_api">
		<div class="menu_text">집 근처 편의시설 찾기</div>

		<!-- 지도 -->
		<div class="map_wrap">
			<div id="map"
				style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div>
						<form onsubmit="searchPlaces(); return false;">
							키워드 : <input type="text" value="강남 병원" id="keyword" size="15">
							<button type="submit">검색하기</button>
						</form>
					</div>
				</div>
				<hr>
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
		</div>
		
		<!-- 지도 app key -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=72bd43e207ace7b4adbc2a7f9e8860e9&libraries=services"></script>
		
		<!-- 지도 javascript -->
		<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                 
      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>

	</div>

    <a href="#" class="btn_gotop">
        <span class="glyphicon glyphicon-chevron-up">
            TOP
        </span>
    </a>
    <script>
        $(window).scroll(function(){
            if ($(this).scrollTop() > 300){
                $('.btn_gotop').show();
            } else{
                $('.btn_gotop').hide();
            }
        });
        $('.btn_gotop').click(function(){
            $('html, body').animate({scrollTop:0},400);
            return false;
        });
        </script>



	<div class="image3">
		<div class="footer_box">
			주소 : 서울 특별시 서초구</br> 대표자 : 박정훈</br> 전화번호 : 02-000-0000</br> COPYRIGHT © 2023 나도
			젊어봤다. ALL RIGHTS RESERVED. CREATED BY 이조판서</br>
		</div>
	</div>








	<!--footer.jsp 에서 html가지고 오는 코드 자세한 내용은 headerFooter 파일에서-->



</body>



</html>