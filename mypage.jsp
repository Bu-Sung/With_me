<head>
    <!DOCTYPE html>
    <html lang="en">
    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <meta name="viewport" content="initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="mypage.css">
    <title>함께 갈래요</title>
</head>

<body>
    <div id="body"> 
    <h1>
        MYPAGE
        <hr width = "100%" color = "black" size = "3">  <!-- MYPAGE 밑 가로줄 -->
    </h1>


    <h3>
        <!-- 개인 정보 받아오기  -->
        이름 : <input type="text" name="name"><br> 
        전화번호 : <input type="text" name="phone"><br>
        <input type="submit" value="정보수정">  <!-- 정보수정 버튼  -->
        <!-- 서버 연결 아직 안함  -->
        <br><br>
        <br><br>
        사용내역
        <div style = "border: 1px solid black; padding: 10px;"> <!-- 사용내역 네모박스  -->
            <div style = "border: 1px dotted; border-radius: 5px; padding:10px;"> 사용내역 1 </div> <br>    <!-- 각 사용내역들 점선박스로 구분할 예정  -->
            <div style = "border: 1px dotted; border-radius: 5px; padding:10px;">사용내역 2 </div> <br> </div>
    </h3>
    </div>
</body>