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
<jsp:useBean id="login" scope="session" type="com.board.demo.model.UserVO"/>
<body class="hold-transition sidebar-mini"><script>
    $(document).ready(function() {
        $("#submitBtn").click(function(){
            event.preventDefault();
            let tempTitle = $("#title").val();
            console.log("title:",tempTitle);
            console.log("content:",$("#content").val());
            if($("#title").val() == ""){
                alert("제목을 입력해주세요.");
                document.getElementById("title").focus();
            }else if($("#content").val() == ""){
                alert("내용을 입력해주세요.");
                // $('#title').val(tempTitle);
                // console.log("temp2:",tempTitle);
                document.getElementById("content").focus();
            }else{
                let userID = "${login.id}";
                $.post("",{title:$("#title").val(),content:$("#content").val(),author:$("#author").val(),userID:userID},function (res) {
                    console.log(res);
                    if(res === "fail"){
                        alert("글쓰기를 실패했습니다.");
                    }else if(res === "success"){
                        alert("게시글이 등록되었습니다.");
                        location.href="/board/list";
                    }

                });
            }
        })
    })
</script>
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
                    <form role="form" id="writeForm" method="post" action="${path}/board/write">
                        <div class="card">
                            <div class="card-header with-border">
                                <h3 class="card-title">게시글 작성</h3>
                            </div> <div class="card-body">
                            <div class="form-group">
                                <label for="title">제목</label>
                                <input class="form-control" id="title" name="title" placeholder="제목을 입력해주세요">
                            </div>
                            <div class="form-group">
                                <label for="content">내용</label>
                                <textarea class="form-control" id="content" name="content" rows="30" placeholder="내용을 입력해주세요" style="resize: none;"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="author">작성자</label>
                                <input class="form-control" id="author" name="author" value="${login.userName}" readonly>
                            </div>
                        </div>
                            <div class="card-footer">
                                <button type="button" class="btn btn-primary">
                                    <i class="fa fa-list"></i> 목록</button>
                                <div class="float-right">
                                    <button type="reset" class="btn btn-warning">
                                        <i class="fa fa-reply"></i> 초기화</button>
                                    <button id="submitBtn" type="submit" class="btn btn-success">
                                        <i class="fa fa-save"></i> 저장</button>
                                </div>
                            </div>
                        </div>
                    </form>
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
</html>

