<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="search.css">
    <script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
    <script type="text/javascript">
        //초기 좌표 값 설정
        var x = 37.49241689559544;
        var y = 127.03171389453507;
        var s_x; // 시작 x 값
        var s_y; // 시작 y 값
        var e_x; // 도착 x 값
        var e_y; // 도착 y 값
        //위치 표시를 위함 마커
        var marker_s; //시작지 마커
        var marker_e; //도착지 마커

        //지도 표시
        function initTmap(){
                var map;
                //기본 지도 설정
                map = new Tmapv2.Map("map", {
                    center : new Tmapv2.LatLng(x, y),
                    width : "100%",
                    height : "400px",
                    zoom : 11,
                    zoomControl : false,
                    scrollwheel : true
                });
                $("#search_btn").click(function(){
                    //출발지 마커 찍기
                    marker_s = new Tmapv2.Marker(
						{
							position : new Tmapv2.LatLng(37.566567545861645,
									126.9850380932383),
							icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
							iconSize : new Tmapv2.Size(24, 38),
							map : map
						});
		
                    //도착지 마커 찍기
                    marker_e = new Tmapv2.Marker(
                            {
                                position : new Tmapv2.LatLng(37.403049076341794,
                                        127.10331814639885),
                                icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
                                iconSize : new Tmapv2.Size(24, 38),
                                map : map
                            });
                })
                
                
        }
    </script>
        
    <title>위치 검색</title>
</head>
<body onload="initTmap();">
    <header>header not contents</header>
    <main class="search">
        <form class="search_form">
            <div style="flex: 8;">
                <input class="search_form_text" type="text" placeholder="시작 위치를 입력하세요." id="start" required>
                <input class="search_form_text" type="text" placeholder="도착 위치를 입력하세요." id="end" required>
            </div>
                <input id="search_btn" type="button" value="검색" onclick="search();">
        </form>
        <div id="map"></div><br>
        <p id="result"></p>
        <button id="select_btn" style="float: right;"> 설정하기</button>
    </main>
</body>
</html>