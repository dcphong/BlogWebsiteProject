<%--
  Created by IntelliJ IDEA.
  User: doanc
  Date: 05/11/2024
  Time: 21:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="sidebar bg-ytb p-0 w-100 py-3">
    <ul class="p-0">
        <li class="nav-item">
            <c:url value="/UserHome" var="home"/>
            <a class="nav-link text-center p-3" style="font-size: 14px;" href="${home}"><i
                    class="bi bi-house-door-fill"></i> <br>Trang chủ</a>
        </li>
        <li class="nav-item">
            <c:url value="/UserFavorites?idUser=${userLogin.id}" var="urlFavorites"/>
            <a class="nav-link text-center p-3" style="font-size: 14px;" id="linkFavorites" href="${urlFavorites}"><i
                    class="bi bi-star-fill"></i><br>Yêu thích</a>
        </li>
        <li class="nav-item">
            <button type="button" id="buttonProfiles" class="nav-link text-center p-3 w-100" style="font-size: 14px;"
            >
                <i class="bi bi-person-fill"></i><br>Tài khoản
            </button>
        </li>
        <li class="nav-item">
            <c:url value="/Admin/Home" var="adminHome"/>
            <a class="nav-link text-center p-3" id="adminSite" style="font-size: 14px;" href="${adminHome}"><i
                    class="bi bi-house-door-fill"></i> <br>Quản trị</a>
        </li>
    </ul>
</div>

<!-- ACCESS DENIED MODAL -->
<div class="modal" id="accessDeniedModal">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
            <div class="modal-header">
                <h5 class="modal-title">Thông báo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p id="notiAccessDenied"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>
<!-- END ACCESS DENIED MODAL -->


<script>
    document.getElementById('adminSite').addEventListener('click', async function (e) {
        e.preventDefault();
        const url = this.href;
        const loginMessage = document.getElementById('loginMessage');

        try {
            const response = await fetch(url, {method: 'GET'});
            const content = await response.text();
            if (content == 'NOT_LOGGED_IN') {
                const loginModal = new bootstrap.Modal(document.getElementById('tabsFormLogin'))
                loginMessage.innerText = 'Vui lòng đăng nhập!'
                loginMessage.classList.add('text-danger')
                loginModal.show();

                // Chuyển tab sa ng Đăng nhập
                const loginTab = document.querySelector('[href="#login"]');
                const registerTab = document.querySelector('[href="#register"]');
                loginTab.classList.add('active');
                registerTab.classList.remove('active');

                // Hiển thị nội dung tab Đăng nhập
                document.getElementById('login').classList.add('active', 'show');
                document.getElementById('register').classList.remove('active', 'show');
            } else if (content == 'ACCESS_DENIED') {
                const accessDeniedModal = new bootstrap.Modal(document.getElementById('accessDeniedModal'))
                document.getElementById('notiAccessDenied').innerText = 'Bạn không có quyền truy cập vào trang quản trị. Vui lòng liên hệ quản trị viên để được hỗ trợ.'
                accessDeniedModal.show()
            } else {
                window.location.href = url;
            }
        } catch (err) {
            console.log('khong gui duoc request', err)
        }
    })

    document.getElementById('buttonProfiles').addEventListener('click', async function (e) {
        e.preventDefault();

        try {
            const response = await fetch('/UserHome/profiles', {method: 'GET'});
            const status = await response.text();
            const profileModal = new bootstrap.Modal(document.getElementById('tabsProfiles'));
            const loginTab = document.querySelector('[href="#login"]');
            const registerTab = document.querySelector('[href="#register"]');
            const loginModal = new bootstrap.Modal(document.getElementById('tabsFormLogin'));
            const loginMessage = document.getElementById('loginMessage');

            if (status == 'NOT_LOGGED_IN') {
                profileModal.hide();

                loginMessage.innerText = 'Vui lòng đăng nhập!'
                loginMessage.classList.add('text-danger')
                loginModal.show();

                loginTab.classList.add('active');
                registerTab.classList.remove('active');

                document.getElementById('login').classList.add('active', 'show');
                document.getElementById('register').classList.remove('active', 'show');
            } else {
                profileModal.show();
            }
        } catch (error) {
            console.log('Loi roi', error)
        }
    })

    document.getElementById('linkFavorites').addEventListener('click', async function (e) {
        e.preventDefault();
        const url = this.href;

        try {
            const response = await fetch('/UserFavorites', {method: 'POST'});
            const content = await response.text();
            const loginMessage = document.getElementById('loginMessage');

            if (content == 'NOT_LOGGED_IN') {
                const loginModal = new bootstrap.Modal(document.getElementById('tabsFormLogin'))
                loginMessage.innerText = 'Vui lòng đăng nhập!'
                loginMessage.classList.add('text-danger')
                loginModal.show();

                const loginTab = document.querySelector('[href="#login"]');
                const registerTab = document.querySelector('[href="#register"]');
                loginTab.classList.add('active');
                registerTab.classList.remove('active');

                document.getElementById('login').classList.add('active', 'show');
                document.getElementById('register').classList.remove('active', 'show');
            } else if (content == 'ACCESS_DENIED') {
                const accessDeniedModal = new bootstrap.Modal(document.getElementById('accessDeniedModal'))
                document.getElementById('notiAccessDenied').innerText = 'Bạn không có quyền truy cập vào trang quản trị. Vui lòng liên hệ quản trị viên để được hỗ trợ.'
                accessDeniedModal.show()
            } else {
                window.location.href = url;
            }
        } catch (err) {
            console.log('khong gui duoc request', err)
        }
    })
</script>
