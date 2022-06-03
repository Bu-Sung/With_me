<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--틀만 만들어둔 상태-->
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  
  <% String num = request.getParameter("num"); //메인에서 클릭이벤트로 넘어온 그룹 번호 값%>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/image/icon.png">
  <title>
    함께 갈래요?
  </title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@500&display=swap" />
  <!-- Nucleo Icons -->
  <link href="./assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="./assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="./assets/css/material-kit.css?v=3.0.2" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
  
  <!-- Tmap API -->
  <script src="tmap.js"></script>
  <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
  <script type="text/javascript">
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
    }
  </script>
</head>

<body onload="initTmap();" class="detail-info bg-gray-200">
  <!-- Navbar Transparent -->
  <nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent ">
    <div class="container">
      <a class="navbar-brand  text-white " href="main.jsp" data-placement="bottom">
        함께 갈래요?
      </a>
      <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
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
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuPages8" href="myPage.jsp">
              <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
              마이페이지
              <img class="arrow ms-2 d-lg-block d-none">
              <img class="arrow ms-2 d-lg-none d-block">
            </a>
          </li>
          <!--두 번째 메뉴(예약 내역)-->
          <li class="nav-item dropdown dropdown-hover mx-2">
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuBlocks" href="reservation.html">
              <i class="material-icons opacity-6 me-2 text-md">view_day</i>
              예약내역
              <img class="arrow ms-2 d-lg-block d-none">
              <img class="arrow ms-2 d-lg-none d-block">
            </a>
          </li>
          <li class="nav-item dropdown dropdown-hover mx-2">
            <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="logout" href="sign-in.jsp">
              <i class="material-icons opacity-6 me-2 text-md">view_day</i>
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
    <div class="page-header min-height-400" style="background-image: url('https://c.pxhere.com/photos/14/86/architecture_buildings_bus_business_cars_city_cityscape_clouds-1495895.jpg!d');" loading="lazy">
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
              <h3 class="mb-1">글 등록자의 사용자명</h3>
              <hr width="100%" color="#B2B2B2" noshade />
            </div>
            <div class="col-lg-8 col-md-8 mt-4 px-md-2 px-sm-5 mx-auto">
                <!--지도 넣을 부분-->
                <div id="map" class="align-items-center me-5 mb-5"></div>
                <!--설명 나와야 하는 부분-->
                    <form class="position-relative align-items-center">
                        출발지 <input class="form-control-plaintext border p-2 mt-1 mb-3" type="text" readonly>
                        도착지 <input class="form-control-plaintext border p-2 mt-1 mb-3" type="text" readonly>
                        <div class="row">
                          <div class="col-md-6">
                            날짜 <input type="text" id="datePicker" class="form-control-plaintext border p-2 mt-1 mb-3" readonly>
                          </div>
                          <div class="col-md-6">
                            시간 <input type="text" class="form-control-plaintext border p-2 mt-1 mb-3" readonly>
                          </div>
                        </div>
                        예상가격 (1인당) <input class="form-control-plaintext border p-2 mt-1 mb-3" type="text" readonly>
                        상세설명 <textarea class="form-control-plaintext border p-2 mt-1 mb-3" id="floatingTextarea2" style="height: 12rem; resize: none;" readonly></textarea>
                        <div class="d-flex justify-content-end mt-5">
                            <p class="pt-2">1/4</p>
                            <button class="btn btn-primary col-lg-2 col-md-2 col-5 ms-3 fs-6" type="button" id="join">참가</button>
                        </div>
                      </form>
            </div>
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
  <!--  Google Maps Plugin    
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
  <script src="./assets/js/material-kit.min.js?v=3.0.2" type="text/javascript"></script>-->
  </body>
</html>