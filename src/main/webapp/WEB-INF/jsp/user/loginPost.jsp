<%@ page import="com.board.demo.model.UserVO" %>
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
<%

%>
    <script type="text/javascript">
        alert("아이디와 비밀번호를 확인해주세요.");
        location.href = "${path}/user/login";
    </script>
</body>
</html>
