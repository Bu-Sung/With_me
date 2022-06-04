<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.*" %>

<!-- 정보 수정 디비 저장  -->

            <% // MySQL JDBC Driver Loading
                Class.forName("com.mysql.cj.jdbc.Driver"); 
                Connection conn =null;
                PreparedStatement pstmt = null;
                ResultSet rs =null;

                String uid = session.getAttribute("sid").toString();  // 아이디 세션 값 가져옴
                // update.jsp에서 이름, 비밀번호, 전화번호 입력값 가져옴
                String user_name = request.getParameter("user_name");  // 이름
                String user_pw = request.getParameter("user_pw");  // 비밀번호
                String user_phone = request.getParameter("user_phone");  // 전화번호

                try {
                    String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
                    String dbUser ="taxi"; //mysql id
                    String dbPass ="1234"; //mysql password
                    
                    String sql = "update user set user_name = ?, user_pw=?, user_phone=? where user_id = ?";

                    // Create DB Connection
                    conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                    // Create Statement
                    pstmt = conn.prepareStatement(sql);
                    
                    //pstmt 생성
                    pstmt.setString(1,user_name);
                    pstmt.setString(2,user_pw);
                    pstmt.setString(3,user_phone);
                    pstmt.setString(4,uid);
                    pstmt.executeUpdate();

                    %>
                    <script>
                        alert("수정 완료!!");
                        location.href= "myPage.jsp";
                    </script>
                    <%
   
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


