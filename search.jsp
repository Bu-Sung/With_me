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
                    center : new Tmapv2.LatLng(37.49241689559544, 127.03171389453507),
                    width : "100%",
                    height : "400px",
                    zoom : 11,
                    zoomControl : false,
                    scrollwheel : true
                });
                
                
                $("#search_btn").click(function(){
                    var search_s = $('#start').val();
                    var search_e = $('#end').val();
                    //시작 점 검색
                    $.ajax({
                        method:"GET",
                        url:"https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
                        async:false,
                        data:{
                            "appKey" : "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
                            "searchKeyword" : search_s,
                            "resCoordType" : "EPSG3857",
                            "reqCoordType" : "WGS84GEO",
                            "count" : 1
                        },
                        success:function(response){
                            var resultpoisData = response.searchPoiInfo.pois.poi;
                            var markerArr = [];

                            
                            var positionBounds = new Tmapv2.LatLngBounds();		//맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
                                
                                var noorLat = Number(resultpoisData[0].noorLat);
                                var noorLon = Number(resultpoisData[0].noorLon);
                                var name = resultpoisData[0].name;
                                
                                var pointCng = new Tmapv2.Point(noorLon, noorLat);
                                var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
                                
                                var lat = projectionCng._lat;
                                var lon = projectionCng._lng;
                                s_x = lat;
                                s_x = lon;
                                var markerPosition = new Tmapv2.LatLng(lat, lon);
                                
                                marker = new Tmapv2.Marker({
                                    position : markerPosition,
                                    icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_s.png",
                                    iconSize : new Tmapv2.Size(24, 38),
                                    title : name,
                                    map:map
                                });
                                
                                
                                document.getElementById("start").value = name;
                                markerArr.push(marker_s);
                                positionBounds.extend(markerPosition);	// LatLngBounds의 객체 확장
                            
                            map.panToBounds(positionBounds);	// 확장된 bounds의 중심으로 이동시키기
                            map.zoomOut();
                            
                        },
                        error:function(request,status,error){
                            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }
                    });
                    //도착지 검색
                    $.ajax({
                        method:"GET",
                        url:"https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
                        async:false,
                        data:{
                            "appKey" : "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
                            "searchKeyword" : search_e,
                            "resCoordType" : "EPSG3857",
                            "reqCoordType" : "WGS84GEO",
                            "count" : 1
                        },
                        success:function(response){
                            var resultpoisData = response.searchPoiInfo.pois.poi;
                            var markerArr = [];
                           
                            var positionBounds = new Tmapv2.LatLngBounds();		//맵에 결과물 확인 하기 위한 LatLngBounds객체 생성
                                
                                var noorLat = Number(resultpoisData[0].noorLat);
                                var noorLon = Number(resultpoisData[0].noorLon);
                                var name = resultpoisData[0].name;
                                
                                var pointCng = new Tmapv2.Point(noorLon, noorLat);
                                var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
                                
                                var lat = projectionCng._lat;
                                var lon = projectionCng._lng;
                                e_x = lat;
                                e_x = lon;
                                var markerPosition = new Tmapv2.LatLng(lat, lon);
                                
                                marker_e = new Tmapv2.Marker({
                                    position : markerPosition,
                                    icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_e.png",
                                    iconSize : new Tmapv2.Size(24, 38),
                                    title : name,
                                    map:map
                                });
                                
                                
                                document.getElementById("end").value = name;
                                markerArr.push(marker_e);
                                positionBounds.extend(markerPosition);	// LatLngBounds의 객체 확장
                            
                            map.panToBounds(positionBounds);	// 확장된 bounds의 중심으로 이동시키기
                            map.zoomOut();
                            
                        },
                        error:function(request,status,error){
                            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                        }
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
                <input class="search_form_text" type="text" placeholder="도착 위치를 입력하세요." id="end"  required>
            </div>
                <input id="search_btn" type="button" value="검색">
        </form>
        <div id="map"></div><br>
        <button id="select_btn" style="float: right;"> 설정하기</button>
    </main>
</body>
</html>