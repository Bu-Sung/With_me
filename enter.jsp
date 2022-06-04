<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.*" %>

<!-- 그룹 참가 시 디비 member 테이블에 저장  -->

<% 
// member 테이블에서 그룹번호에 해당하는 leader, one, two, three 값 가져옴
    // MySQL JDBC Driver Loading
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    Connection conn =null;
    PreparedStatement pstmt = null;
    ResultSet rs =null;

    String num = session.getAttribute("snum").toString();  // 그룹번호 detail-info.jsp에서 세션 저장해서 값 가져옴
    String uid = session.getAttribute("sid").toString();  // 아이디 세션 값 가져옴

    String leader = null;  
    String one = null;  
    String two = null;  
    String three = null;  

    try {
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        String dbUser ="taxi"; //mysql id
        String dbPass ="1234"; //mysql password
                    
        String sql = "select * from member where group_num = ?";
        // Create DB Connection
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        // Create Statement
        pstmt = conn.prepareStatement(sql);
                    
        //pstmt 생성
        pstmt.setString(1,num);
                    
        // Run Qeury
        rs = pstmt.executeQuery();
        // Print Result (Run by Query)
                                    
        if(rs.next()){
            leader = rs.getString("leader");
            one = rs.getString("one");
            two = rs.getString("two");
            three = rs.getString("three");
        }
    
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




// 그룹에 중복 참가할 경우 "이미 참가된 그룹" 메시지 띄우기
// 중복 참가 아닐 경우 아이디 값 저장

    // one이 null일 경우 (아직 leader만 그룹에 참가된 경우)
    // 다음 참가자는 member 테이블의 one에 정보 저장해야함
    if(one==null){
        
        // 그룹에 leader만 존재하기 때문에 
        // 자신의 아이디가 leader의 값과 같지않으면 참가 가능
        // , 같으면 참가 불가능 (이미 참가된 그룹이기 때문에)
        if(!(leader.equals(uid))) { 
            Class.forName("com.mysql.cj.jdbc.Driver"); 

            try {
                String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
                String dbUser ="taxi"; //mysql id
                String dbPass ="1234"; //mysql password
            
                String sql = "update member set one=? where group_num =?";
                // Create DB Connection
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                // Create Statement
                pstmt = conn.prepareStatement(sql);
            
                //pstmt 생성
                pstmt.setString(1,uid);
                pstmt.setString(2,num);
                pstmt.executeUpdate();

                %>
                <script>
                    alert("참가 완료!!");
                    location.href= "main.jsp";
                </script>
                <%

                return;
            

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
        } else {
            %>
            <script>
                alert("이미 참가된 그룹!!");
                location.href= "main.jsp";
            </script>
            <%
        }

    }  // end-if


    // two null일 경우 (leader, one만 그룹에 참가된 경우)
    // 다음 참가자는 member 테이블의 two에 정보 저장해야함
    else if (two==null){

        // 그룹에 leader, one만 존재하기 때문에 
        // 자신의 아이디가 leader 값과 one 값과 같지않으면 참가 가능
        // , 같으면 참가 불가능 (이미 참가된 그룹이기 때문에)
        if((leader.equals(uid) && one.equals(uid))) {
            Class.forName("com.mysql.cj.jdbc.Driver"); 

            try {
                String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
                String dbUser ="taxi"; //mysql id
                String dbPass ="1234"; //mysql password
            
                String sql = "update member set two=? where group_num =?";
                // Create DB Connection
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                // Create Statement
                pstmt = conn.prepareStatement(sql);
            
                //pstmt 생성
                pstmt.setString(1,uid);
                pstmt.setString(2,num);
                pstmt.executeUpdate();

                %>
                <script>
                    alert("참가 완료!!");
                    location.href= "main.jsp";
                </script>
                <%
                return;
           
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
        }else {
            %>
            <script>
                alert("이미 참가된 그룹!!");
                location.href= "main.jsp";
            </script>
            <%
        }

    }  // end-elseif


    // three null일 경우 (leader, one, two만 그룹에 참가된 경우)
    // 다음 참가자는 member 테이블의 three에 정보 저장해야함
    else if (three==null){

        // 그룹에 leader, one, two만 존재하기 때문에 
        // 자신의 아이디가 leader 값과 one 값과 two 값과 같지않으면 참가 가능
        // , 같으면 참가 불가능 (이미 참가된 그룹이기 때문에)
        if(!(leader.equals(uid) && one.equals(uid) && two.equals(uid))) {
 
            Class.forName("com.mysql.cj.jdbc.Driver"); 

            try {
                String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
                String dbUser ="taxi"; //mysql id
                String dbPass ="1234"; //mysql password
                
                String sql = "update member set three=? where group_num =?";
                // Create DB Connection
                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
                // Create Statement
                pstmt = conn.prepareStatement(sql);
            
                //pstmt 생성
                pstmt.setString(1,uid);
                pstmt.setString(2,num);
                pstmt.executeUpdate();

                %>
                <script>
                    alert("참가 완료!!");
                    location.href= "main.jsp";
                </script>
                <%
                return;
           

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
        } else {
            %>
            <script>
                alert("이미 참가된 그룹!!");
                location.href= "main.jsp";
            </script>
            <%
        }

    }  // end-elseif 
    

    // leader, one, two, three 모두 값이 저장되있는 경우
    // 인원초과 메시지 띄우기
    else {  
        %>
        <script>
            alert("참가인원초과!!");
            location.href= "main.jsp";
        </script>
        <%
    }  // end-else

%>
