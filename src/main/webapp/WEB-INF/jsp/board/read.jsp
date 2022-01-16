<%--
  Created by IntelliJ IDEA.
  User: johaeseong
  Date: 1/15/22
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<%@ include file="../include/head.jsp"%>
<script language="JavaScript">
    console.log("111111111111");
    $(document).ready(function () {
        var formObj = $("form[role='form']");
        console.log(formObj);
        $("#updateBtn").click(function () {
            console.log("mod");
            formObj.attr("action", "${path}/board/update");
            formObj.attr("method", "get");
            formObj.submit();
        });
        $("#deleteBtn").click(function () {
            console.log("delete");
            formObj.attr("action", "${path}/board/delete");
            formObj.submit();
        });
        $("#listBtn").click(function () {
            console.log("list;");
            self.location = "${path}/board/list" });
    });
</script>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

    <!-- Navbar -->
    <%@ include file="../include/main_header.jsp"%>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <%@include file="../include/left_column.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1 class="m-0">Starter Page</h1>
                    </div><!-- /.col -->
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">Starter Page</li>
                        </ol>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->

        <!-- Main content -->
        <div class="content">
            <div class="container-fluid">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">글제목 : ${read.title}</h3>
                        </div>
                        <div class="card-body" style="height: 700px">
                            ${read.content}
                        </div>
                        <div class="card-footer">
                            <div class="user-block">
                                <img class="img-circle img-bordered-sm" src="${path}/dist/img/user1-128x128.jpg" alt="user image">
                                <span class="username">
                                    <a href="#">${read.author}</a>
                                </span>
                                <span class="description">
                                    <fmt:formatDate pattern="yyyy-MM-dd" value="${read.createdAt}"/>
                                </span>
                            </div>
                        </div>
                        <div class="card-footer">
                            <form role="form" method="post">
                                <input type="hidden" name="bno" value="${read.bno}">
                            </form>
                            <button id="listBtn" type="submit" class="btn btn-primary listBtn">
                                <i class="fa fa-list"></i> 목록
                            </button>
                            <div class="float-right">
                                <button id="updateBtn" type="submit" class="btn btn-warning modBtn">
                                    <i class="fa fa-edit"></i> 수정
                                </button>
                                <button id="deleteBtn" type="submit" class="btn btn-danger delBtn">
                                    <i class="fa fa-trash"></i> 삭제
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
        <div class="p-3">
            <h5>Title</h5>
            <p>Sidebar content</p>
        </div>
    </aside>
    <!-- /.control-sidebar -->

    <!-- Main Footer -->
    <%@include file="../include/main_footer.jsp"%>
</div>
<!-- ./wrapper -->
</body>
<%@ include file="../include/plugin_js.jsp"%>
</html>

