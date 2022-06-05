<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--틀만 만들어둔 상태-->
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/image/icon.png">
  <title>
    함께 갈래요? - 등록페이지
  </title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css"
    href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&display=swap" />
  <!-- Nucleo Icons -->
  <link href="./assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="./assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="./assets/css/material-kit.css?v=3.0.2" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js"
    integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk"
    crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js"
    integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy"
    crossorigin="anonymous"></script>

  <!--datepicker사용을 위해-->
  <link rel="stylesheet" href="./assets/css/bootstrap-datepicker.css">
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="./assets/js/bootstrap-datepicker.js"></script>
  <script
    src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>

  <!--Tmap API 사용-->
  <script src="tmap.js"></script>
  <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
  <script type="text/javascript">
    var map;
    var s_x; // 시작 x 값
    var s_y; // 시작 y 값
    var e_x; // 도착 x 값
    var e_y; // 도착 y 값
    //위치 표시를 위함 마커
    var marker_s; //시작지 마커
    var marker_e; //도착지 마커
    var drawInfoArr = [];
    var resultdrawArr = [];
    var markerArr_s = []; //출발지 검색된 값 
    var markerArr_e = []; //도착지 검색된 값 
    function initTmap() {
      //기본 지도 설정
      map = new Tmapv2.Map("map", {
        center: new Tmapv2.LatLng(37.49241689559544, 127.03171389453507),
        width: "100%",
        height: "400px",
        zoom: 13,
        zoomControl: false,
        scrollwheel: true
      });

      $("#input").click(function () {
        var search_s = $('#start').val();
        var search_e = $('#end').val();
        var num = document.getElementById("num").value; 
        if( search_s == ""){
          alert("출발지를 입력해 주세요!")
        }else if(search_e == ""){
          alert("도착지를 입력해 주세요!")
        }else if(num == ""){
          alert("인원 수를 지정해 주세요!");
          $('#num').val("");
        }else if(num<2||num>4){
          alert("인원 수는 2~4명 사이로 지정해 주세요!");
          $('#num').val("");
        }else{
          resettingMap();
          //시작 점 검색
          let [x1, y1] = toPoint(search_s);
          s_x = x1;
          s_y = y1;
        
          //시작 마커 찍기
          marker_s = new Tmapv2.Marker({
            position: new Tmapv2.LatLng(s_y, s_x),
            icon: "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_s.png",
            iconSize: new Tmapv2.Size(24, 38),
            title: reverseGeo(s_x,s_y), //주소이름
            map: map
          });
          markerArr_s.push(marker_s); //마커를 누르면 상세 주소
          map.setCenter(new Tmapv2.LatLng(s_y, s_x));

          //도착지 마커 찍기
          let [x2, y2] = toPoint(search_e);
          e_x = x2;
          e_y = y2;
          marker_e = new Tmapv2.Marker({
                position: new Tmapv2.LatLng(e_y, e_x),
                icon: "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_e.png",
                iconSize: new Tmapv2.Size(24, 38),
                title: reverseGeo(e_x, e_y), //주소 이름
                map: map
          });
          markerArr_e.push(marker_e); //마커를 누르면 상세 주소

          //경로 표시하기
          $.ajax({
            type: "POST",
            url: "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result",
            async: false,
            data: {
              "appKey": "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
              "startX": s_x,
              "startY": s_y,
              "endX": e_x,
              "endY": e_y,
              "reqCoordType": "WGS84GEO",
              "resCoordType": "EPSG3857",
            },
            success: function (response) {
              var resultData = response.features;

              document.getElementById("price").value = Math.floor(resultData[0].properties.taxiFare / num);

              for (var i in resultData) { //for문 [S]
                var geometry = resultData[i].geometry;
                var properties = resultData[i].properties;

                if (geometry.type == "LineString") {
                  for (var j in geometry.coordinates) {
                    // 경로들의 결과값들을 포인트 객체로 변환 
                    var latlng = new Tmapv2.Point(
                      geometry.coordinates[j][0],
                      geometry.coordinates[j][1]);
                    // 포인트 객체를 받아 좌표값으로 변환
                    var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
                      latlng);
                    // 포인트객체의 정보로 좌표값 변환 객체로 저장
                    var convertChange = new Tmapv2.LatLng(convertPoint._lat, convertPoint._lng);
                    // 배열에 담기
                    drawInfoArr.push(convertChange);
                  }//for문 끝
                  drawLine(drawInfoArr);
                }
              }
            } //키 인증 성공
          }); //ajex끝
      }})
    } //출발지, 도착지버튼 클릭 끝

    //라인그리기
    function drawLine(arrPoint) {
      var polyline_;

      var lineColor = "";
      polyline_ = new Tmapv2.Polyline({
        path: arrPoint,
        strokeColor: "#DD0000",
        strokeWeight: 6,
        map: map
      });
      resultdrawArr.push(polyline_);
    }

    //초기화 기능
    function resettingMap() {
      //기존마커는 삭제
      if (markerArr_s.length > 0) {
        markerArr_s[0].setMap(null);

      }
      if (markerArr_e.length > 0) {
        markerArr_e[0].setMap(null);
      }
      if (resultdrawArr.length > 0) {
        for (var i = 0; i < resultdrawArr.length; i++) {
          resultdrawArr[i].setMap(null);
        }
      }
      drawInfoArr = [];
      resultdrawArr = [];
    }
  </script>

