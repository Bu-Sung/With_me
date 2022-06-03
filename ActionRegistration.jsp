<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<link href="icon.png"rel="shortcut icon"type="image/x-icon"><!--아이콘-->
<%@page import ="java.sql.*"%>
<%  
    //mysql jdbc 드라이버 불러오기
    Class.forName("com.mysql.cj.jdbc.Driver");
    //db 연결역할
    Connection conn =null;
    //db 명령 전달 역할
    PreparedStatement pstmt =null;
    
    try{
    //값 변수에 저장
    int group_num = ((int) (Math.random() * (9999-1001)) + 1000); //그룹 번호
    String ugroup_num = Integer.toString(group_num);
    String ustart = request.getParameter("start"); //출발지
    String uend = request.getParameter("end"); //도착지
    String udate = request.getParameter("date"); //날짜
    String utime = request.getParameter("time"); //시간
    String people = request.getParameter("wr_1"); //인원수
    int upeople = Integer.parseInt(people);
    String price = request.getParameter("price"); //인당 가격
    int uprice = Integer.parseInt(price);
    int utotal_price = uprice * upeople; //총 가격
    String utext =request.getParameter("text"); //상세설명
    int ucompletion = 0;
    
    //jdbc 주소 저장
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        // mysql 로그인 정보
        String dbUser ="taxi";
        String dbPass ="1234";
        
        //질의문 형태로 저장
        String sql ="INSERT INTO taxi(group_num, start, end, day, daytime, people, price, div_price, detail, completion) values(?,?,?,?,?,?,?,?,?,?)";
        
        //db 연결
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        
        //sql 구문을 전달해줄 Statement 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1,ugroup_num);
        pstmt.setString(2,ustart);
        pstmt.setString(3,uend);
        pstmt.setString(4,udate);
        pstmt.setString(5,utime);
        pstmt.setInt(6,upeople);
        pstmt.setInt(7,utotal_price);
        pstmt.setInt(8,uprice);
        pstmt.setString(9,utext);
        pstmt.setInt(10,ucompletion);

        //db에 정보 저장
        pstmt.executeUpdate();
        
        response.sendRedirect("main.jsp");

    }catch(SQLException ex) { //예외처리
        out.println(ex.getMessage());
        ex.printStackTrace();
    } finally { //connection, statement 반환
        if (pstmt !=null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
    }
%>