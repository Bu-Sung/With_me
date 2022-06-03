<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
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
  <!--tmap.js 함수 사용-->
  <script language="JavaScript" src="tmap.js"></script>
  <!--tmap API 사용-->
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
  <script type="text/javascript">
    var x, y;
        function reload_list() { //주소값 검색을 위한 함수
          var search_s = $('#start').val(); //출발지
          var search_e = $('#end').val(); //도착지
          //출발지 검색하고 신주소로 출력
          $.ajax({
              method: "GET",
              url: "https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
              async: false,
              data: {
                  "appKey": "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
                  "searchKeyword": search_s,
                  "resCoordType": "EPSG3857",
                  "reqCoordType": "WGS84GEO",
                  "count": 1
              },
              success: function (response) {
                  var resultpoisData = response.searchPoiInfo.pois.poi;    
                  var noorLat = Number(resultpoisData[0].noorLat); // 좌표의 경도
                  var noorLon = Number(resultpoisData[0].noorLon); // 좌표의 위도
                  var pointCng = new Tmapv2.Point(noorLon, noorLat);
                  var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
                  var lat = projectionCng._lat; 
                  var lon = projectionCng._lng;
                  var name = reverseGeo(lon, lat); //새주소로 이름 변경
                  document.getElementById("start").value = name;// 검색된 내용으로 상세 표시 
              },
              error: function (request, status, error) {
                  console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
              }
          });
          //도착지 검색하고 신주소로 출력
          $.ajax({
              method: "GET",
              url: "https://apis.openapi.sk.com/tmap/pois?version=1&format=json&callback=result",
              async: false,
              data: {
                  "appKey": "l7xx34fbc458caac49f6b3fd63b8e1dcadd5",
                  "searchKeyword": search_e,
                  "resCoordType": "EPSG3857",
                  "reqCoordType": "WGS84GEO",
                  "count": 1
              },
              success: function (response) {
                  var resultpoisData = response.searchPoiInfo.pois.poi;    
                  var noorLat = Number(resultpoisData[0].noorLat); // 좌표의 경도
                  var noorLon = Number(resultpoisData[0].noorLon); // 좌표의 위도
                  var pointCng = new Tmapv2.Point(noorLon, noorLat);
                  var projectionCng = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(pointCng);
                  var lat = projectionCng._lat; 
                  var lon = projectionCng._lng;
                  var name = reverseGeo(lon, lat); //새주소로 이름 변경
                  document.getElementById("end").value = name;// 검색된 내용으로 상세 표시 
              },
              error: function (request, status, error) {
                  console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
              }
          });

          $("#list > tr").remove();
          var list=null;
          <%
          Class.forName("com.mysql.cj.jdbc.Driver"); 
          Connection conn =null;
          PreparedStatement pstmt =null;
          ResultSet rs =null;
          try {
                                  
              String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
              String dbUser ="taxi"; //mysql id
              String dbPass ="1234"; //mysql password
              String query ="select * from taxi"; //query
              
              // Create DB Connection
              conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
              // Create Statement
              pstmt = conn.prepareStatement(query);
              
              // Run Qeury
              rs = pstmt.executeQuery();
              // Print Result (Run by Query)
              while(rs.next()) {
          %>
                  
                  list = '<tr style="cursor:pointer;"><td><%= rs.getString("group_num")%></td><td><%= rs.getString("day")%><br><%= rs.getString("daytime")%></td></td><td><%= rs.getString("start")%></td><td><%= rs.getString("end")%></tr>';
                  $("#list").append(list);
          
          <%
              }
          } catch(SQLException ex) {
              out.println(ex.getMessage());
              ex.printStackTrace();
          } finally {
              if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
              if (pstmt !=null) try { pstmt.close(); } catch(SQLException ex) {}
              if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
          }
          %>

          $('#list tr').click( function(){
              var data = $(this).children();
              location.replace("detail-info.jsp?num="+data.eq(0).text());
              
          })
        }     

        //초기 로딩 시 
    </script>
</head>

