<%@ page import="com.board.demo.model.UserVO" %>
<<<<<<< HEAD
<<<<<<< HEAD
=======
<%@ page import="org.springframework.security.core.parameters.P" %>
>>>>>>> 4014b449b8b7aff3c0a2e8a45cb2ca097bfbb999
=======
<%@ page import="org.springframework.security.core.parameters.P" %>
>>>>>>> refs/remotes/origin/spring_security
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-17
  Time: 오전 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <script type="text/javascript">
        console.log("LOGINPOST");
        let username = "<%=session.getAttribute("user")%>";
        if(username){
            location.href = "${path}/board/list";
        }else{
            alert("아이디와 비밀번호를 확인해주세요.");
            location.href = "${path}/user/login";
        }
    </script>
</body>
</html>
