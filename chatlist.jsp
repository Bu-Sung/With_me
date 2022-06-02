<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html>
    <head>
        <meta charset="UTF-8"> <!--한글 깨짐 UTF-8형식으로 인코딩으로 개선-->
        <title>함께 갈래요?</title> <!--탭 제목-->
        <link rel="shortcut icon" type = "shortcut icon" href="./assets/image/taxi.jpg">
        <link rel="stylesheet" type="text/css" href="chatlist.css" />
    </head>
    <body>
        
        
        <%

        response.setContentType("text/html; charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");

        String htmlchatname = request.getParameter("attend");

        String sql = "INSERT INTO chat(group_num) VALUES(?)";
        
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;
        
        try {

            String jdbcDriver ="jdbc:mysql://49.50.166.159:3306/taxi?serverTimezone=UTC"; 
            String dbUser ="tester"; //mysql id
            String dbPass ="1234"; //mysql password
            String query ="select distinct group_num from chat"; //query
            // Create DB Connection
            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            // Create Statement
            stmt = conn.createStatement();

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, htmlchatname);
            pstmt.executeUpdate();
            
            rs = stmt.executeQuery(query);
        %>
        <div class="head">
            헤드라인
        </div>
            
        <div class="chatlisttop" >
            채팅방 목록
        </div>
            <%
            while(rs.next()) {
                String tmp = rs.getString("group_num");
            %>
            
            <div class="chatlist" onclick="location.href='chat.jsp?chatroomname=<%=tmp%>'" >
                <%
                    out.println(rs.getString("group_num"));
                %>
                    </div>

        <%
            }
        } 
        catch(SQLException ex) {
            out.println(ex.getMessage());
            ex.printStackTrace();
        } finally {
            // Close Statement
            if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
            if (stmt !=null) try { stmt.close(); } catch(SQLException ex) {}
            
            // Close Connection
            if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
        }
        %>
        
    </body>
</html>