<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="mypackage.ConnectionPooltaxi" %>
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

        String sql = "INSERT INTO grouptaxi(group_num) VALUES(?)";
        
        
        Connection conn =null;
        Statement stmt =null;
        ResultSet rs =null;
        
        try {

            
            String query ="select group_num from grouptaxi"; //query
            // Create DB Connection
            conn = ConnectionPooltaxi.get();
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