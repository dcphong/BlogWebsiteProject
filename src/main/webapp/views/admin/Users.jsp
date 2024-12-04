<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 16/11/2024
  Time: 22:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fun" %>
<link href="/css/admin.css" rel="stylesheet"/>
<link href="/css/styles.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<body style="background-color: #121212;color:#e0e0e0;margin: 0">

<!-- HEADER -->
<%@include file="/views/common/admin/header.jsp" %>
<!-- END HEADER -->

<!-- SIDEBAR -->
<%@include file="/views/common/admin/aside.jsp" %>
<!-- END SIDEBAR -->

<!-- MAIN CONTENT -->
<div class="content">
    <div class="tab-content">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active text-success" id="details-tab" data-bs-toggle="tab"
                        data-bs-target="#userDetails" type="button" role="tab" aria-controls="details"
                        aria-selected="true">Chi Tiết User
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link text-success" id="list-tab" data-bs-toggle="tab" data-bs-target="#usersList"
                        type="button" role="tab" aria-controls="list" aria-selected="false">Danh Sách User
                </button>
            </li>
        </ul>
        <div class="tab-content mt-3" id="myTabContent">
            <!-- Tab: Chi Tiết User -->
            <div class="tab-pane fade show active" id="userDetails" role="tabpanel" aria-labelledby="details-tab"
                 style="height: 450px;">
                <div class="row">
                    <div class="col-md-8">
                        <form method="POST" id="adminUsersForm">
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên người dùng</label>
                                <input type="text" name="id" class="form-control"
                                       placeholder="Nhập username người dùng..."
                                       id="username">
                                <span id="usernameError" class="text-success"></span>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Mật khẩu</label>
                                <input type="password" name="password" class="form-control"
                                       placeholder="Nhập mật khẩu..." id="password">
                                <span id="passwordError" class="text-danger"></span>
                            </div>
                            <div class="mb-3">
                                <label for="fullname" class="form-label">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" placeholder="Nhập họ và tên..."
                                       id="fullname">
                                <span id="fullnameError" class="text-danger"></span>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" placeholder="Nhập email..."
                                       id="email">
                                <span id="emailError" class="text-danger"></span>
                            </div>
                            <div>
                                <button type="reset" class="btn  btn-info" name="resetBtn" id="resetButton">Reset
                                </button>
                                <button type="submit" name="adminUserAction" id="updateButton" value="update"
                                        class="btn btn-warning">Cập nhật
                                </button>
                                <button type="submit" name="adminUserAction" id="deleteButton" value="delete"
                                        class="btn btn-danger">Xóa
                                </button>
                            </div>
                            <span id="adminUserFormMessage" class="text-success"></span>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Tab: Danh Sách User -->
            <div class="tab-pane fade overflow-auto scrollbar-hidden" id="usersList" role="tabpanel"
                 aria-labelledby="list-tab"
                 style="max-height: 550px">
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Tên người dùng</th>
                        <th>Mật khẩu</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Chức năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${userList}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.password}</td>
                            <td>${user.fullname}</td>
                            <td>${user.email}</td>
                            <td>${user.admin == true ? 'Quản trị' : 'Người dùng'}</td>
                            <td>
                                <button class="btn btn-sm btn-info" id="buttonEdit" name="getUserIdToEdit"
                                        value="${user.id}">Chỉnh sửa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    <!-- Add more rows as necessary -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- MAIN CONTENT -->

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const handleButtonClick = async (e, buttonValue) => {
            e.preventDefault();
            const form = document.getElementById('adminUsersForm');
            const formData = new FormData(form);

            formData.append('adminUserAction', buttonValue);

            try {
                const response = await fetch('/Admin/user/action', {
                    method: 'POST',
                    body: new URLSearchParams(formData)
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }

                const data = await response.json();

                document.getElementById('usernameError').textContent = '';
                document.getElementById('passwordError').textContent = '';
                document.getElementById('fullnameError').textContent = '';
                document.getElementById('emailError').textContent = '';

                if (data.status === 'errorDelete') {
                    document.getElementById('adminUserFormMessage').textContent = data.message
                    document.getElementById('adminUserFormMessage').classList.add('text-success')
                }

                if (data.status === 'error') {
                    const errors = data.errors || {};

                    if (errors.userMessage) {
                        document.getElementById('usernameError').textContent = errors.userMessage;
                    }
                    if (errors.passwordMessage) {
                        document.getElementById('passwordError').textContent = errors.passwordMessage;
                    }
                    if (errors.fullnameMessage) {
                        document.getElementById('fullnameError').textContent = errors.fullnameMessage;
                    }
                    if (errors.eUserEmail) {
                        document.getElementById('emailError').textContent = errors.eUserEmail;
                    }

                } else if (data.status === 'success') {
                    document.getElementById('adminUserFormMessage').textContent = data.message
                    document.getElementById('adminUserFormMessage').classList.add('text-success')
                }
            } catch (error) {
                console.error('Error:', error);
            }
        };

        document.getElementById('updateButton').addEventListener('click', (e) => {
            handleButtonClick(e, 'update');
        });

        document.getElementById('deleteButton').addEventListener('click', (e) => {
            handleButtonClick(e, 'delete');
        });

        const buttonEditForUser = document.querySelectorAll("[name='getUserIdToEdit']");

        buttonEditForUser.forEach((button) => {
            button.addEventListener('click', async () => {
                const id = button.value;
                try {
                    const response = await fetch('/Admin/user/edit', {
                        method: 'POST',
                        body: new URLSearchParams({
                            id: id
                        })
                    });

                    const data = await response.json()

                    if (!response.ok) {
                        throw new Error(`HTTP error! status: `${response.status})
                    }

                    document.getElementById('username').value = data.username
                    document.getElementById('password').value = data.password
                    document.getElementById('email').value = data.email
                    document.getElementById('fullname').value = data.fullname

                    document.getElementById('userDetails').classList.add('show', 'active');
                    document.getElementById('usersList').classList.remove('show', 'active');

                    document.getElementById('details-tab').classList.add('active');
                    document.getElementById('list-tab').classList.remove('active');
                } catch (error) {
                    console.log('Editbutton say ra loi', error)
                }
            })
        })

        document.getElementById('resetButton').addEventListener('click', () => {
            document.getElementById('username').value = ''
            document.getElementById('password').value = ''
            document.getElementById('email').value = ''
            document.getElementById('fullname').value = ''
        })

    });

</script>
</html>

