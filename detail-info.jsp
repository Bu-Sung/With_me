<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!--틀만 만들어둔 상태-->
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  
  <% String num = request.getParameter("num"); //메인에서 클릭이벤트로 넘어온 그룹 번호 값
    session.setAttribute("snum", num);  // 그룹번호 세션값에 저장

  %>
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
  
  <!--tmap.js 함수 사용-->
  <script language="JavaScript" src="tmap.js"></script>
  <!--tmap API 사용-->
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
  <script type="text/javascript">
    var map;
    var marker_s;
    var marker_e;
    var user;
    var start;
    var end;
    var day;
    var daytime;
    var price;
    var text;
    var join;
    var max;
    var drawInfoArr = [];
    var resultdrawArr = [];
    var markerArr_s = []; //출발지 검색된 값 
    var markerArr_e = []; //도착지 검색된 값 
    function initTmap() {
      <% 
        // taxi 테이블 정보가져오기
        // MySQL JDBC Driver Loading
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        PreparedStatement pstmt = null;
        ResultSet rs =null;

        try {
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        String dbUser ="taxi"; //mysql id
        String dbPass ="1234"; //mysql password

        String sql = "select * from taxi nature join member using(group_num) where group_num = ?";
        // Create DB Connection
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        // Create Statement
        pstmt = conn.prepareStatement(sql);

        //pstmt 생성
        pstmt.setString(1,num);

        // Run Qeury
        rs = pstmt.executeQuery();
        // Print Result (Run by Query)

          if(rs.next()){
      %>
            user = '<%= rs.getString("leader")%>';
            start = '<%= rs.getString("start")%>';
            end = '<%= rs.getString("end")%>';
            day = '<%= rs.getString("day")%>';
            daytime = '<%= rs.getString("daytime")%>';
            price = '<%= rs.getString("div_price")%>';
            text = '<%= rs.getString("detail")%>';
            join = '<%= rs.getString("people")%>';
            max = '<%= rs.getString("total_p")%>';
      <%
          }
        } catch(SQLException ex) {
          out.println(ex.getMessage());
          ex.printStackTrace();
        } finally {
        // Close Statement
          if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
          if (pstmt !=null) try { pstmt.close(); } catch(SQLException ex) {}
          // Close Connection
          if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
          }
      %>
      //기본 지도 설정
      map = new Tmapv2.Map("map", {
        center: new Tmapv2.LatLng(37.49241689559544, 127.03171389453507),
        width: "100%",
        height: "400px",
        zoom: 13,
        zoomControl: false,
        scrollwheel: true
      });
      resettingMap();
      //시작지점
      let [sx,sy] = toPoint(start);
      var s_m= new Tmapv2.LatLng(sy, sx);
      marker_s = new Tmapv2.Marker({
            position: s_m,
            icon: "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_s.png",
            iconSize: new Tmapv2.Size(24, 38),
            title: reverseGeo(sx, sy), //주소이름
            map: map
      });
      document.getElementById("start").value = start;// 시작 주소 검색을 상세하게 나타내기
      markerArr_s.push(marker_s); //마커를 누르면 상세 주소
      map.setCenter(s_m);
      
      //도착지
      let [ex,ey] = toPoint(end);
      var e_m =new Tmapv2.LatLng(ey, ex);
      marker_e = new Tmapv2.Marker({
            position: e_m,
            icon: "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_e.png",
            iconSize: new Tmapv2.Size(24, 38),
            title: reverseGeo(ex, ey), //주소이름
            map: map
        });
      document.getElementById("end").value = end;// 시작 주소 검색을 상세하게 나타내기
      markerArr_s.push(marker_s); //마커를 누르면 상세 주소
      
      //정보설정
      $('h3').text(user);
      document.getElementById("datePicker").value = day;
      document.getElementById("daytime").value = daytime;
      document.getElementById("price").value = price;
      document.getElementById("floatingTextarea2").value = text;
      var a = join+"/"+max;
      $('p').text(a);

      //경로 그리기
      $.ajax({
        type: "POST",
        url: "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result",
        async: false,
        data: {
            "appKey": "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
            "startX": sx,
            "startY": sy,
            "endX": ex,
            "endY": ey,
            "reqCoordType": "WGS84GEO",
            "resCoordType": "EPSG3857",
        },
        success: function (response) {

            var resultData = response.features;
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
      
    }
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
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuBlocks" href="reservation.jsp">
              <i class="material-icons opacity-6 me-2 text-md">view_day</i>
              예약내역
              <img class="arrow ms-2 d-lg-block d-none">
              <img class="arrow ms-2 d-lg-none d-block">
            </a>
          </li>
          <li class="nav-item dropdown dropdown-hover mx-2">
            <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="logout" href="sign-in.jsp">
              <i class="material-icons opacity-6 me-2 text-md">article</i>
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
                        출발지 <input class="form-control-plaintext border p-2 mt-1 mb-3" id="start" type="text" readonly>
                        도착지 <input class="form-control-plaintext border p-2 mt-1 mb-3" id="end"type="text" readonly>
                        <div class="row">
                          <div class="col-md-6">
                            날짜 <input type="text" id="datePicker" class="form-control-plaintext border p-2 mt-1 mb-3" readonly>
                          </div>
                          <div class="col-md-6">
                            시간 <input type="text" id="daytime" class="form-control-plaintext border p-2 mt-1 mb-3" readonly>
                          </div>
                        </div>
                        예상가격 (1인당) <input class="form-control-plaintext border p-2 mt-1 mb-3" id="price" type="text" readonly>
                        상세설명 <textarea class="form-control-plaintext border p-2 mt-1 mb-3" id="floatingTextarea2" style="height: 12rem; resize: none;" readonly></textarea>
                        <div class="d-flex justify-content-end mt-5">
                            <p class="pt-2" id="join">
                              
                            </p>
                            <button class="btn btn-primary col-lg-2 col-md-2 col-5 ms-3 fs-6" type="sumbit" id="join" formaction="enter.jsp">참가</button>
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