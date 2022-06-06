<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="mypackage.ChatDAO" %>
<%@ page import="mypackage.ConnectionPoolwith_me" %>
<%@ page import="mypackage.ChatObj" %>

<%
    response.setContentType("text/html; charset=utf-8");
    response.setCharacterEncoding("utf-8");
    request.setCharacterEncoding("utf-8");
%>

<%
    String uid = session.getAttribute("sid").toString();
    String chatroomname = request.getParameter("chatroomname");
    String chatting = request.getParameter("chatting");

    ChatDAO dao = new ChatDAO();

    if (chatting != null){
        dao.enterchat(chatroomname,uid,chatting);
    } 

    

%>
<html>
<head>
    <link rel="icon" href="./assets/image/icon.png">
  <title>함께 갈래요? - 채팅</title>
<script type="text/javascript">
    function trans(){
        form.submit();
    }
    
</script>
</head>
<body onload="trans()">

    <form action="chat.jsp" name="form" method="post">
        <input type="hidden" name="chatroomname" value=<%=chatroomname%>>
        <input type="hidden" name="chatting" value=<%=chatting%>>
    </form>
   

</body>
</html>