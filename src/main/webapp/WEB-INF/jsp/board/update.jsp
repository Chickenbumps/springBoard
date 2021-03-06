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
<%@ include file="../include/plugin_js.jsp"%>
<%@ include file="../include/head.jsp"%>
<script type="text/javascript">
    $(document).ready(function () {
        var formObj = $("form[role='form']");
        console.log(formObj);
        $(".modBtn").on("click", function () {
            formObj.submit();
        });
        $(".cancelBtn").on("click", function () {
            history.go(-1);
        });
        $(".listBtn").on("click", function () {
            self.location = "${path}/board/list"
        });
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
                    <form role="form" id="writeForm" method="post" action="${path}/board/update">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">????????? ??????</h3>
                            </div>
                            <div class="card-body">
                                <input type="hidden" name="bno" value="${read.bno}">
                                <div class="form-group">
                                    <label for="title">??????</label>
                                    <input class="form-control" id="title" name="title" placeholder="????????? ??????????????????" value="${read.title}">
                                </div>
                                <div class="form-group">
                                    <label for="content">??????</label>
                                    <textarea class="form-control" id="content" name="content" rows="30" placeholder="????????? ??????????????????" style="resize: none;">${read.content}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="author">?????????</label>
                                    <input class="form-control" id="author" name="author" value="${read.author}" readonly>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button type="button" class="btn btn-primary">
                                    <i class="fa fa-list"></i> ??????
                                </button>
                                <div class="float-right">
                                    <button type="button" class="btn btn-warning cancelBtn">
                                        <i class="fa fa-trash"></i> ??????
                                    </button>
                                    <button type="submit" class="btn btn-success modBtn">
                                        <i class="fa fa-save"></i> ?????? ??????
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
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
</html>

