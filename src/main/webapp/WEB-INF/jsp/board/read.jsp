<%--
  Created by IntelliJ IDEA.
  User: johaeseong
  Date: 1/15/22
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/plugin_js.jsp"%>
<%@ include file="../include/head.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<jsp:useBean id="login" scope="session" type="com.board.demo.model.UserVO"/>

<body class="hold-transition sidebar-mini">
<script>

    $(document).ready(function () {
        var formObj = $("form[role='form']");
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
            self.location = "${path}/board/list"
        });

        let bno = "${read.bno}";

        Handlebars.registerHelper("escape",function (content) {
            let handledContent = Handlebars.Utils.escapeExpression(content);
            handledContent = handledContent.replace(/(\r\n|\n|\r)/gm,"<br/>");
            handledContent = handledContent.replace(/( )/gm,"&nbsp;");
            return new Handlebars.SafeString(handledContent);
        });

        function prettyDate (timeValue) {
            let dateObj = new Date(timeValue);
            let year = dateObj.getFullYear();
            let month = dateObj.getMonth() + 1;
            let date = dateObj.getDate();
            let hours = dateObj.getHours();
            let minutes = dateObj.getMinutes();
            month < 10 ? month = '0' + month : month;
            date < 10 ? date = '0' + date : date;
            hours < 10 ? hours = '0' + hours : hours;
            minutes < 10 ? minutes = '0' + minutes : minutes;
            return year + "-" + month + "-" + date + " "+ hours + ":" + minutes;
        }
        getReplies("${path}/replies/all/"+ bno);
        let loginUsername = "${login.userName}"

        function getReplies(repliesUri) {
            $.getJSON(repliesUri, function (data) {
                printReplyCount(data.length);
                let str = '';
                let path = "${path}";
                $(data).each(function (){
                    let formatDate = prettyDate(this.updatedAt);
                    str += "<div class='post replyDiv' data-rno='"+ this.rno +"'>"
                        if(this.parentRno == 0){
                         str+=  "<div class='user-block'>"
                            +  "<img class='img-circle img-bordered-sm' src='"+path+"/dist/img/user1-128x128.jpg' alt='user image'>"
                            +  "<span class='username'>"
                            +  "<a href='#'>"+ this.author +"</a>"
                            +  "<a href='#' class='float-right btn-box-tool replyDelBtn' data-toggle='modal' data-target='#delModal'>"
                            +  "<i class='fa fa-times'>"+"??????"+"</i>"
                            +  "</a>"
                            +  "<a href='#' class='float-right btn-box-tool replyModBtn' data-toggle='modal' data-target='#modModal'>"
                            +  "<i class='fa fa-edit'>"+"??????"+"</i>"
                            +  "</a>"
                            +  "</span>"
                            +  "<span class='description'>"+formatDate+"</span>"
                            +  "</div>"
                            +  "<div class='oldContent'>"+ this.content + "</div>"
                            +  "<div class='form-row float-left rereplyDiv'>"
                            +  "<a id='"+this.rno+"'" +"href='#rereplyCollapse"+this.rno +"'"+ "class='btn-box-tool rereplyShowBtn' data-toggle='collapse' rno='"+this.rno +"'>"+"?????? ??????" + "</a>"
                            +  "</div>"
                        }else {
                            str+=  "<div class='user-block pl-5'>"
                                +  "<img class='img-circle img-bordered-sm' src='"+path+"/dist/img/user1-128x128.jpg' alt='user image'>"
                                +  "<span class='username'>"
                                +  "<a href='#'>"+ this.author +"</a>"
                                +  "<a href='#' class='float-right btn-box-tool replyDelBtn' data-toggle='modal' data-target='#delModal'>"
                                +  "<i class='fa fa-times'>"+"??????"+"</i>"
                                +  "</a>"
                                +  "<a href='#' class='float-right btn-box-tool replyModBtn' data-toggle='modal' data-target='#modModal'>"
                                +  "<i class='fa fa-edit'>"+"??????"+"</i>"
                                +  "</a>"
                                +  "</span>"
                                +  "<span class='description'>"+formatDate+"</span>"
                                +  "</div>"
                                +  "<div class='oldContent pl-5'>"+ this.content + "</div>"
                                +  "<div class='form-row float-left pl-5 rereplyDiv'>"
                                +  "<a id='"+this.rno+"'" +"href='#rereplyCollapse"+this.rno +"'"+ "class='btn-box-tool rereplyShowBtn' data-toggle='collapse' rno='"+this.rno +"'>"+"?????? ??????" + "</a>"
                                +  "</div>"
                        }
                    str +=  "<div class='collapse row' id='rereplyCollapse"+this.rno+"'"+">"

                        +  "<div class='col-7'>"
                        +  "<input class='w-100 form-control rereplyInput"+this.rno+"' type='text' placeholder='????????????...' rno='"+ this.rno +"'>"
                        +  "</div>"
                        +  "<div class='col-3'>"
                        +  "<span class='username'>" + loginUsername + "</span>"
                        +  "</div>"
                        +  "<div class='col-3'>"
                        +  "<button type='button' class='btn btn-success mb-1 rereplyAddBtn' rno='"+ this.rno +"'>" + "?????? ??????" +"</button>"
                        +  "</div>"
                        +  "</div>"
                        +  "<div class='rereplyDiv'>"
                        +  "</div>"
                        +  "<br/>"
                        +  "</div>";
                })
                $(".repliesDiv").html(str);
            })
        }

        function printReplyCount(totalCount) {
            let replyCount = $(".replyCount");
            let collapsedBox = $(".collapsed-box");

            // ?????? ?????????
            if(totalCount === 0) {
                replyCount.html(" ????????? ????????????. ????????? ???????????????.");
                collapsedBox.find(".btn-box-tool").remove();
                return;
            }

            replyCount.html(" ???????????? (" + totalCount + ")");
            collapsedBox.find(".box-tools").html(
                "<button type='button' class='btn btn-box-tool' data-widget='collapse'>"
                + "<i class='fa fa-plus'></i>"
                + "</button>"
            );
        }

        function printReplies(replyArr, targetArea, templateObj){
            let replyTemplate = Handlebars.compile(templateObj.html());
            let html = replyTemplate(replyArr);
            $(".replyDiv").remove();
            targetArea.html(html);
        }

        $(".replyAddBtn").click(function () {
            console.log("ADD BTN CLICKED.");
            let replyContent = $("#inputContent");
            let authorValue = loginUsername;
            let userID = ${login.id};
            let contentValue = replyContent.val();
            $.ajax({
                type:"post",
                url:"${path}/replies/",
                headers: {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override":"POST"
                },
                dataType: "text",
                data: JSON.stringify({
                    bno:bno,
                    author:authorValue,
                    content:contentValue,
                    parentRno:0,
                    userID:userID
                }),
                success: function(res){
                    if(res === "regSuccess"){
                        alert("????????? ?????????????????????.");
                        getReplies("${path}/replies/all/"+bno);
                        replyContent.val("");
                        $('#replyTemplate').load(location.href+' #replyTemplate');
                    }
                }
            })
        })

        $(document).on("click",".rereplyAddBtn",function () {
            console.log("READD BTN CLICKED.");
            let rno = $(this).attr('rno');
            let contentInput = ".rereplyInput"+rno;
            let replyContent = $(contentInput);
            console.log("V:",contentInput,$(contentInput).val());
            let authorValue = loginUsername;
            let contentValue = replyContent.val();
            let userID = ${login.id};
            $.ajax({
                type:"post",
                url:"${path}/replies/",
                headers: {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override":"POST"
                },
                dataType: "text",
                data: JSON.stringify({
                    bno:bno,
                    author:authorValue,
                    content:contentValue,
                    parentRno:rno,
                    userID:userID
                }),
                success: function(res){
                    if(res === "regSuccess"){
                        alert("????????? ?????????????????????.");
                        getReplies("${path}/replies/all/"+bno);
                        replyContent.val("");
                        $('#replyTemplate').load(location.href+' #replyTemplate');
                    }
                }
            })
        })

        $(".repliesDiv").on("click",".replyDiv",function(event){
            let reply = $(this);
            $(".rno").val(reply.attr("data-rno"));
            $("#content").val(reply.find(".oldContent").text());
        });

        $(".modalModBtn").on("click",function (){
            let rno = $(".rno").val();
            let content = $("#content").val();
            $.ajax({
                type: "put",
                url:"${path}/replies/"+rno,
                headers:{
                    "Content-Type":"application/json",
                    "X-HTTP-Method-Override":"PUT"
                },
                dataType:"text",
                data: JSON.stringify({
                    content:content
                }),
                success: function(res){
                    if(res === "updateSuccess"){
                        alert("????????? ?????????????????????.");
                        getReplies("${path}/replies/all/"+ bno);
                        $("#modModal").modal("hide");
                        $('#replyTemplate').load(location.href+' #replyTemplate');
                    }
                }
            })
        })

        $(".modalDelBtn").on("click",function (){
            let rno =$(".rno").val();
            $.ajax({
                type: "delete",
                url:"${path}/replies/"+rno,
                headers:{
                    "Content-Type":"application/json",
                    "X-HTTP-Method-Override":"DELETE"
                },
                dataType:"text",
                success: function(res){
                    if(res === "delSuccess"){
                        alert("????????? ?????????????????????.");
                        getReplies("${path}/replies/all/"+ bno);
                        $("#delModal").modal("hide");
                        $('#replyTemplate').load(location.href+' #replyTemplate');
                    }
                }
            })
        })
        <%--$(".rereplyShowBtn").on("click",function (){--%>
        <%--    console.log("Show");--%>
        <%--    let str = '';--%>
        <%--    let username = "${login.userName}";--%>
        <%--    str += "<div class='card card-body'>"--%>
        <%--        +  "<form class='form-horizontal'>"--%>
        <%--        +  "<div class='row'>"--%>
        <%--        +  "<div class='form-group col-sm-8'>"--%>
        <%--        +  "<input class='form-control input-sm' id='rereplyContent' type='text' placeholder='?????? ??????...'>"--%>
        <%--        +  "</div>"--%>
        <%--        +  "<div class='form-group col-sm-2'>"--%>
        <%--        +  "<input class='form-control input-sm' id='rereplyAuthor' type='text' placeholder='?????????' value='"+ username +"' readonly>"--%>
        <%--        +  "</div>"--%>
        <%--        +  "<div class='form-group col-sm-2'>"--%>
        <%--        +  "<button type='button' class='btn btn-primary btn-sm btn-block replyAddBtn'>"--%>
        <%--        +  "<i class='fa fa-save'></i>"+ "??????"--%>
        <%--        +  "</button>"--%>
        <%--        +  "</div>"--%>
        <%--        +  "</div>"--%>
        <%--        +  "</form>"--%>
        <%--        +  "</div>";--%>
        <%--    $(".rereplyDiv").html(str);--%>
        <%--})--%>

    });
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
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="${path}/board/list">Home</a></li>
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
                            <h3 class="card-title">????????? : ${read.title}</h3>
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
                                <i class="fa fa-list"></i> ??????
                            </button>
                            <c:if test="${login.userName == read.author}">
                                <div class="float-right">
                                    <button id="updateBtn" type="submit" class="btn btn-warning modBtn">
                                        <i class="fa fa-edit"></i> ??????
                                    </button>
                                    <button id="deleteBtn" type="submit" class="btn btn-danger delBtn">
                                        <i class="fa fa-trash"></i> ??????
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="card card-body">
                        <form class="form-horizontal">
                            <div class="row">
                                <div class="form-group col-sm-8">
                                    <input class="form-control input-sm" id="inputContent" type="text" placeholder="?????? ??????...">
                                </div>
                                <div class="form-group col-sm-2">
                                    <input class="form-control input-sm" id="inputAuthor" type="text" placeholder="?????????" value="${login.userName}" readonly>
                                </div>
                                <div class="form-group col-sm-2">
                                    <button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn">
                                        <i class="fa fa-save"></i> ??????
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="card card-primary card-outline">
                        <div class="card-header">
                            <a href="" class="link-black text-lg"><i class="fas fa-comments margin-r-5 replyCount"></i></a>
                            <div class="card-tools">
                                <button type="button" class="btn primary" data-widget="collapse">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body repliesDiv">
