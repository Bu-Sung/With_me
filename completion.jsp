<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<%  //탑승 완료 리더가 버튼을 클릭하면 completion 값을 1로 변경 
    String user = (String) session.getAttribute("sid");
  //  String number = request.getParameter("num");
    String number = "5684";

    Class.forName("com.mysql.cj.jdbc.Driver"); 
    Connection conn =null;
    PreparedStatement pstmt =null;
    ResultSet rs =null;
    try {
                            
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        String dbUser ="taxi"; //mysql id
        String dbPass ="1234"; //mysql password
        //택시 그룹 조회 SQL
        String query ="select * from member where group_num=?";
        //탑승완료 수정 SQl
        String setSql = "update taxi set completion=1 where group_num=?";
       
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1,number);
        rs = pstmt.executeQuery();
        // Print Result (Run by Query)
        if(rs.next()){
        if(user.equals(rs.getString("leader"))){
            //그룹내 리더가 맞을때
            pstmt = conn.prepareStatement(setSql);
            pstmt.setString(1,number);
            int co=pstmt.executeUpdate();
            if(co==1){
            %>
                <script type="text/javascript">
                    alert("탑승 완료하였습니다.");
                    location.href = "main.jsp";
                </script>
            <%
            }
        }else{
            //그룹내 리더가 아닐때
            session.setAttribute("success", "실패");
            
        }
        }else{
        //채팅방이 존재하므로 예외처리 따로 안함
        }
    } catch(SQLException ex) {
        out.println(ex.getMessage());
        ex.printStackTrace();
    } finally {
        if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
        if (pstmt !=null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
    }
    

%>