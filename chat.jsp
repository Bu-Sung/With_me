<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

        <%
        response.setContentType("text/html; charset=utf-8"); 
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");

        String tmp = request.getParameter("chatroomname");
        String chat = request.getParameter("chatting");
        
        String sql = "INSERT INTO chat(group_num, user_name, message) VALUES(?,?,?)";
        %>
<html>
    <head>
        <meta charset="UTF-8"> <!--한글 깨짐 UTF-8형식으로 인코딩으로 개선-->
        <title>함께 갈래요?</title> <!--탭 제목-->
        <link rel="shortcut icon" type = "shortcut icon" href="./assets/image/taxi.jpg">
        <link rel="stylesheet" type="text/css" href="chatlist.css" />
        <script type="text/javascript">
            window.onload = function () {
                if (window.Notification) {
                    Notification.requestPermission();
                }
                notify();
            }
            
            function calculate() {
                    notify();
            }
            function notify() {
                var chatname = document.getElementsByName('chatroomname')[0].value;
                var message = document.getElementsByName('chat')[0].value;
                if (Notification.permission !== 'granted') {
                    alert('notification is disabled');
                }
                else if(message != null && message != ""){
                    var notification = new Notification( chatname, {
                        icon: './assets/image/taxi.jpg',
                        body: message,
                    });
     
                    notification.onclick = function () {
                        window.open('chat.jsp');
                    };
                }
            }
        </script>
    </head>
    <body>
        
        <div class="head">
            헤드라인 채팅방 
        </div>

        <div class="chatlisttop" >
            <% 
            if(tmp != null)
            out.print(tmp);
            else
            out.print("제목 없음");
            %>
            </div>

        <% 
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn =null;
        ResultSet rs =null;
        Statement stmt = null; 
        
        try {
            String jdbcDriver ="jdbc:mysql://49.50.166.159:3306/taxi?serverTimezone=UTC"; 
            String dbUser ="tester";
            String dbPass ="1234";
            String query ="select * from chat";

            conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
            stmt = conn.createStatement();

            
            PreparedStatement pstmt = conn.prepareStatement(sql);

           
                if (chat != null){
                    pstmt.setString(1, "groupnumber");
                    pstmt.setString(2, "송신자");
                    pstmt.setString(3, chat);
                    pstmt.executeUpdate();
                    }
            
            

            rs = stmt.executeQuery(query);
            while(rs.next()) {
                String user = rs.getString("user_name");
                String message = rs.getString("message");
        %>
            
        <div class="chatsender";>
            <%
                out.println(rs.getString("user_name"));
            %>
        </div>
        <div class="chatlist";>
            <%
                out.println("메시지:" +rs.getString("message"));
                out.println(rs.getString("send_time"));
            %>
        </div>
        <%
            }
        } catch(SQLException ex) {
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
        
        

        <form action="chat.jsp" method="post" >   
            <input type="hidden" name="chatroomname" value=<%=tmp%> >
            <input type="hidden" name="chat" value=<%=chat%> >
        <p><textarea cols ="50" rows="10" placeholder="채팅 입력 하세요" name="chatting" required></textarea></p>
        <p><input type="submit" value="채팅 입력"></p>
        </form>

        <button onclick="calculate()">알림버튼</button>
        
        <button onclick="location.reload()">새로고침 버튼</button>
        
    </body>
</html>