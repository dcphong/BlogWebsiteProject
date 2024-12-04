<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 16/11/2024
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <c:url value="/Admin/Home" var="adminHome"/>
    <a href="${adminHome}"><i class="fas fa-home"></i> Home</a>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#videosMenu" aria-expanded="false">
        <i class="fas fa-video"></i> Videos
    </a>
    <div id="videosMenu" class="collapse">
        <c:url value="/Admin/Home" var="adminVideos"/>
        <a href="${adminVideos}" class="dropdown-item" style="background-color: #2a2a2a">Upload Video</a>
    </div>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#usersMenu" aria-expanded="false">
        <i class="fas fa-users"></i> Users
    </a>
    <div id="usersMenu" class="collapse">
        <c:url value="/Admin/user" var="adminUser"/>
        <a href="${adminUser}" class="dropdown-item" style="background-color: #2a2a2a">Add User</a>
    </div>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#reportsMenu" aria-expanded="false">
        <i class="fas fa-chart-bar"></i> Reports
    </a>
    <div id="reportsMenu" class="collapse">
        <c:url value="/Admin/statistics" var="adminStatistics"/>
        <a href="${adminStatistics}" class="dropdown-item" style="background-color: #2a2a2a">Thong ke chi tiet</a>
    </div>
</div>

