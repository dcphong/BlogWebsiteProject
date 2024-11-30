<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 16/11/2024
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><img
                src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg" alt="Logo"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <c:url value="/UserHome" var="homeClients"/>
                    <input type="button" readonly class="nav-link">Tổng người dùng: ${applicationScope.visitors}</input>
                </li>
                <li class="nav-item">
                    <c:url value="/UserHome" var="homeClients"/>
                    <a class="nav-link" href="${homeClients}"><i class="fas fa-home"></i> Trang chủ</a>
                </li>
                <li class="nav-item">
                    <c:url value="/Admin/Home" var="adminVideos"/>
                    <a class="nav-link" href="${adminVideos}"><i class="fas fa-video"></i> Videos</a>
                </li>
                <li class="nav-item">
                    <c:url value="/Admin/user" var="adminUser"/>
                    <a class="nav-link" href="${adminUser}"><i class="fas fa-users"></i> Người dùng</a>
                </li>
                <li class="nav-item">
                    <c:url value="/Admin/statistics" var="adminStatistics"/>
                    <a class="nav-link" href="${adminStatistics}"><i class="fas fa-chart-bar"></i> Thống kê</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="fas fa-user"></i> Tài khoản</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