<body class="main bg-gray-200" >
  <!-- Navbar -->
  <div class="container position-sticky z-index-sticky top-0">
    <div class="row">
      <div class="col-12">
        <nav class="navbar navbar-expand-lg  blur border-radius-xl top-0 z-index-fixed shadow position-absolute my-3 py-2 start-0 end-0 mx-4">
          <div class="container-fluid px-0">
            <a class="navbar-brand font-weight-bolder ms-sm-3" href="main.jsp" data-placement="bottom">
              함께 갈래요?
            </a>
            <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon mt-2">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
              </span>
            </button>
            <div class="collapse navbar-collapse pt-3 pb-2 py-lg-0 w-100" id="navigation">
              <ul class="navbar-nav navbar-nav-hover ms-auto">
                <li class="nav-item dropdown dropdown-hover mx-2">
                  <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="myPage" href="myPage.jsp">
                    <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
                    마이페이지
                    <img class="arrow ms-auto ms-md-2 d-lg-block d-none">
                    <img class="arrow ms-auto ms-md-2 d-lg-none d-block">
                  </a>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                  <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="reservation" href="reservation.html">
                    <i class="material-icons opacity-6 me-2 text-md">view_day</i>
                    예약내역
                    <img class="arrow ms-auto ms-md-2 d-lg-block d-none">
                    <img class="arrow ms-auto ms-md-2 d-lg-none d-block">
                  </a>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                  <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="logout" href="sign-in.jsp">
                    <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
                    로그아웃
                    <img class="arrow ms-auto ms-md-2 d-lg-block d-none">
                    <img class="arrow ms-auto ms-md-2 d-lg-none d-block">
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
        <!-- End Navbar -->
      </div>
    </div>
  </div>
  <header class="header-2">
    <div class="page-header min-vh-75 relative" style="background-image: url('https://c.pxhere.com/photos/14/86/architecture_buildings_bus_business_cars_city_cityscape_clouds-1495895.jpg!d')">
      <span class="mask bg-gradient-dark opacity-4"></span>
      <div class="container">
        <div class="row">
          <div class="col-lg-7 text-center mx-auto">
            <h1 class="text-white pt-3 mt-n5">With me</h1>
            <p class="lead text-white mt-3">함께 택시탈 사람을 구해보세요! </p>
          </div>
        </div>
      </div>
    </div>
    
  </header>
  <!--카드 부분(둥근 네모 영역)-->
  <div class="card card-body blur shadow-blur mx-3 mx-md-4 mt-n6">
    <section class="my-5 py-5">
      <div class="container">
        <div class="row">
          <div class="row justify-content-center text-center my-sm-5">
            <div class="col-lg-6">
              <span class="badge bg-primary mb-3">Find someone to ride with</span>
              <h2 class="text-dark mb-4">위치 기반 택시 쉐어</h2>
              <img src="./assets/image/taxiShare.png" width=180rem class="mb-4">
              <p class="lead">현재 위치를 입력하여 근처에서 택시를 함께 탈 사람을 찾거나, 직접 글을 올려 함께 탈 사람을 찾아보세요. </p>
            </div>

          </div>
          </div>
        
        </div>
        <form class="position-relative px-md-2 px-sm-5 mx-auto">
          <div class="d-flex justify-content-center align-items-center mb-2">
            <div class="col-lg-6">

              <input class="form-control me-2 border p-2 m-2" id="start" type="search" placeholder="출발지" aria-label="Search">
              <input class="form-control me-2 border p-2 m-2" id="end" type="search" placeholder="도착지" aria-label="Search">
            </div>
            <button class="btn btn-outline-success my-1 p-4 ms-4 fs-6" type="button" id="input" onclick="reload_list();">조회</button>
          </div>
        </form>
          <div  class="row justify-content-center text-center my-sm-5" >
            <div id="guide"></div>
        </div>
            
        <div class="col-lg-7 col-md-7 position-relative px-md-2 px-sm-5 mx-auto">
          <form class="d-flex justify-content-reverse align-items-center mt-4">
              <div class="ms-auto text-center">
                <button class="btn btn-outline-success fs-6" type="button" onClick="location.href='registration.jsp'">등록</button>
              </div>
          </form>
            <!--구인 글 목록-->
            <!--table 동적으로 -->
            <!--부트스트랩 동적 테이블 검색해서 사용-->
            <table class="table" id="list">
              <thead class="table-light">
                <tr>
                  <th scope="col" style="text-align: center;" >번호</th>
                  <th scope="col" style="width: 15%;">시간</th>
                  <th scope="col" style="width: 35%;" >출발지</th>
                  <th scope="col" style="width: 35%;">도착지</th>
                </tr>
              </thead>
              
            </table>
        </div>
        </div>
        </div>
      </div>
    </section>
    <section class="py-8">
      <div class="container">
        <div class="row">
          <div class="col-11 mx-auto">
            <div class="text-center">
              <h4 class="mt-5 mb-4 color=d3d3d3">마음에 드는 글을 찾지 못했다면 직접 글을 작성해보세요!✏️</h4>
            </div>
          </div>
        </div>
      </div>
    </section>
  <!--   Core JS Files   -->
  <script src="./assets/js/core/popper.min.js" type="text/javascript"></script>
  <script src="./assets/js/core/bootstrap.min.js" type="text/javascript"></script>
  <script src="./assets/js/plugins/perfect-scrollbar.min.js"></script>
  <!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
  <script src="./assets/js/plugins/parallax.min.js"></script>
  <!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
  <!--  Google Maps Plugin    -->
  <!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
  <script src="./assets/js/material-kit.min.js?v=3.0.2" type="text/javascript"></script>-->

</body>

</html>