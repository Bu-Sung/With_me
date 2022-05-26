<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.lang.String.*" %>

<html>
    <head>
        <meta charset="UTF-8"> <!--한글 깨짐 UTF-8형식으로 인코딩으로 개선-->
        <title>함께 갈래요?</title> <!--탭 제목-->
        <link rel="shortcut icon" type = "shortcut icon" href="taxi.jpg">
        <link rel="stylesheet" type="text/css" href="chatlist.css" />
    </head>
    <body>
        
        
        <%

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String htmlchatname = request.getParameter("attend");
        String ALLchatname ="";
        int dbcount = 0;
        String special ="[.]";

        String sql = "INSERT INTO chatlist(list) VALUES(?)";
        %>

        <% // MySQL JDBC Driver Loading
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;
        
                                
            String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
            String dbUser ="ansb"; //mysql id
            String dbPass ="1234"; //mysql password
            String query ="select * from chatlist"; //query
            // Create DB Connection
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            // Create Statement
            stmt = conn.createStatement();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, htmlchatname);
            pstmt.executeUpdate();
            
            // Run Qeury
            rs = stmt.executeQuery(query);
            // Print Result (Run by Query)
            while(rs.next()) {
            %>

            <%
            dbcount++;
            ALLchatname += rs.getString("list") + ".";
            %>
        
        <%
            }
            
        %>

        <%
        String[] chatlistname = ALLchatname.split(special);
        %>
        
        <div class="head">
            헤드라인
        </div>
            
        <div class="chatlisttop" >
            채팅방 목록
        </div>

        <%
        for(int i=0;i<dbcount;i++){ 
        %>
            <div class="chatlist">
        <%
            String a ="hi";
            out.println(chatlistname[i]);
        %>
            </div>
        <%
        }

        rs.close();
        stmt.close();
        pstmt.close();
        conn.close();
        %>
        
    </body>
</html>