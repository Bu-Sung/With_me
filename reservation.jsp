<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import ="java.sql.*" %>

    

    <!--틀만 만들어둔 상태-->
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="./assets/image/icon.png">
  <title>
    함께 갈래요? - 예약내역
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

<body class="reservation bg-gray-200">
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
            <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuPages8" href="sign-in.jsp">
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
    <div class="page-header min-height-400" style="background-image: url('./assets/image/road.jpg');" loading="lazy">
      <span class="mask bg-gradient-dark opacity-6"></span>
    </div>
  </header>

  
  
  <!-- -------- END HEADER 4 w/ search book a ticket form ------- -->
  <div class="card card-body shadow-blur mx-3 mx-md-4 mt-n6 mb-4">
    <!-- START Testimonials w/ user image & text & info -->
    <section class="py-sm-7 py-5 position-relative">
        <div class="row">
          <div class="col-12 mx-auto">
            <div class="col-lg-9 col-md-9 mt-4 z-index-2 position-relative px-md-2 px-sm-5 mx-auto">
                <h2 class="mb-1" >Reservation List
                <svg xmlns="http://www.w3.org/2000/svg" width="3rem" height="3rem" fill="currentColor" class="bi bi-list-ul" viewBox="0 0 16 16">
                  <path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm-3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
                </svg>

              </h2>
              <!--구분선-->
              <hr width="100%" color="#B2B2B2" noshade />
              </div>
            </div>
            <div class="col-lg-8 col-md-8 position-relative px-md-2 px-sm-5 mx-auto py-5">
              <div class="d-flex justify-content-reverse align-items-center mt-4">
              <table class="table ">
                <thead class="table-light">
                  <tr>
                    <th scope="col">번호</th>
                    <th scope="col">날짜</th>
                    <th scope="col">출발지</th>
                    <th scope="col">도착지</th>
                    <th scope="col">예상 가격</th>
                  </tr>
                </thead>
                <tbody>
                  <% // MySQL JDBC Driver Loading
                  Class.forName("com.mysql.cj.jdbc.Driver"); 
                  Connection conn =null;
                  PreparedStatement pstmt = null;
                  ResultSet rs =null;
    
                  String uid = session.getAttribute("sid").toString();
                  String start = null;
                  String end = null;
                  String price = null;
                  short completion = 0;

                    try {
                    String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
                    String dbUser ="taxi"; //mysql id
                    String dbPass ="1234"; //mysql password
                        
                    String sql = "select * from taxi  where group_num in ( select member.group_num from member where member.leader = ? or member.one =? or member.two =?  or member.three =?  )";
    
                    // Create DB Connection
                    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                    // Create Statement
                    pstmt = conn.prepareStatement(sql);
                        
                    //pstmt 생성
                    pstmt.setString(1,uid);
                    pstmt.setString(2,uid);
                    pstmt.setString(3,uid);
                    pstmt.setString(4,uid);
                        
                    // Run Qeury
                    rs = pstmt.executeQuery();
                    // Print Result (Run by Query)
                        
                    while(rs.next()) {

                      // completion이 0인것만 테이블에 출력
                      // 즉, 탑승이 완료되지 않은 그룹만 출력 
                      if(rs.getInt("completion") == 0 ) {
                         
                        %>  
                        <tr onClick="location.href='#'" style="cursor:pointer;">
                        <td scope="row">  <% out.println(rs.getString("group_num")); %></td>
                        <td >  <% out.println(rs.getString("day")+"\n"+rs.getString("daytime")); %></td>
                        <td > <% out.println(rs.getString("start")); %></td>
                        <td> <% out.println(rs.getString("end")); %> </td>
                        <td><% out.println(rs.getString("div_price")); %>￦</td>
                        </tr>
                        <%
                      }

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