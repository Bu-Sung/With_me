<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="search.css">
    <script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
    <script type="text/javascript">
        function initTmap(){
            var map;
                map = new Tmapv2.Map("map", {
                center : new Tmapv2.LatLng(37.49241689559544, 127.03171389453507),
                width : "100%",
                height : "400px",
                zoom : 11,
                zoomControl : true,
                scrollwheel : true
            });
         }
    </script>
    <title>위치 검색</title>
</head>
<body onload="initTmap();">
    <header>header not contents</header>
    <main style="width: 500px;">
        <form class="search_form">
            <input type="text" placeholder="시작 위치를 입력하세요." name="start"><br>
            <input type="text" placeholder="도착 위치를 입력하세요." name="end">
        </form>
        <div id="map">
            
        </div>
    </main>
</body>
</html>