<%--                            <script id="replyTemplate" type="text/x-handlebars-template" defer>--%>
<%--                                {{#each.}}--%>
<%--                                <div class="post replyDiv" data-rno={{rno}}>--%>
<%--                                    <div class="user-block">--%>
<%--                                        <img class="img-circle img-bordered-sm" src="${path}/dist/img/user1-128x128.jpg" alt="user image">--%>
<%--                                        <span class="username">--%>
<%--                                            <a href="#">{{author}}</a>--%>
<%--                                            <a href="#" class="float-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#delModal"> <i class="fa fa-times"> ??????</i> </a>--%>
<%--                                            <a href="#" class="float-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modModal"> <i class="fa fa-edit"> ??????</i> </a>--%>
<%--                                        </span>--%>
<%--                                        <span class="description"></span>--%>
<%--                                    </div>--%>
<%--                                    <div class="oldContent">{{content}}</div>--%>
<%--                                    <br/>--%>
<%--                                </div>--%>
<%--                                {{/each}}--%>
<%--                            </script>--%>
                        </div>
                        <%--?????? ?????? modal ??????--%>
                        <div class="modal fade" id="modModal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">????????????</h4>
                                    </div>
                                    <div class="modal-body" data-rno>
                                        <input type="hidden" class="rno"/>
                                        <%--<input type="text" id="content" class="form-control"/>--%>
                                        <textarea class="form-control" id="content" rows="3" style="resize: none"></textarea>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">??????</button>
                                        <button type="button" class="btn btn-primary modalModBtn">??????</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--?????? ?????? modal ??????--%>
                        <div class="modal fade" id="delModal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title">?????? ??????</h4>
                                        <input type="hidden" class="rno"/>
                                    </div>
                                    <div class="modal-body" data-rno>
                                        <p>????????? ?????????????????????????</p>
                                        <input type="hidden" class="rno"/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">?????????.</button>
                                        <button type="button" class="btn btn-primary modalDelBtn">???. ???????????????.</button>
                                    </div>
                                </div>
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
</body>
</html>

