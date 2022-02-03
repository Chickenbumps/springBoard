<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2022-01-17
  Time: 오전 10:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="../include/plugin_js.jsp"%>
<%@ include file="../include/head.jsp" %>
<!DOCTYPE html>
<html>
<script>
    let msg = "${msg}";
    let loginFailMsg = "${loginFailMsg}";
    console.log("loginFailMsg:",loginFailMsg);
    if (msg === "registered") {
        alert("회원가입이 완료되었습니다. 로그인해주세요~");
    }else if(loginFailMsg != ""){
        alert(loginFailMsg);
    }
</script>
    <body class="hold-transition login-page">
        <div class="login-box">
            <div class="card">
                <div class="card-body login-card-body">
                    <p class="login-box-msg">Sign in to start your session</p>
                    <form action="${path}/user/login" method="post">
                        <div class="input-group mb-3">
                            <input type="text" name="username" class="form-control" placeholder="아이디">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-exclamation"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="password" name="password" class="form-control" placeholder="비밀번호">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <div class="icheck-primary">
                                    <input type="checkbox" id="remember">
                                    <label for="remember"> Remember Me </label>
                                </div>
                            </div> <!-- /.col -->
                            <div class="col-4">
                                <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                            </div> <!-- /.col -->
                        </div>
                    </form>
                    <p class="mb-1">
                        <a href="#">I forgot my password</a>
                    </p>
                    <p class="mb-0">
                        <a href="${path}/user/register" class="text-center">Register a new membership</a> </p>
                </div><!-- /.login-card-body -->
            </div> <!-- /.login-box-body -->
        </div> <!-- /.login-box -->
    </body>
</html>

