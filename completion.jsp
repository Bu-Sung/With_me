<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>

<%  //탑승 완료 리더가 버튼을 클릭하면 completion 값을 1로 변경 
    String user = (String) session.getAttribute("sid");
    String number = request.getParameter("num");
    
    <%
          Class.forName("com.mysql.cj.jdbc.Driver"); 
          Connection conn =null;
          PreparedStatement pstmt =null;
          ResultSet rs =null;
          try {
                                  
              String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
              String dbUser ="taxi"; //mysql id
              String dbPass ="1234"; //mysql password
              String query ="select * from member where group_num=?"; //query
              String setSql = "update set completion=1 from taxi where group_num=?"
              // Create DB Connection
              conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
              // Create Statement
              pstmt = conn.prepareStatement(query);
              pstmt.setString(1,number);
              // Run Qeury
              rs = pstmt.executeQuery();
              // Print Result (Run by Query)
             if(rs.next()){
                if(user.equals(rs.getString("leader"))){
                    //그룹내 리더가 맞을때
                    pstmt = conn.prepareStatement(setSql);
                    pstmt.setString(1,number);
                    pstmt.excutUpdate();
                    session.setAttribute("ssuccess", "탑승이 완료되었습니다.");
                }else{
                    //그룹내 리더가 아닐때
                    session.setAttribute("success", "탑승이 완료되었습니다.");
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

%>