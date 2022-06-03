<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="java.sql.*" %>

<% // MySQL JDBC Driver Loading
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    Connection conn =null;
    PreparedStatement pstmt = null;
    ResultSet rs =null;
    
    String uid = session.getAttribute("sid").toString();
    String user_id = null;
    String user_pw = null;
    String user_name = null;
    String user_phone = null;
    try {
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        String dbUser ="taxi"; //mysql id
        String dbPass ="1234"; //mysql password
                        
        String sql = "select * from user where user_id = ?";
    
        // Create DB Connection
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        // Create Statement
        pstmt = conn.prepareStatement(sql);
                        
        //pstmt 생성
        pstmt.setString(1,uid);
                        
        // Run Qeury
        rs = pstmt.executeQuery();
        // Print Result (Run by Query)
                        
        if(rs.next()) {
            user_id = rs.getString("user_id");
            user_pw = rs.getString("user_pw");
            user_name = rs.getString("user_name");
            user_phone = rs.getString("user_phone");
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

<!--틀만 만들어둔 상태-->
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/image/icon.png">
  <title>
    함께 갈래요? - 마이페이지
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
</head>

<body class="myPage bg-gray-200">

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
    <div class="page-header min-height-400" style="background-image: url('./assets/image/city-profile.jpg');" loading="lazy">
      <span class="mask bg-gradient-dark opacity-7"></span>
    </div>
  </header>


  <!-- -------- END HEADER 4 w/ search book a ticket form ------- -->
  <div class="card card-body shadow-blur mx-3 mx-md-4 mt-n6 mb-4">
    <!-- START Testimonials w/ user image & text & info -->
    <section class="py-sm-7 py-5 position-relative">
        <div class="row">
          <div class="col-12 mx-auto">
            <div class="col-lg-9 col-md-9 mt-4 z-index-2 position-relative px-md-2 px-sm-5 mx-auto">
                <h2 class="mb-1" >My Page
                <svg xmlns="http://www.w3.org/2000/svg" width="3rem" height="3rem" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
                  <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
                </svg>
              </h2>
              <!--사용자명 윗 구분선-->
              <hr width="100%" color="#B2B2B2" noshade />
              </div>
            </div>
                <div class="col-md-8 m-auto d-flex justify-content-between align-items-center mb-2">
                  <!--사용자명 가져오기-->
                  <h3 class="mb-0" id="user_name">
                    <%= user_name%>
                  </h3>
                  <!-- Button trigger modal -->
                  <button type="button" class="btn btn-primary mt-3 fs-6 " onclick="location.href='update.jsp'">
                    정보 수정
                  </button>
                </div>
                <p class="text-lg mb-0 col-md-8 m-auto" id="phone_number">
                  <!--전화번호 입력-->
                  전화번호: <%= user_phone%>
                </p>
              </div>
            <div class="row py-5 mt-6">
              <div class="col-lg-8 col-md-8 z-index-2 position-relative px-md-2 px-sm-5 mx-auto">
                <!--사용 테이블 임시-->
                <!--사용 테이블 동적으로 받아와서 늘려줘야 함-->
                <h3>사용 내역 조회</h3>
                <table class="table">
                  <thead class="table-light">
                    <tr>
                      <th scope="col">출발지</th>
                      <th scope="col">도착지</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr onClick="location.href='#'" style="cursor:pointer;">
                      <td scope="row">부산시 부산진구 가야동</td>
                      <td>동의대학교 정보공학관</td>
                    </tr>
                    <tr onClick="location.href='#'" style="cursor:pointer;">
                      <td scope="row">출발지1</td>
                      <td>도착지1</td>
                    </tr>
                    <tr onClick="location.href='#'" style="cursor:pointer;">
                      <td scope="row">출발지2</td>
                      <td>도착지2</td>
                    </tr>
                  </tbody>
                </table>
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
  <!--  Google Maps Plugin    -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
  <script src="./assets/js/material-kit.min.js?v=3.0.2" type="text/javascript"></script>
  </body>
</html>