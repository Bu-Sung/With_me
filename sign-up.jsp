<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="icon" href="./assets/image/icon.png">
  <title>함께 갈래요? - 회원가입</title>

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

  <%
    String id_error=(String)session.getAttribute("id_error");
    if (id_error==null) id_error="";
  %>

  <%
    String pw_error=(String)session.getAttribute("pw_error");
    if (pw_error==null) pw_error="";
  %>

  <% session.invalidate(); %>
  <!--세션 제거-->

</head>

<body class="sign-in-basic">
  
  <nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent ">
    <div class="container">
      <a class="navbar-brand  text-white " href="sign-in.jsp" data-placement="bottom">
        함께 갈래요?
      </a>
    </div>
  </nav>
  <!-- End Navbar -->
  <div class="page-header align-items-start min-vh-100" style="background-image: url('https://cdn.pixabay.com/photo/2018/09/14/10/38/taxi-3676711_960_720.jpg');" loading="lazy">
    <span class="mask bg-gradient-dark opacity-6"></span>
    <div class="container my-auto">
      <div class="row">
        <div class="col-lg-4 col-md-8 col-12 mx-auto">
          <div class="card z-index-0 fadeIn3 fadeInBottom">
            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
              <div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
                <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">Sign up</h4>
              </div>
            </div>

            <div class="card-body">
              <form action="signUp.jsp" method="Get" role="form" class="text-start">
                <div class="input-group input-group-outline mt-3">
                  <label class="form-label">Id</label>
                  <input type="text" name="id" class="form-control" required>
                </div>
                <!--에러메시지 출력-->
                <div class="mb-3" id="id_error" style="color:#e91e63"><%=id_error%></div>
                <div class="input-group input-group-outline mb-3">
                  <label class="form-label">Password</label>
                  <input type="password" name="pw" class="form-control" required>
                </div>
                <div class="input-group input-group-outline">
                  <label class="form-label">Password agin</label>
                  <input type="password" name="pw2" class="form-control" required>
                </div>
                <!--에러메시지 출력-->
                <div class="mb-3" id="pw_error" style="color:#e91e63"><%=pw_error%></div>

                <div class="input-group input-group-outline mb-3">
                  <label class="form-label">Name</label>
                  <input type="text" name="name" class="form-control" required>
                </div>
                <div class="input-group input-group-outline mb-3">
                  <label class="form-label">Phone Number</label>
                  <input type="text" name="phoneNum" class="form-control" required>
                </div>
                <div class="text-center">
                  <button type="submit" class="btn bg-gradient-primary w-100 my-4 mb-2">Sign up</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    
  </div>
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