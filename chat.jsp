<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="mypackage.ChatDAO" %>
<%@ page import="mypackage.ConnectionPoolwith_me" %>
<%@ page import="mypackage.ChatObj" %>


<%
    response.setContentType("text/html; charset=utf-8"); 
    response.setCharacterEncoding("utf-8");
    request.setCharacterEncoding("utf-8");

    String uid = session.getAttribute("sid").toString();
    session.setAttribute("sid", uid);
    String chatroomname = request.getParameter("chatroomname");
    String chatting = request.getParameter("chatting");
    if(request.getParameter("chatting") == null){
      chatting = "hello";
    }
    ChatDAO dao = new ChatDAO();
    ArrayList<ChatObj> chats = dao.getList(chatroomname);
    
  %>
<!--틀만 만들어둔 상태-->
<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/WebPage">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="icon" href="./assets/image/icon.png">
  <title>함께 갈래요? - 채팅</title>

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
  <!--js-->
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx34fbc458caac49f6b3fd63b8e1dcadd5"></script>
  <script type="text/javascript">
      function completion(){ // 탑승 완료시 처리
        var num = $('h5').html();
        location.href = "completion.jsp?num="+num;
      }
  </script>
  <script type="text/javascript">

    function notify() {
        var chatname = document.getElementsByName('chatroomname')[0].value;
        var message = document.getElementsByName('chatting')[0].value;
        if (Notification.permission == 'default') {
            alert('알림 설정을 허용해 주세요 좌측 상단에 있습니다.');
            Notification.requestPermission();
            alert('3초 뒤에 알림이 닫히고 알림을 누르면 메인 페이지로 이동 가능합니다');
        }
        else if(message != null && message != ""){

            var notification = new Notification( chatname, {
                icon: './assets/image/taxi.jpg',
                body: message,
            });
        }
        setTimeout(function(){
          notification.close(); }, 3000);
    }
    </script>
    <script type="text/javascript">
      window.setTimeout('window.location.reload()',10000);
      //10초마다 리플리쉬 시킨다 1000이 1초가 된다.
    </script> 
    
    
</head>
<body class="chat">
  
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
                  <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="dropdownMenuPages" href="myPage.jsp">
                    <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
                    마이페이지
                    <img class="arrow ms-auto ms-md-2 d-lg-block d-none">
                    <img class="arrow ms-auto ms-md-2 d-lg-none d-block">
                  </a>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                  <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="dropdownMenuBlocks" href="reservation.jsp">
                    <i class="material-icons opacity-6 me-2 text-md">view_day</i>
                    예약내역
                    <img class="arrow ms-auto ms-md-2 d-lg-block d-none">
                    <img class="arrow ms-auto ms-md-2 d-lg-none d-block">
                  </a>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                  <a class="nav-link ps-2 d-flex cursor-pointer align-items-center" id="logout"href="sign-in.jsp">
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
      </div>
    </div>
  </div>
  <!-- End Navbar -->
  <div class="page-header align-items-start min-vh-100" style="background-image: url('https://media.triple.guide/triple-cms/c_limit,f_auto,h_1024,w_1024/02c6a702-d8fb-442a-906f-331b359d54f9.jpeg');" loading="lazy">
    <span class="mask bg-gradient-dark opacity-6"></span>
    <div class="container my-auto">
      <div class="row">
        <div class="col-lg-10 col-md-10 col-12 mx-auto">
          <div class="card mt-7 position-relative">
            <h5 class="card-header col-12 bg-light position-absolute" id="number">
              <% 
                if(chatroomname != null)
                  out.print(chatroomname);
                else
                  out.print("제목 없음");
              %>
            </h5>
            <div class="d-flex justify-content-end">
              <div class="dropdown">
                <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" style="height: 4.7rem;" data-bs-toggle="dropdown" aria-expanded="false">
                  menu
                </button>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                  <li><button class="dropdown-item" type="button" onclick="completion();">그룹 번호</a></li>
                </ul>
              </div>
            </div>
            <div class="card-body">
              
              <!--일정 크기 이상되면 스크롤바 생기도록 설정-->
              <!--채팅 가져올 때, 스크롤바 아래로 가도록 설정해야함-->
              <div class="scroll mb-4" style="height: 20rem; overflow: scroll;">
                <%
                        
                for(ChatObj ch: chats) {
                %>
                    <%
                    String user = ch.getSender();
                    String message = ch.getMessage();

                    if(user.equals(uid)){
                    %>
                  <p style="text-align:right;" > 
                  <% }
                    else
                    {
                    %><p style="text-align:left;" > 
                  
                    <%} out.print(user); %> <br>
                    <% out.print(message); %> <br>
                    <% out.print(ch.getTime()); %> </p>
                  <%
                    
                  }
                  
                  %>
              </div>
              <form action="returnchat.jsp" method="post" >       
                <input type="hidden" name="chatroomname" value=<%=chatroomname%> >
              <div class="d-flex justify-content-end">
                <textarea class="form-control border p-2 me-2" style="height:3rem; resize: none;" placeholder="메시지를 입력하세요." name="chatting" required></textarea>
                
                <button type="submit" onclick="notify()" class="btn btn-primary" style="height:3rem; width:5rem;">전송</button>
                
              </form>  
              </div>
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