<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 05/11/2024
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- NAVBAR -->
<div class="row sticky-top mb-3 z-2" style="${isDoingAction != null ? 'padding-right:0px;margin-right:-12px;' : ''}">
    <nav class="navbar navbar-expand-lg bg-ytb">
        <div class="container-fluid d-flex justify-content-between">
            <c:url value="/UserHome" var="home"/>
            <a class="navbar-brand" href="${home}"><img style="height: 40px"
                                                        src="https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg"
                                                        alt="Logo"></a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">

                <!-- SEARCH -->
                <div class=" list-group  mx-auto d-flex position-relative justify-content-between"
                     style="width: 40%;position: relative;">
                    <div class="input-group">
                        <input type="text" id="searchInput"
                               class="form-control input-focus-none list-group-item list-group-item-action outline-none rounded-4 rounded-end-0   border-dark-subtle text-black outline-none"
                               placeholder="Search">
                        <button id="buttonSearch" class="btn btn-outline-dark text-light rounded-4 rounded-start-0 "
                                type="button">Search
                        </button>
                        <div class="list-group w-100 position-relative" id="suggestions" style="display:none;">

                        </div>
                    </div>

                </div>
                <!-- END SEARCH -->

                <ul class="navbar-nav me-end ms-auto fs-5 mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active text-light" aria-current="page" href="#">Trang chủ</a>
                    </li>
                    <!-- LOGIN BUTTON -->
                    <li class="nav-item p-1">
                        <c:if test="${userLogin == null}">
                            <button type="button" class="btn bg-button-ytb rounded-1 w-100 h-100" data-bs-toggle="modal"
                                    data-bs-target="#tabsFormLogin">
                                Tài khoản
                            </button>
                        </c:if>
                        <c:if test="${userLogin != null}">
                            <button type="button" class="btn bg-button-ytb rounded-1 w-100 h-100" data-bs-toggle="modal"
                                    data-bs-target="#tabsProfiles">
                                    ${userLogin.fullname}
                            </button>
                        </c:if>
                    </li>
                    <!-- END LOGIN BUTTON -->
                </ul>
            </div>
        </div>
    </nav>
</div>

<!-- LOGIN / REGISTER MODAL -->
<div class="modal " id="tabsFormLogin">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-ytb text-light">
            <div class="modal-header">
                <ul class="nav nav-tabs border-bottom-0" role="tablist">
                    <li class="nav-item"><a href="#register" class="nav-link active text-success fw-bold"
                                            data-bs-toggle="tab">Đăng
                        ký</a></li>
                    <li class="nav-item"><a href="#login" class="nav-link text-info fw-bold" data-bs-toggle="tab">Đăng
                        nhận</a>
                    </li>
                </ul>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- MODAL REGISTER / LOGIN -->
            <div class="modal-body">
                <div class="tab-content">

                    <!-- REGISTER -->
                    <div id="register" class="container tab-pane active">
                        <h2 class="mt-2">Đăng ký tài khoản</h2>
                        <form id="registerForm" class="border rounded-2 p-3 bg-ytb" method="POST">
                            <label for="Id" class="form-label">Username:</label>
                            <input type="text" name="id" placeholder="Nhập username..." id="Id"
                                   class="form-control mb-3">
                            <span class="text-danger d-block" id="eRegisterUsername"></span>

                            <label for="password" class="form-label">Password: </label>
                            <input type="password" name="password" placeholder="Nhập mật khẩu..." id="password"
                                   class="form-control mb-3">
                            <span id="eRegisterPassword" class="text-danger d-block"></span>

                            <label for="fullname" class="form-label">Họ và tên:</label>
                            <input type="text" name="fullname" placeholder="Nhập họ và tên" id="fullname"
                                   class="form-control mb-3" required
                                   oninvalid="this.setCustomValidity('Vui lòng nhập họ và tên!')"
                                   oninput="this.setCustomValidity('')">

                            <label for="email" class="from-label">Email:</label>
                            <input type="email" name="email" placeholder="abcxyz@gmail.com"
                                   id="email" class="form-control mb-3" required
                                   oninvalid="this.setCustomValidity('Vui lòng không bỏ trống email!')"
                                   oninput="this.setCustomValidity('')">
                            <span id="eRegisterEmail" class="text-danger d-block"></span>

                            <label for="2faPassword" class="from-label">Xác nhận mật khẩu:</label>
                            <input type="password" name="2faPassword" placeholder="Nhập lại mật khẩu..."
                                   id="2faPassword" class="form-control mb-3">
                            <span id="e2faRegisterPassword" class="text-danger d-block"></span>

                            <div class="form-check form-check-inline mt-3 mb-3">
                                <input type="checkbox" name="" id="dongy" class="form-check-input" required
                                       oninvalid="this.setCustomValidity('Vui lòng đồng ý với điều khoản!')"
                                       oninput="this.setCustomValidity('')">
                                <label for="dongy" class="form-check-label"> Tôi đồng ý với các <strong
                                        class="text-danger fw-underline">điều khoản</strong> và <strong
                                        class="text-danger fw-underline">điều
                                    kiện</strong></label>
                            </div>

                            <div>
                                <button type="submit" name="formAction" value="register" class="btn btn-primary">Đăng
                                    ký
                                </button>
                                <p id="registerMessage" class="text-success"></p>
                            </div>

                        </form>
                    </div>
                    <!-- END REGISTER -->

                    <!-- LOGIN -->
                    <div id="login" class="container tab-pane bg-ytb fade">
                        <h2 class="mt-3">Đăng nhập</h2>
                        <form id="loginForm" action="${url}" method="POST" class="border rounded-3 p-3">
                            <label for="username" class="form-label">Username:</label>
                            <input type="text" name="id" placeholder="Nhập username..." id="username"
                                   class="form-control mb-3">

                            <label for="passwordLogin" class="form-label">Mật khẩu</label>
                            <input type="password" name="password" placeholder="Nhập mật khẩu..." id="passwordLogin"
                                   class="form-control mb-3">

                            <div>
                                <button class="btn btn-primary" name="formAction" value="login">Đăng nhận</button>
                                <p id="loginMessage" class="text-success"></p>
                            </div>
                        </form>
                    </div>
                    <!-- END LOGIN -->

                </div>
            </div>
            <!-- END MODAL REGISTER / LOGIN -->

        </div>
    </div>
