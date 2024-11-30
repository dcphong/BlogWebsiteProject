<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 16/11/2024
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar">
    <a href="#"><i class="fas fa-home"></i> Home</a>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#videosMenu" aria-expanded="false">
        <i class="fas fa-video"></i> Videos
    </a>
    <div id="videosMenu" class="collapse">
        <a href="#" class="dropdown-item" style="background-color: #2a2a2a">Video List</a>
        <a href="#" class="dropdown-item" style="background-color: #2a2a2a">Upload Video</a>
    </div>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#usersMenu" aria-expanded="false">
        <i class="fas fa-users"></i> Users
    </a>
    <div id="usersMenu" class="collapse">
        <a href="#" class="dropdown-item" style="background-color: #2a2a2a">User List</a>
        <a href="#" class="dropdown-item" style="background-color: #2a2a2a">Add User</a>
    </div>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#reportsMenu" aria-expanded="false">
        <i class="fas fa-chart-bar"></i> Reports
    </a>
    <div id="reportsMenu" class="collapse">
        <a href="#" class="dropdown-item" style="background-color: #2a2a2a">Report 1</a>
        <a href="#" class="dropdown-item" style="background-color: #2a2a2a">Report 2</a>
    </div>
    <a href="#" data-bs-toggle="collapse" data-bs-target="#accountMenu" aria-expanded="false">
        <i class="fas fa-user"></i> Tài khoản
    </a>
    <div id="accountMenu" class="collapse" style="background-color: #2a2a2a">
        <a href="#" class="dropdown-item">Profile</a>
        <a href="#" class="dropdown-item">Logout</a>
    </div>
</div>

