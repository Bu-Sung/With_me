<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="icon.png"rel="shortcut icon"type="image/x-icon"><!--아이콘-->
<%@page import ="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%  
    //mysql jdbc 드라이버 불러오기
    Class.forName("com.mysql.cj.jdbc.Driver");
    //db 연결역할
    Connection conn =null;
    //db 명령 전달 역할
    PreparedStatement pstmt =null;
    //select문 정보 저장 역할
    ResultSet rs =null;
    //입력받은 값 변수에 저장
    String uid = request.getParameter("id");
    String upw = request.getParameter("pw");

    session.setAttribute("sid", uid); // ID를 계속 사용하기 위해 session에 넣어준다.
    
    try {                    
        //jdbcDriver 주소 변수에 저장
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        //mysql 로그인 정보
        String dbUser ="taxi"; 
        String dbPass ="1234";
        
        //질의문 형태로 저장 
        String query ="select * from user where user_id=?";
        
        //해당 주소로 로그인해서 db연결
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        //sql 구문 전달해줄 Statement 생성
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1,uid);
        //select문 실행하여 rs에 값 저장
        rs = pstmt.executeQuery();
        
        if(rs.next()){ //입력받은 아이디와 db에 저장되어 있는 아이디 비교
                if(upw.equals(rs.getString("user_pw")) ==true){ //비밀번호 일치
                //로그인 성공시 main.html로 이동
                %>
                <script type="text/javascript">
                      location.href = "main.jsp";
                </script>
                <%
            } else{ //비밀번호 불일치
                session.setAttribute("error", "err");
                response.sendRedirect("sign-in.jsp");
            }
        } else{//db에 존재하지 않는 아이디의 경우
            session.setAttribute("error", "err");
            response.sendRedirect("sign-in.jsp");
        }
   
    } catch(SQLException ex) { //예외처리
        out.println(ex.getMessage());
        ex.printStackTrace();
    } finally { //ResultSet,connection, statement 반환
        if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
        if (pstmt !=null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
    }
%>