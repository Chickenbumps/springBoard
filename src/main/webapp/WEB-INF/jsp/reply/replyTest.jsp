<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-20
  Time: 오후 1:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/plugin_js.jsp"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="../include/head.jsp"%>
<%@ page import="com.board.demo.model.UserVO" %>
<jsp:useBean id="login" scope="session" type="com.board.demo.model.UserVO"/>
<script>
    let bno = 1;
    let loginUserName = `${login.userName}`;
    console.log("login:",loginUserName);
    function getReply(){
        $.getJSON("${path}/replies/all/"+bno, function(data){
            console.log("data:",data);
            let str = "";

            $(data).each(function(){
                str += "<li data-rno='" + this.rno + "'class='replyLi'>"
                    + "<p class='content'>" + this.content + "</p>"
                    + "<p class='author'>" + this.author + "</p>"
                    + "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>"
                    + "</li>" + "<hr/>";
            });
            $("#replies").html(str);
        })
    }
    $(document).ready(function (){
        getReply();

        $("#replyAddBtn").on("click", function () {
            let content = $("#inputContent");
            console.log("Clicked.");
            $.ajax({
                type:"post",
                url:"${path}/replies",
                headers:{
                    "Content-type":"application/json",
                    "X-HTTP-Method-Override":"POST"
                },
                dataType:"text",
                data:JSON.stringify({
                    bno:bno,
                    content:content.val(),
                    author:loginUserName
                }),
                success : function (result) {
                    if (result == "regSuccess") {
                        alert("댓글 등록 완료!");
                    }
                    getReply();
                    content.val("");
                },
                error: function(request, status, error) {
                    console.log("Req:",request);
                }
            })
        })

        $('#replies').on("click",".replyLi button",function() {
            let reply = $(this).parent();
            console.log("reply:",reply);
            let rno = reply.attr("data-rno");
            let content = reply.find(".content").text();
            let author = reply.find(".author").text();

            $("#rno").val(rno);
            $("#content").val(content);
            $("#author").val(author)
        })

        $(".modalDelBtn").on("click",function () {
            let rno = $(this).parent().parent().find("#rno").val();

            $.ajax({
                type:"delete",
                url:"${path}/replies/" + rno,
                headers: {
                    "Content-type": "application/json",
                    "X-HTTP-Method-Override":"DELETE"
                },
                dataType:"text",
                success: function (result) {
                    console.log("result:" + result);
                    if(result == "delSuccess"){
                        alert("댓글 삭제 완료.");
                        $("#modifyModal").modal("hide");
                        getReply();
                    }
                }
            })
        })

        $(".modalModBtn").on("click",function () {
            let reply = $(this).parent().parent();
            let rno = reply.find("#rno").val();
            let content = reply.find("#content").val();

            $.ajax({
                type:"put",
                url:"${path}/replies/" + rno,
                headers :{
                    "Content-type":"application/json",
                    "X-HTTP-Method-Override": "PUT"
                },
                data : JSON.stringify({
                    content: content
                }),
                dataType : "text",
                success: function(result) {
                    console.log("result :" + result);
                    if(result == "updateSuccess"){
                        alert("댓글 수정 완료!");
                        $("#modifyModal").modal("hide");
                        getReply();
                    }
                }
            })
        })
    })

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
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="${path}/board/list">Home</a></li>
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
                        <div class="card-header with-border">
                            <h3 class="card-title">댓글 작성</h3>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-sm-8">
                                    <input class="form-control input-sm" id="inputContent" type="text" placeholder="댓글 입력...">
                                </div>
                                <div class="form-group col-sm-2">
                                    <input class="form-control input-sm" id="inputAuthor" type="text" value="${login.userName}" readonly>
                                </div>
                                <div class="form-group col-sm-2">
                                    <button id="replyAddBtn" type="button" class="btn btn-primary btn-sm btn-block replyAddBtn">
                                        <i class="fa fa-save"></i> 저장
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <ul id="replies"> </ul>
                        </div>
                        <div class="card-footer">
                            <nav aria-label="Contacts Page Navigation">
                                <ul class="pagination pagination-sm no-margin justify-content-center m-0"> </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="modifyModal" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">댓글 수정창</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="rno">댓글 번호</label>
                                    <input class="form-control" id="rno" name="rno" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="content">댓글 내용</label>
                                    <input class="form-control" id="content" name="content" placeholder="댓글 내용을 입력해주세요">
                                </div>
                                <div class="form-group">
                                    <label for="author">댓글 작성자</label>
                                    <input class="form-control" id="author" name="author" readonly>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-success modalModBtn">수정</button>
                                <button type="button" class="btn btn-danger modalDelBtn">삭제</button>
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
</html>

