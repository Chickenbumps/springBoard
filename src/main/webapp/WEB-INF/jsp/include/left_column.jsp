<%--
  Created by IntelliJ IDEA.
  User: johaeseong
  Date: 1/16/22
  Time: 7:28 PM
  To change this template use File | Settings | File Templates.
--%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="login" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user panel (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <c:if test="${empty login}">
                <div class="info">
                    <%-- Status --%>
                    <a href="#"><i class="fa fa-circle text-danger"></i> Guest</a>
                </div>
            </c:if>

            <c:if test="${not empty login}">
                <div class="info">
                    <%-- Status --%>
                    <a href="#"><i class="d-block"></i> ${login.name}</a>
                </div>
            </c:if>
        </div>
        <!-- SidebarSearch Form -->
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
                     with font-awesome or any other icon font library -->
                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>
                            Starter Pages
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="${path}/board/write" class="nav-link active">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Write Page</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="${path}/board/list" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>List Page</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>