</div>
<!-- END LOGIN / REGISTER MODAL -->


<!-- INFORMATION PROFILES -->
<div class="modal " id="tabsProfiles">
    <div class="modal-dialog modal-lg">
        <div class="modal-content bg-ytb text-light">
            <div class="modal-header">
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                <p class="fs-3 fw-italic position-absolute top-0 start-0 mx-2">Thông tin tài khoản ${userLogin.fullname}
                    :</p>
            </div>

            <div class="modal-body">

                <div id="overlay" class="overlay d-none">
                    <div class="spinner-border text-light position-absolute top-50 start-50 translate-middle"
                         role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>

                <div class="container" id="profiles">
                    <form id="formProfiles" action="" method="POST" class="border rounded-3 p-3">
                        <input type="hidden" name="userLoginId" value="${userLogin.id}"/>
                        <label for="usernameEdit" class="form-label">Username:</label>
                        <input type="text" name="id" placeholder="Nhập username muốn đổi..." id="usernameEdit"
                               class="form-control mb-3" value="${userLogin.id}">
                        <span id="uErrorMessage" class="d-block"></span>

                        <label for="hovaten" class="form-label">Họ và Tên:</label>
                        <input type="text" name="fullname" placeholder="Nhập họ và tên khác..." id="hovaten"
                               class="form-control mb-3" value="${userLogin.fullname}">
                        <span id="fullnErrorMessage" class="d-block"></span>

                        <label for="diachiEmail" class="form-label">Email:</label>
                        <input type="text" name="email" placeholder="Nhập địa chỉ email mới..." id="diachiEmail"
                               class="form-control mb-3" value="${userLogin.email}">
                        <span id="emailErrorMessage" class="d-block"></span>

                        <div>
                            <button type="submit" class="btn btn-primary">
                                Lưu thay đổi
                            </button>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                    data-bs-target="#passwordEdit">
                                Đổi mật khẩu
                            </button>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                                    data-bs-target="#logout">
                                Đăng xuất
                            </button>
                        </div>
                        <span id="formInforMessage"></span>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END INFORMATION PROFILES -->

<!-- Modal -->
<div class="modal fade" id="passwordEdit" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="" class="" id="pEditForm" method="POST">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Đổi mật khẩu</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body bg-ytb text-light">
                    <input type="hidden" name="userLoginId" value="${userLogin.id}"/>
                    <label for="oldPass" class="form-label">Nhập mật khẩu cũ:</label>
                    <input type="password" name="password" placeholder="Nhập mật khẩu cũ..." id="oldPass"
                           class="form-control mb-3">
                    <span id="ePass1Message" class="text-danger d-block"></span>

                    <label for="newPass" class="form-label">Nhập mật khẩu mới:</label>
                    <input type="password" name="password2" placeholder="Nhập mật khẩu mới..." id="newPass"
                           class="form-control mb-3">
                    <span id="ePass2Message" class="text-danger d-block"></span>

                    <label for="veifiPass" class="form-label">Xác nhận mật khẩu:</label>
                    <input type="password" name="password3" placeholder="Nhập lại mật khẩu..." id="veifiPass"
                           class="form-control mb-3">
                    <span id="ePass3Message" class="text-danger d-block"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" name="formAction" value="changePassword" class="btn btn-primary">Lưu thay
                        đổi
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="logout" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <c:url value="/UserHome/logout" var="logoutUrl"/>
            <form action="${logoutUrl}" method="POST">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="title">Xác nhận đăng xuất</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" name="formAction" value="logout" class="btn btn-primary">Đồng ý</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- END MODAL -->

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
        integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
<script src="/js/validate.js"></script>
<script>
    $(document).ready(function () {
        $('#formProfiles').submit(function (e) {
            e.preventDefault();
            var formDataUpdate = $(this).serialize();

            $.ajax({
                url: '/updateProfiles',
                type: 'POST',
                data: formDataUpdate,
                dataType: 'json',
                success: (response) => {
                    $('#uErrorMessage').text('')
                    $('#formInfoMessage').text('')
                    $('#emailErrorMessage').text('')
                    $('#fullnErrorMessage').text('')

                    console.log(response)
                    if (response.status === 'success') {
                        $('#formInforMessage').text(response.message).addClass('text-success').removeClass('text-danger');
                    } else {
                        if (response.errors.fullnError) {
                            $('#fullnErrorMessage').text(response.errors.fullnError).addClass('text-danger')
                        }
                        if (response.errors.emailError) {
                            $('#emailErrorMessage').text(response.errors.emailError).addClass('text-danger')
                        }
                        $('#formInforMessage').text('Đã có lỗi xảy ra!').addClass('text-danger')
                    }
                },
                error: (error) => {
                    console.log(error)
                    $('#formInforMessage').text('Xảy ra lỗi không mong muốn!').addClass('text-danger')
                }
            })
        })
    })
</script>