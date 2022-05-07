<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="search.css">
    <script src="tmap.js"></script>
    <!--
    <script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
    <script type="text/javascript">
        //초기 좌표 값 설정
        var x = 37.570028;
        var y = 126.986072;
        //위치 표시를 위함 마커
        var marker1; //시작지 마커
        var marker2; //도착지 마커

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
        }
        //좌표 값 새로 입력
        function search(){
            x = document.getElementById("start");
            y = document.getElementById("end");
        }
    </script>
        -->
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
                <input type="button" value="검색" onclick="search();">
        </form>
        <div id="map"></div><br>
        <button id="select_btn" style="float: right;"> 설정하기</button>
    </main>
</body>
</html>