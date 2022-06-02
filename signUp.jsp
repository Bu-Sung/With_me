<%@page contentType="text/html" pageEncoding="utf-8"%>
<link href="icon.png"rel="shortcut icon"type="image/x-icon"><!--아이콘-->
<%@page import ="java.sql.*"%>
<%  
    request.setCharacterEncoding("utf-8");
    //signUp.html 파일의 아이디, 비밀번호, 이름 값 받아와서 저장
    String uid = request.getParameter("id");
    String upass = request.getParameter("pw");
    String upass2 = request.getParameter("pw2");
    String uname = request.getParameter("name");
    String uphone = request.getParameter("phoneNum");
    
    //mysql jdbc 드라이버 불러오기
    Class.forName("com.mysql.cj.jdbc.Driver");
    //db 연결역할
    Connection conn =null;
    //db 명령 전달 역할
    PreparedStatement pstmt =null;
    //select문 정보 저장 역할
    ResultSet rs =null;
    
    try {
        //jdbc 주소 저장
        String jdbcDriver ="jdbc:mysql://118.67.129.235:3306/with_me?serverTimezone=UTC"; 
        // mysql 로그인 정보
        String dbUser ="taxi";
        String dbPass ="1234";
        
        //질의문 형태로 저장
        String sql ="INSERT INTO user(user_id, user_pw, user_name,user_phone) values(?,?,?,?)";
        //db에 있는 아이디 값 가져오기
        String sql2 ="select user_id from user";
        //아이디가 존재하는지에 대한 변수
        boolean exist =false;
        
        //db 연결
        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
        //sql 구문을 전달해줄 Statement 생성
        pstmt = conn.prepareStatement(sql2);
        //select문 실행하여 rs에 값 저장
        rs = pstmt.executeQuery();
        
        
        while(rs.next()){//입력받은 아이디와 db에 저장되어 있는 아이디 비교
            if(rs.getString("user_id").equals(uid)){ //입력받은 아이디와 동일한 아이디가 db에 존재하는지 확인
                exist =true; //있으면 true
            }
        }
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1,uid);
        pstmt.setString(2,upass);
        pstmt.setString(3,uname);
        pstmt.setString(4,uphone);

        if(exist){ //아이디가 존재한다면
            session.setAttribute("id_error", "err");
            response.sendRedirect("sign-up.jsp");
        }else{ //아이디가 존재하지 않는다면
            if(upass.equals(upass2)){
            //db에 회원가입 정보 저장
            pstmt.executeUpdate();
            response.sendRedirect("sign-in.jsp");
            }else{
                session.setAttribute("pw_error", "비밀번호가 다릅니다.");
                response.sendRedirect("sign-up.jsp");
            }
        }
    }catch(SQLException ex) { //예외처리
        out.println(ex.getMessage());
        ex.printStackTrace();
    } finally { //ResultSet,connection, statement 반환
        if (rs !=null) try { rs.close(); } catch(SQLException ex) {}
        if (pstmt !=null) try { pstmt.close(); } catch(SQLException ex) {}
        if (conn !=null) try { conn.close(); } catch(SQLException ex) {}
    }
%>