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
    var slist = new Array(); //예약 리스트
    var x,y,x1,y1,x2,y2;
      //초기 위치/리스트 출발지 좌표/ 리스트 도착지 좌표  
    function getDistanceFromLatLonInKm(lat1,lng1,lat2,lng2) { //거리구하기 함수
      function deg2rad(deg) {
          return deg * (Math.PI/180)
      }
      var R = 6371; // Radius of the earth in km
      var dLat = deg2rad(lat2-lat1);  // deg2rad below
      var dLon = deg2rad(lng2-lng1);
      var a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
      var d = R * c; // Distance in km
      return d;
    }
    var taxi = function(num, day, daytime, start,end){ //예약 객체
      this.num = num; 
      this.day = day;
      this.daytime = daytime;
      this.start = start;
      this.end = end;
    }         
    //현재 시간 받기
    var now = new Date();
    var year = now.getFullYear();
    var month = ('0'+(now.getMonth()+1)).slice(-2);
    var day = ('0' + now.getDate()).slice(-2);
    var hours = ('0' + now.getHours()).slice(-2);
    var minutes = ('0' + now.getMinutes()).slice(-2);
    var seconds = ('0' + now.getSeconds()).slice(-2);
    var dateS = dateString = year + '-' + month  + '-' + day;
    var timeS = hours + ':' + minutes  + ':' + seconds;
    var nowTime = new Date(dateS+" "+timeS);

    function insert_list(){ //DB에 예약리스트 저장
      <%
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        PreparedStatement pstmt =null;
        ResultSet rs =null;
        try {
                                
          String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
          String dbUser ="taxi"; //mysql id
          String dbPass ="1234"; //mysql password
          String getUser = "select * from user where user_id= ?";
          String query ="select * from taxi"; //query
          

          // Create DB Connection
          conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
          //유저 초기 좌표 정보를 얻기 위해 실행
          pstmt = conn.prepareStatement(getUser);
          pstmt.setString(1,(String)session.getAttribute("sid"));
          rs = pstmt.executeQuery();
          if(rs.next()){
      %>
          [x,y] = toPoint('<%= rs.getString("address")%>');
      <%
          }
          
          // 택시 목록 받기
          pstmt = conn.prepareStatement(query);
          rs = pstmt.executeQuery();
          while(rs.next()) {
          
      %>    
            
            var taxiTime = new Date('<%= rs.getString("day")%> <%= rs.getString("daytime")%>');
            
            if(!<%=rs.getShort("completion")%> && !nowTime<=taxiTime ){
              slist.push(new taxi('<%= rs.getString("group_num")%>','<%= rs.getString("day")%>','<%= rs.getString("daytime")%>','<%= rs.getString("start")%>','<%= rs.getString("end")%>'));
            }
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
    }
    
    function onlist() { //초기 로딩 시
      var table_list;
      //사용자 초기위치 값에 대한 초기 목록
      $("#list > tr").remove(); //리스트 지우기
      insert_list(); //리스트에 저장  
      
      for (var i = 0; i < slist.length; i++){
        let [sx,sy]=toPoint(slist[i].start);
        if( getDistanceFromLatLonInKm(x,y,sx,sy)<=0.5){ //반경 50M
            table_list = '<tr style="cursor:pointer;"><td>'+slist[i].num+'</td><td>'+slist[i].day+'<br>'+slist[i].daytime+'</td><td>'+slist[i].start+'</td><td>'+slist[i].end+'</tr>';
            $('#list').append(table_list);
        }else{
            console.log(getDistanceFromLatLonInKm(x,y,sx,sy));
        }
      }  
      $('#list tr').click( function(){
          var data = $(this).children();
          location.replace("detail-info.jsp?num="+data.eq(0).text());
          
      })
    }   

    function reload_list(){ //원하는 위치 검색 받아서 검색
       //도착지
      //출발지 검색하고 신주소로 출력
      [x1, y1] = toPoint($('#start').val());
      document.getElementById("start").value = reverseGeo(x1, y1);
      //도착지 검색하고 신주소로 출력
      [x2, y2] = toPoint($('#end').val());
      document.getElementById("end").value = reverseGeo(x2, y2);
      var table_list;
      $("#list > tr").remove();
      for (var i = 0; i < slist.length; i++){
        let [sx,sy]=toPoint(slist[i].start);
        let [ex,ey]=toPoint(slist[i].end);
        
        if( getDistanceFromLatLonInKm(x1,y1,sx,sy)<=0.5 && getDistanceFromLatLonInKm(x2,y2,ex,ey)<=0.5 ){
            table_list = '<tr style="cursor:pointer;"><td>'+slist[i].num+'</td><td>'+slist[i].day+'<br>'+slist[i].daytime+'</td><td>'+slist[i].start+'</td><td>'+slist[i].end+'</tr>';
            console.log(table_list);
            $('#list').append(table_list);
        }else{
            console.log("false");
        }
      }
      $('#list tr').click( function(){
          var data = $(this).children();
          location.replace("detail-info.jsp?num="+data.eq(0).text());
          
      })
    }
    </script>
</head>

<body onload="onlist();" class="main bg-gray-200" >
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
                    <i class="material-icons opacity-6 me-2 text-md">article</i>
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
            <button class="btn btn-outline-success my-1 p-4 ms-4 fs-6" type="button" onclick="reload_list();">조회</button>
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
                  <th scope="col" style="width: 37%;" >출발지</th>
                  <th scope="col" style="width: 37%;">도착지</th>
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