</head>

<body onload="initTmap();" class="registration bg-gray-200">

  <!-- Navbar Transparent -->
  <nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent ">
    <div class="container">
      <a class="navbar-brand  text-white " href="main.jsp" data-placement="bottom">
        함께 갈래요?
      </a>
      <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse"
        data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon mt-2">
          <!-- 메뉴 바 아이콘 -->
          <span class="navbar-toggler-bar bar1"></span>
          <span class="navbar-toggler-bar bar2"></span>
          <span class="navbar-toggler-bar bar3"></span>
        </span>
      </button>
      <div class="collapse navbar-collapse w-100 pt-3 pb-2 py-lg-0 ms-lg-12 ps-lg-5" id="navigation">
        <ul class="navbar-nav navbar-nav-hover ms-auto">
          <!--첫 번째 메뉴(마이페이지)-->
          <li class="nav-item dropdown dropdown-hover mx-2 ms-lg-6">
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center"
              id="dropdownMenuPages8" href="myPage.jsp">
              <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
              마이페이지
              <img class="arrow ms-2 d-lg-block d-none">
              <img class="arrow ms-2 d-lg-none d-block">
            </a>
          </li>
          <!--두 번째 메뉴(예약 내역)-->
          <li class="nav-item dropdown dropdown-hover mx-2">
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center"
              id="dropdownMenuBlocks" href="reservation.jsp">
              <i class="material-icons opacity-6 me-2 text-md">view_day</i>
              예약내역
              <img class="arrow ms-2 d-lg-block d-none">
              <img class="arrow ms-2 d-lg-none d-block">
            </a>
          </li>
          <li class="nav-item dropdown dropdown-hover mx-2">
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuPages8" href="sign-in.jsp">
              <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
              로그아웃
              <img class="arrow ms-2 d-lg-block d-none">
              <img class="arrow ms-2 d-lg-none d-block">
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <!-- End Navbar -->
  <!-- -------- START HEADER 4 w/ search book a ticket form ------- -->
  <header>
    <!--메뉴바 밑 이미지 부분-->
    <div class="page-header min-height-400"
      style="background-image: url('https://c.pxhere.com/photos/14/86/architecture_buildings_bus_business_cars_city_cityscape_clouds-1495895.jpg!d');"
      loading="lazy">
      <span class="mask bg-gradient-dark opacity-4"></span>
    </div>
  </header>

  <!-- -------- END HEADER 4 w/ search book a ticket form ------- -->
  <div class="card card-body shadow-blur mx-3 mx-md-4 mt-n6 mb-4">
    <!-- START Testimonials w/ user image & text & info -->
    <section class="py-sm-7 py-5 position-relative">
      <div class="container">
        <div class="row">
          <div class="col-12 mx-auto">
            <div class="col-lg-9 col-md-9 mt-4 z-index-2 position-relative px-md-2 px-sm-5 mx-auto">
              <h2 class="mb-1">구인글 등록</h2>
              <hr width="100%" color="#B2B2B2" noshade />
            </div>
            <div class="col-lg-8 col-md-8 mt-4 px-md-2 px-sm-5 mx-auto">
              <div id="map"></div>
              <form class="justify-content-center my-sm-5 align-items-center mt-4" action="ActionRegistration.jsp" method="post" role="form">
                출발지 <input class="form-control border p-2 mt-1 mb-3" id="start" name="start" type="search" placeholder="출발지" required>
                도착지 <input class="form-control border p-2 mt-1 mb-3" id="end" name="end" type="search" placeholder="도착지" required>
                <div class="row">
                  <div class="col-lg-6 col-md-6">
                    인원수
                    <div class="d-flex justify-content-center">
                      <input type="number" name="wr_1" id="num" class="form-control border p-2 mt-1 mb-3 me-2" min="2"
                        max="4" placeholder="2 ~ 4" required>
                      <button class="btn btn-outline-success mt-1 mb-3" type="button" id="input"
                        style="width:7rem;height:42px">조회</button>
                    </div>
                  </div>
                  <div class="col-lg-6 col-md-6">
                    예상가격<input id="price" name="price" class="form-control-plaintext p-2 mt-1 mb-3" placeholder="조회 클릭시 확인 가능"
                      readonly>
                  </div>
                </div>
                <div class="row">
                  <div class="col-lg-6 col-md-6">
                    날짜 <input type="text" id="datePicker" name="date" class="form-control border p-2 mt-1 mb-3"
                      placeholder="날짜 선택 (최대 15일 이후까지 선택 가능)" required>
                  </div>
                  <div class="col-lg-6 col-md-6">
                    시간 <input type="time" name="time" class="form-control border p-2 mt-1 mb-3" required>
                  </div>
                </div>
                상세설명 <textarea class="form-control border p-2 mt-1 mb-3" placeholder="상세설명을 작성해주세요."
                  id="floatingTextarea2" name="text" style="height: 12rem; resize: none;" required></textarea>
                  <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-primary mt-3 fs-6">
                  등록
                </button>
              </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END Testimonials w/ user image & text & info -->
  </div>



  <!-- -------- END FOOTER 5 w/ DARK BACKGROUND ------- -->
  <!--   Core JS Files   -->
  <script src="./assets/js/core/popper.min.js" type="text/javascript"></script>
  <script src="./assets/js/core/bootstrap.min.js" type="text/javascript"></script>
  <script src="./assets/js/plugins/perfect-scrollbar.min.js"></script>
  <!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
  <script src="./assets/js/plugins/parallax.min.js"></script>
  <!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
  <!--  Google Maps Plugin   
  <script src="./assets/js/material-kit.min.js?v=3.0.2" type="text/javascript"></script>-->
</body>

<!--
<script>
  $(document).on("keyup", "input[name^=wr_1]", function () {
    var val = $(this).val();

    

    if (val < 2 || val > 4) {
      alert("2~4 범위로 입력해 주십시오.");
      $(this).val('');
    }

  });
</script>
-->
<script>
  $('#datePicker')
    .datepicker({
      format: 'yyyy-mm-dd', //데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
      startDate: '0d', //달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
      endDate: '+15d', //달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
      autoclose: true, //사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
      calendarWeeks: false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
      clearBtn: false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
      disableTouchKeyboard: false, //모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
      immediateUpdates: false, //사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false
      templates: {
        leftArrow: '&laquo;',
        rightArrow: '&raquo;',
      }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징
      showWeekDays: true, // 위에 요일 보여주는 옵션 기본값 : true
      todayHighlight: true, //오늘 날짜에 하이라이팅 기능 기본값 :false
      weekStart: 0, //달력 시작 요일 선택하는 것 기본값은 0인 일요일
      language: 'ko', //달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
    })
    .on('changeDate', function (e) {
      console.log(e);
      // e.date를 찍어보면 Thu Jun 27 2019 00:00:00 GMT+0900 (한국 표준시) 위와 같은 형태로 보인다.
    });
</script>

</html>