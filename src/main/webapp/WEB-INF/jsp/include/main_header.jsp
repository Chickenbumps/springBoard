<%--
  Created by IntelliJ IDEA.
  User: johaeseong
  Date: 1/16/22
  Time: 7:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="login" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
        <li class="nav-item d-none d-sm-inline-block">
            <a href="/board/list" class="nav-link">Home</a>
        </li>
    </ul>
    <!-- SEARCH FORM -->
    <form class="form-inline ml-3">
        <div class="input-group input-group-sm">
            <input class="form-control form-control-navbar" type="search" placeholder="Search" aria-label="Search">
            <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>
    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
        <c:if test="${not empty login}">
            <li class="nav-item dropdown user user-menu dropleft">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class="hidden-xs">${login.name}</span>
                </a>
                <ul class="dropdown-menu">
                    <li class="user-header">
                        <p>
                            <small> 가입일자 : <fmt:formatDate value="${login.userJoinDate}" pattern="yyyy-MM-dd"/> </small>
                            <small> 최근로그인일자 : <fmt:formatDate value="${login.userLoginDate}" pattern="yyyy-MM-dd"/> </small>
                        </p>
                    </li>
                    <li class="user-footer">
                        <div class="float-left">
                            <a href="#" class="btn btn-default btn-flat">
                                <i class="fa fa-info-circle"></i><b> 내 프로필</b>
                            </a>
                        </div>
                        <div class="float-right">
                            <a href="${path}/user/logout" class="btn btn-default btn-flat">
                                <i class="glyphicon glyphicon-log-out"></i><b> 로그아웃</b>
                            </a>
                        </div>
                    </li>
                </ul>
            </li>
        </c:if>
        <c:if test="${empty login}">
            <li class="nav-item dropdown user user-menu dropleft">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <span class="hidden-xs">회원가입 또는 로그인</span>
                </a>
                <ul class="dropdown-menu">
                    <li class="user-header">
                        <p>
                            <b>회원가입 또는 로그인해주세요</b>
                            <small></small>
                        </p>
                    </li>
                    <li class="user-footer">
                        <div class="float-left">
                            <a href="${path}/user/register" class="btn btn-default btn-flat">
                                <i class="fas fa-user-plus"></i>
                                <b> 회원가입</b>
                            </a>
                        </div>
                        <div class="float-right">
                            <a href="${path}/user/login" class="btn btn-default btn-flat">
                                <i class="glyphicon glyphicon-log-in"></i>
                                <b> 로그인</b>
                            </a>
                        </div>
                    </li>
                </ul>
            </li>
        </c:if>
    </ul>
</nav>
